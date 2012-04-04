function [sys3] = %r_r_sym(sys1,sys2)

// Overloads division
// The operands are: rational-object , sym-object

sys3 = %sym_r_sym(sym(sys1),sys2);

endfunction
