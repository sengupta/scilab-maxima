function sym1 = %sym_s(a)

// %sym_s
// Change of sign of symbolic objects.

    // Symbolic treatment:
    if %f
       str1 = '-('+a.str1+')';
       sym1 = str2max2sym(str1);
    else
       str1 = strchsign(a.str1);
       sym1 = mlist(['sym';'str1'],str1);
    end;

endfunction
