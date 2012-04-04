function [sym1] = %sym_tan(a)

// %sym_tan
// Tangent of symbolic objects
// Element by element if applied to a matrix

    a = sym(a);

    if part(a.str1,[1:7]) == 'matrix(' | part(a.str1,[1:7]) == 'MATRIX(';
       str1 = 'matrixmap(tan,'+a.str1+')';
    else
       str1 = 'tan('+a.str1+')';
    end;

    sym1 = str2max2sym(str1);

endfunction
