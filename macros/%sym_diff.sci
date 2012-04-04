function [sym1] = %sym_diff(varargin)

// %sym_diff
//-----------------------------------------------------------------
// PURPOSE
// Differentiates  symbolic  expressions  using the Maxima function
// diff.
//
// SYNOPSIS
// B = diff(A,x1);
// B = diff(A,x1,n1,x2,n2,...,xi,ni)
//
// INPUT ARGUMENTS
// A       Symbolic expression.
// x1,x2   Symbolic atoms appearing in A: differentiation w.r.t. xi
// n1,n2   Integers. Order of the differentiation w.r.t. xi. ni = 1
//         by default.
//
// OUTPUT ARGUMENT
// B       Symbolic expression.
//
// See also sym/integ, sym/limit, sym/taylor
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b
//    diff(a^3/b^4,a,2,b,2)
//    diff('a^3/b^4','a',2,'b',2)

// Author: : J.F. Magni
// 20-02-2006

    n = length(varargin);

    if n < 2; error('At least two arguments'); end;

// Simple case df/dx

    if n == 2;

       func = sym(varargin(1));
       variable = sym(varargin(2));

       str1 = 'diff('+func.str1+','+variable.str1+')';

       // Execute in Maxima Retrieve result from Maxima
       sym1 = str2max2sym(str1);

       return

    end;

// General case: higher derivatives w.r.t. more than one variable

    if n > 2;
       if round((n-1)/2) ~= (n-1)/2;
          error('Invalid number of argumernts');
       end;

       func = sym(varargin(1));
       str1 = 'diff('+func.str1;

       for ii = 1:(n-1)/2;

          variable = sym(varargin(2*ii));
          if typeof(varargin(2*ii+1)) ~= 'constant';
             error('Differentiation order should be an integer');
          end;
          if round(varargin(2*ii+1)) ~= varargin(2*ii+1);
             error('Differentiation order should be an integer');
          end;

          str1 = str1 + ',' + variable.str1 + ',' + string(varargin(2*ii+1));

       end;

       str1 = str1 + ')';
       // Execute in Maxima Retrieve result from Maxima
       sym1 = str2max2sym(str1);

       return
    end;

endfunction
