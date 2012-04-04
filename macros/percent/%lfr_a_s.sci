function [sys3] = %lfr_a_s(sys1,sys2)

// Overloads addition
// The operands are: lfr-object , constant-object

sys3 = %lfr_a_lfr(sys1,lfr(sys2));

endfunction
