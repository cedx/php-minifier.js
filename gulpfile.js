import gulp from "gulp";
import {spawn} from "node:child_process";
import {readdir, rm} from "node:fs/promises";
import {join} from "node:path";
import {env} from "node:process";
import pkg from "./package.json" with {type: "json"};

/** Builds the project. */
export async function build() {
	await run(`npx tsc ${typeScriptArguments()}`);
}

/** Deletes all generated files. */
export async function clean() {
	await rm("lib", {force: true, recursive: true});
	for (const file of await readdir("var")) if (file != ".gitkeep") await rm(join("var", file), {recursive: true});
}

/** Packages the project. */
export async function dist() {
	env.NODE_ENV = "production"
	await build();
}

/** Builds the documentation. */
export async function doc() {
	await run("npx typedoc --options etc/TypeDoc.js");
}

/** Performs the static analysis of source code. */
export async function lint() {
	await run("npx tsc --build tsconfig.json --noEmit");
	await run("npx eslint --config=etc/ESLint.js gulpfile.js example src test");
}

/** Publishes the package. */
export async function publish() {
	await run("npx gulp");
	for (const action of ["tag", "push origin"]) await run(`git ${action} v${pkg.version}`);
	for (const registry of ["https://registry.npmjs.org", "https://npm.pkg.github.com"]) await run(`npm publish --registry=${registry}`);
}

/** Runs the test suite. */
export async function test() {
	env.NODE_ENV = "test";
	await run(`npx tsc ${typeScriptArguments()}`);
	await run("node --enable-source-maps --test");
}

/** Watches for file changes. */
export async function watch() {
	env.NODE_ENV = "development";
	await run(`npx tsc ${typeScriptArguments({watch: true})}`);
}

/** The default task. */
export default gulp.series(clean, dist);

/**
 * Spawns a new process using the specified command.
 * @param {string} command The command to run.
 * @returns {Promise<void>} Resolves when the command is terminated.
 */
function run(command) {
	return new Promise((resolve, reject) => {
		const process = spawn(command, {shell: true, stdio: "inherit"});
		process.on("close", code => code ? reject(Error(command)) : resolve());
	});
}

/**
 * Gets the TypeScript build arguments.
 * @param {{watch?: boolean}} options Value indicating whether to enable file watching.
 * @returns {string} The arguments to be passed to the TypeScript command line.
 */
function typeScriptArguments(options = {}) {
	const args = ["--build", "src/tsconfig.json"];
	if (env.NODE_ENV != "production") args.push("--sourceMap");
	if (options.watch) args.push("--preserveWatchOutput", "--watch");
	return args.join(" ");
}
