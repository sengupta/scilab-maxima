function [sys3] = %sym_r_c(sys1,sys2)

// Overloads division
// The operands are: sym-object , string-object

sys3 = %sym_r_sym(sys1,sym(sys2));

endfunction
