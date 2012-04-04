function sym1 = maxima2(varargin)

//-----------------------------------------------------------------
// PURPOSE
// Execute a function with several arguments in Maxima and retrieve
// result.  Limited  to  Maxima  functions  which return  a  single
// symbolic  object  otherwise  returns  a string instead of a sym-
// object.
//
// SYNOPSIS
// sym = maxima(function,arg1,arg2,...)
//
// INPUT ARGUMENTS
// function  String: name of a Maxima function
// argi      Strings, sym-objects or syml-objects: arguments of the
//           Maxima  function.  Note  that  syml-objects  have been
//           implemented  specifically for the function 'maxima' as
//           some  Maxima functions require input arguments defined
//           as lists rather than matrices.
//
// OUTPUT ARGUMENT
// sym       Symbolic object.
//
// See also: mhlp, syml
//#----------------------------------------------------------------
// // EXAMPLES
//   x = maxima('cos','%pi-a')
//
//   x = maxima('factorsum','a*x*z+a*z+a*w*x+v*x+u*x+a*w+v+u')
//
//   p1=sym('-a*b^2-3*b^2+a^2*b+3*a*b+3*b+a^2+a');
//   p2=sym('-a*b^3-3*b^3-a*b^2+a^3*b+3*a^2*b+a*b+3*b+a^3+a');
//   maxima('gcd',p1,p2)
//
//   p=sym('a^2*b^2-3+a*b*(a-b)*b^6');
//   maxima('scsimp',p,'a=b')
//
// // Case in which a string is returned (note the use of syml)
//   maxima('solve',syml(['a*x+b*y=3','a*x*y = 2']),syml(['x','y']))

// Author: : J.F. Magni
// 20-02-2006

   n = length(varargin);
////////////////////////////////////////////////////////////////////////////////
// Generate string to evaluate in Maxima

   global MAX

   formaxima = varargin(1) +'(';

   for ii = 2:n;

      strii = varargin(ii);

      if typeof(strii) == 'syml';
      // Symbolic lists (already in Maxima format)

         strii = strii.str1;

      else
      // All other kinds of objects

         strii = sym(strii);
         strii = strii.str1;
         // Transfom matrices in Maxima format if necessary
         strii = scistr2max(strii);

      end;

      formaxima = formaxima + strii + ',';

   end;

   formaxima = part(formaxima,[1:length(formaxima)-1])+')'

////////////////////////////////////////////////////////////////////////////////
// Execution in Maxima and retrieve result in rep

   rep = str2max2sym(formaxima,'str');

////////////////////////////////////////////////////////////////////////////////
// Treatment of the result. Note that calling str2max2sym with flag = str'
// prevents treatment of the string via scistr2max

   if isempty(strindex(rep,'=')) & isempty(strindex(rep,'[[')) & isempty(strindex(rep,']]')) & isempty(strindex(rep,'],['));
      sym1 = mlist(['sym';'str1'],rep);
   else
      write(%io(2),'========= Maxima result is returned as a string ============','(a)')
      write(%io(2),'========= Copy and paste the part of result you need =======','(a)')

      // see max2scistr.sci
      rep = strsubst(rep,'ATANH(','atanh(');
      rep = strsubst(rep,'ACOSH(','acosh(');
      rep = strsubst(rep,'ASINH(','asinh(');

      rep = strsubst(rep,'COTH(','coth(');
      rep = strsubst(rep,'TANH(','tanh(');
      rep = strsubst(rep,'COSH(','cosh(');
      rep = strsubst(rep,'SINH(','sinh(');

      rep = strsubst(rep,'ATAN(','atan(');
      rep = strsubst(rep,'ACOS(','acos(');
      rep = strsubst(rep,'ASIN(','asin(');

      rep = strsubst(rep,'COT(','cotg(');  // Different names in Scilab and Maxima
      rep = strsubst(rep,'TAN(','tan(');
      rep = strsubst(rep,'COS(','cos(');
      rep = strsubst(rep,'SIN(','sin(');

      rep = strsubst(rep,'SQRT(','sqrt(');
      rep = strsubst(rep,'conjugate(','conj(');
      rep = strsubst(rep,'CONJUGATE(','conj(');
      rep = strsubst(rep,'LOG(','log(');

      rep = strsubst(rep,'%PI','%pi');
      rep = strsubst(rep,'%E','%e');
      rep = strsubst(rep,'Inf','%inf');
      rep = strsubst(rep,'INF','%inf');
      rep = strsubst(rep,'IND','%nan');
      rep = strsubst(rep,'Nan','%nan');
      rep = strsubst(rep,'%I','%i');

      sym1 = rep;
   end;

endfunction