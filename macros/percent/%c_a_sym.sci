function [sys3] = %c_a_sym(sys1,sys2)

// %c_a_sym
// Overloads addition
// The operands are: string-object , sym-object

sys3 = %sym_a_sym(sym(sys1),sys2);

endfunction
