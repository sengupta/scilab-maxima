function %syml_p(a)

// %syml_p
// Displays symbolic lists

   // Send a to Maxima for simplification
   str = a.str1;
   newa = str2max2sym(str);

   // Set a.str1 to the simplified version
   strdisp = newa.str1;

   // Repace MATRIX( , matrix( by list->
   if isempty(strindex(strdisp,'MATRIX(')) & isempty(strindex(strdisp,'matrix('));
      disp('symbolic list -> '+strdisp);
      //write(%io(2),'symbolic list -> '+strdisp,'(a)');
   else
      strdisp = strsubst(strdisp,'MATRIX(','symbolic list -> ');
      strdisp = strsubst(strdisp,'matrix(','symbolic list -> ');
      strdisp = part(strdisp,[1:length(strdisp)-1]);
      disp(strdisp);
      //write(%io(2),strdisp,'(a)');
   end;

endfunction
