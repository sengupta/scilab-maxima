function [sys3] = %lfr_a_r(sys1,sys2)

// Overloads addition
// The operands are: lfr-object , rational-object

sys3 = %lfr_a_lfr(sys1,lfr(sys2));

endfunction
