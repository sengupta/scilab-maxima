function [sym1] = %sym_acos(a)

// %sym_acos
//-----------------------------------------------------------------
// Arc Cosine of symbolic objects
// Element by element if applied to a matrix

    a = sym(a);

    if part(a.str1,[1:7]) == 'matrix(' | part(a.str1,[1:7]) == 'MATRIX(';
       str1 = 'matrixmap(acos,'+a.str1+')';
    else
       str1 = 'acos('+a.str1+')';
    end;

    sym1 = str2max2sym(str1);

endfunction
