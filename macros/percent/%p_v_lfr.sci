function [sys3] = %p_v_lfr(sys1,sys2)

// Overloads feedback
// The operands are: polynomial-object , lfr-object

sys3 = %lfr_v_lfr(lfr(sys1),sys2);

endfunction
