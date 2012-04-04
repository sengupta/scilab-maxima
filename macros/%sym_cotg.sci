function [sym1] = %sym_cotg(a)

// %sym_cotg
//-----------------------------------------------------------------
// Cotangent of symbolic objects
// Element by element if applied to a matrix

// Warning: cotg in Scilab = cot in Maxima

    a = sym(a);

    if part(a.str1,[1:7]) == 'matrix(' | part(a.str1,[1:7]) == 'MATRIX(';
       str1 = 'matrixmap(cot,'+a.str1+')';
    else
       str1 = 'cot('+a.str1+')';
    end;


    sym1 = str2max2sym(str1);

endfunction
