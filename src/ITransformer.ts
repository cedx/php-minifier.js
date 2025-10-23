/**
 * Removes comments and whitespace from a PHP script.
 */
export interface ITransformer extends AsyncDisposable {

	/**
	 * Releases any resources associated with this object.
	 * @returns Resolves when this object has been disposed.
	 */
	dispose: () => Promise<void>;

	/**
	 * Processes a PHP script.
	 * @param file The path to the PHP script.
	 * @returns The transformed script.
	 */
	transform: (file: string) => Promise<string>;
}
