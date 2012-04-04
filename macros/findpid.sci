function [pidlist] = findpid(str1,str2)

// findpid
//-----------------------------------------------------------------
// PURPOSE
// Find the pid of Unix tasks containing str1 or both str1 and str2
//
// SYNOPSIS
// [pid] = findpid(str1[,str2])
//
// INPUT ARGUMENT
// str1     String to be searched in task description
// str2     String to be searched in task description.
//
// OUTPUT ARGUMENT
// pid      Vector of pid's.
//
// See also restartserver, killserver
//#----------------------------------------------------------------
//  EXAMPLE
//    findpid('scilex')

   pidlist = [];
   if MSDOS; return; end;

   [%nargout,%nargin] = argn(0);
   if %nargin == 1; str2 = str1; end;

   str_tasks = 'ps -edf | grep ' + str1;
   tasks = unix_g(str_tasks);

   // Search digits in string vector tasks
   PID = list();
   kk=1;
   for ii = 1:maxi(size(tasks));
       ind = [];
       if ~isempty(strindex(tasks(ii),str2)) & isempty(strindex(tasks(ii),'grep'));
          tasksii = tasks(ii);
          // look for pid
          ind = [];
          for jj = 1:10;
             ind = [ind strindex(tasksii,string(jj-1))];
          end;
          ind = sort(ind);
          PID(kk) = ind;
          taskindices(kk) = ii;
          kk = kk+1;
       end;
    end;

    // Look for the first contiguous set of digits (=pid)
    for kk = 1:length(PID);

       ind = PID(kk);
       tasksii = tasks(taskindices(kk));
       pid = '';
       ii = length(ind);
       while %t
          pid = pid + part(tasksii,ind(ii));
          if ind(ii-1) ~= ind(ii)+1; break; end;
          ii = ii-1;
       end;
       pidlist(kk) = pid;

    end;

endfunction
