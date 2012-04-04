function [sys3] = %lfr_c_p(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: lfr-object , polynomial-object

sys3 = %lfr_c_lfr(sys1,lfr(sys2));

endfunction
