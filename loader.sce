mode(-1);

global INTERFACE
// To be customized (perl slower than compiled version)
// INTERFACE = 'perl'  -> platform indepedent interface based on Perl
// INTERFACE = 'win32' -> interface in C, compiled for Windows
// INTERFACE = 'lin86' -> interface in C, compiled for Linux 32 bits x86
// INTERFACE = 'sparc' -> interface in C, compiled for Solaris Sparc
// interface.c can be compiled, put executable in 'myos' ans set INTERFACE = 'myos'
INTERFACE = 'perl';

libname='SYMBOLIC'
libname_ext='SYMB_ext'
libtitle='Symbolic Math Toolbox';

// Generic part
// get the absolute path
[units,typs,nams]=file();
clear units typs
for k=size(nams,'*'):-1:1
  l=strindex(nams(k),'loader.sce');
  if l<>[] then
    DIR=part(nams(k),1:l($)-1);
    break
  end
end

// Path to macros
if ~MSDOS then // Unix
  if part(DIR,1)<>'/' then DIR=getcwd()+'/'+DIR,end
  MACROS=DIR+'macros/'
  MACROS_ext=DIR+'macros/percent/'
else // Windows
  if part(DIR,2)<>':' then DIR=getcwd()+'\'+DIR,end
  DIR=strsubst(DIR,'/','\');
  MACROS=DIR+'macros\'
  MACROS_ext=DIR+'macros\percent\'
end

// load the library
execstr(libname+'=lib(""'+MACROS+'"")')
execstr(libname_ext+'=lib(""'+MACROS_ext+'"")')

// lauch server and Maxima
global SYMDIR
if MSDOS then
   SYMDIR = DIR+'server\';
   exec(SYMDIR+'serveur.sce');
else
   SYMDIR = DIR+'server/';
   exec(SYMDIR+'serveur.sce');
end;

// Specific SYMBOLIC
DIR2 = strsubst(DIR,'\','/');
mess=[' ';' ';libtitle+'. Type hlp symbolic.';'file://'+DIR2+'doc/index.html'];
write(%io(2),mess);

// Add the help chapter
// %helps = [DIR+'man', libtitle;%helps]    // no help at that time

clear fd err nams DIR DIR2 libname libname_ext libtitle mess  //clean environment
