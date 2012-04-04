function str = latex(a);

// latex
//-----------------------------------------------------------------
// PURPOSE
// Transforms  a  symbolic  expression  to a string compatible with
// LaTeX.
//
// SYNOPSIS
// str = latex(expr)
//
// INPUT ARGUMENTS
// expr   Symbolic expression.
//
// OUTPUT ARGUMENT
// str    LaTeX  string  corresponding  to  'expr'  compatible with
//        amsmath style.
//
// See also fortran
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b c d
//    M = [a^5*b 4;a*b*c^3*d a*d]
//    latex(M)

   a = sym(a);

   // Execute tex in Maxima
   formaxima = 'tex('+a.str1+')';
   str = str2max2sym(formaxima,'str');
   if ~isempty(strindex(str,'\pmatrix{'));
      str = strsubst(str,'\pmatrix{','\begin{pmatrix}');
      str = strsubst(str,'}$$','\end{pmatrix}$$');
   end;

endfunction
