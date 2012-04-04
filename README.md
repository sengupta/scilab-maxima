Symbolic Toolbox for Scilab
===========================

This is a continuation of Jean-François Magni's Symbolic Toolbox. JFM passed away on January 4th, 2008. I am maintaining this for posterity. 

The home page for this project used to be available [here](http://www.cert.fr/dcsd/idco/perso/Magni/s_sym/doc/index.html) but has been removed. A mirror of the page can be found [here](http://web.archive.org/web/20081206065628/http://www.cert.fr/dcsd/idco/perso/Magni/s_sym/doc/index.html). 

This repository is a continuation of the project according to his wishes, expressed about 2 months before his passing [here](https://groups.google.com/group/comp.soft-sys.math.scilab/msg/f0d07290f0b18099). 

This toolbox provides a interface to Maxima, a Free and Open Source Software that specializes in symbolic operations. It uses Perl to initiate a Maxima server and uses a socket connection between Scilab and Maxima to transport data and commands between the two packages.

Most functions have a syntax similar to the MATLAB Symbolic Toolbox, although the functionality of this toolbox is limited to the functionality available in Maxima.

This toolbox requires Perl, Maxima and Scilab to be installed on your computer. This toolbox has been used successfully on several Unix flavours and on Windows.

Due to the unfortunate demise of JFM, this is no longer maintained. In particular, the toolbox does not load in the latest versions of Scilab since certain functions have been deprecated in Scilab since this toolbox was authored. A workaround is the issue the following two aliasing commands:

    sort = gsort;
    maxi = max;

The two commands above should restore functionality for this toolbox. 

I will probably fix these problems directly in the source at some point. 

Alternative Toolboxes
---------------------

I suggest you reconsider the use of this toolbox for any symbolic computation needs in production. Here are a few possible alternatives. 

* The [SciMax](http://forge.scilab.org/index.php/p/scimax/) toolbox by Calixte Denizet also integrates with Maxima. 
* There is a [Symbolic Computing](http://forge.scilab.org/index.php/p/symcomp/) toolbox by @jorgeecardona on Scilab Forge. I'm not sure what the status is with this project. 
