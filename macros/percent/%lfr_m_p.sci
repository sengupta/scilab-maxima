function [sys3] = %lfr_m_p(sys1,sys2)

// Overloads multiplication
// The operands are: lfr-object , polynomial-object

sys3 = %lfr_m_lfr(sys1,lfr(sys2));

endfunction
