function [sym1] = %sym_symsum(varargin)

// %sym_symsum
//-----------------------------------------------------------------
// PURPOSE
// Series summation
//
// SYNOPSIS
// sym1 = symsum(A,nn,n_min,n_max)
//
// INPUT ARGUMENTS
// A        Symbolic expression
// nn       Integer symbolic variable for series summation
// n_min    First value of nn for summation
// n_max    Last value of nn for summation
//
// See also sym/int
//#----------------------------------------------------------------
// // EXAMPLE
//    syms a n
//    symsum(a^(-n),n,0,10)
//    symsum(a^(-n),n,0,%inf)

    n = length(varargin);
    if n ~= 2 & n ~= 4; error('Four arguments expected'); end;

    a = sym(varargin(1));
    b = sym(varargin(2));

    if n == 2;
       b_min = sym(0);
       b_max = sym('%inf');
    else
       b_min = sym(varargin(3));
       b_max = sym(varargin(4));
    end;

    //str1 = 'nusum('+a.str1+','+b.str1+','+b_min.str1+','+b_max.str1+')';
    mexec('simpsum:true');
    str1 = 'sum('+a.str1+','+b.str1+','+b_min.str1+','+b_max.str1+')';
    sym1 = str2max2sym(str1);

endfunction
