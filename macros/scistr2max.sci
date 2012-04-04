function [str1] = scistr2max(array_str1)

// scistr2max
//-----------------------------------------------------------------
// PURPOSE
// Transforms  a  Scilab  string  array  describing a matrix into a
// matrix compatible with Maxima.
//
// SYNOPSIS
// str2 = scistr2max(str1)
//
// INPUT ARGUMENTS
// str1    Simple  string or array of strings or string of the form
//         '[a,b;c,d]'
//
// OUTPUT ARGUMENT
// str2    String compatible with Maxima
//
// See also max2scistr, str2max2sym
//#----------------------------------------------------------------
// // EXAMPLES
//    scistr2max('a')
//    scistr2max('[a*b c^3*4;0 a*b/c^2]')
//    scistr2max(['a*b' 'c^3*4';'0' 'a*b/c^2'])
//    scistr2max('matrix([a*b,c^3*4],[0,a*b/c^2]')

// Author: : J.F. Magni
// 20-02-2006

// If a function is applied to a matrix, e.g., cos(M), the strings
// 'cos(' and ')' are added in the function file %sym_cos.sci.

[r_dim,c_dim] = size(array_str1);

// Quick return in 1-by-1 case
if r_dim ==1 & c_dim == 1 & isempty(strindex(array_str1,'['));
   str1 = array_str1;
   return;
end;

// 1-by-1 case and string containing '['
if r_dim ==1 & c_dim == 1 & ~isempty(strindex(array_str1,'['));

   p1 = strindex(array_str1,'[');
   p2 = strindex(array_str1,']');

   // Case string already compatible with Maxima
   if ~isempty([strindex(array_str1,'matrix(') strindex(array_str1,'MATRIX(')]);
      str1 = array_str1;
      return

   // String of the form '[a*b c^3*4;0 a*b/c^2]'
   elseif length(p1) == 1 & length(p2) == 1;

      str2 = part(array_str1,[p1:p2]);

      str2 = strsubst(str2,'     ',' ');
      str2 = strsubst(str2,'    ',' ');
      str2 = strsubst(str2,'   ',' ');
      str2 = strsubst(str2,'  ',' ');

      str2 = strsubst(str2,'[ ','[');
      str2 = strsubst(str2,' ]',']');
      str2 = strsubst(str2,'[','matrix([');
      str2 = strsubst(str2,']','])');

      str2 = strsubst(str2,' ; ',';');
      str2 = strsubst(str2,';','],[');

      str2 = strsubst(str2,' ',',');

      str1 = str2;
      return

   else
       error('Strings supported: ''[.,.;.,.]'' (no space, single square brackets pair)');
   end;

end;

// Case array_str1 is a matrix of strings
str1 = 'matrix(';

for ii = 1:r_dim;

   for jj = 1:c_dim;
      if jj == 1 & jj == c_dim;
      // Single column case
         str1 = str1 + '['+ array_str1(ii,jj) + '],';
      elseif jj == 1;
         str1 = str1 + '['+ array_str1(ii,jj) + ',';
      elseif jj == c_dim
         str1 = str1 + array_str1(ii,jj) + '],';
      else
         str1 = str1 + array_str1(ii,jj) + ',';
      end;
   end;

end;

str1 = part(str1,[1:length(str1)-1]);
str1 = str1 + ')';

endfunction


