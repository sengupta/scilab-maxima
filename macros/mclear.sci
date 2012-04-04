function []=mclear(varargin)

// mclear
//-----------------------------------------------------------------
// PURPOSE
// Clear variables in Maxima workspace
//
// SYNOPSIS
// mclear a b
//
// See also syms, mexec
//#----------------------------------------------------------------
// // EXAMPLES
//     mexec('a:3;b:6')
//     syms a b
//     a*b
//     mclear a b
//     a*b

   // Preliminary treatment
   narg = length(varargin);
   for ii = 1:narg;
      var = varargin(ii);
      if typeof(var) == 'sym';
         varargin(ii) = var.str1;
      end;
      if typeof(varargin(ii)) ~= 'string';
         error('Arguments should be strings or sym-objects');
      end;
   end

   // Kill variables
   mexecstr = 'kill(';
   for ii = 1:narg
      mexecstr = mexecstr + varargin(ii) + ',';
   end;
   mexecstr = part(mexecstr,[1:1:length(mexecstr)-1]) + ')';
   mexec(mexecstr);

endfunction
