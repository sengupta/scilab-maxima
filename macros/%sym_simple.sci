function [sym1] = %sym_simple(varargin)

// %sym_simple
//-----------------------------------------------------------------
// PURPOSE
// Simplification  of  symbolic  expressions using the Maxima func-
// tions fullratsimp and trigrat.
//
// SYNOPSIS
// B = simple(A[,x1[,x2,...]])
//
// CAUTION
// The  name  of  this function is misleading, it is not similar to
// the Matlab simple function....
//
// INPUT ARGUMENTS
// A    Rational symbolic expression
// xi   Symbolic  atoms appearing in A for ordering factorisations.
//
// OUTPUT ARGUMENT
// B    Simplified symbolic expression
//
// See also sym/expand, sym/factor
//#----------------------------------------------------------------
// // EXAMPLES
//
//    A = sym('3*(a+b+c)^3-(a+b-c)^3');
//    B0 = simple(A)
//    B1 = simple(A,'a')
//    syms b
//    B2 = simple(A,b)
//
//    syms a real
//    G = [cos(a) sin(a);-sin(a) cos(a)]
//    simple(G^2)
//    simple(G'*G)

// Author: : J.F. Magni
// 20-02-2006

n = length(varargin);

// use of fullratsimp
a = varargin(1);
a = sym(a);
str1 = 'fullratsimp('+a.str1+',';

for ii = 2:n;
   b = varargin(ii);
   b = sym(b);
   str1 = str1+b.str1+',';
end;

str1 = part(str1,[1:length(str1)-1]);
str1 = str1+')';
sym1 = str2max2sym(str1);

// Further simplification
//sym1 = str2max2sym('trigsimp('+sym1.str1+')');
if size(sym1,1) == 1 & size(sym1,2) == 1;
  sym1 = str2max2sym('trigrat('+sym1.str1+')');
else
  sym1 = str2max2sym('matrixmap(trigrat,'+sym1.str1+')');
end;

endfunction
