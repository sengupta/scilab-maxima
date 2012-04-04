function [] = restartserver(silent)

// restartserver
//-----------------------------------------------------------------
// PURPOSE
// Restarts  Maxima  and  the server used for communication between
// Scilab and Maxima (Symbolic toolbox). In case Scilab freezes you
// must kill manually maxima and perl/serveur tasks.
//
// SYNOPSIS
// restartserver(boolean)
//
// REMARK
// This function should be used in the following cases:
// - You  forgot to invoke killserver before the last time you shut
//   down Scilab.
// - You  have  just invoked the scripts builder.sce and loader.sce
//   of the symbolic toolbox.
// - You want to re-initialize Maxima workspace.
//
// CAUTION
// Windows:  For  killing  tasks, we use ProKill v2.1 (pk.exe). All
// tasks named perl.exe or maxima.exe will be killed, so be careful.
// <br>See: http://www.white-scorpion.nl/programs/programs.html.
//
// INPUT ARGUMENT
// boolean     If  boolean = %t  no comments are displayed. Default
//             boolean = %f.
//
// See also killserver, findpid
//#----------------------------------------------------------------

[%nargout,%nargin] = argn(0);
if %nargin == 0; silent = %f; end;

killserver(silent);

if MSDOS
   str_ex = 'exec('""+SYMDIR+'serveur.sce"");'
else
   str_ex = 'exec('''+SYMDIR+'serveur.sce'');';
end;

execstr(str_ex);

if MSDOS
   if ~silent;  write(%io(2),'=== Server and Maxima started ===','(a)'); end;
else
   perl_pid = findpid('perl','SYM');
   max_pid  = findpid('maxima','lisp');
   if ~silent & ~isempty(perl_pid); write(%io(2),'=== New PID of server task: '+string(perl_pid'),'(a)'); end;
   if ~silent & ~isempty(max_pid);  write(%io(2),'=== New PID of Maxima task: '+string(max_pid'),'(a)'); end;
end;

endfunction
