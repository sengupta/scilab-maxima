function sym1 = %sym_r_sym(a,b)

// %sym_r_sym
//-----------------------------------------------------------------
// Division of symbolic objects
//
// REMARK:  the  division  is  replaced  by a*inv(b) in which 'inv'
// invokes  the  Maxima  function  'invert' based on adjoint method
// which  might  be bad for large matrices. However, this technique
// seems  better  than  a*b^(-1)  (a*b^^(-1)  in  Maxima) for small
// matrices.

    dims = size(b);
    if dims(1) == 1 & dims(2) == 1;
       sym1 = a*b^(-1);
    elseif dims(1) == dims(2);
       sym1 = a*inv(b);
    else
       error('Divide only with square sym-objects');
    end;

endfunction
