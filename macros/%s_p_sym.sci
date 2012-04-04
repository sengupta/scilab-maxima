function sym1 = %s_p_sym(a,b)

// %s_p_sym
// Power of symbolic objects.

// Warning: ^^-power rather than ^-power for matrices, the
// ^-power performs elementwise power

    if ~isempty(strindex(b.str1,'matrix(['));
       error('Only scalar powers');
    end;

    if prod(size(a)) > 1;
       str1 = '('+string(a)+')^^('+b.str1+')';
    else
       str1 = '('+string(a)+')^('+b.str1+')';
    end;

    sym1 = str2max2sym(str1);

endfunction
