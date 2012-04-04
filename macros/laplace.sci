function [sym1] = laplace(A,t,s)

// laplace
//-----------------------------------------------------------------
// PURPOSE
// Laplace  transform.  Recognizes the functions or strings: delta,
// exp,  log, sin, cos, sinh, cosh, erf and ilt (name of the Maxima
// inverse Laplace transform).
//
// SYNOPSIS
// B = laplace(A[,t[,s]])
//
// INPUT ARGUMENTS
// A       Symbolic expression.
// t       Time variable ('t' by default)
// s       Laplace variable ('s' by default)
//
// OUTPUT ARGUMENT
// B       Symbolic expression.
//
// See also: ilaplace, sym/integ
//#----------------------------------------------------------------
// // EXAMPLE
//    syms t s
//    laplace('3*delta(t-2)+cos(t)*sin(t)',t,s)
//    laplace('3*delta(t-2)+cos(t)*sin(t)',t,'p')
//    laplace(diff(cos(t)^3,t),t,s)

// Author: : J.F. Magni
// 18-04-2006

    [%nargout,%nargin] = argn(0);
    if %nargin ~= 1 & %nargin ~= 2 & %nargin ~= 3; error('One to three arguments'); end;

    if %nargin == 1; t = 't'; s = 's'; end;
    if %nargin == 2; s = 's'; end;

    A = sym(A);
    t = sym(t);
    s = sym(s);
    str1 = 'laplace('+A.str1+','+t.str1+','+s.str1+')'

    sym1 = str2max2sym(str1);

endfunction
