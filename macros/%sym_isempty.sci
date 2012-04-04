function [bool] = %sym_isempty(a);

// %sym_isempty
//-----------------------------------------------------------------
// This overloaded function is ignored by Scilab !!!!!!!!!!!!!!!!

    a = sym(a);

    n1 = length(a.str1);

    if n1==0  | a.str1 == ' ' | a.str1 == '  '| a.str1 == '   ';
        bool=%T;
    else
        bool=%F;
    end;

endfunction

