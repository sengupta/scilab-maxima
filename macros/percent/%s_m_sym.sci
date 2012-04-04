function [sys3] = %s_m_sym(sys1,sys2)

// Overloads multiplication
// The operands are: constant-object , sym-object

sys3 = %sym_m_sym(sym(sys1),sys2);

endfunction
