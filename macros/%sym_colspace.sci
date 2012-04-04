function [cspace,warn] = %sym_colspace(a)

// %sym_colspace
//-----------------------------------------------------------------
// PURPOSE
// Null  space  of  a  symbolic  matrix  using  the Maxima function
// colspacespace.
//
// SYNOPSIS
// [I,warn] = colspace(A)
//
// INPUT ARGUMENTS
// A      Symbolic  matrix
//
// OUTPUT ARGUMENT
// I      Symbolic  matrix: column space.
// warn   String giving restrictions on column span validity.
//
// See also sym/rank, sym/null
//#----------------------------------------------------------------
// // EXAMPLES
//   syms a b
//   M = [a 2*a 3*a;b 2*b 3*b];
//   [I,warn] = colspace(M)

// Author: : J.F. Magni
// 04-04-2006

   a = sym(a);

// Scalar case
   if maxi(size(a)) == 1;
      warn = 'Scalar case, check that argument is non-zero';
      cspace = 1;
      return
   end;

// Matrix case
   str1 = 'columnspace('+a.str1+')';
   sym1 = str2max2sym(str1,'vec');

   // Isolate warnings
   if maxi(size(sym1)) > 1;
      warn = sym1(1);
      warn = strsubst(warn,'#','~=');
      x = sym1($);
   else
      warn = '';
      x = sym1(1);
   end;

   // Remove span()
   if ~isempty(strindex(x,'span('));
      x = part(x,[6:1:length(x)-1]);
   end;

   // x is something like : matrix([0],[1],[-2/3]),matrix([1],[0],[-1/3])
   colspacestr = [];
   xind = strindex(x,',matrix(');
   xind = [0,xind,length(x)+1];
   for ii = 1:length(xind)-1;
      strii = part(x,[xind(ii)+1:1:xind(ii+1)-1]);
      xii = max2scistr(strii);
      colspacestr = [colspacestr xii];
   end;

   cspace = sym(colspacestr);

endfunction
