function [sym1] = coeffs(a,x,n)

// coeffs
//-----------------------------------------------------------------
// PURPOSE
// Retrieves  polynomial  coefficients  using  the  Maxima function
// ratcoeff.
//
// SYNOPSIS
// cof = coeffs(A,x[,n])
//
// INPUT ARGUMENTS
// A      Polynomial  symbolic  expression. Don't use with rational
//        expressions.
// x      Symbolic atom appearing in A.
// n      Integer, power of x in A. By default n = 1
//
// OUTPUT ARGUMENT
// cof    Symbolic expression: coefficient of x^n in A
//
// See also numden, degrees, findsym
//#----------------------------------------------------------------
// // EXAMPLES
//    P = sym('(a+b+c)^3-(a+b+c)^2');
//    simple(P,'a')
//
//    cof_a_0 = coeffs(P,'a',0)
//    cof_a_1 = coeffs(P,'a',1)
//    cof_a_2 = coeffs(P,'a',2)
//    cof_a_3 = coeffs(P,'a',3)

// Author: : J.F. Magni
// 20-02-2006

    [%nargout,%nargin] = argn(0);

    if %nargin < 3; n = 1; end;
    if %nargin < 2; error('At least 2 input arguments'); end;

    // Check that a is not a rational expression

    // [num,den] = numden(a);
    // if typeof(den) ~= 'constant'; error('Only polynomial expressions'); end;

    // Extract coefficient
    x = sym(x);

    str1 = 'ratcoeff('+a.str1+','+x.str1+','+string(n)+')';

    sym1 = str2max2sym(str1);

endfunction
