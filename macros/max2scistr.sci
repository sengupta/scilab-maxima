function [array_str1] = max2scistr(str1)

// max2scistr
//-----------------------------------------------------------------
// PURPOSE
// Transforms a string in Maxima syntax to Scilab syntax
//
// SYNOPSIS
// str2 = max2scistr(str1)
//
// DESCRIPTION
// Treats  in  particular  matrices.  If a function is applied to a
// matrix,  say cos(matrix([...])) this function is applied element
// by element (provisional). For improving this feature, the string
// associated  to  a symbolic object (a.str1) must be replaced by a
// list or a series of strings.
//
// INPUT ARGUMENT
// str1    String compatible with Maxima
//
// OUTPUT ARGUMENT
// str2    String  compatible  with Scilab (used for display or ev-
//         aluation)
//
// See also scistr2max, str2max2sym
//#----------------------------------------------------------------

// Author: : J.F. Magni
// 20-02-2006

// Most substitution below are relevant for Maxima 5.9.1 but useless
// for Maxima 5.9.2.

// Substitute first long strings e.g. ATANH before TAN otherwiswe -> AtanH !
// COPY THESE SUBSTITUTIONS IN maxima.sci
str0 = str1;

str1 = strsubst(str1,'ATANH(','atanh(');
str1 = strsubst(str1,'ACOSH(','acosh(');
str1 = strsubst(str1,'ASINH(','asinh(');

str1 = strsubst(str1,'COTH(','coth(');
str1 = strsubst(str1,'TANH(','tanh(');
str1 = strsubst(str1,'COSH(','cosh(');
str1 = strsubst(str1,'SINH(','sinh(');

str1 = strsubst(str1,'ATAN(','atan(');
str1 = strsubst(str1,'ACOS(','acos(');
str1 = strsubst(str1,'ASIN(','asin(');

str1 = strsubst(str1,'COT(','cotg(');  // Different names in Scilab and Maxima
str1 = strsubst(str1,'TAN(','tan(');
str1 = strsubst(str1,'COS(','cos(');
str1 = strsubst(str1,'SIN(','sin(');

str1 = strsubst(str1,'SQRT(','sqrt(');
str1 = strsubst(str1,'conjugate(','conj(');
str1 = strsubst(str1,'CONJUGATE(','conj(');
str1 = strsubst(str1,'LOG(','log(');
str1 = strsubst(str1,'realpart(','real(');
str1 = strsubst(str1,'REALPART(','real(');
str1 = strsubst(str1,'imagpart(','imag(');
str1 = strsubst(str1,'IMAGPART(','imag(');

str1 = strsubst(str1,'%PI','%pi');
str1 = strsubst(str1,'Inf','%inf');
str1 = strsubst(str1,'INF','%inf');
str1 = strsubst(str1,'IND','%nan');
str1 = strsubst(str1,'Nan','%nan');
str1 = strsubst(str1,'%I','%i');

// Special treatment of exponentials
str1 = strsubst(str1,'%E','%e');      // For old releases of Maxima
str1 = strsubst(str1,'%e^(','exp(');  // Note %e^4 remains %e^4
// IMPORTANT : treat %e^-(....) %e^-4 in priority as not compatible with Scilab

// 'matrix(' for Maxima 5.9.2, 'MATRIX(' for Maxima 5.9.1
iiMATRIX = [strindex(str1,'matrix([') strindex(str1,'MATRIX([')];

// Matrix treatment
if ~isempty(iiMATRIX);
   // Matrix treatment
   // matrix([  -> ['
   str1 = strsubst(str1,'matrix([','[''');
   str1 = strsubst(str1,'MATRIX([','[''');
   // last ])  or last ]); -> '] and last ])) -> ']) and so on
   str1 = str1+'#';   // for identifying the end of the string
   str1 = strsubst(str1,'])#',''']');
   str1 = strsubst(str1,']);#',''']');
   str1 = strsubst(str1,']))#','''])');     // one function applied
   str1 = strsubst(str1,'])))#',''']))');   // two functions applied
   str1 = strsubst(str1,']))))#','''])))'); // three functions applied
   if ~isempty(strindex(str1,')))))#')); error('Too many functions applied'); end;
   // , -> '];['
   str1 = strsubst(str1,'],[','''];[''');
   // other comas -> ','
   str1 = strsubst(str1,',',''',''');
else
   // Below for avoiding evaluation from workspace
   str1 = ''''+str1+'''';
end;

// Special case when a function is applied to a matrix
i1 = strindex(str1,'([''');
i2 = strindex(str1,'''])');
if ~isempty(strindex(str1,'(['''));
// e.g., cos(['a^5*b','4'];['27*a*b*d','a*d'])
// Warning: cos applied element-wise here. Can be modified
// if sym-object is upgraded e.g., sym.str2 = 'cos(%)'.
   lhs = part(str1,[1:i1]);
   rhs = part(str1,[i2+2:length(str1)]);
   str2 = '['+part(str1,[i1+1:i2+1])+']'; // evaluate -> string array
   array_str2 = evstr(str2);
   array_str1 = lhs + array_str2 + rhs;
else
   array_str1 = evstr(str1);
end;

endfunction


