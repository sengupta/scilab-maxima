function [] = typ(fichier)

// typ
//-----------------------------------------------------------------
// PURPOSE
// This  function  is  similar to Matlab type function. It displays
// the file defining a function.
//
// SYNOPSIS
// typ function_name
// typ object_type/function_name
//
// See also hlp
//#----------------------------------------------------------------
// // EXAMPLE
//   typ size
//   typ sym/dbl

list_of_prefix = ['old';'lfr';'sym'];

// Treat prefix in argument (form prefix/name)
ind = strindex(fichier,'/');
if length(ind) == 1;
   fichier = '%'+part(fichier,[1:1:ind(1)-1])+'_'+part(fichier,[ind(1)+1:1:length(fichier)]);
end;

// Search function path
ierr = execstr('type('+fichier+')','errcatch');
if ierr == 0;
   path_and_fichier = get_function_path(fichier);
else
   return
end;

// If function path non-empty: read file, extact the first series of
// lines of comments (isolated lines of comments are ignored)
if ~isempty(path_and_fichier);

   u=file('open',path_and_fichier,'unknown');
   toto=read(u,-1,1,'(a)');
   file('close',u);

   for i = 1:maxi(size(toto));
      write(%io(2),toto(i),'(a)');
   end;

end;

// If argument was not of the form 'prefix/name', search for possible
// prefixes
if length(ind) == 0;
   wr = %t;
   for ii = 1:maxi(size(list_of_prefix));
      ierr = execstr('type(%'+list_of_prefix(ii)+'_'+fichier+')','errcatch');
      if ierr == 0;
         if wr; write(%io(2),'See:','(a)'); wr = %f; end;
         write(%io(2),'   typ '+list_of_prefix(ii)+'/'+fichier,'(a)');
      end;
   end;
end;

endfunction
