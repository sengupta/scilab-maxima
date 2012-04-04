function [sys3] = %sym_a_p(sys1,sys2)

// Overloads addition
// The operands are: sym-object , polynomial-object

sys3 = %sym_a_sym(sys1,sym(sys2));

endfunction
