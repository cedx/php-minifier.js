import console from "node:console";
import type {Dirent, Stats} from "node:fs";
import {mkdir, readdir, stat, writeFile} from "node:fs/promises";
import {basename, dirname, extname, join, relative, resolve} from "node:path";
import {exit} from "node:process";
import {parseArgs} from "node:util";
import pkg from "../package.json" with {type: "json"};
import {FastTransformer} from "./FastTransformer.js";
import {SafeTransformer} from "./SafeTransformer.js";
import {TransformMode} from "./TransformMode.js";

// The usage information.
const usage = `
Remove comments and whitespace from PHP scripts.

Usage:
	npx @cedx/php-minifier [options] <input> [output]

Arguments:
	input            The path to the input file or directory.
	output           The path to the output directory.

Options:
	-b, --binary     The path to the PHP executable. Defaults to "php".
	-e, --extension  The extension of the PHP files to process. Defaults to "php".
	-m, --mode       The operation mode of the minifier. Defaults to "${TransformMode.Safe}".
	-q, --quiet      Whether to silence the minifier output.
	-r, --recurse    Whether to process the input directory recursively.
	-h, --help       Display this help.
	-v, --version    Output the version number.
`;

// Start the application.
try {
	// Parse the command line arguments.
	const {positionals, values} = parseArgs({allowPositionals: true, options: {
		binary: {short: "b", type: "string", default: "php"},
		extension: {short: "e", type: "string", default: "php"},
		help: {short: "h", type: "boolean", default: false},
		mode: {short: "m", type: "string", default: TransformMode.Safe},
		quiet: {short: "q", type: "boolean", default: false},
		recurse: {short: "r", type: "boolean", default: false},
		version: {short: "v", type: "boolean", default: false}
	}});

	// Print the usage.
	if (values.help) {
		console.log(usage.trim().replaceAll("\t", "  "));
		exit(0);
	}

	if (values.version) {
		console.log(pkg.version);
		exit(0);
	}

	// Check the requirements.
	if (!positionals.length) {
		console.error("You must provide the path to the input file or directory.");
		exit(400);
	}

	const input = resolve(positionals[0]);
	let stats: Stats|null = null;
	try { stats = await stat(input); }
	catch {
		console.error("The input file or directory was not found.");
		exit(404);
	}

	// Process the PHP scripts.
	using transformer = values.mode == TransformMode.Fast ? new FastTransformer(values.binary) : new SafeTransformer(values.binary);

	const extension = `.${values.extension}`;
	const files = stats.isFile()
		? [{name: basename(input), parentPath: dirname(input)} as Dirent]
		: (await readdir(input, {recursive: values.recurse, withFileTypes: true})).filter(item => item.isFile() && extname(item.name).toLowerCase() == extension);

	const output = positionals.length > 1 ? resolve(positionals[1]) : (stats.isFile() ? dirname(input) : input);
	for (const file of files) {
		const fullPath = join(file.parentPath, file.name);
		const relativePath = stats.isFile() ? file.name : relative(input, fullPath);
		if (!values.quiet) console.log(`Minifying: ${relativePath}`);

		const script = await transformer.transform(fullPath);
		const target = join(output, relativePath);
		await mkdir(dirname(target), {recursive: true});
		await writeFile(target, script);
	}
}
catch (error) {
	console.error(error instanceof Error ? error.message : error);
	exit(500);
}
