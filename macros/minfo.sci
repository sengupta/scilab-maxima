function minfo()

// minfo
//-----------------------------------------------------------------
// PURPOSE
// Information relative to the maxima version.
//
// SYNOPSIS
// minfo
//
// See also mhlp, maxima, mexec
//#----------------------------------------------------------------

   global MAX SYMDIR MAXVERSION

// Executable path
   if ~exists('MAX');
      error('Global variable MAX deleted: reload the symbolic toolbox');
   else
      maxima_bin = MAX;
   end;
   if ~exists('SYMDIR');
      error('Global variable SYMDIR deleted: reload the symbolic toolbox');
   end;
   SYMDIR2 = part(SYMDIR,[1:1:length(SYMDIR)-7]);

   if ~MSDOS;

   //========================== UNIX =============================
   // Search information
      [v,stat] = unix_g(maxima_bin+' --version');
      d = unix_g(maxima_bin+' -d');
      d = strsubst(d(1),'maxima-prefix=','');
      b = unix_g('which '+maxima_bin);

   // Display information
      write(%io(2),'Maxima version : '+v,'(a)');
      write(%io(2),'Path to binary : '+b,'(a)');
      write(%io(2),'Install dir    : '+d+'/','(a)');
      write(%io(2),'Toolbox dir    : '+SYMDIR2,'(a)');

   else

   //========================== Windows ==========================
   // MAXVERSION erroneous if MAX has been modified after loading the tbx
      if ~exists('MAXVERSION');
         error('Global variable MAXVERSION deleted: reload the symbolic toolbox');
      end;

   // Display information
      write(%io(2),'Maxima version : '+MAXVERSION,'(a)');
      write(%io(2),'Path to binary : '+MAX,'(a)');
      write(%io(2),'Toolbox dir    : '+SYMDIR2,'(a)');

   end;

endfunction
