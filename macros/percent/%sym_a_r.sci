function [sys3] = %sym_a_r(sys1,sys2)

// Overloads addition
// The operands are: sym-object , rational-object

sys3 = %sym_a_sym(sys1,sym(sys2));

endfunction
