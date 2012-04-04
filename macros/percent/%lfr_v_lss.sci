function [sys3] = %lfr_v_lss(sys1,sys2)

// Overloads feedback
// The operands are: lfr-object , syslin-object

sys3 = %lfr_v_lfr(sys1,lfr(sys2));

endfunction
