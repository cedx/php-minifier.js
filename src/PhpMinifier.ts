import {FastTransformer} from "./FastTransformer.js";
import type {ITransformer} from "./ITransformer.js";
import {SafeTransformer} from "./SafeTransformer.js";
import {TransformMode} from "./TransformMode.js";

/**
 * Removes comments and whitespace from PHP scripts.
 */
export class PhpMinifier implements ITransformer {

	/**
	 * The instance used to process the PHP code.
	 */
	readonly #transformer: ITransformer;

	/**
	 * Creates a new PHP minifier.
	 * @param mode The operation mode of the minifier.
	 * @param executable The path to the PHP executable.
	 */
	constructor(mode: TransformMode = TransformMode.Safe, executable = "php") {
		this.#transformer = mode == TransformMode.Fast ? new FastTransformer(executable) : new SafeTransformer(executable);
	}

	/**
	 * Releases any resources associated with this object.
	 */
	[Symbol.dispose](): void {
		this.dispose();
	}

	/**
	 * Releases any resources associated with this object.
	 */
	dispose(): void {
		this.#transformer.dispose();
	}

	/**
	 * Processes a PHP script.
	 * @param file The path to the PHP script.
	 * @returns The transformed script.
	 */
	transform(file: string): Promise<string> {
		return this.#transformer.transform(file);
	}
}
