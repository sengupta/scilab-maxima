function symbolic();

// symbolic
//-----------------------------------------------------------------
// Scilab Symbolic Toolbox based on Maxima
//
// LIST OF FUNCTIONS
//
// OPERATIONS
// %sym_a_sym.sci    addition
// %sym_c_sym.sci    horizontal concatenation
// %sym_f_sym.sci    vertical concatenation
// %sym_i_sym.sci    insersion
// %sym_p_sym.sci    repeated product
// %sym_r_sym.sci    division
// %sym_m_sym.sci    multiplication
// %sym_s_sym.sci    substraction
// %sym_v_sym.sci    feedback
// %sym_e.sci        extraction by indices
// %sym_p.sci        display
// %sym_s.sci        change of sign
// %sym_t.sci        conjugate transpose
// OTHER OPERATIONS IN DIRECTORY 'percent'
//
// OTHER FUNCTIONS
// Note  that  some functions cannot be overloaded when applied to
// sym-objects  these  functions  must  be invoked with the prefix
// '%sym_',  for  example '%sym_expand' instead of 'expand'.
//
// 1- Symbolic object generation:
//     sym      generation of sym-objects and conversions
//     syms     1-by-1 real sym-objects
//     syml     generation of syml-objects (Maxima symbolic lists)
//     symtype  symbolic type (odd, even,... real, complex)
//     findsym  retrieves symbolic atoms of an expression
//
// 2- Elementary functions (element-wise for matrices)
//     conj     conjugate-transpose
//     real     real part
//     imag     imaginary part
//     abs      modulus
//     log      natural logarithm
//     exp      exponential
//     sqrt     square root
//
// 3- Polynomial / rational functions:
//     factor   (%sym_factor)   factorization
//     expand   (%sym_expand)   expansion
//     simple   (%sym_simple)   simplification (mhlp fullratsimp)
//     horner   (%sym_horner)   horner form of a polynomial
//     numden   numerator and denominator
//     coeffs   coefficients of a polynomial
//     degrees  partial degrees of a polynomial
//     gcd      greatest common divisor
//     lcm      least common multiple
//
// 4- Matrix manipulations:
//     size     size
//     det      determinant
//     inv      inverse
//     diag     (%sym_diag)  diagonal
//     eig      (%sym_eig)   eigenvalues/eigenvectors
//     trace    (%sym_trace)  trace
//     null     null space
//     rank     rank
//     colspace column span
//     rref     row echelon form of a matrix
//     triu     upper triangular form
//     tril     lower triangular form
//
// 5- Calculus:
//     diff     (%sym_diff)  differentiation
//     int      (%sym_int)   integration
//     limit    (%sym_limit) limit
//     symsum   sums and limits of series
//     taylor   Taylor expansion
//     laplace  Laplace transform
//     ilaplace inverse Laplace transform
//
// 6- Evaluation and substitution:
//     eval     evaluation considering values in workspace
//     subs     substitutions
//     dbl      numerical floating point evaluation
//     float    symbolic floating point evaluation
//     bfloat   high precision symbolic floating point evaluation
//
// 7- General:
//     hlp      help for Scilab functions
//     typ      types function files in a command window
//     symbolic list of functions of the toolbox
//     latex    symbolic expression in LaTeX forma (amsmath)
//     fortran  symbolic expression in Fortran format
//
// 8-  Access to Maxima kernel
//     mhlp    displays Maxima help in Scilab
//     minfo   displays Maxima version and paths
//     maxima  invokes a Maxima function and retrieves result in Scilab
//     mexec   executes a Maxima command only in Maxima workspace
//     mclear  clears declarations in Maxima workspace
//
// 9-  Communication Scilab / Maxima
//     killserver      must be invoked before shuting down Scilab
//     restartserver   reinitializes Maxima workspace and server
//     str2max2sym     controls Scilab / Maxima communication
//     findpid         finds task PIDs (Unix)
//
// 10- Trigonometric functions
//     cos, acos, cosh, acosh, sin, asin, sinh, asinh,
//     tan, atan, tanh, atanh, cotg, coth.
//
//#----------------------------------------------------------------
// EXAMPLE 1 matrix manipulation
//   syms a b c
//   M = [a^2+3 0 b*c;1 c^3 b;1 2/a 3/(1+4*b)]
//   size(M)
//   det(M)
//   N = inv(M)
//   simple(M*N)
//
// EXAMPLE 2 scalar functions
//   f=sym('3*cos(a)+b')
//   a=%pi;
//   b=sym('b');
//   eval(f)
//
// For more examples type hlp <name_of_function>

endfunction
