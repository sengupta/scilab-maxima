function [sys3] = %lss_m_lfr(sys1,sys2)

// Overloads multiplication
// The operands are: syslin-object , lfr-object

sys3 = %lfr_m_lfr(lfr(sys1),sys2);

endfunction
