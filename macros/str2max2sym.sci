function [sym1,iserr,formaxima] = str2max2sym(str1,flag)

// str2max2sym
//-----------------------------------------------------------------
// PURPOSE
// Transforms a set of strings into a set of instructions in Maxima
// syntax  (see  scistr2max). The Maxima commands are executed (see
// unix_g). Then, the result is treated and converted to a symbolic
// object.
//
// SYNOPSIS
// [resp,iserr] = str2max2sym(str1[,flag])
//
// INPUT ARGUMENTS
// str1   String  like  'conjugate(a+%i*b)'  (a function applied to
//        an argument still in Scilab syntax.
// flag   String  equal  to  'str', 'vec' or 'sym' (default: flag =
//        'sym').  This  flag  sets the type of the output argument
//        sym as follows:
//        - case 'str' -> concatenated string
//        - case 'vec' -> vector of strings
//        - case 'sym' -> symbolic object
//
// OUTPUT ARGUMENTS
// resp   sym-object,
// iserr  Should be equal to 0 if no error occured.
//
// See also max2scistr, scistr2max
//#----------------------------------------------------------------
// // EXAMPLE
//   resp = str2max2sym('matrix([a,b],[c,d])','cos(%)')
//   resp = str2max2sym(['a','b';'c','d'],'cos(%)')
//   resp = str2max2sym('[a,b;c,d]','cos(%)')

// Author: : J.F. Magni
// 20-02-2006

   [%nargout,%nargin] = argn(0);
   global MAX SYMDIR INTERFACE

   if %nargin == 1;
      flag = 'sym';
   end;

// Executable path
   if ~exists('MAX');
      error('Global variable MAX deleted: reload the symbolic toolbox');
   else
      maxima_bin = MAX;
   end;

// Symbolic toolbox directory
   if ~exists('SYMDIR');
      error('Global variable SYMDIR deleted: reload the symbolic toolbox');
   end;

// Generation of the string to send to Maxima
// str1 transformed to a matrix in Maxima syntax
   if flag ~= 'str';
      str1 = scistr2max(str1);
   end;

// Execution in Maxima
   if INTERFACE == 'win32';
      rep = unix_g(PERL+' ""'+SYMDIR+'perl\interface"" ""'+ str1+';""');
   elseif INTERFACE == 'perl' & MSDOS;
      rep = unix_g(PERL+' ""'+SYMDIR+'perl\interface"" ""'+ str1+';""');
   elseif INTERFACE == 'perl' & ~MSDOS;
      rep = unix_g(PERL+' '+SYMDIR+'perl/interface '''+ str1+';''');
   else
      // Perl interface rewritten in C and compiled for OS ~ INTERFACE
      rep = unix_g(SYMDIR+INTERFACE+'/interface '''+ str1+';''');
      rep = rep(1);
   end;

// Check error: to be adapted to new version based on server/socket
   if ~isempty(strindex(rep,'ERROR'));
      disp('An error occured in Maxima. The command was:');
      disp(str1);
      error('');
   end;

// Transformation to symbolic object if flag ~= 'str'
   // Break lines at new lines <=> split(rep,/<NEW_LINE>/)
   newlines = strindex(rep,'<NEW_LINE>');
   if newlines(1) == 1; rep = part(rep,[11:1:length(rep)]); newlines = strindex(rep,'<NEW_LINE>'); end;
   newlines = newlines - ones(size(newlines,1),size(newlines,2));
   if ~isempty(newlines);
      rep = strsplit(rep,newlines);
      rep = strsubst(rep,'<NEW_LINE>','');
   end;

   // Rtrieve result depending on option 'str' or not
   if flag == 'str';
      sym1 = strcat(rep);
   elseif flag == 'vec';
      sym1 = rep;
   else
      sym1 = mlist(['sym';'str1'],rep($));
   end;

endfunction
