function [sys3] = %sym_s_c(sys1,sys2)

// Overloads substraction
// The operands are: sym-object , string-object

sys3 = %sym_s_sym(sys1,sym(sys2));

endfunction
