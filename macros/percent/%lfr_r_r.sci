function [sys3] = %lfr_r_r(sys1,sys2)

// Overloads division
// The operands are: lfr-object , rational-object

sys3 = %lfr_r_lfr(sys1,lfr(sys2));

endfunction
