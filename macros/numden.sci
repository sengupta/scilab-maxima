function [num,den] = numden(a);

// numden
//-----------------------------------------------------------------
// PURPOSE
// Retrieves  numerators  and  denominators  of a rational symbolic
// matrix  using  the  Maxima  functions   matrixmap,  ratnumer and
// ratdenom.
//
// SYNOPSIS
// [num,den] = numden(A);
//
// INPUT ARGUMENTS
// A      Rational symbolic expression
//
// OUTPUT ARGUMENT
// num    Symbolic expression
// den    Symbolic expression
//
// See also coeffs, degrees, findsym
//#----------------------------------------------------------------
// // EXAMPLE
//   syms a b
//   M = [2*a/(1+b) 0;1 a/b];
//   [num,den] = numden(M)

// Author: : J.F. Magni
// 04-04-2006

   a = sym(a);
   if size(a,1) == 1 & size(a,2) == 1;
      num = str2max2sym('ratnumer('+a.str1+')');
      den = str2max2sym('ratdenom('+a.str1+')');
   else
      num = str2max2sym('matrixmap(ratnumer,'+a.str1+')');
      den = str2max2sym('matrixmap(ratdenom,'+a.str1+')');
   end;

endfunction
