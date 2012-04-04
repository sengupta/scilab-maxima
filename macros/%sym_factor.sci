function [sym1] = %sym_factor(a)

// %sym_factor
//-----------------------------------------------------------------
// PURPOSE
// Factorization  of rational expressions using the Maxima function
// factor.
//
// SYNOPSIS
// B = factor(A)
//
// INPUT ARGUMENTS
// A     Rational symbolic expression
//
// OUTPUT ARGUMENT
// B     Factorized symbolic expression
//
// See also sym/expand, sym/simple
//#----------------------------------------------------------------
// // EXAMPLE
//    A = sym('((a+b+c)^2-(d+e+f)^2)/(a^2-b^2)');
//    A = expand(A)
//    B = factor(A)

// Author: : J.F. Magni
// 20-02-2006

    a = sym(a);

    str1 = 'factor('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction
