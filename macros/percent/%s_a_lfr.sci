function [sys3] = %s_a_lfr(sys1,sys2)

// Overloads addition
// The operands are: constant-object , lfr-object

sys3 = %lfr_a_lfr(lfr(sys1),sys2);

endfunction
