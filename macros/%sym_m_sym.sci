function sym1 = %sym_m_sym(a,b)

// %sym_m_sym
// Product of symbolic objects

// Warning: .-product rather than *-product for matrices, the
// *-product performs elementwise multiplication

   // if ~isempty(strindex(a.str1,'matrix([')) & ~isempty(strindex(b.str1,'matrix(['));
   //    str1 = '('+a.str1+').('+b.str1+')';
   // else
   //    str1 = '('+a.str1+')*('+b.str1+')';
   // end;

   // sym1 = str2max2sym(str1);

   str1 = strmult(a,b);

   if sum(length(str1)) > 600
      sym1 = str2max2sym(str1);
   else
      sym1 = mlist(['sym';'str1'],scistr2max(str1));
   end;

endfunction
