function [sys3] = %r_a_lfr(sys1,sys2)

// Overloads addition
// The operands are: rational-object , lfr-object

sys3 = %lfr_a_lfr(lfr(sys1),sys2);

endfunction
