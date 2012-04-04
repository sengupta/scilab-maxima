function [sys3] = %sym_f_s(sys1,sys2)

// Overloads vertical concatenation
// The operands are: sym-object , constant-object

sys3 = %sym_f_sym(sys1,sym(sys2));

endfunction
