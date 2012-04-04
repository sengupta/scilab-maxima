function [sys3] = %c_f_sym(sys1,sys2)

// Overloads vertical concatenation
// The operands are: string-object , sym-object

sys3 = %sym_f_sym(sym(sys1),sys2);

endfunction
