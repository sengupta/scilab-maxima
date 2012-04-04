function [sys3] = %sym_v_c(sys1,sys2)

// Overloads feedback
// The operands are: sym-object , string-object

sys3 = %sym_v_sym(sys1,sym(sys2));

endfunction
