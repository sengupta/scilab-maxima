function [sym1] = %sym_inv(a)

// %sym_inv
//-----------------------------------------------------------------
// PURPOSE
// Inverts a symbolic matrix using the Maxima function invert.
//
// SYNOPSIS
// B = inv(A)
//
// INPUT ARGUMENT
// A      Symbolic square matrix.
//
// OUTPUT ARGUMENT
// B      Symbolic square matrix.
//
// See also sym/det, sym/rank, sym/rref
//#----------------------------------------------------------------
// // EXAMPLE
//    A = sym(['a-b','a-b';'2','a+b'])
//    B = inv(A)
//    simple(B)

// Author: : J.F. Magni
// 20-02-2006

    a = sym(a);

    str1 = 'invert('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction
