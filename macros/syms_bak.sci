function syms(varargin)

//-----------------------------------------------------------------
// PURPOSE
// Generation of 1-by-1 sym-objects
//
// SYNOPSIS
// syms x y z ....
//
// See also: sym
//#----------------------------------------------------------------
// EXAMPLE
//    syms a b c
//    M = [a,b;1,2]

// Author: : J.F. Magni
// 20-02-2006

n = length(varargin);
resumstr = '';

for ii = 1:n;
   // Create symbolic 1-by-1 objects
   LOCALname = varargin(ii);
   resumstr = resumstr + LOCALname +',';
   execstr(LOCALname + '=sym(''' + LOCALname + ''');');
end;

// Send to workspace
resumstr = part(resumstr,[1:length(resumstr)-1])
execstr('['+resumstr+']=resume('+resumstr+');');

endfunction
