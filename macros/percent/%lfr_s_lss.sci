function [sys3] = %lfr_s_lss(sys1,sys2)

// Overloads substraction
// The operands are: lfr-object , syslin-object

sys3 = %lfr_s_lfr(sys1,lfr(sys2));

endfunction
