function [sys3] = %s_f_lfr(sys1,sys2)

// Overloads vertical concatenation
// The operands are: constant-object , lfr-object

sys3 = %lfr_f_lfr(lfr(sys1),sys2);

endfunction
