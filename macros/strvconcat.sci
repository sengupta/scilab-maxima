function c = strvconcat(a,b)

//-----------------------------------------------------------------
// PURPOSE
// Vertical  concatenation  of strings similar to symbolic vertical
// concatenation.  This  function is used to replace symbolic vert-
// ical  concatenation  for intermediate  calculus  (symbolic vert-
// ical  concatenation calls Maxima, so, needs a lot of CPU time).
//
// SYNOPSIS
// cc = strvconcat(aa,bb)
//
// See also stradd, strminus, strmult, strhconcat,
//#----------------------------------------------------------------
// // EXAMPLE
//   strvconcat(['a','b';'1','2'],['1','2';'a','b'])

if typeof(a) == 'constant';
   a = string(a);
elseif typeof(a) == 'sym';
   a = max2scistr(a.str1);
end;

if typeof(b) == 'constant';
   b = string(b);
elseif typeof(b) == 'sym';
   b = max2scistr(b.str1);
end;


[n1,n2]  = size(a);
[n11,n22] = size(b);

if n2 ~= n22; error('Incompatible sizes for vertical concatenation'); end;

c = [a;b];

endfunction
