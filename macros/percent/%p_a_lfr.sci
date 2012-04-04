function [sys3] = %p_a_lfr(sys1,sys2)

// Overloads addition
// The operands are: polynomial-object , lfr-object

sys3 = %lfr_a_lfr(lfr(sys1),sys2);

endfunction
