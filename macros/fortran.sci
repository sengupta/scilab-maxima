function str = fortran(a,M)

// fortran
//-----------------------------------------------------------------
// PURPOSE
// Transforms  a  symbolic  expression  to a string compatible with
// LaTeX.
//
// SYNOPSIS
// str = fortran(expr[,M]);
//
// INPUT ARGUMENTS
// expr   Symbolic expression.
// M      String  correponding  to the name of the expression expr.
//        If  expr  is  a matrix, this second argument is required,
//        its value is 'M' by default.
//
// OUTPUT ARGUMENT
// str    Fortran string corresponding to 'expr'
//
// See also latex
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b c d
//    fortran(a^2+0.3*b/(0.5+c^2)^2)
//
//    X = [a^5*b 4;a*b*c^3*d a*d]
//    fortran(X,'M')

   [%nargout,%nargin] = argn(0);
   if %nargin == 1;
      M = 'M';
   elseif typeof(M) ~= 'string';
      ~error('The second argument should be a string');
   end;

   a = sym(a);

   if size(a,1) == 1 & size(a,2) == 1;
   // Scalar case
      if %nargout == 1;
         formaxima = 'fortran('+a.str1+')';
         str = str2max2sym(formaxima,'vec');
      else
         formaxima = 'fortran('+M+'='+a.str1+')';
         str = str2max2sym(formaxima,'vec');
      end;
   else
   // Matrix case
      formaxima = 'fortran('+M+'='+a.str1+')';
      str = str2max2sym(formaxima,'vec');
   end;

endfunction
