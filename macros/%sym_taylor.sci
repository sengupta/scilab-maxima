function [sym1] = %sym_taylor(varargin)

// %sym_taylor
//-----------------------------------------------------------------
// PURPOSE
// Taylor expansion
//
// SYNOPSIS
// sym1 = taylor(A,xx,x0,pow)
//
// INPUT ARGUMENTS
// A      Symbolic expression.
// xx     Taylor expansion w.r.t. symbolic variable.
// x0     Constant: value of xx where is considered the expansion
// pow    Integer: power of the expansion
//
// OUTPUT ARGUMENT
// sym1   Symbolic expression of the Taylor expansion.
//
// See also sym/diff, sym/integ, sym/limit
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a
//    taylor(cos(a),a,0,4)
//
//    M = sym(['a^3*b';'(1-a^2)'])
//    taylor(M,a,3,2)

// Author: : J.F. Magni
// 20-02-2006

    n = length(varargin);
    if n ~= 4; error('Four arguments expected'); end;

    a = sym(varargin(1));
    str1 = 'taylor('+a.str1+',';

    for ii = 2:n;
       b = sym(varargin(ii));
       str1 = str1+b.str1+',';
    end;

    str1 = part(str1,[1:length(str1)-1]);
    str1 = str1+')';

    sym1 = str2max2sym(str1);

endfunction
