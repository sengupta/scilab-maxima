function [n,warn] = %sym_rank(a)

// %sym_rank
//-----------------------------------------------------------------
// PURPOSE
// Rank of a symbolic matrix
//
// SYNOPSIS
// [nn,warn] = rank(A)
//
// INPUT ARGUMENTS
// A      Symbolic  matrix
//
// OUTPUT ARGUMENT
// nn     Integer
// warn   String giving restrictions on rank result
//
// See also sym/null, sym/colspace
//#----------------------------------------------------------------
// // EXAMPLES
//   syms a b
//   M = [a 2*a 3*a;b 2*b 3*b];
//   [n,warn] = rank(M)

// Author: : J.F. Magni
// 04-04-2006

    a = sym(a);
    str1 = 'rank('+a.str1+')';
    sym1 = str2max2sym(str1,'vec');

    if maxi(size(sym1)) > 1;
       warn = sym1(1);
       warn = strsubst(warn,'#','~=');
       n = evstr(sym1($));
    else
       warn = '';
       n = evstr(sym1(1));
    end;

endfunction
