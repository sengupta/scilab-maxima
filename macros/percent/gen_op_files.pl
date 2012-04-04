#!/usr/local/bin/perl

# This perl script generates the Scilab "percent" files for overloading
# operations applied to pairs of objects in which one operand is an sym-object
# Fill the four arrays below and execute "perl gen_op_files.pl"
#
# WARNING: existing files in the script directory will be overwritten.

@operation = ('a','s','m','r','v','c','f');
@ope_names = ('addition','substraction','multiplication','division','feedback','horizontal concatenation','vertical concatenation');
@objects   = ('c','p','r','s');
@obj_names = ('string','polynomial','rational','constant');

for ($i=0; $i <= $#operation; $i++) {
   for ($j=0; $j <= $#objects; $j++) {
      # Content of the file (sym - other object)
      $str = "function \[sys3] = \%sym_$operation[$i]_$objects[$j](sys1,sys2)\n\n";
      $str = $str . "// Overloads $ope_names[$i]\n// The operands are: sym-object , $obj_names[$j]-object\n\n";
      $str = $str . "sys3 = \%sym_$operation[$i]_sym(sys1,sym(sys2));\n\n";
      $str = $str . "endfunction\n";
      # print($str);
      # Cration of the file
      $nom_fichier = "\%sym_$operation[$i]_$objects[$j]\.sci";
      print "getf(\'macros/percent/$nom_fichier\');\n";
      open (FICH_OPEN, ">$nom_fichier") or die "Cannot open $nom_fichier for write :$!";
      print FICH_OPEN "$str";
      close(FICH_OPEN);

      # Content of the file (other object - sym)
      $str = "function \[sys3] = \%$objects[$j]_$operation[$i]_sym(sys1,sys2)\n\n";
      $str = $str . "// Overloads $ope_names[$i]\n// The operands are: $obj_names[$j]-object , sym-object\n\n";
      $str = $str . "sys3 = \%sym_$operation[$i]_sym(sym(sys1),sys2);\n\n";
      $str = $str . "endfunction\n";
      # print($str);
      # Cration of the file
      $nom_fichier = "\%$objects[$j]_$operation[$i]_sym\.sci";
      print "getf(\'macros/percent/$nom_fichier\');\n";
      open (FICH_OPEN, ">$nom_fichier") or die "Cannot open $nom_fichier for write :$!";
      print FICH_OPEN "$str";
      close(FICH_OPEN);
   }
}

