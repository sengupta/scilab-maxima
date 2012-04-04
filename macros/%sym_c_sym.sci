function sym1 = %sym_c_sym(a,b)

// %sym_c_sym
// Horizontal concatenation of symbolic objects

   if %sym_isempty(a); sym1 = b; return; end;
   if %sym_isempty(b); sym1 = a; return; end;

   str1 = strhconcat(a,b);

   if sum(length(str1)) > 600
      sym1 = str2max2sym(str1);
   else
      sym1 = mlist(['sym';'str1'],scistr2max(str1));
   end;

endfunction
