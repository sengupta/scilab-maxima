function [sys3] = %c_c_sym(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: string-object , sym-object

sys3 = %sym_c_sym(sym(sys1),sys2);

endfunction
