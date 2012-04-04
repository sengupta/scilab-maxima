function sym1 = %sym_p_s(a,b)

// %sym_p_s
// Power of symbolic objects.

// Warning: ^^-power rather than ^-power for matrices, the
// ^-power performs elementwise power


    if prod(size(b)) ~= 1;
       error('Only scalar powers');
    end;

    // String power limited to a and b scalars
    str1 = strpow(a,b);

    if isempty(str1);
    // Not treated by strpow
       if ~isempty(strindex(a.str1,'matrix(['));
          str1 = '('+a.str1+')^^('+string(b)+')';
       else
          str1 = '('+a.str1+')^('+string(b)+')';
       end;

       sym1 = str2max2sym(str1);

    else
    // Treated by strpow
       sym1 = mlist(['sym';'str1'],str1);

    end;

endfunction
