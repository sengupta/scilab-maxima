function sym1 = mfun(varargin)

// mfun
//-----------------------------------------------------------------
// PURPOSE
// Execute a function with several arguments in Maxima and retrieve
// result.
//
// SYNOPSIS
// numb = mfun(function,arg1,arg2,...)
//
// DESCRIPTION
// Use  restricted  to   Maxima  functions returning a number. Type
// 'mhlp  maxima_function'  for a description of a Maxima function.
//
// INPUT ARGUMENTS
// function  String: name of a Maxima function
// arg1,arg2 Strings, sym-objects or syml-objects: arguments of the
//           Maxima  function.  Note  that  syml-objects  have been
//           implemented  specifically for the function 'maxima' as
//           some  Maxima functions require input arguments defined
//           as lists rather than matrices.
//
// OUTPUT ARGUMENT
// numb      Scilab floating point number.
//
// See also: maxima, mhlp, syml
//#----------------------------------------------------------------
// // EXAMPLES
//   x = mfun('cos','%pi/4')
//   x = mfun('binomial',11,7)

// Author: : J.F. Magni
// 18-04-2006

   n = length(varargin);
////////////////////////////////////////////////////////////////////////////////
// Generate string to evaluate in Maxima

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
// Execution in Maxima and retrieve result in rep and transform to floating point

   rep = str2max2sym(formaxima);
   sym1 = dbl(rep)

endfunction