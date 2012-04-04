function [sys3] = %sym_f_c(sys1,sys2)

// Overloads vertical concatenation
// The operands are: sym-object , string-object

sys3 = %sym_f_sym(sys1,sym(sys2));

endfunction
