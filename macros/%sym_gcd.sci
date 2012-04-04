function [g,f1,f2] = %sym_gcd(p1,p2,x)

// %sym_gcd
//-----------------------------------------------------------------
// PURPOSE
// Computes  the greatest common divisor of polynomials.
//
// SYNOPSIS
// [gg,f1,f2] = gcd(aa,bb,xx)
//
// INPUT ARGUMENTS
// aa     Symbolic polynomial
// bb     Symbolic polynomial
// xx     Variable considered (multivariate polynomials).
//
// OUTPUT ARGUMENT
// gg    Greatest common divisor symbolic polynomial
// f1    Symbolic polynomial
// f2    Symbolic polynomial: p1*f1+p2*f2 = gg
//
// See also sym/lcm
//#----------------------------------------------------------------
// // EXAMPLE
//    syms x
//    p1 = x^3+x;
//    p2 = x^5+x^3+4*x^2+4;
//    [g,f1,f2] = gcd(p1,p2)
//
//    simple(f1*p1+f2*p2-g)

// Author: : J.F. Magni
// 20-02-2006

   [%nargout,%nargin] = argn(0);
   if %nargin < 2; error('Three arguments required'); end;
   // Not compatible with gcd applied to Scilab polynomials

   p1 = sym(p1);
   p2 = sym(p2);

   if %nargin == 2;
      xs = findsym(p1+p2);
      if maxi(size(xs)) ~= 1; error('Third argument required'); end;
      x = xs(1);
   end;

   if maxi(size(p1)) ~= 1 | maxi(size(p2)) ~= 1;
      error('Scalar polynomials required');
   end;

   x = sym(x);

   str1 = 'gcdex('+p1.str1+','+p2.str1+','+x.str1+')';

   sym1 = str2max2sym(str1,'str');
   sym1 = sym(sym1);

   g =  sym1(3);
   f1 = sym1(1);
   f2 = sym1(2);

endfunction
