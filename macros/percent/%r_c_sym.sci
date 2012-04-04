function [sys3] = %r_c_sym(sys1,sys2)

// Overloads horizontal concatenation
// The operands are: rational-object , sym-object

sys3 = %sym_c_sym(sym(sys1),sys2);

endfunction
