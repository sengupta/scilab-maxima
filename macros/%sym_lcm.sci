function g = %sym_lcm(p1,p2)

// %sym_lcm
//-----------------------------------------------------------------
// PURPOSE
// Computes the least common multiple of two polynomials.
//
// SYNOPSIS
// ll = lcm(aa,bb)
//
// INPUT ARGUMENTS
// aa     Symbolic polynomial
// bb     Symbolic polynomial
//
// OUTPUT ARGUMENT
// ll     Least common multiple symbolic polynomial
//
// See also sym/gcd
//#----------------------------------------------------------------
// // EXAMPLE
//    syms x y
//    p1 = y^3+x;
//    p2 = x^5+x^3+4*x^2+4;
//    l = lcm(p1,p2)

// Author: : J.F. Magni
// 20-02-2006

   [%nargout,%nargin] = argn(0);
   if %nargin < 2; error('Two arguments required'); end;
   // Not compatible with lcm applied to Scilab polynomials

   if maxi(size(p1)) ~= 1 | maxi(size(p2)) ~= 1;
      error('Scalar polynomials required');
   end;

   p1 = sym(p1);
   p2 = sym(p2);

   str1 = 'lcm('+p1.str1+','+p2.str1+')';

   mexec('load(functs)');
   g = str2max2sym(str1);

endfunction
