import "../../paving.asy" as paving;

string[] brick_patterns = {
  "running_bond", "stack_bond", "herringbone",
  "basket_weave", "basket_weave_stack_bond", "basket_weave_variation"
};

string[] flagstone_patterns = {
  "flagstone"
};

real[] scales = {1/4};
string[] scale_strings = {"1/4"};

architects_pages(brick_patterns, scales, scale_strings, 8);
architects_pages(flagstone_patterns, scales, scale_strings, 12);
