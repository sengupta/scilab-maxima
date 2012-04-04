function [sys3] = %lfr_s_s(sys1,sys2)

// Overloads substraction
// The operands are: lfr-object , constant-object

sys3 = %lfr_s_lfr(sys1,lfr(sys2));

endfunction
