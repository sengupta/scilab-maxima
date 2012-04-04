function [sym1] = %sym_log(a)

// %sym_log
//-----------------------------------------------------------------
// Natural logarithm of symbolic objects
// see mhlp logexpand, mhlp logsimp

    a = sym(a);

    str1 = 'log('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction
