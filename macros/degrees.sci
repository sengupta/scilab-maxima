function [sym1] = degrees(a,x)

// degrees
//-----------------------------------------------------------------
// PURPOSE
// Retrieves  degrees  of  polynomial  expressions using the Maxima
// function hipow.
//
// SYNOPSIS
// deg = degrees(A,x)
//
// INPUT ARGUMENTS
// A      Polynomial  symbolic  expression. Don't use with rational
//        expressions.
// x      Symbolic atom appearing in A.
//
// OUTPUT ARGUMENT
// deg    Scalar (or matrix): partial degree(s) of x in A
//
// See also numden, coeffs, findsym
//#----------------------------------------------------------------
// // EXAMPLES
//    P = sym('[(a+b+c)^3-a^3;a*b*c]');
//    expand(P)
//
//    degrees(P,'a')
//    degrees(P,'b')
//    degrees(P,'c')

// Author: : J.F. Magni
// 20-02-2006

    [%nargout,%nargin] = argn(0);
    if %nargin < 2;
       param = findsym(a);
       if maxi(size(param)) > 1;
          error('At least 2 input arguments');
       else
          x = param;
       end;
    end;

    // Check that a is not a rational expression

    // BAD TEST so removed
    [num,den] = numden(a);
    // if typeof(den) ~= 'constant'; warning('Function ''degrees'' only for polynomial expressions'); end;

    // Extract coefficient

    a = %sym_expand(num);
    x = sym(x);

    for ii = 1:size(den,1);
    for jj = 1:size(den,2);

       aij = a(ii,jj);

       str1 = 'hipow('+aij.str1+','+x.str1+')';

       sym1(ii,jj) = str2max2sym(str1);

    end;
    end;

endfunction
