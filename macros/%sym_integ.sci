function [sym1] = %sym_integ(varargin)

// %sym_integ
//-----------------------------------------------------------------
// PURPOSE
// Intergrates  a  symbolic  expression  using  the Maxima function
// integrate.
//
// SYNOPSIS
// B = integ(A,xx[,x_min,x_max])
//
// INPUT ARGUMENTS
// A       Symbolic expression.
// xx       Symbolic atom appearing in A: integration w.r.t. xx
// x_min   Lower bound for integration.
// x_max   Upper bound for integration.
//
// OUTPUT ARGUMENT
// B     Symbolic expression.
//
// See also sym/diff, sym/limit, sym/taylor
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b
//    P=[a a^2;b 3];
//    integ(P,a)

// Author: : J.F. Magni
// 20-02-2006

    n = length(varargin);
    if n ~= 2 & n ~= 4; error('Two or four arguments'); end;

    a = sym(varargin(1));
    str1 = 'integrate('+a.str1+',';

    for ii = 2:n;
       b = sym(varargin(ii));
       str1 = str1+b.str1+',';
    end;

    str1 = part(str1,[1:length(str1)-1]);
    str1 = str1+')';

    sym1 = str2max2sym(str1);

endfunction
