function [] = hlp(fichier)

// hlp
//-----------------------------------------------------------------
// PURPOSE
// This  function  is  similar to Matlab help function. It displays
// the  first  set  of  two  adjacent  lines  of  comments (ignores
// isolated comment lines)
//
// SYNOPSIS
// hlp function_name
// hlp object_type/function_name
//
// REMARK
// The  functions "help fields" must be structured so that the perl
// script 'hlp2html.pl'  can transform this field into an HTML file
// compatible  with  the standard Scilab help function. For details
// on  the  required  structure,  see the perl script file heading.
// <br>You can add two kinds of HTML tags: <PRE> </PRE> and <BR> (lower
// cases),  these tags will be used by the perl script but will not
// be displayed when hlp is invoked.
//
// See also typ
//#----------------------------------------------------------------
// // EXAMPLE
//   hlp hlp
//   hlp size
//   hlp sym/dbl

// List to be updated if new objects are defined
list_of_prefix = ['lfr';'sym'];

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

   // replace <pre>, </pre> and <br> by blanks
   toto = strsubst(toto,'<pre>','');
   toto = strsubst(toto,'</pre>','');
   toto = strsubst(toto,'<br>','');


   debut = -1;

   for i = 1:size(toto,1)-1;
      if part(toto(i),[1 2]) == '//' & part(toto(i+1),[1 2]) == '//' then
         debut = i;
         break;
      end;
   end;

   fin = size(toto,1);

   if debut > 0 then

      for i = debut:size(toto,1);
         if part(toto(i),[1 2]) ~= '//' then
            fin = i-1;
            break;
         end;
      end;

      for i = debut:fin
         write(%io(2),part(toto(i),[3:length(toto(i))]),'(a)');
      end;

   else

      write(%io(2),'No hlp for this function','(a)');

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
         write(%io(2),'   hlp '+list_of_prefix(ii)+'/'+fichier,'(a)');
      end;
   end;
end;

endfunction
