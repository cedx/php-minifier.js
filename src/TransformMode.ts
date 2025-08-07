/**
 * The operation mode of the minifier.
 */
export const TransformMode = Object.freeze({

	/**
	 * Applies a fast transformation.
	 */
	Fast: "fast",

	/**
	 * Applies a safe transformation.
	 */
	Safe: "safe"
});

/**
 * The operation mode of the minifier.
 */
export type TransformMode = typeof TransformMode[keyof typeof TransformMode];
