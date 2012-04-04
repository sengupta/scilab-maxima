function LOCALa=sym(name_a,typ)

//-----------------------------------------------------------------
// PURPOSE
// Main  function  of  the  symbolic  toolbox for defining symbolic
// objects (sym-objects)
//
// SYNOPSIS
// a_sym = sym(a_str[,type])
//
// DESCRIPTION
// Main  function  of the symbolic toolbox as it returns a symbolic
// object (sym-object) from an argument of type
// - constant,
// - string,
// - polynomial
// - rational
// - list
// - (sym)
// A  sym-object X  is an mlist containing a string compatible with
// Maxima : X.str1.  In future versions additional strings might be
// considered.
//
// INPUT ARGUMENTS
// a_str     String  defining  a  symbolic atom or a combination of
//           symbolic  atoms (see example below). a_str can also be
//           a  constant,  polynomial, rational, symbolic or a list
//           object, in this case it is converted to a sym-object.
// type      String  defining  the  type  of  all atoms involved in
//           a_str.   Supported  types  are:  even,  odd,  integer,
//           rational, irrational, real, imaginary or complex.
//
// OUTPUT ARGUMENT
// a_sym     Symbolic object.
//
// See also: syms, symtype
//#----------------------------------------------------------------
// EXAMPLES
//    a = sym('a'); b = sym('b');
//    Y = [a^2-3*b a*b*5];
//    Y.str1
//
//    a = sym('a','odd');
//    symtype(a)
//
//    X = sym(['a+b*2+3*a' 'cos(c)';'1/(3*a-sin(c))' '3'])
//    X.str1
//
//    Z = sym('x^2+y^3+z','imaginary');
//    real(Z)
//    symtype('z') // string 'z' because the atom z is not in Scilab workspace
//
//    M=[0.33333333 0.85858585;0.122122122 0.22222222];
//    sym(M)
//
//    syms a
//    0.33333333*a
//    '0.33333333'*a

   [%nargout,%nargin] = argn(0);

   if %nargin == 0; LOCALa = mlist(['sym';'str1'],''); return; end;

   if %nargin == 1; typ = 'default'; end;
   typelist = ["even","odd","integer","rational","irrational","real","imaginary","complex","default"];
   okay = %f;
   for ii = 1:maxi(size(typelist));
      if typ == typelist(ii); okay = %t; end;
   end
   if ~okay; error('Bad second argument'); end;

   if typeof(name_a) == 'sym';
      LOCALa = name_a;
      return
   elseif typeof(name_a) == 'syml';
      // Conversion of symbolic list to sym-object
      name_a = scistr2max(name_a.str1);
      LOCALa = mlist(['sym';'str1'],name_a);
   elseif typeof(name_a) == 'string';
      // Definition of a new 1-by-1 sym-object
      name_a = scistr2max(name_a);
      LOCALa = mlist(['sym';'str1'],name_a);
   elseif typeof(name_a) == 'constant';
      // Conversion of constant to sym-object
      [num,den] = rat(name_a,100*%eps);
      for ii=1:size(name_a,1);
      for jj=1:size(name_a,2);
         strname_a(ii,jj) = string(num(ii,jj))+'/'+ string(den(ii,jj));
      end;
      end;
      name_a = scistr2max(strname_a);
      LOCALa = mlist(['sym';'str1'],name_a);
   elseif typeof(name_a) == 'polynomial'
      // Conversion of polynomial to sym-object
      x = varn(name_a);
      str =  ra2str(name_a);
      execstr(x+'=sym('''+x+''');');
      LOCALa = evstr(str);
   elseif typeof(name_a) == 'rational';
      // Conversion of rational to sym-object
      den = denom(name_a); num = numer(name_a);
      x = varn2(name_a);
      str =  ra2str(name_a);
      execstr(x+'=sym('''+x+''');');
      LOCALa = evstr(str);
   elseif typeof(name_a) == 'list';
      // Scilab lists
      nl = length(name_a);
      str = 'matrix([';
      for ii = 1:nl;
         elemii = sym(name_a(ii));
         if ii < nl;
            str = str+elemii.str1+',';
         else
            str = str+elemii.str1;
         end;
      end;
      str = str + '])';
      LOCALa = mlist(['sym';'str1'],str);
   else
      error('Cannot be converted to sym-object');
   end;

   if typ ~= 'default'
      // search list of atoms
      str1 = 'listofvars('+LOCALa.str1+')';
      str2 = syml(str2max2sym(str1));

      // Remove type if exist
      typelist = syml(["even","odd","integer","rational","irrational","real","imaginary","complex"]);
      maxima('remove',str2,typelist);

      // Define new type
      maxima('declare',str2,typ);
   end;

endfunction
