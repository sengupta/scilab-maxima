function  [var] = varn2(a);

//-----------------------------------------------------------------
// PURPOSE
// Find  the variable name in a rational matrix. The standard func-
// tion varn is limited to polynomial arguments.
//
// SYNOPSIS
// [var] = varn2(aa);
//#----------------------------------------------------------------
// // EXAMPLE
//   M = [1/%s+2 3*(%s+5/%s)]
//   varn2(M)

   var = [];

   [p m] = size(a);
   for i = 1:p;
   for j = 1:m;
       aij = a(i,j);
       num = numer(aij);
       den = denom(aij);
       if typeof(num) == 'polynomial' then var = [var varn(num)]; break; end;
       if typeof(den) == 'polynomial' then var = [var varn(den)]; break; end;
   end;
   end;

   // Remark: only one name !

endfunction
