function [num,den] = numden_bak(a);

//-----------------------------------------------------------------
// PURPOSE
// Retrieves numerator and denominator of a rational symbolic matrix
//
// SYNOPSIS
// [num,den] = numden_bak(A);
//
// INPUT ARGUMENTS
// A      Rational symbolic expression
//
// OUTPUT ARGUMENT
// num    Symbolic expression
// den    Symbolic expression
//
// See also: numden, coeffs, degrees, findsym
//#----------------------------------------------------------------
// // EXAMPLE
//   syms a b
//   M = [2*a/(1+b) 0;1 a/b];
//   [num,den] = numden_bak(M)

// Author: : J.F. Magni
// 20-02-2006

// Check Maxima version if version < 5.9.2 the use of float(%) freezes

   isfloat = %t;
   verifver = sort([MAXVERSION,'5.9.2']);
   if verifver(1) ~= '5.9.2';
      warning('This function requires Maxima version >= 5.9.2');
      isfloat = %f;
   end;

// Find num/den elementwise for a matrix

    a = sym(a);

    astr1 = max2scistr(a.str1); // string array
    [n1,n2] = size(astr1);

    for ii = 1:n1;
    for jj = 1:n2;

       // Element (ii,jj) of the string array symplified via ratsimp
       if isfloat;
          aijstr = 'fullratsimp('+astr1(ii,jj)+')$ float(%)';
       else
          aijstr = 'fullratsimp('+astr1(ii,jj)+')';
       end;
       aij =  str2max2sym(aijstr);

       // look for division
       kk = strindex(aij.str1,'/');
       p1 = strindex(aij.str1,')');
       p2 = strindex(aij.str1,'(');

       if length(kk) > 1;
          error('Problem using ratsimp in Maxima or argument wasn''t rational');
       elseif length(kk) == 0;
          num(ii,jj) = aij;
          den(ii,jj) = 1;
       elseif (p1<kk) == (p2<kk); // same number of ( and ) on both sides of /
          num(ii,jj) = sym(part(aij.str1,[1:kk-1]));
          den(ii,jj) = sym(part(aij.str1,[kk+1:length(aij.str1)]));
       else
          num(ii,jj) = aij;
          den(ii,jj) = 1;
       end;

    end;
    end;

endfunction
