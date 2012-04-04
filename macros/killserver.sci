function [] = killserver(silent)

// killserver
//-----------------------------------------------------------------
// PURPOSE
// Kill  all  maxima tasks and the server lauched for communication
// between  Maxima  and  Scilab.  THIS  FUNCTION  MUST  BE  INVOKED
// MANUALLY  BEFORE  SHUTING  DOWN SCILAB. For re-initialization of
// Maxima invoke the function restartserver.
//
// SYNOPSIS
// killserver(boolean)
//
// CAUTION
// Windows:  For  killing  tasks, we use ProKill v2.1 (pk.exe). All
// tasks named perl.exe or maxima.exe will be killed, so be careful.
// <br>See: http://www.white-scorpion.nl/programs/programs.html.
//
// If  you  forgot to invoke killserver before shuting down Scilab,
// next  time  you launch Scilab, invoke the function restartserver
// before you invoke any function of the symbolic toolbox.
//
// INPUT ARGUMENT
// boolean     If  boolean = %t  no comments are displayed. Default
//             boolean = %f.
//
// See also restartserver, findpid
//#----------------------------------------------------------------

[%nargout,%nargin] = argn(0);
if %nargin == 0; silent = %f; end;
// silent mode for killserver called in loader.sce

if MSDOS
// ============================= Windows =========================

   str_disp = 'exec('""+SYMDIR+'serveur.sce""); // to restart the server';

   if silent;
      yes_no = 'y';
   else
      yes_no = input('ALL Perl and Maxima tasks will be killed. Okay ? (y/n)','s');
   end;

   if part(yes_no,1) == 'y';

      if ~silent; write(%io(2),'=== Server and Maxima  killed ===','(a)'); end;
      str_task1 = '""'+SYMDIR+'pk"" -n maxima.exe';
      unix(str_task1);
      str_task2 = '""'+SYMDIR+'pk"" -n perl.exe';
      unix(str_task2);

   end;

   //if ~silent; write(%io(2),str_disp,'(a)'); end;

else
// ============================= Unix ============================

   str_disp = 'exec('''+SYMDIR+'serveur.sce''); // To restart the server.';

   // Look for tasks

   perl_pid = findpid('perl','SYM');
   max_pid  = findpid('maxima','lisp');
   if ~silent & isempty(perl_pid); write(%io(2),'=== Server pid not found ===','(a)'); end;
   if ~silent & isempty(max_pid);  write(%io(2),'=== Maxima pid not found ===','(a)'); end;

   pid_to_kill = [perl_pid;max_pid];
   if ~silent & ~isempty(pid_to_kill);  write(%io(2),'=== PID of killed task: '+string(pid_to_kill'),'(a)'); end;

   for ii = 1:size(pid_to_kill,1);
      exec_str = 'kill -9 ' + pid_to_kill(ii);
      unix(exec_str);
   end;

   //if ~silent; write(%io(2),str_disp,'(a)'); end;

end;

endfunction
