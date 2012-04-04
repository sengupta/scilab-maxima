function [sys3] = %lfr_f_r(sys1,sys2)

// Overloads vertical concatenation
// The operands are: lfr-object , rational-object

sys3 = %lfr_f_lfr(sys1,lfr(sys2));

endfunction
