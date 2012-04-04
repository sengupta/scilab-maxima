function [sysfb] = %sym_v_sym(sys,fb)

// %sym_v_sym
//--------------------------------------------------------------------
// PURPOSE
// Feedback compatible with the Scilab feedback operator "/."
// Negative feedback. Works only if dimensions of system and feedback
// gain are compatible.
//
// SYNOPSIS
//   sfb = sys/.fb
//
// See also
//--------------------------------------------------------------------
// EXAMPLE
//    sys = sym('[1/(a+s) 1/(1+s)]');
//    fb  = sym('[ 1;2]');
//    sfb = sys/.fb;
//    sfb = simple(sfb,'s')

// Author: : J.F. Magni
// 20-02-2006

[p1,m1] = size(sys);
[p2,m2] = size(fb);

if m1 ~= p2 | m2 ~= p1 then
   error('Sizes of system and feedback are not compatible');
end;

n_mes = p1;
n_com = m1;

M2 = [sys zeros(n_mes,n_com);zeros(n_com,n_com) eye(n_com,n_com)];
M3 = M2*[fb eye(n_com,n_com);zeros(n_com,n_com+n_mes)];
M4 = eye(n_mes+n_com,n_mes+n_com) + M3;

M5 = inv(M4);

sysfb = - [eye(n_mes,n_mes) zeros(n_mes,n_com)]*M5*[zeros(n_mes,n_com);eye(n_com,n_com)];

endfunction
