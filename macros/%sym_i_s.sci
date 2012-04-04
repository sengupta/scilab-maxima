function sym2 = %sym_i_s(varargin);

// %sym_i_s
//-----------------------------------------------------------------
// Insersion of a sym-object in a matrix sym-object
// Example:
// syms a b c d
// M = [1 2;3 4]
// M(1,:) = [a*b c*d];

   rhs=argn(2)
   M=varargin(rhs)   // destination sym-object
   N=varargin(rhs-1) // inserted sym-object
   Mstr = string(M);
   Nstr = max2scistr(N.str1);
   Mstr(varargin(1:$-2)) = Nstr;

   // If the matrix is enlarged, set to '0' all non assigned values
   [nr,nc] = size(Mstr);
   for ii = 1:nr;
   for jj = 1:nc;
      if Mstr(ii,jj) == ' ' | isempty(Mstr(ii,jj)); Mstr(ii,jj) = '0'; end;
   end;
   end;

   sym2 = sym(Mstr);

endfunction

