function b = jordan(a)

// jordan
//-----------------------------------------------------------------
// PURPOSE
// Jordan. Not working as expected....
//
// SYNOPSIS
// J = jordan(A)
//
// INPUT ARGUMENTS
// A      Symbolic  matrix
//
// OUTPUT ARGUMENT
// J      Symbolic  matrix
//#----------------------------------------------------------------
// EXAMPLES
//   syms a
//   M = [1 2 a;2 3 0;1 0 1];
//   J = jordan(M)

// Author: : J.F. Magni
// 04-04-2006

    a = sym(a);
    str1 = 'dispJordan(jordan('+a.str1+'))';
    b = str2max2sym(str1);

endfunction
