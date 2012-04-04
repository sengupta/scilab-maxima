function [sym1] = %sym_limit(varargin)

// %sym_limit
//-----------------------------------------------------------------
// PURPOSE
// Computes  the  limit  of  a symbolic expression using the Maxima
// function limit
//
// SYNOPSIS
// B = limit(A,xx,xx0[,sign])
//
// INPUT ARGUMENT
// A     Rational (possibly matrix) symbolic expression.
// xx    Symbolic atom appearing in A. The limit of A is considered
//       w.r.t. xx.
// xx0   Constant. Value of xx at which the limit is evaluated.
// sign  String equal to '-' or '+', indicates left or right limit.
//
// OUTPUT ARGUMENT
// B     Limit in symbolic form.
//
// See also sym/diff, sym/integ
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a
//    limit(cos(a),a,%pi/4)

// Author: : J.F. Magni
// 20-02-2006


    n = length(varargin);
    if n < 3; error('Three or four arguments expected'); end;
    if n > 4; error('Three or four arguments expected'); end;

    a = sym(varargin(1));
    str1 = 'limit('+a.str1+',';

    for ii = 2:n;
       b = sym(varargin(ii));
       str1 = str1+b.str1+',';
    end;

    str1 = part(str1,[1:length(str1)-1]);
    str1 = str1+')';

    sym1 = str2max2sym(str1);

endfunction
