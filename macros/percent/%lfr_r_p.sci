function [sys3] = %lfr_r_p(sys1,sys2)

// Overloads division
// The operands are: lfr-object , polynomial-object

sys3 = %lfr_r_lfr(sys1,lfr(sys2));

endfunction
