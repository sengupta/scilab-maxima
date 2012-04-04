function lists = extractlist(str);

// extractlist
//-----------------------------------------------------------------
// PURPOSE
// This  function  extracts  symbolic  objects  from  some kinds of
// strings returned by Maxima. It is a sub-function of the function
// maxima so, can be ignored by the user.
//
// SYNOPSIS
// lists = extractlist(str)
//
// DESCRIPTION
// The  kind of strings supported by this function consists of sub-
// strings limited by square brackets. In each sub-string an equal-
// ity is expected. Example of supported strings:
// [[x = s_x1,y = s_y1,z = s_z1],[x = s_x2,y = s_y2, z = s_z2]]
// This function returns a structured array of the form:
//   lists.x(1) = s_x1; lists.x(2) = s_x2;
//   lists.y(1) = s_y1; lists.y(2) = s_y2;
//   lists.z(1) = s_z1; lists.z(2) = s_z2;
// in which s_x1, s_y1,... are symbolic objects.
//
// INPUT ARGUMENT
// str     String  returned by some Maxima functions (see the above
//         example).
//
// OUTPUT ARGUMENT
// lists   Structured  array containing symbolic objects. The field
//         names of this structured array are the expected variable
//         names (see the above example).
//
// See also maxima
//#----------------------------------------------------------------
// // EXAMPLES
//   sym1 = maxima('solve','a*x^2-x+3=0','x');
//   sym1.x
//
//   equs = syml(['a*x+2*y-5*z=a','x^2=4','a*x+b*y=5']);
//   unkn = syml(['x','y','z']);
//   sym2 = maxima('solve',equs,unkn);
//   sym2.x
//   sym2.y
//   sym2.z

openbr = strindex(str,'[');
closbr = strindex(str,']');
allbr = sort([openbr closbr]);
allbr = allbr([length(allbr):-1:1]);

// strlist(ii) is a sub-strings of str contained between [ and ]
kk = 1;
lastop = 0;
for ii = 1:length(allbr);
   if part(str,allbr(ii)) == '['; lastop = allbr(ii); end;
   if part(str,allbr(ii)) == ']' & lastop ~= 0;
      strlist(kk) = part(str,[lastop+1:1:allbr(ii)-1]);
      lastop = 0;
      kk = kk + 1;
   end;
end;

// str2(jj) is a sub-string of strlist(ii), substring separated by a coma
lists = [];
for ii=1:maxi(size(strlist));
   str = strlist(ii);
   str2 = tokens(str,',');
   for jj = 1:maxi(size(str2));
      str3 = str2(jj);
      // Split str2(jj) at =, on the left -> field name
      equ = strindex(str3,' = ');
      if ~isempty(equ);
         // Field name
         xxx = part(str3,[1:1:equ(1)-1]);
         xxx = strsubst(xxx,' ','');
         // Value corresponding to field name
         yyy = part(str3,[equ(1)+3:1:length(str3)]);
         // Identify current indice ll of lists.x(ll) (field name assumed to be x)
         test = evstr('exists(''LOCAL_'+xxx+''')');
         if ~test;
            execstr('LOCAL_'+xxx+'=1');
            ll = 1;
         else
            execstr('LOCAL_'+xxx+'=LOCAL_'+xxx+'+1');
            ll = evstr('LOCAL_'+xxx);
         end;
         // Set lists.x(ll) to value corresponding to field name
         execstr('lists.'+xxx+'('+string(ll)+')=0');
         execstr('lists.'+xxx+'('+string(ll)+')=sym('''+yyy+''')');
      end;
   end;
end;

endfunction
