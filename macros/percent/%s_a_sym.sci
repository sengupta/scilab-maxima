function [sys3] = %s_a_sym(sys1,sys2)

// Overloads addition
// The operands are: constant-object , sym-object

sys3 = %sym_a_sym(sym(sys1),sys2);

endfunction
