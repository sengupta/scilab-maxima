function [sym1] = %sym_horner(a,x)

// %sym_horner
//-----------------------------------------------------------------
// PURPOSE
// Factorization  of rational expressions using the Maxima function
// horner.
//
// SYNOPSIS
// B = horner(A[,xx])
//
// INPUT ARGUMENTS
// A     Rational symbolic expression
// xx    Symbolic atom appearing in A selected for factorisations.
//
// OUTPUT ARGUMENT
// B     Symbolic expression in horner form.
//
// See also sym/expand, sym/factor, sym/simple
//#----------------------------------------------------------------
// // EXAMPLE
//    A = sym('((a^2+b+c)^2-(a+b+c))/(a^2-b^2)^2');
//    A = expand(A)
//    B = horner(A,'a')
//    B = horner(A,'b')

// Author: : J.F. Magni
// 20-02-2006

    [%nargout,%nargin] = argn(0);

    a = sym(a);

    if %nargin == 1;
       str1 = 'horner('+a.str1+')';
    else
       x = sym(x);
       str1 = 'horner('+a.str1+','+x.str1+')';
    end;

    sym1 = str2max2sym(str1);

endfunction
