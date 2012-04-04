function [sys3] = %lfr_f_p(sys1,sys2)

// Overloads vertical concatenation
// The operands are: lfr-object , polynomial-object

sys3 = %lfr_f_lfr(sys1,lfr(sys2));

endfunction
