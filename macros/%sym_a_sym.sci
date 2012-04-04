function sym1 = %sym_a_sym(a,b)

// %sym_a_sym
// Sum of symbolic objects

    // str1 = '('+a.str1+')+('+b.str1+')';
    //
    // sym1 = str2max2sym(str1);

   str1 = stradd(a,b);

   if sum(length(str1)) > 600
      sym1 = str2max2sym(str1);
   else
      sym1 = mlist(['sym';'str1'],scistr2max(str1));
   end;

endfunction
