function [sys3] = %lfr_c_r(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: lfr-object , rational-object

sys3 = %lfr_c_lfr(sys1,lfr(sys2));

endfunction
