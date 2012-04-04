function b = float(a)

// float
//-----------------------------------------------------------------
// PURPOSE
// Converts  integers,  rational  numbers  and  bigfloats  in input
// argument to floating point numbers.
//
// SYNOPSIS
// bb = float(aa)
//
// INPUT ARGUMENT
// aa      Symbolic expression or expression which can be converted
//         into  a symbolic expression  (e.g., a string) before its
//         numerical evaluation is returned in b.
//
// OUTPUT ARGUMENT
// bb      Symbolic expression or symbolic number
//
// See also bfloat, sym/dbl
//#----------------------------------------------------------------
// EXAMPLES:
//    syms b
//    %pi*b
//    float(%pi*b)
//
//    float('(1/3)*a')

    a = sym(a);
    str1 = 'float('+a.str1+')';

    b = str2max2sym(str1);

endfunction

