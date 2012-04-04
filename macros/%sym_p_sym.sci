function sym1 = %sym_p_sym(a,b)

// %sym_p_sym
// Power of symbolic objects.

// Warning: ^^-power rather than ^-power for matrices, the
// ^-power performs elementwise power

    if ~isempty(strindex(b.str1,'matrix(['));
       error('Only scalar powers');
    end;

    if ~isempty(strindex(a.str1,'matrix(['));
       str1 = '('+a.str1+')^^('+b.str1+')';
    else
       str1 = '('+a.str1+')^('+b.str1+')';
    end;

    sym1 = str2max2sym(str1);

endfunction
