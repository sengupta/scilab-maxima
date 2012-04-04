function [] = syms(varargin)

//-----------------------------------------------------------------
// PURPOSE
// Creates  symbolic  atoms  in Scilab workspace and declares types
// (as real, odd,...) of these atoms in Maxima workspace.
//
// SYNOPSIS
// syms aa bb string nn string cc string
// syms aa bb cc
//
// DESCRIPTION
// By  default,  non  already typed atoms are considered as complex
// (Maxima  5.9.2  or higher) or real (Maxima 5.9.1). If a type was
// already  declared and if a new type is not specified  when  syms
// is  invoked,  the  previously  defined  type is preserved.
//
// INPUT ARGUMENTS
// aa,bb,cc,nn  Strings (names of symbolic atoms)
// string       Strings:  even,  odd, integer, rational, irrational,
//              real, imaginary, complex or default.
//
// See also sym, symtype
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b real c d imaginary
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

// Check if all arguments are typed
var = varargin(narg);
if var ~= 'even' & var ~= 'odd' & var ~= 'integer' & var ~= 'rational' & var ~= 'irrational' & var ~= 'real' & var ~= 'imaginary' & var ~= 'complex';
   if var ~= 'default';
      varargin(narg+1) = 'default';
      narg = narg + 1;
   end;
end;

// Building strings
kk = 1;
str = 'declare(';
atoms = 'syml([';
resumstr1 = '';
resumstr2 = '';

   for ii = 1:narg;
      if varargin(ii) == 'default';
         for jj = kk:ii-1;
            var = varargin(jj);
            // Don't define with type in Maxima workspace
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'real';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',real,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'complex';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',complex,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'imaginary';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',imaginary,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'integer';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',integer,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'even';
         for jj = 1:ii-1;
            var = varargin(jj);
            str = str + var + ',even,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'odd';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',odd,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'rational';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',rational,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

      elseif varargin(ii) == 'irrational';
         for jj = kk:ii-1;
            var = varargin(jj);
            str = str + var + ',irrational,';
            atoms = atoms + '""' + var + '"",';
            execstr('LOCAL_sym_object_' + string(jj) +' = sym(''' + var + ''');');
            resumstr1 = resumstr1  + var + ',';
            resumstr2 = resumstr2  + 'LOCAL_sym_object_' + string(jj) + ',';
         end;
         kk = ii+1;

   end;
end;

str = part(str,[1:length(str)-1]);
str = str + ')';
atoms = part(atoms,[1:length(atoms)-1]);
atoms = atoms + '])';

if atoms ~= 'syml(])'; // Exists type declarations
   // First, undeclare to avoid Maxima error
   atomlist = evstr(atoms);
   maxima('remove',atomlist,typelist);

   // Second, declare types in Maxima workspace
   str2max2sym(str)
end;

// Third, send symbolic atoms to Scilab workspace
resumstr1 = part(resumstr1,[1:length(resumstr1)-1]);
resumstr2 = part(resumstr2,[1:length(resumstr2)-1]);
execstr('['+resumstr1+']=resume('+resumstr2+');');

endfunction
