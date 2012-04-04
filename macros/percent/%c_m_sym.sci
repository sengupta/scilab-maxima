function [sys3] = %c_m_sym(sys1,sys2)

// Overloads multiplication
// The operands are: string-object , sym-object

sys3 = %sym_m_sym(sym(sys1),sys2);

endfunction
