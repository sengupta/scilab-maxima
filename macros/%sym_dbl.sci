function LOCALa = %sym_dbl(LOCALb,flag)

// %sym_dbl
//-----------------------------------------------------------------
// PURPOSE
// Converts  symbolic  numbers to floating point numbers. Note that
// in some cases this function looks similar to eval but the output
// of eval is a symbolic object (possibly symbolic number).
//
// SYNOPSIS
// bb = dbl(aa)
//
// INPUT ARGUMENT
// aa       Symbolic expression containing no symbolic atoms.
//
// OUTPUT ARGUMENT
// bb       Scalar or matrix of floating point numbers
//
// See also bfloat, float, sym/eval
//#----------------------------------------------------------------
// // EXAMPLE:
//    a = log(sym('3'))
//    float(a)        // Symbolic floating point number
//    dbl(a)          // Numerical floating point number (indented)

   LOCALb = sym(LOCALb);
   LOCALb = float(LOCALb); // removes

   // Workspace values available in function, so atoms with
   // numerical value in workspace are supported
   LOCALa = evstr(max2scistr(LOCALb.str1));

   if typeof(LOCALa) ~= 'constant';
      error('The argument shouldn''t contain symbolic atoms');
   end;

endfunction
