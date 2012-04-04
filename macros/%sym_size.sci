function [dims1,dims2] = %sym_size(a,flag)

// %sym_size
//-----------------------------------------------------------------
// PURPOSE
// Computes the size of a sym-object
//
// SYNOPSIS
// n1n2 = size(A)
// [n1,n2] = size(A)
// ni = size(A,ii)
//
// INPUT ARGUMENTS
// A       Symbolic matrix
// ii      integer equal to 1 or 2
//#----------------------------------------------------------------
// // EXAMPLE
//   M = sym(['1' 'a' '2';'3' 'b' 'c'])
//   n1n2 = size(M)
//   [n1,n2] = size(M)
//   size(M,1)
//   size(M,2)

    [%nargout,%nargin] = argn(0);
    if %nargin == 1; flag = 0; end;

    a = sym(a);

    // Transform to Scilab string
    str2  = max2scistr(a.str1);
    // Object size is the size of the string array
    if %nargout == 1;
       if flag == 1;
          dims1 = size(str2,1);
       elseif flag == 2;
          dims1 = size(str2,2);
       else
          dims1 = size(str2);
       end;
    else
       if %nargin ~= 1; error('Incompatibles LHS and RHS'); end;
       dims1 = size(str2,1);
       dims2 = size(str2,2);
    end;


endfunction
