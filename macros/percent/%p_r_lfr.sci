function [sys3] = %p_r_lfr(sys1,sys2)

// Overloads division
// The operands are: polynomial-object , lfr-object

sys3 = %lfr_r_lfr(lfr(sys1),sys2);

endfunction
