function sym1 = %sym_f_sym(a,b)

// %sym_f_sym
// Vertical concatenation of symbolic objects

  //  // Transform to scilab string arrrays
  //  array_a_str = max2scistr(a.str1);
  //  array_b_str = max2scistr(b.str1);
  //  // Concatenate string arrays
  //  str0 = [array_a_str;array_b_str];
  //  // Back to Maxima matrix description
  //  str1 = scistr2max(str0);
  //
  //  sym1 = str2max2sym(str1);

   if %sym_isempty(a); sym1 = b; return; end;
   if %sym_isempty(b); sym1 = a; return; end;

   str1 = strvconcat(a,b);

   if sum(length(str1)) > 600
      sym1 = str2max2sym(str1);
   else
      sym1 = mlist(['sym';'str1'],scistr2max(str1));
   end;

endfunction
