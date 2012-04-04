function [sys3] = %sym_v_s(sys1,sys2)

// Overloads feedback
// The operands are: sym-object , constant-object

sys3 = %sym_v_sym(sys1,sym(sys2));

endfunction
