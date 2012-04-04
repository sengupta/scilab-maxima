function [sys3] = %p_r_sym(sys1,sys2)

// Overloads division
// The operands are: polynomial-object , sym-object

sys3 = %sym_r_sym(sym(sys1),sys2);

endfunction
