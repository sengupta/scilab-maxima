function b = bfloat(a,n)

// bfloat
//-----------------------------------------------------------------
// PURPOSE
// Converts  all numbers and functions of numbers in input argument
// to bigfloat numbers.
//
// SYNOPSIS
// bb = bfloat(aa,nn)
//
// DESCRIPTION
// Big  float numbers might have a very large number of significant
// digits,  therefore,  these  numbers  are  meaningless  in Scilab
// workspace.  For  this  reason the Maxima form (e.g. 3.333333b-1)
// is  preserver.  For  an  evaluation in Scilab workspace, use the
// function double.
//
// INPUT ARGUMENT
// aa       Symbolic expression or symbolic number
// nn       number of significant digits
//
// OUTPUT ARGUMENT
// bb       Symbolic expression or symbolic number
//
// See also float, sym/dbl
//#----------------------------------------------------------------
// // EXAMPLE:
//    x = log(sym('3')) - log(3)
//    y = float(x)
//
//    bfloat(sym('%pi'),2400) // pi with 2400 digits

   [%nargout,%nargin] = argn(0);
   if %nargin == 1; n = 20; end;

   mexec('fpprec:'+string(n)');

   a = sym(a);
   str1 = 'bfloat('+a.str1+')';

   b = str2max2sym(str1);

endfunction

