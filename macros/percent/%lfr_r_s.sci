function [sys3] = %lfr_r_s(sys1,sys2)

// Overloads division
// The operands are: lfr-object , constant-object

sys3 = %lfr_r_lfr(sys1,lfr(sys2));

endfunction
