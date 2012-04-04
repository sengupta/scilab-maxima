function [sys3] = %sym_c_c(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: sym-object , string-object

sys3 = %sym_c_sym(sys1,sym(sys2));

endfunction
