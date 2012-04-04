function [sys3] = %sym_m_c(sys1,sys2)

// Overloads multiplication
// The operands are: sym-object , string-object

sys3 = %sym_m_sym(sys1,sym(sys2));

endfunction
