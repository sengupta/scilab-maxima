function [sys3] = %s_r_lfr(sys1,sys2)

// Overloads division
// The operands are: constant-object , lfr-object

sys3 = %lfr_r_lfr(lfr(sys1),sys2);

endfunction
