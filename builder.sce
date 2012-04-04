mode(-1);
libname='SYMBOLIC' // name of scilab function library

// Get the absolute path to this file -> DIR
[units,typs,nams]=file();
clear units typs
for k=size(nams,'*'):-1:1
  l=strindex(nams(k),'builder.sce');
  if l<>[] then
    DIR=part(nams(k),1:l($)-1);
    break
  end
end

// Path to files to be compiled : standard files of the Symbolic Toolbox
if ~MSDOS then // Unix Linux
  if part(DIR,1)<>'/' then DIR=getcwd()+'/'+DIR,end
  MACROS=DIR+'macros/' // Path of the macros directory
else  // Windows
  if part(DIR,2)<>':' then DIR=getcwd()+'\'+DIR,end
  MACROS=DIR+'macros\' // Path of the macros directory
end

// Compile sci files if necessary and build lib file
genlib(libname,MACROS)

// Path to files to be compiled : percent files of the Symbolic Toolbox
if ~MSDOS then // Unix Linux
  if part(DIR,1)<>'/' then DIR=getcwd()+'/'+DIR,end
  MACROS=DIR+'macros/percent/' // Path of the macros directory
else  // Windows
  if part(DIR,2)<>':' then DIR=getcwd()+'\'+DIR,end
  MACROS=DIR+'macros\percent\' // Path of the macros directory
end

//compile sci files if necessary and build lib file
genlib(libname,MACROS)

clear DIR libname MACROS genlib
