function [sys3] = %lfr_a_p(sys1,sys2)

// Overloads addition
// The operands are: lfr-object , polynomial-object

sys3 = %lfr_a_lfr(sys1,lfr(sys2));

endfunction
