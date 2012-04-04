function b = %sym_e(i,j,a)

// %sym_e
//-----------------------------------------------------------------
// Extraction by indices from a sym-object
// Example:
// syms a b c d
// M = [a^5*b 4;a*b*c^3*d a*d]
// M(1,:)

    [%nargout,%nargin]=argn(0)

    if %nargin == 2;
       astr = max2scistr(j.str1);
       bstr = astr(i);
       b = sym(bstr);
    else
       astr = max2scistr(a.str1);
       bstr = astr(i,j);
       b = sym(bstr);
    end;

endfunction

