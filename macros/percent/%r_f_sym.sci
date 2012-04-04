function [sys3] = %r_f_sym(sys1,sys2)

// Overloads vertical concatenation
// The operands are: rational-object , sym-object

sys3 = %sym_f_sym(sym(sys1),sys2);

endfunction
