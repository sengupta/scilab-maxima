function [sys3] = %sym_r_r(sys1,sys2)

// Overloads division
// The operands are: sym-object , rational-object

sys3 = %sym_r_sym(sys1,sym(sys2));

endfunction
