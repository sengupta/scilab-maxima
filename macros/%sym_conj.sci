function [sym1] = %sym_conj(a)

// %sym_conj
//-----------------------------------------------------------------
// PURPOSE
// Conjugation of a symbolic object depending on REAL parameters
//
// SYNOPSIS
// b = conj(a)
//
// DESCRIPTION
// Note  that  symbolic variables are assumed to be complex or real
// depending  on the version of Maxima (real version 5.9.1, complex
// for version 5.9.2 or higher). If you intend to use the functions
// real,  imag,  conj  or  abs, it is better to declare the type of
// atoms when they are defined (see example below).
//
// See also sym/real, sym/imag, sym/abs
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b 'real'
//    c = (a+%i*b)^3
//    conj(c)

   if ~exists('MAXVERSION');
      error('Global variable MAXVERSION deleted: reload the symbolic toolbox');
   end;

   a = sym(a);

   if MAXVERSION == '5.9.1';
      str1 = 'CONJUGATE('+a.str1+')';
   else
      str1 = 'conjugate('+a.str1+')';
   end;

   sym1 = str2max2sym(str1);

endfunction
