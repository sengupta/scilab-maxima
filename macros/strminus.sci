function c = strminus(a,b)

//-----------------------------------------------------------------
// PURPOSE
// Substraction  of  strings similar to symbolic substraction. This
// function  is  used  to replace symbolic substraction for interm-
// ediate  calculus  (symbolic substraction calls Maxima, so, needs
// a lot of CPU time).
//
// SYNOPSIS
// cc = strminus(aa,bb)
//
// See also: stradd, strmult, strvconcat, strhconcat,
//#----------------------------------------------------------------
// // EXAMPLE
//   strminus(['a','b';'1','2'],['1','2';'a','b'])


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

if n2 ~= n22 | n1 ~= n11; error('Incompatible sizes for addition'); end;

for ii = 1:n1;
for jj = 1:n2;

    c(ii,jj) = '('+a(ii,jj)+')-('+b(ii,jj)+')';

end;
end;

endfunction
