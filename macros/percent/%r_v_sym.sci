function [sys3] = %r_v_sym(sys1,sys2)

// Overloads feedback
// The operands are: rational-object , sym-object

sys3 = %sym_v_sym(sym(sys1),sys2);

endfunction
