function [sys3] = %lfr_m_lss(sys1,sys2)

// Overloads multiplication
// The operands are: lfr-object , syslin-object

sys3 = %lfr_m_lfr(sys1,lfr(sys2));

endfunction
