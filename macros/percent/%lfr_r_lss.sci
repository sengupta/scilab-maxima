function [sys3] = %lfr_r_lss(sys1,sys2)

// Overloads division
// The operands are: lfr-object , syslin-object

sys3 = %lfr_r_lfr(sys1,lfr(sys2));

endfunction
