function [str,var] = ra2str(a)

// ra2str
//-----------------------------------------------------------------
// PURPOSE
// Utility  for evaluation from values in the workspace of rational
// expressions .
//
// SYNOPSIS
// [str,var] = ra2str(r_expr)
//
// INPUT ARGUMENTS
// r_expr   Scilab standard rational expression
//
// OUTPUT ARGUMENT
// str      String which can be evaluated
//#----------------------------------------------------------------
// // EXAMPLE
//   r_expr = [%s 3*%s 1/%s;2+1/(1+3*%s) 2 %s];
//   [str,var] = ra2str(r_expr)

// Author: : J.F. Magni
// 20-02-2006

// Find variable (convert to polynomial)

   [p m] = size(a);
   for i = 1:p;
   for j = 1:m;
       aij = a(i,j);
       num = numer(aij);
       den = denom(aij);
       if typeof(num) == 'polynomial' then var = varn(num); break; end;
       if typeof(den) == 'polynomial' then var = varn(den); break; end;
   end;
   end;

// To string entry per entry

   str = "[";

   for i = 1:p;
   for j = 1:m;
       aij = a(i,j);
       num = numer(aij);
       den = denom(aij);

       if typeof(den) == 'polynomial' & typeof(num) == 'polynomial' then
          // On account of a bug of the function string applied to the 0-polynomial
          if num == 0 then stringnum = '0'; else stringnum = pol2str(num); end;
          entrystr = '('+stringnum+')/('+pol2str(den)+')';
       elseif typeof(den) == 'polynomial' then
          entrystr = '('+string(num)+')/('+pol2str(den)+')';
       elseif typeof(num) == 'polynomial' then
          // On account of a bug of the function string applied to the 0-polynomial
          if num == 0 then stringnum = '0'; else stringnum = pol2str(num); end;
          entrystr = '('+stringnum+')/('+string(den)+')';
       else
          entrystr = '('+string(num)+')/('+string(den)+')';
       end;

       if j < m then
          str = str+entrystr+',';
       elseif j == m & i < p then
          str = str+entrystr+';';
       else
          str = str+entrystr+']';
       end;

    end;
    end;

endfunction

