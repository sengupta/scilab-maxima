function [sym1] = %sym_det(a)

// %sym_det
//-----------------------------------------------------------------
// PURPOSE
// Computes the determinant of a symbolic square matrix
//
// SYNOPSIS
// B = det(A)
//
// INPUT ARGUMENTS
// A     Symbolic square matrix
//
// OUTPUT ARGUMENT
// B     Symbolic expression
//
// See also sym/eig, sym/diag, sym/trace, sym/inv
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b c d
//    M = [a^5*b 4;a*b*c^3*d a*d]
//    det(M)

// Author: : J.F. Magni
// 20-02-2006

    a = sym(a);

    str1 = 'determinant('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction
