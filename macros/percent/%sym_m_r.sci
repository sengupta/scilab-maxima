function [sys3] = %sym_m_r(sys1,sys2)

// Overloads multiplication
// The operands are: sym-object , rational-object

sys3 = %sym_m_sym(sys1,sym(sys2));

endfunction
