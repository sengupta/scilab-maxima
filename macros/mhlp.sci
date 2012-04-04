function mhlp(func,number)

// mhlp
//-----------------------------------------------------------------
// PURPOSE
// Maxima  help  viewed  in Scilab. This function doesn't work with
// Maxima 5.9.2 on some platforms.
//
// SYNOPSIS
// mhlp func[ number]
//
// INPUT ARGUMENTS
// func    String  expected  to be a part of a Maxima function name
// number  Integer.  If  you  type 'mhlp str', you will get a numb-
//         ered  list  of  functions  with 'str' in the name. Then,
//         type  'mhlp  str <number>'  for  displaying the required
//         help.
//
// See also: maxima, minfo, hlp
//#----------------------------------------------------------------
// // EXAMPLE
//   mhlp eigen
//   mhlp eigen 2

// Author: J.F. Magni
// 20-02-2006

   global MAX

   [%nargout,%nargin] = argn(0);
   if %nargin == 1; number = '0'; end;
   if typeof(number) == 'constant'; number = string(number); end;

   // Executable path
   if ~exists('MAX');
      error('Global variable MAX deleted: reload the symbolic toolbox');
   else
      maxima_bin = MAX;
   end;

   // Maxima queries
   formaxima = '? '+func;
   str = str2max2sym(formaxima,'vec');

   for ii = 1:maxi(size(str));
      write(%io(2),str(ii),'(a)');
   end;

   if part(str(1),[1:3]) ~= ' 0:'; return; end;

   if %nargin == 1;
      number = ' ';
      while number == ' ';
         number = input('Enter space-separated numbers, all or none','string');
      end;
   end;
   str = mexec(number,'vec');
   while %t
      if ~isempty(strindex(str(1),'Discarding')) |  ~isempty(strindex(str(1),'Ignoring'));
         number = input('Enter space-separated numbers, all or none','string');
         if ~isempty(number);
            str = mexec(number,'vec');
         end;
      else
         break;
      end;
   end;

   for ii = 1:maxi(size(str));
      write(%io(2),str(ii),'(a)');
   end;

endfunction

