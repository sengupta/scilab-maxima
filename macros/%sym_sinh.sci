function [sym1] = %sym_sinh(a)

// %sym_sinh
// Sine Hyperbolic
// Element by element if applied to a matrix

    a = sym(a);

    if part(a.str1,[1:7]) == 'matrix(' | part(a.str1,[1:7]) == 'MATRIX(';
       str1 = 'matrixmap(sinh,'+a.str1+')';
    else
       str1 = 'sinh('+a.str1+')';
    end;

    sym1 = str2max2sym(str1);

endfunction
