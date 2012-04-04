function [sys3] = %p_a_sym(sys1,sys2)

// Overloads addition
// The operands are: polynomial-object , sym-object

sys3 = %sym_a_sym(sym(sys1),sys2);

endfunction
