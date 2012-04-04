function c = strhconcat(a,b)

//-----------------------------------------------------------------
// PURPOSE
// Horizontal  concatenation  of strings similar to symbolic horiz-
// ontal  concatenation.  This function is used to replace symbolic
// horizontal  concatenation  for  intermediate  calculus (symbolic
// horizontal  concatenation  calls  Maxima, so, needs a lot of CPU
// time).
//
// SYNOPSIS
// cc = strhconcat(aa,bb)
//
// See also stradd, strmunus, strmult, strvconcat,
//#----------------------------------------------------------------
// // EXAMPLE
//   strhconcat(['a','b';'1','2'],['1','2';'a','b'])


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

if n1 ~= n11; error('Incompatible sizes for horizontal concatenation'); end;

c = [a b];

endfunction
