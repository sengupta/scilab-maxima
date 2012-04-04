function b = %sym_diag(a,k)

// %sym_diag
//-----------------------------------------------------------------
// PURPOSE
// Extracts  the  diagonal of a symbolic square matrix or creates a
// matrix with given symbolic diagonal.
//
// SYNOPSIS
// B = diag(A[,kk])
//
// INPUT ARGUMENTS
// A    Symbolic square matrix or symbolic vector.
// kk   Integer  ignored  if  A is a vector. If kk = 0 (default), B
//      is  the  main  diagonal, if kk > 0, B is the kkth upper sub-
//      diagonal, if kk < 0,  B is the |k|th lower subdiagonal
//
// OUTPUT ARGUMENT
// B     Symbolic  vector if A is not a vector of a square symbolic
//       matrix if A is a vector.
//
// See also sym/eig, sym/trace, sym/triu, sym/tril
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b c d
//    M = [a^5*b 4 d;a*b c^3*d a*d;1 2 3]
//    N = diag(M)
//    diag(N)
//    diag(M,1)
//    diag(M,-1)

// Author: : J.F. Magni
// 20-02-2006

   [%nargout,%nargin] = argn(0);
   if %nargin == 1; k = 0; end;

   [n1,n2] = size(a);
   a = sym(a);

   if n1 == 1;
   // from row vector to diagonal matrix

      b=zeros(n2,n2);
      for ii = 1:n2;
         b(ii,ii) = a(1,ii);
      end;

   elseif n2 == 1;
   // from column vector to diagonal matrix

      b=zeros(n1,n1);
      for ii = 1:n1;
         b(ii,ii) = a(ii,1);
      end;

   else;
   // from matrix to vector

      b = [];
      kk = 1;
      for ii = 1:n1;
         if ii+k > 0 & ii+k <= n2;
            b(kk,1) = a(ii,ii+k);
            kk = kk+1;
         end;
      end;

   end;

endfunction
