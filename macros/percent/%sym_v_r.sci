function [sys3] = %sym_v_r(sys1,sys2)

// Overloads feedback
// The operands are: sym-object , rational-object

sys3 = %sym_v_sym(sys1,sym(sys2));

endfunction
