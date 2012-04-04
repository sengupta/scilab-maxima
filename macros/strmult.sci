function c = strmult(a,b)

//-----------------------------------------------------------------
// PURPOSE
// Multiplication  of  strings  similar to symbolic multiplication.
// This is used to replace symbolic multiplication for intermediate
// calculus (symbolic  multiplication calls Maxima, so, needs a lot
// of CPU time).
//
// SYNOPSIS
// cc = strmult(aa,bb)
//
// See also strminus, stradd, strvconcat, strhconcat,
//#----------------------------------------------------------------
// // EXAMPLE
//   strmult(['a','b';'1','2'],['1';'2'])
//   strmult(['a','b';'1','2'],'c')

// Author: : J.F. Magni
// 20-02-2006

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

// Multiplication by a scalar
[n1,n2]  = size(a);
[n22,n3] = size(b);

if n1==1 & n2==1;
   aa = string(zeros(n22,n22));
   for ii = 1:n22; aa(ii,ii) = a; end;
   a = aa;
end;
if n22==1 & n3==1;
   aa = string(zeros(n2,n2));
   for ii = 1:n2; aa(ii,ii) = b; end;
   b = aa;
end;

// Matrix multiplication
[n1,n2]  = size(a);
[n22,n3] = size(b);

if n2 ~= n22; error('Incompatible sizes for multiplication'); end;

for ii = 1:n1;
for jj = 1:n3;

    ciijj = '';
    for kk = 1:n2;
       if kk == 1
          if a(ii,kk) ~= '0' & b(kk,jj) ~= '0';
             ciijj = ciijj + '('+a(ii,kk)+')*('+b(kk,jj)+')';
          else
             ciijj = ciijj + '0';
          end;
       else
          if a(ii,kk) ~= '0' & b(kk,jj) ~= '0';
             ciijj = ciijj + '+('+a(ii,kk)+')*('+b(kk,jj)+')';
          end;
       end;
    end;
    c(ii,jj) = ciijj;

end;
end;

endfunction
