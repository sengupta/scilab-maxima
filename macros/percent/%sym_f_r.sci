function [sys3] = %sym_f_r(sys1,sys2)

// Overloads vertical concatenation
// The operands are: sym-object , rational-object

sys3 = %sym_f_sym(sys1,sym(sys2));

endfunction
