function sym1 = %sym_exp(a)

// %sym_exp
//-----------------------------------------------------------------
// PURPOSE
// Element-wise exponential of a symbolic matrix
//
// SYNOPSIS
// A = exp(B)
//
// CAUTION
// The  part of the function max2scistr concerning the function exp
// must  be rewritten for supporting expressions like %e^-(...) and
// so on.
//#----------------------------------------------------------------
// // EXAMPLE:
// syms a b c d
// M = [a^5*b 4;a*b*c^3*d a*d]
// P = exp(M)
// P^2

    a = sym(a);

    str1 = '%e^('+a.str1+')';

    sym1 = str2max2sym(str1);

endfunction

