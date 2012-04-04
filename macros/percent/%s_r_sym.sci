function [sys3] = %s_r_sym(sys1,sys2)

// Overloads division
// The operands are: constant-object , sym-object

sys3 = %sym_r_sym(sym(sys1),sys2);

endfunction
