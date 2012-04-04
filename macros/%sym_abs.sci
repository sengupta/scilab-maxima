function [sym1] = %sym_abs(a)

// %sym_abs
//-----------------------------------------------------------------
// PURPOSE
// Absolute value
//
// SYNOPSIS
// bb = abs(aa)
//
// DESCRIPTION
// Note  that  symbolic variables are assumed to be complex or real
// depending  on the version of Maxima (real version 5.9.1, complex
// for version 5.9.2 or higher). If you intend to use the functions
// real,  imag,  conj  or  abs, it is better to declare the type of
// atoms when they are defined (see example below).
//
// See also sym/real, sym/imag, sym/conj
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b 'real'
//    c = a+%i*b
//    abs(c)

   if ~exists('MAXVERSION');
      error('Global variable MAXVERSION deleted: reload the symbolic toolbox');
   end;

   a = sym(a);

   if MAXVERSION == '5.9.1';
      str1 = 'ABS('+a.str1+')';
   else
      str1 = 'abs('+a.str1+')';
   end;

   sym1 = str2max2sym(str1);

endfunction
