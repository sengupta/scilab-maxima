function [sys3] = %p_c_lfr(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: polynomial-object , lfr-object

sys3 = %lfr_c_lfr(lfr(sys1),sys2);

endfunction
