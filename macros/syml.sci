function LOCALa=syml(name_a)

//-----------------------------------------------------------------
// PURPOSE
// Defines  Maxima  lists  of symbolic objects. Maxima lists are of
// the  form  [a,b,c] (row vectors without the 'matrix(.)' string).
// No  operation  can  be applied to these objects.  Useful only as
// arguments  of  the  function  'maxima'  when  a list is expected
// rather than a matrix..
//
// SYNOPSIS
// a_syml = syml(a_str)
//
// DESCRIPTION
// Returns a list of symbolic objects compatible with Maxima syntax
// (syml-object) from an arguments of type
// - constant,
// - string,
// - polynomial,
// - rational,
// - symbolic,
// - Scilab list
//
// See also: maxima, mhlp, sym, syms
//#----------------------------------------------------------------
// // EXAMPLES
//    X = syml(['a+b*2+3*a' 'cos(c)' '1/(3*a-sin(c))' '3'])
//    X.str1
//
//    syms a b
//    Y = [a^2-3*b a*b*5]
//    Y_list = syml(Y)
//
//    Z = syml(['2*a+b=1','a-3*b=2'])
//
//    syms x
//    arg2_for_plot2d = syml([x,-%pi,%pi])
//    maxima('plot2d',(1+cos(x))/(2+sin(x)),arg2_for_plot2d);


// Quick return if already syml-object

   if typeof(name_a) == 'syml';
      LOCALa = name_a;
      return
   end;

// Consider first as a sym-object

   LOCALa = sym(name_a);

// Transform to syml-object

   [n1,n2] = size(LOCALa);
   if n1 ~= 1 &  n2 ~= 1; error('Symbolic lists are ''vectors'''); end;

   str = LOCALa.str1;

   if isempty(strindex(str,'MATRIX(')) & isempty(strindex(str,'matrix('));
      LOCALa = mlist(['syml';'str1'],LOCALa.str1);
      return;
   end;

   // Remove Matrix
   str = strsubst(str,'MATRIX(','');
   str = strsubst(str,'matrix(','');
   str = part(str,[1:length(str)-1]);
   str = strsubst(str,';',',');

   // Remove blanks
   str = strsubst(str,'   ','');
   str = strsubst(str,'  ','');
   str = strsubst(str,' ','');
   str = strsubst(str,'   ','');
   str = strsubst(str,'  ','');
   str = strsubst(str,' ','');

   LOCALa = mlist(['syml';'str1'],str);

endfunction
