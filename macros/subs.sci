function [sym1] = subs(a,b,c)

// subs
//-----------------------------------------------------------------
// PURPOSE
// Substitution based on the Maxima function 'subst'.
//
// SYNOPSIS
// expr2 = subs(expr1,old,new)
//
// DESCRIPTION
// Similar to sym/eval but here, workspace values are ignored.
//
// INPUT ARGUMENTS
// expr1   Symbolic  expression  in which 'new' will be substituted
//         for 'old'.
// old     Symbolic  atom  or  vector  of  atoms to be substituded.
//         Atoms  can also be replaced by sub-expressions appearing
//         explicitely in expr1. See illutrative examples.
// new     Symbolic  expression  or  vector  of expressions of same
//         length as 'old'. Substitution is performed sequentially,
//         old(1) replaced by new(1) then old(2) replaced by new(2)
//         and so on. See illutrative examples.
//
// OUTPUT ARGUMENT
// expr2   Resulting symbolic expression after substitution.
//
// See also sym/eval
//#----------------------------------------------------------------
// // EXAMPLES
//    syms a b c x 'real'
//    c1 = (a+%i*b)^2;
//    c2 = subs(c1,a,c-%i*b)
//
//    c3 = cos(a) + b*sin(c);
//    c4 = subs(c3,[a b],[2*c c^2])
//
// // Substitutions performed sequencially !
//    c5 = subs(c3,[a b x],[x a b]) // a->x then b->a then x->b
//    subs(c3,[a b],[b a])          // a->b then b->a
//
// // Substitution of sub-expressions
//    c6 = subs(c1,a+%i*b,3)
//    subs(expand(c1),a+%i*b,3)  // doesn't work after expansion

    [%nargout,%nargin] = argn(0);
    if %nargin ~= 3; error('Three arguments expected'); end;

    a = sym(a);
    b = sym(b);
    c = sym(c);

    nb = maxi(size(b));
    nc = maxi(size(c));
    if nb ~= nc; error('2nd and 3rd arguments should have same length'); end;

    if nb == 1;
    // Single substitution
       str1 = 'subst('+c.str1+','+b.str1+','+a.str1+')';
       sym1 = str2max2sym(str1);
    else
    // Multiple substitution -> subst([<eq_1>,<eq_2>,...],expr)
       str2 = '[';
       for ii = 1:nb
          ci = c(ii);
          bi = b(ii);
          str2 = str2+bi.str1+'='+ci.str1+',';
       end;
       str2 = part(str2,[1:1:length(str2)-1])+']';
       equt = syml(str2);
       sym1 = maxima('subst',equt,a);
    end;

endfunction
