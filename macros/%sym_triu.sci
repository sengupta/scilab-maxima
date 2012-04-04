function [b] = %sym_triu(a,k)

// %sym_triu
//-----------------------------------------------------------------
// PURPOSE
// Upper triangular form of a matrix
//
// SYNOPSIS
// B = triu(A[,kk])
//
// INPUT ARGUMENTS
// A     Symbolic matrix
// kk    Integer. By default kk=0. If kk is negative |kk| lower sub-
//       diagonals  are not set to zero. If kk is positive, the main
//       diagonal  and the kk-1 following upper subdiagonals are set
//       to zero.
//
// OUTPUT ARGUMENT
// B     Upper diagonal form of A if kk = 0,...
//
// See also sym/tril, sym/diag, sym/rref
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b c d
//    X = [a^5*b 4 c;a*b a*d c^3*d;1 2 a]
//    triu(X)
//    triu([X X],1)
//    triu([X X],-1)

   [%nargout,%nargin] = argn(0);
   if %nargin == 1; k = 0; end;

    a = sym(a);

   [nr,nc] = size(a);
   astr = max2scistr(a.str1);

   for ii = 2-k:nr;
   for jj = 1:ii+k-1;
      if ii > 0 & jj > 0 & ii <= nr & jj <= nc;
         astr(ii,jj) = '0';
      end;
   end;
   end;

   b = sym(astr);

endfunction
