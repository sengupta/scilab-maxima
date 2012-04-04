function sym1 = %sym_t(a)

// %sym_t
// Conjugate transpose of symbolic objects.

    // to Scilab string and transpose Scilab string
    str1 = max2scistr(a.str1);
    str1 = str1';

    // to sym-object and conjugation
    sym1 = str2max2sym(str1);
    sym1 = conj(sym1);

endfunction
