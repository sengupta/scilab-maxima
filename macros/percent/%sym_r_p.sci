function [sys3] = %sym_r_p(sys1,sys2)

// Overloads division
// The operands are: sym-object , polynomial-object

sys3 = %sym_r_sym(sys1,sym(sys2));

endfunction
