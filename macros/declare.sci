function [] = declare(varargin)

// declare
//-----------------------------------------------------------------
// PURPOSE
// Declare  types  of  atoms  in Maxima workspace. This function is
// invoked by other functions of the toolbox.
//
// SYNOPSIS
// declare(aa,bb,string,nn,string,cc,string,...)
//
// INPUT ARGUMENTS
// aa,bb,cc,nn  Symbolic ATOMS
// string       Strings = even, odd, integer, rational, irrational,
//              real, imaginary or complex
//
// See also syms, symtype
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b c d
//    declare a b 'real' c d 'imaginary'
//    symtype(a)
//    symtype(d)


typelist = syml(["even","odd","integer","rational","irrational","real","imaginary","complex"]);

narg = length(varargin);

// Preliminary treatment
for ii = 1:narg;
   var = varargin(ii);
   if typeof(var) == 'sym';
      varargin(ii) = var.str1;
   end;
   if typeof(varargin(ii)) ~= 'string';
      error('Arguments should be strings or sym-objects');
   end;
end

// Building strings
kk = 1;
str = 'declare(';
atoms = 'syml([';

   for ii = 1:narg;
      if varargin(ii) == 'real';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',real,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'complex';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',complex,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'imaginary';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',imaginary,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'integer';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',integer,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'even';
         for jj = 1:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',even,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'odd';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',odd,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'rational';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',rational,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'irrational';
         for jj = kk:ii-1;
            var = sym(varargin(jj));
            str = str + var.str1 + ',irrational,';
            atoms = atoms + '""' + var.str1 + '"",';
         end;
         kk = ii+1;

   end;
end;

str = part(str,[1:length(str)-1]);
str = str + ')';
atoms = part(atoms,[1:length(atoms)-1]);
atoms = atoms + '])';

// First, undeclare to avoid Maxima error
atomlist = evstr(atoms);
maxima('remove',atomlist,typelist);

// Second, declare
str2max2sym(str)

endfunction
