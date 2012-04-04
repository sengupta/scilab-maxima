function c = strpow(a,b)

//-----------------------------------------------------------------
// PURPOSE
// Scalar power of a scalar.
// This  is used to replace scalar symbolic powers for intermediate
// calculus  (symbolic  powers call  Maxima, so, needs a lot of CPU
// time).
//
// SYNOPSIS
// cc = strpow(aa,bb)
//
// See also strminus, stradd, strvconcat, strhconcat,
//#----------------------------------------------------------------
// // EXAMPLE
//   strpow('a',2)

// Author: : J.F. Magni
// 20-02-2006

c = '';

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

// All scalars
[n1,n2]  = size(a);
[n22,n3] = size(b);

if n22==1 & n3==1 & n1 == 1, n2 == 1;
   c = '('+a+')^('+b+')';
end;

endfunction
