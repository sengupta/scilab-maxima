function [sys3] = %p_c_sym(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: polynomial-object , sym-object

sys3 = %sym_c_sym(sym(sys1),sys2);

endfunction
