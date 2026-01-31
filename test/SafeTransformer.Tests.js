import {SafeTransformer} from "@cedx/php-minifier";
import {ok} from "node:assert/strict";
import {after, describe, it} from "node:test";

/**
 * Tests the features of the {@link SafeTransformer} class.
 */
describe("SafeTransformer", () => {
	describe("dispose()", () => {
		it("should not trigger any errors, even if called several times", () => {
			const transformer = new SafeTransformer;
			transformer.dispose();
			transformer.dispose();
		});
	});

	describe("transform()", () => {
		const patterns = new Map([
			["should remove the inline comments", "<?= 'Hello World!' ?>"],
			["should remove the multi-line comments", "namespace dummy; class Dummy"],
			["should remove the single-line comments", "$className = get_class($this); return $className;"],
			["should remove the whitespace", "__construct() { $this->property"]
		]);

		const transformer = new SafeTransformer;
		after(() => transformer.dispose());

		for (const [key, value] of patterns) it(key, async () => {
      const output = await transformer.transform("res/Sample.php");
			ok(output.includes(value));
    });
	});
});
