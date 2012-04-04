function [sys3] = %lfr_c_s(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: lfr-object , constant-object

sys3 = %lfr_c_lfr(sys1,lfr(sys2));

endfunction
