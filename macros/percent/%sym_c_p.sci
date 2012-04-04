function [sys3] = %sym_c_p(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: sym-object , polynomial-object

sys3 = %sym_c_sym(sys1,sym(sys2));

endfunction
