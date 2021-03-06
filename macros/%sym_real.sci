function [sym1] = %sym_real(a)

// %sym_real
//-----------------------------------------------------------------
// PURPOSE
// Real part of a symbolic object depending on REAL parameters.
//
// SYNOPSIS
// b = real(a)
//
// DESCRIPTION
// Note  that  symbolic variables are assumed to be complex or real
// depending  on the version of Maxima (real version 5.9.1, complex
// for version 5.9.2 or higher). If you intend to use the functions
// real,  imag,  conj  or  abs, it is better to declare the type of
// atoms when they are defined (see example below).
//
// See also sym/imag, sym/conj, sym/abs
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b 'real'
//    c = (a+%i*b)^3
//    real(c)
//    imag(c)

// CONJUGATE  works for Maxima 5.9.1, check if it must be replaced
// by conjugate for Maxima 5.9.2

    a = sym(a);

    str1 = 'fullratsimp(0.5*('+a.str1+'+conjugate('+a.str1+')))';
    // From version 5.9.3 the following command should be equivalent
    // str1 = 'realpart('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction
