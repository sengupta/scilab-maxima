function [sym1] = ilaplace(A,t,s)

// ilaplace
//-----------------------------------------------------------------
// PURPOSE
// Inverse laplace transform.
//
// SYNOPSIS
// B = ilaplace(A[,s[,t]])
//
// INPUT ARGUMENTS
// A       Symbolic expression.
// t       Time variable ('t' by default)
// s       Laplace variable ('s' by default)
//
// OUTPUT ARGUMENT
// B       Symbolic expression.
//
// See also: laplace
//#----------------------------------------------------------------
// // EXAMPLE
//    syms t p
//    ilaplace('exp(-2*p)/(1+p^2)',p,t) // Maxima ignores Heaviside!
//    ilaplace('1/(p*(1+p^2))',p,t)
//    laplace(ilaplace(1/p^2,p,t),t,p)

// Author: : J.F. Magni
// 18-04-2006

    [%nargout,%nargin] = argn(0);
    if %nargin ~= 1 & %nargin ~= 2 & %nargin ~= 3; error('One to three arguments'); end;

    if %nargin == 1; t = 's'; s = 't'; end;
    if %nargin == 2; s = 't'; end;

    A = sym(A);
    t = sym(t);
    s = sym(s);
    str1 = 'ilt('+A.str1+','+t.str1+','+s.str1+')'

    sym1 = str2max2sym(str1);

endfunction
