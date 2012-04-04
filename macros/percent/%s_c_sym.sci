function [sys3] = %s_c_sym(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: constant-object , sym-object

sys3 = %sym_c_sym(sym(sys1),sys2);

endfunction
