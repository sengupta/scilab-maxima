function [b] = %sym_tril(a,k)

// %sym_tril
//-----------------------------------------------------------------
// PURPOSE
// Lower triangular form of a matrix
//
// SYNOPSIS
// B = tril(A[,kk])
//
// INPUT ARGUMENTS
// A     Symbolic matrix
// kk    Integer. By default kk = 0. If  is negative the main diag-
//       onal  and |kk|-1 lower subdiagonals are set to zero. If kk
//       is positive, kk upper subdiagonals are not set to zero.
//
// OUTPUT ARGUMENT
// B     Lower triangular form of A if kk = 0,...
//
// See also sym/triu, sym/diag
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b c d
//    X = [a^5*b 4 c;a*b a*d c^3*d;1 2 a]
//    tril(X)
//    tril([X X],1)
//    tril([X X],-1)

   [%nargout,%nargin] = argn(0);
   if %nargin == 1; k = 0; end;

   a = sym(a);

   [nr,nc] = size(a);
   astr = max2scistr(a.str1);

   k = -k;
   for jj = 2-k:nc;
   for ii = 1:jj+k-1;
      if ii > 0 & jj > 0 & ii <= nr & jj <= nc;
         astr(ii,jj) = '0';
      end;
   end;
   end;

   b = sym(astr);

endfunction
