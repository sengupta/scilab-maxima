function [sys3] = %s_m_lfr(sys1,sys2)

// Overloads multiplication
// The operands are: constant-object , lfr-object

sys3 = %lfr_m_lfr(lfr(sys1),sys2);

endfunction
