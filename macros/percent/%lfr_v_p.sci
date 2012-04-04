function [sys3] = %lfr_v_p(sys1,sys2)

// Overloads feedback
// The operands are: lfr-object , polynomial-object

sys3 = %lfr_v_lfr(sys1,lfr(sys2));

endfunction
