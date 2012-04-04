function c = strchsign(a)

//-----------------------------------------------------------------
// PURPOSE
// Change "sign" of strings.
// This is used to replace symbolic change of sign for intermediate
// calculus (symbolic  multiplication calls Maxima, so, needs a lot
// of CPU time).
//
// SYNOPSIS
// cc = strchsign(aa)
//
// See also strminus, stradd, strvconcat, strhconcat, strpow
//#----------------------------------------------------------------
// // EXAMPLE
//   strchsign('1/(c+b)')
//   strchsign(['a+1','b';'1','2/a'])

// Author: : J.F. Magni
// 20-02-2006

if typeof(a) == 'constant';
   a = string(a);
elseif typeof(a) == 'sym';
   a = max2scistr(a.str1);
end;

[n1,n2]  = size(a);

for ii = 1:n1;
for jj = 1:n2;

  c(ii,jj) = '-('+a(ii,jj)+')';

end;
end;

endfunction
