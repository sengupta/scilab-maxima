function [sys3] = %s_s_sym(sys1,sys2)

// Overloads substraction
// The operands are: constant-object , sym-object

sys3 = %sym_s_sym(sym(sys1),sys2);

endfunction
