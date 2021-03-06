function sym2 = %s_i_sym(varargin);

// %s_i_sym
//-----------------------------------------------------------------
// Insersion of a sym-object in a matrix sym-object
// Example:
// syms a b c d
// M = [a^5*b 4;a*b*c^3*d a*d]
// M(1,:) = [1 2];

   rhs=argn(2)
   M=varargin(rhs)   // destination sym-object
   Mstr = max2scistr(M.str1);

   N=varargin(rhs-1) // inserted s-object
   N = sym(N);       // Transforms '0.3333333333' -> '1/3'
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

