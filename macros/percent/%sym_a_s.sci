function [sys3] = %sym_a_s(sys1,sys2)

// Overloads addition
// The operands are: sym-object , constant-object

sys3 = %sym_a_sym(sys1,sym(sys2));

endfunction
