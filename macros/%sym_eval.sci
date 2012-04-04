function LOCALsym1 = %sym_eval(LOCALa,flag)

// %sym_eval
//-----------------------------------------------------------------
// PURPOSE
// Evaluation  of a symbolic expression from values of the symbolic
// atoms  in Scilab workspace. The atom values in the workspace can
// be constant, polynomial, symbolic.
//
// SYNOPSIS
// B = eval(A)
//
// REMARK
// Needs to be revisited for a special treatment of %pi, %e and %i.
//
// INPUT ARGUMENT
// A      Symbolic expression
//
// OUTPUT ARGUMENT
// B      Evaluated form of A.
//
// See also subs, float, bfloat, sym/dbl
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a b c d e f
//    A = sym(((a+b+c)^2/(d+e+f)))
//    d = a; e = b; f = c;
//    B = eval(A)
//    a = 2; b = 3;
//    C = eval(B)

// Author: : J.F. Magni
// 20-02-2006

[%nargout,%nargin] = argn(0);
if %nargin == 1; flag = %f; end;

LOCALa = sym(LOCALa);

if flag;
// Evaluation in Scilab workspace
// Very long CPU time and result false for very long expressions
    LOCALstr  = max2scistr(LOCALa.str1);
    LOCALsym1 = evstr(LOCALstr);

else
// Evaluate in Maxima workspace

   // retrieve atoms
   symbs = findsym(LOCALa);

   // Create a string to evaluate. String of the form
   // syml(['atom1 = <its_value_in_workspace>','atom2 = <its_value_in_workspace>',...])
   symliststr = 'syml([';
   for ii=1:maxi(size(symbs));
      if exists(symbs(ii));
         valsym = evstr(symbs(ii));
         if typeof(valsym) ~= 'sym';
            valsym = sym(valsym);
         end;
         symliststr = symliststr + '''' + symbs(ii) + ' = ' + valsym.str1 + ''',';
      end;
   end;
   symliststr = part(symliststr,[1:1:length(symliststr)-1])+'])';

   if symliststr ~= 'syml(])'; // If no values from workspace symliststr = 'syml(])'

      // Evaluate LOCALa.str1 in Maxima workspace -> symbolic object
      symlist = evstr(symliststr);
      LOCALstr2 = LOCALa.str1;
      LOCALsym1 = maxima('ev',LOCALstr2,symlist);

      // Put LOCALsym1.str1 in right form in case of matrix  //!!!!!!!!!!
      LOCALsym1 = sym(LOCALsym1.str1);

   else

      LOCALsym1 = LOCALa;

   end;

end;

endfunction
