function [sys3] = %lss_s_lfr(sys1,sys2)

// Overloads substraction
// The operands are: syslin-object , lfr-object

sys3 = %lfr_s_lfr(lfr(sys1),sys2);

endfunction
