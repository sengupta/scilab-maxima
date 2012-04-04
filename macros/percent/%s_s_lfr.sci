function [sys3] = %s_s_lfr(sys1,sys2)

// Overloads substraction
// The operands are: constant-object , lfr-object

sys3 = %lfr_s_lfr(lfr(sys1),sys2);

endfunction
