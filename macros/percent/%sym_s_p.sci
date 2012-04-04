function [sys3] = %sym_s_p(sys1,sys2)

// Overloads substraction
// The operands are: sym-object , polynomial-object

sys3 = %sym_s_sym(sys1,sym(sys2));

endfunction
