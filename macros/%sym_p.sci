function %sym_p(a)

// %sym_p
// Display symbolic objects

   // Empty
   if isempty(a.str1) | a.str1 == ' ' | a.str1 == '  '| a.str1 == '   ';
      disp('[]');
      return;
   end;

   // Send a to Maxima for simplification
   newa = str2max2sym(a.str1);

   // Set a.str1 to the simplified version
   a.str1 = newa.str1;

   // Transform to Scilab syntax for display
   strdisp = max2scistr(newa.str1);
   disp(strdisp);
   //for ii = 1:size(strdisp,1); write(%io(2),strdisp(ii,:),'(a)'); end;

endfunction
