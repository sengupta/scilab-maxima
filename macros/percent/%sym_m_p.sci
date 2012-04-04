function [sys3] = %sym_m_p(sys1,sys2)

// Overloads multiplication
// The operands are: sym-object , polynomial-object

sys3 = %sym_m_sym(sys1,sym(sys2));

endfunction
