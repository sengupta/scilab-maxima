function [sys3] = %sym_m_s(sys1,sys2)

// Overloads multiplication
// The operands are: sym-object , constant-object

sys3 = %sym_m_sym(sys1,sym(sys2));

endfunction
