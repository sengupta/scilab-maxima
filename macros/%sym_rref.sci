function b = %sym_rref(a)

// %sym_rref
//-----------------------------------------------------------------
// PURPOSE
// Computes the row echelon form of a matrix (Gaussian elimination)
// using the Maxima function echelon.
//
// SYNOPSIS
// B = rref(A)
//
// INPUT ARGUMENTS
// A      Symbolic  matrix
//
// OUTPUT ARGUMENT
// B      Symbolic  matrix
//
// See also sym/triu, sym/tril
//#----------------------------------------------------------------
// // EXAMPLES
//   syms a b
//   M = [1 2*b 3*a;2 3*b 0;a*b 0 1];
//   B = rref(M)

// Author: : J.F. Magni
// 04-04-2006

    a = sym(a);
    str1 = 'echelon('+a.str1+')';
    b = str2max2sym(str1);

endfunction
