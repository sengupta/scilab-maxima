function sym1 = %sym_expand(a)

// %sym_expand
//-----------------------------------------------------------------
// PURPOSE
// Expands a rational expressions using the Maxima function expand
//
// SYNOPSIS
// B = expand(A)
//
// INPUT ARGUMENT
// A      Rational (possibly matrix) symbolic expression.
//
// OUTPUT ARGUMENT
// B      Expanded symbolic expression
//
// See also sym/simple, sym/factor
//#----------------------------------------------------------------
// // EXAMPLE
//    A = sym('3*(a+b+c)^3-(a+b-c)^3')
//    B = expand(A)

// Author: : J.F. Magni
// 20-02-2006

    a = sym(a);

    str1 = 'expand('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction
