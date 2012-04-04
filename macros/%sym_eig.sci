function [vec,val] = %sym_eig(a);

// %sym_eig
//-----------------------------------------------------------------
// PURPOSE
// Computes  the  eigenvalues and eigenvectors of a symbolic matrix
// using the Maxima functions eigenvalues or eigenvectors.
//
// SYNOPSIS
// [Vec,Val] = eig(A)
// Val = eig(A)
//
// CAUTION
// Invoke preferably this function with only one output argument as
// eigenvector  computation  is  not reliable. Often, the length of
// the  string  corresponding  to the result is so long that Scilab
// freezes.
//
// INPUT ARGUMENT
// A      Symbolic square matrix.
//
// OUTPUT ARGUMENT
// Val    Vector  of the eigenvalues of A if one output argument or
//        diagonal form of A if two output arguments.
// Vec    Matrix of the eigenvectors of A
//
// See also sym/trace, sym/diag
//#----------------------------------------------------------------
// // EXAMPLE
//    A = sym(['a-b','a-b';'2','a+b'])
//    Val = eig(A)

// Author: : J.F. Magni
// 20-02-2006

    global MAX
    a = sym(a);

// Eigenvalues / eigenvectors of a matrix

    [%nargout,%nargin] = argn(0)
    if %nargout == 1;
       str1 = 'eigenvalues('+a.str1+')';
    else
       str1 = 'eigenvectors('+a.str1+')';
    end;

    // Execution in Maxima and retrieve result in rep
    rep = str2max2sym(str1,'str');

    rep = strsubst(rep,'[[[','['); // eigenvectors
    rep = strsubst(rep,'[[','[');  // eigenvalues
    i1  = strindex(rep,']');

    // Eigenvalues
    val = part(rep,[1:1:i1(1)]);
    val = strsubst(val,'[','[''');
    val = strsubst(val,']',''']');
    val = strsubst(val,',',''';''');
    val = evstr(val);

    // Transformation to sym-objects
    valstr = scistr2max(val);
    val = mlist(['sym';'str1'],valstr);

    // Orders
    ord = part(rep,[i1(1)+2:1:i1(2)]);
    ord = evstr(ord);

    // Repeat values if some order > 1
    Q = zeros(sum(ord),length(ord));
    kk = 1;
    for ii = 1:length(ord);
       for jj = 1:ord(ii);
          Q(kk,ii) = 1;
          kk = kk+1;
       end;
    end;
    val = Q*val;

    if %nargout == 1;

       vec = val;

    else

       val = %sym_diag(val);

       // Eigenvectors
       vec = part(rep,[i1(3)+2:1:length(rep)-1]);
       vec = strsubst(vec,'],[',']#[');
       vec = strsubst(vec,',',''';''');
       vec = strsubst(vec,']#[','],[');
       vec = strsubst(vec,'[','[''');
       vec = strsubst(vec,']',''']');
       vec = '['+vec+']';
       vec = evstr(vec);

       // Transformation to sym-objects
       vecstr = scistr2max(vec);
       vec = mlist(['sym';'str1'],vecstr);

    end;

endfunction
