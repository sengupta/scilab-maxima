function sym1 = mexec(str1,flag)

// mexec
//-----------------------------------------------------------------
// PURPOSE
// Executes  a  string in Maxima and retrieves Maxima response as a
// string.  For  retrieving a symbolic object from Maxima workspace
// use preferably the function 'maxima'.
//
// SYNOPSIS
// resp = mexec(str1[,flag])
//
// INPUT ARGUMENTS
// str1   String in Maxima syntax like  'conjugate(a+%i*b)'
// flag   String  equal  to  'str' or 'vec'(default: flag = 'vec').
//        This  flag  sets the type of the output argument as:
//        <br>- case 'str' -> concatenated string
//        <br>- case 'vec' -> vector of strings
//
// OUTPUT ARGUMENT
// resp   String.
//
// See also maxima, str2max2sym
//#----------------------------------------------------------------
// // EXAMPLE
//   resp = mexec('%pi-b$ cos(%)')
//   mexec('load(ntrig)')

// Author: : J.F. Magni
// 20-02-2006

   [%nargout,%nargin] = argn(0);
   global MAX SYMDIR INTERFACE

   if %nargin == 1;
      flag = 'vec';
   end;

// Command canno end with $
   if part(str1,length(str1)) == '$'; str1 = part(str1,[1:1:length(str1)-1]); end;
   // Still problem e.g. if str1 = 'toto$ '

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

// Treatment of result
   // Break the line at '<NEW_LINE>' <=> split(rep,/<NEW_LINE>/)
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
   else
      sym1 = rep;
   end;

endfunction
