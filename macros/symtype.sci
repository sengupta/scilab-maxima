function [typp] = symtype(a)

// symtype
//-----------------------------------------------------------------
// PURPOSE
// Retrieves  the  type  of  a symbolic variables from Maxima work-
// space  within  the following list: even, odd, integer, rational,
// irrational, real, imaginary, complex.
//
// SYNOPSIS
// tp = symtype(aa)
//
// INPUT ARGUMENTS
// aa        Symbolic  ATOM  defined  in  the  Scilab workspace. By
//           default, aa is assumed to be real.
//
// OUTPUT ARGUMENT
// tp        Maxima type of the symbolic object aa..
//
// See also: declare, syms, sym
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b c d
//    declare a b 'real' c d 'imaginary'
//    symtype(a)
//    symtype(d)

   typp = 'real';

   a = sym(a);

// Order important e.g., an integer is also rational

   str = 'featurep('+a.str1+',even)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'even'; return; end;

   str = 'featurep('+a.str1+',odd)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'odd'; return; end;

   str = 'featurep('+a.str1+',integer)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'integer'; return; end;

   str = 'featurep('+a.str1+',rational)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'rational'; return; end;

   str = 'featurep('+a.str1+',irrational)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'irrational'; return; end;

   str = 'featurep('+a.str1+',real)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'real'; return; end;

   str = 'featurep('+a.str1+',imaginary)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'imaginary'; return; end;

   str = 'featurep('+a.str1+',complex)';
   str = str2max2sym(str,'str');
   if str == 'true'; typp = 'complex'; return; end;

endfunction
