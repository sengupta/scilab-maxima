function [sys3] = %p_v_sym(sys1,sys2)

// Overloads feedback
// The operands are: polynomial-object , sym-object

sys3 = %sym_v_sym(sym(sys1),sys2);

endfunction
