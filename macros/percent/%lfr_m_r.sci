function [sys3] = %lfr_m_r(sys1,sys2)

// Overloads multiplication
// The operands are: lfr-object , rational-object

sys3 = %lfr_m_lfr(sys1,lfr(sys2));

endfunction
