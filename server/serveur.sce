// This script installs the perl server for communication between
// Scilab and Maxima. Tested on Windows and Unixes.
// Shut down manually the server after closing Scilab !!!!!!!!!!!
//
// On Windows you might have to modify the vectors search_maxima
// and search_perl (see below).

// SYMDIR  = path to the directory containing this file
// SCIHOME = path to the directory containing .scilab

global MAX PERL TEMPFILE MAXVERSION SYMDIR

if MSDOS then
// ============================ WINDOWS ==========================
// Possible paths to Maxima and Perl executables

   // The following paths might be updated by the user
   search_maxima = ['maxima';... // in the path
                    '""C:\Program Files\Maxima-5.9.3\bin\maxima""'; ...
                    '""D:\Program Files\Maxima-5.9.3\bin\maxima""'; ...
                    '""C:\Program Files\Maxima-5.9.2\bin\maxima""'; ...
                    '""D:\Program Files\Maxima-5.9.2\bin\maxima""'; ...
                    '""C:\Program Files\Maxima-5.9.2-rc99\bin\maxima""'; ...
                    '""D:\Program Files\Maxima-5.9.2-rc99\bin\maxima""'; ...
                    '""C:\Program Files\Maxima-5.9.1\bin\maxima""'; ...
                    '""D:\Program Files\Maxima-5.9.1\bin\maxima""';];

   search_perl =   ['perl';... // in the path
                    '""C:\Perl\bin\perl""'; ...
                    '""D:\Perl\bin\perl""';];

// Look for Maxima executable
   is_error1 = %t;
   for i = 1:maxi(size(search_maxima));
      //str_test = 'if exist '+search_maxima(i)+' (echo OK) else (echo KO)';
      str_test = search_maxima(i)+ ' --version';
      stat = unix(str_test); // BUG IN UNIX_G at line 58
      if stat == 0 then
         MAX = search_maxima(i);
         is_error1 = %f;
         break;
      end;
   end;

   if is_error1;

      disp('SYMBOLIC TOOLBOX ERROR: Maxima is not in your path or is not installed');
      disp('If Maxima is installed add its path in the following file:');
      disp(SYMDIR+'serveur.sce');

   else

      // Maxima version: release candidate ignored
      ismax = unix_g(MAX+' --version');
      if ~isempty(strindex(ismax,'5.9.1'))
      // Useful for some functions like conj
         MAXVERSION = '5.9.1';
      elseif ~isempty(strindex(ismax,'5.9.2'))
         MAXVERSION = '5.9.2';
      elseif ~isempty(strindex(ismax,'5.9.3'))
         MAXVERSION = '5.9.3';
      else
         disp('SYMBOLIC TOOLBOX WARNING: your Maxima version is not tested');
         MAXVERSION = ismax;
      end;

   end;

// Look for Perl executable
   is_error2 = %t;
   for i = 1:maxi(size(search_perl));
      str_test = search_perl(i)+' -e $a=0;';
      stat = unix(str_test); // BUG IN UNIX_G at line 58
      if stat == 0 then
         PERL = search_perl(i);
         is_error2 = %f;
         break;
      end;
   end;

   if is_error2;
      disp('SYMBOLIC TOOLBOX ERROR: Perl is not in your path or is not installed');
      disp('If Perl is installed add its path to Windows %PATH%:');
      disp(SYMDIR+'serveur.sce');
   end;

// Launch the server and Maxima listening on port 2001
   is_error = is_error1 | is_error2;
   if ~is_error then
      // Path to temporary file
      TEMPFILE = SCIHOME+'\max2sym';

      // Launch server, example:
      // start "server scimax" /D "C:\....\SYM\server" /B perl serveur
      str_server = 'start ""server scimax"" /D ""'+SYMDIR+'"" /B '+PERL+' serveur';
      unix(str_server);

      // Lauch Maxima listening on port 2001, example (perl in  the path):
      // start "maxima client" /D "C:\Program Files\Maxima-5.9.2\bin\" /B maxima -s 2001
      dir0 = pwd();
      chdir(SYMDIR);
      if MAX == 'maxima";
         str_maxima = 'start ""maxima client"" /B maxima -s 2001 --preload-lisp=maxconf.lisp';
      else
         iii = strindex(MAX,'\');
         MAX0 = part(MAX,[1:1:iii(length(iii))])+'""';
         //str_maxima = 'start ""maxima client"" /D '+MAX0+' /B maxima -s 2001 --preload-lisp=maxconf.lisp';
         str_maxima = 'start ""maxima client"" /B '+MAX+' -s 2001 --preload-lisp=maxconf.lisp';
      end;
      unix(str_maxima);
      chdir(dir0);
   end;

else
// ============================ UNIX =============================
// Look for Maxima (assumed to be in the path)

   is_error = %f;

   ismax = unix_g('maxima --version');
   if isempty(strindex(ismax,'Maxima')) then
      disp('SYMBOLIC TOOLBOX ERROR: Maxima is not in your path or is not installed');
      is_error = %t;
   else
      if ~isempty(strindex(ismax,'5.9.1'))
      // Useful for some functions like conj
         MAXVERSION = '5.9.1';
      elseif ~isempty(strindex(ismax,'5.9.2'))
         MAXVERSION = '5.9.2';
      elseif ~isempty(strindex(ismax,'5.9.3'))
         MAXVERSION = '5.9.3';
      else
         disp('SYMBOLIC TOOLBOX WARNING: your Maxima version is not tested');
         MAXVERSION = ismax;
      end;
      MAX = unix_g('which maxima');
   end;

// Look for Perl (assumed to be in the path)
   isperl = unix_g('perl -e ''print(""PERLOK"");''');
   if isempty(strindex(isperl,'PERLOK')) then
      disp('SYMBOLIC TOOLBOX ERROR: Perl is not in your path or is not installed');
      is_error = %t;
   else
      PERL = unix_g('which perl');
   end;

// Launch the server and Maxima listening on port 2001
   if ~is_error then
   // Path to temporary file
      TEMPFILE = SCIHOME+'/max2sym';

   // Launch server
      unix(PERL+' '+SYMDIR+'serveur &');
      
   // halt; // Uncomment this line if Maxima is launched before the server is started.

   // Lauch Maxima listening on port 2001
      unix(MAX+' -s 2001 --preload-lisp='+SYMDIR+'maxconf.lisp&');
   end;

end;

// Now, you can communicate with Maxima as follows
//    maxima_command = 'expand((3*a+2*d)^10)';
//    result = unix_g(PERL+' '+SYMDIR+'interface '''+ maxima_command+'''');

