function vars = findsym(a)

// findsym
//-----------------------------------------------------------------
// PURPOSE
// Extracts  the  symbolic  atoms  from a symbolic expression using
// the Maxima function listofvars.
//
// SYNOPSIS
// vars = findsym(expr)
//
// INPUT ARGUMENTS
// expr   Symbolic expression
//
// OUTPUT ARGUMENT
// vars   Symbolic vector.
//
// See also: numden
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b c d
//    M = [a^5*b 4;a*b*c^3*d a*d]
//    findsym(M)

// Author: J.F. Magni
// 20-02-2006

    a = sym(a);

    str1 = 'listofvars('+a.str1+')';
    sym1 = str2max2sym(str1);

    // Trick: transform the list sym1 to a Maxima matrix string
    // (-> matrix([],[]) in case syml corresponds to a matrix)
    vars = max2scistr('matrix('+sym1.str1+')');

endfunction
