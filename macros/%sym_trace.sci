function b = %sym_trace(a)

// %sym_trace
//-----------------------------------------------------------------
// PURPOSE
// Computes the trace of a symbolic square matrix
//
// SYNOPSIS
// B = trace(A)
//
// INPUT ARGUMENTS
// A     Symbolic square matrix
//
// OUTPUT ARGUMENT
// B     Symbolic expression
//
// See also sym/eig, sym/diag, sym/triu, sym/tril
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b c d
//    M = [a^5*b 4;a*b*c^3*d a*d]
//    trace(M)

// Author: : J.F. Magni
// 20-02-2006

a = sym(a);

[n1,n2] = size(a);
b = 0;

if n1 == n2;
// from square matrix to vector

   for ii = 1:n1;
      b =  b + a(ii,ii);
   end;

else

   error('Square symbolic matrix');

end;

endfunction
