function [sys3] = %c_r_sym(sys1,sys2)

// Overloads division
// The operands are: string-object , sym-object

sys3 = %sym_r_sym(sym(sys1),sys2);

endfunction
