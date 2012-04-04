#!/usr/local/bin/perl
#
# Identique à hlp2html.pl mais les documents HTML sont plus basiques
# pour etre vus dans le browser de Scilab (pas de css, pas de tables)
#
# Transformation du help-message de fonctions écrites pour Scilab en
# fichier html. Mettre ce script dans le répertoire contenant les
# sous-réprtoires 'macros' et 'man' d'une toolbox Scilab et exécuter
# 'perl hlp2man.pl'. Attention, les fichiers du sous-répertoire 'man'
# sont écrasés (faire une sauvegarde en cas de pépin).
#
# Les champs 'help' (= premier ensemble de plus de deux lignes de
# commentaires contigues) doivent être conformes à la structure ci-
# dessous (champs dans le même ordre) et suivre quelques spécifications
# dont celles précisées dans la rubique 'description'.
# Il faudra éventuellement quelques essais-erreurs pour parvenir au
# fichier HTML désiré (script peu intelligent!). On doit en particulier
# retrouver les arguments du champ 'synopsis' dans les champs 'input'
# et 'output' arguments.
#
# // PURPOSE (obligatoire)
# // Descripption courte
# //
# // SYNOPSIS (obligatoire)
# // [ou1,out2] = f_nom(in1,in2[,in3])
# // f_nom(in1)
# //
# // DESCRIPTION (facultatif)
# // Texte pouvant contenir des champs <pre></pre> pour préserver la
# // même présentation en HTLM. Retours ligne automatiques si moins
# // de 68 caractères on peut aussi utiliser la balise HTML <br>. Les
# // balises ne seront pas affichées en utilisant 'hlp foo'. Ne pas
# // utiliser '<some string>' qui serait considéré comme une balise
# // HTML inconnue.
# //
# // REMARK(S) (facultatif)
# // Comme ci-dessus.
# //
# // WARNING (facultatif)
# // Comme ci-dessus
# //
# // CAUTION (facultatif)
# // Comme ci-dessus
# //
# // INPUT ARGUMENT(S) (facultatif)
# // in1     descriptif
# // in2     descriptif
# //
# // OUTPUT ARGUMENT(S) (facultatif)
# // out1     descriptif
# // out2     descriptif
# //
# // See also f_nom1, f_nom2 (facultatif)
# //--------------------------------------------------------------
# // // EXAMPLE (facultatif)
# // bla-bla
# // bla-bla
#
# UNIX, WINDOWS
# perl hlp2html.pl

   use List::Util qw( min );

# Liste des fichiers à traiter
   @liste_des_point_sci = <macros/*.sci>;
   $ref_to_liste = \@liste_des_point_sci;

# Liste des fonctions (D'APRÈS NOMS DES FICHIERS) sans le % éventuel
   for ($i=0; $i <= $#liste_des_point_sci; $i++) {
      $liste_des_point_sci[$i] =~ m/macros\/(\%[^_]+?_)?(\w*)\.sci/;
      $FUNC[$i] = "$1$2";
   }
   $ref_to_functions = \@FUNC;
   print "Liste des fonctions\n";
   foreach $f (@FUNC) {print "$f\n";};

# Creation d'une page html pour chaque fonction
   for ($indidufich=0; $indidufich<$#liste_des_point_sci+1; $indidufich++)
   #for ($indidufich=24; $indidufich<25; $indidufich++)
      {
         &creerhtml($indidufich,$ref_to_liste,$ref_to_functions);
      };

# Fabrication de l'index
   $index_html  = "<head>\n</head>\n";
   $index_html .= "<body>\n\n<center><table><tr><td>\n\n<h1>Index</h1>\n\n<ul>\n";
   foreach $f (@FUNC) {
      $index_html .= "<li><a href=\"$f.html\">$f</a></li>\n";
   }
   $index_html .= "</ul>\n\n</td></tr></table></center>\n\n</body>\n";

   if (! -e "man") {
      print "Creation de man\n";
      mkdir(man,0711);
   }

   open(filehtml,">man/index.html") || die "Ouverture impossible";
   print filehtml "$index_html";
   close(filehtml);

#====================================================================
#====================================================================
# SUBROUTINE PRINCIPALE
#====================================================================
#====================================================================

sub creerhtml {

   my($indidufich,$ref_to_liste,$ref_to_functions) = @_;

#---------------------------------------------------------------------
# Variables locales

   local(@contenu,@hContenu,$PURPO,$SYNOP,$DESCR,$WARNI,$CAUTI,$INPUT,$OUTPU,$SEEAL,$EXAMP,@FUNC,@FUNC0,@ARGS,$milieu);
   @liste_des_point_sci = @$ref_to_liste;
   @FUNC = @$ref_to_functions;

#---------------------------------------------------------------------
# Ouverture du fichier

   $fichier="<$liste_des_point_sci[$indidufich]";
   open (fichier,$fichier) or die "Ouverture de $fichier impossible";
   @contenu = <fichier>;

   print "\n######################## Fichier traité = $fichier\n";

#---------------------------------------------------------------------
# Récuperation de la première ligne et du nom de la fonction

    $premLigne = $contenu[0];
    $premLigne =~ /function.*?[ =]([^= \[\]]*?)\(.*\)/;
    $NOMFONC = $1;

#---------------------------------------------------------------------
# Récuperation de la partie du fichier comportant plus de 2 lignes
# commançant par //

    $i = 0;
    $start = 0;
    for ($j=0; $j<$#contenu; $j++) {
       if ($contenu[$j] =~ m#^//# && $contenu[$j+1] =~ m#^//#) {
          $hContenu[$i] = $contenu[$j];
          $h = $contenu[$j+1];
          # Si les lignes sont plus longues que 68, pas de <br>
          if (length($hContenu[$i]) < 68) {$hContenu[$i] =~ s/\n/\nBR_BR/;};
          $hContenu[$i] =~ s#^// +// *(.*?)\n#<u>$1</u>\n#;   # Lignes de commentaires dans exemples
          $hContenu[$i] =~ s#^// ##;
          $hContenu[$i] =~ s#^//##;
          $hContenu[$i] =~ s/#-+/ /; # Supprime la ligne //#---------...
          $start = 1; # Premier groupes de + de 2 lignes de commentaires
          $i++;
       } else {
          if ($start == 1) {
             # On ignore les autres groupes de + de 2 lignes de commentaires
             last;
          }
       }
    }
    # Dernière ligne
    $h =~ s#^// +// *(.*?)\n#<u>$1</u>\n#; # Lignes de commentaires dans exemples
    $h =~ s#^// ##;
    $h =~ s#^//##;
    $h =~ s/#-+/ /;
    push(@hContenu,$h);
    # Plus : utile si 'See also' sur dernière ligne du help
    push(@hContenu,' ');

#---------------------------------------------------------------------
# Recherche des champs PURPOSE, SYNOPSIS,... EXAMPLE, See also

   # PUROPOSE sera stocké dans $PURPO = ligne $l_purpo1 à ligne $l_purpo2

   $l_purpo1 = $#hContenu; $l_purpo2 = $#hContenu;
   $l_synop1 = $#hContenu; $l_synop2 = $#hContenu;
   $l_descr1 = $#hContenu; $l_descr2 = $#hContenu;
   $l_remar1 = $#hContenu; $l_remar2 = $#hContenu;
   $l_warni1 = $#hContenu; $l_warni2 = $#hContenu;
   $l_cauti1 = $#hContenu; $l_cauti2 = $#hContenu;
   $l_input1 = $#hContenu; $l_input2 = $#hContenu;
   $l_outpu1 = $#hContenu; $l_outpu2 = $#hContenu;
   $l_seeal1 = $#hContenu; $l_seeal2 = $#hContenu;
   $l_examp1 = $#hContenu; $l_examp2 = $#hContenu;

   # Boucle avec indice décroissant pour récupérer le premier mot clé
   # définissant les champs
   for ($i = $#hContenu; $i > -1 ; $i--)
   {
      if ($hContenu[$i] =~ m/EXAMPLE/)    {$l_examp1=$i;}
      if ($hContenu[$i] =~ m/See also/)   {$l_seeal1=$i;}
      if ($hContenu[$i] =~ m/OUTPUT/)     {$l_outpu1=$i;}
      if ($hContenu[$i] =~ m/INPUT/)      {$l_input1=$i;}
      if ($hContenu[$i] =~ m/CAUTION/)    {$l_cauti1=$i;}
      if ($hContenu[$i] =~ m/WARNING/)    {$l_warni1=$i;}
      if ($hContenu[$i] =~ m/REMARK/)     {$l_remar1=$i;}
      if ($hContenu[$i] =~ m/DESCRIPTION/){$l_descr1=$i;}
      if ($hContenu[$i] =~ m/SYNOPSIS/)   {$l_synop1=$i;}
      if ($hContenu[$i] =~ m/PURPOSE/)    {$l_purpo1=$i;}
   }

   # Ligne de fin des champs
   $l_purpo2 = min($l_synop1,$l_descr1,$l_remar1,$l_warni1,$l_cauti1,$l_input1,$l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_synop2 = min($l_descr1,$l_remar1,$l_warni1,$l_cauti1,$l_input1,$l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_descr2 = min($l_remar1,$l_warni1,$l_cauti1,$l_input1,$l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_remar2 = min($l_warni1,$l_cauti1,$l_input1,$l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_warni2 = min($l_cauti1,$l_input1,$l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_cauti2 = min($l_input1,$l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_input2 = min($l_outpu1,$l_examp1,$l_seeal1,$#hContenu);
   $l_outpu2 = min($l_examp1,$l_seeal1,$#hContenu);
   $l_seeal2 = min($l_examp1,$#hContenu);
   $l_examp2 = $#hContenu;

   if ($l_purpo1 != $#hContenu) {$PURPO = join(' ',@hContenu[$l_purpo1+1..$l_purpo2-1]);} else { $PURPO = '';};
   if ($l_synop1 != $#hContenu) {$SYNOP = join(' ',@hContenu[$l_synop1+1..$l_synop2-1]);} else { $SYNOP = '';};
   if ($l_descr1 != $#hContenu) {$DESCR = join(' ',@hContenu[$l_descr1+1..$l_descr2-1]);} else { $DESCR = '';};
   if ($l_remar1 != $#hContenu) {$REMAR = join(' ',@hContenu[$l_remar1+1..$l_remar2-1]);} else { $REMAR = '';};
   if ($l_warni1 != $#hContenu) {$WARNI = join(' ',@hContenu[$l_warni1+1..$l_warni2-1]);} else { $WARNI = '';};
   if ($l_cauti1 != $#hContenu) {$CAUTI = join(' ',@hContenu[$l_cauti1+1..$l_cauti2-1]);} else { $CAUTI = '';};
   if ($l_input1 != $#hContenu) {$INPUT = join(' ',@hContenu[$l_input1+1..$l_input2-1]);} else { $INPUT = '';};
   if ($l_outpu1 != $#hContenu) {$OUTPU = join(' ',@hContenu[$l_outpu1+1..$l_outpu2-1]);} else { $OUTPU = '';};
   if ($l_seeal1 != $#hContenu) {$SEEAL = join(' ',@hContenu[$l_seeal1+0..$l_seeal2-0]);} else { $SEEAL = '';};
   if ($l_examp1 != $#hContenu) {$EXAMP = join(' ',@hContenu[$l_examp1+0..$l_examp2-1]);} else { $EXAMP = '';};

#---------------------------------------------------------------------
# DEBUT et FIN du fichier HTML

   # Ecriture du heading du fichier html
   $debut  = "<html>";
   $debut .= "<head>\n";
   $debut .= "<title>SRMCT function: $NOMFONC</title>\n";
   $debut .= "</head>\n";
   $debut .= "<body bgcolor='#FFFFFF' text='#000000'>\n\n";

   $fin    = "<\/body>\n<\/html>";

#---------------------------------------------------------------------
# PREPARATION DES CHAMPS DU CONTENU DE LA PAGE HTML
#---------------------------------------------------------------------

# Traitement de $SYNOP (en premier car on y identifie les arguments)

   $synop = $SYNOP;
   $synop =~ s/\n//g;
   $synop =~ s/BR_BR //g;                # <- appel de la fonction sur deux lignes
   $synop =~ s/;//g;
   $synop =~ s/\)/\)SPLIT_HERE/g;        # on coupe aux parenthèses fermantes
   @synop2 = split(/SPLIT_HERE/,$synop); # <- plusieurs appels de la fonction

   $inarg0 = '';
   $outarg0 = '';
   $normalCase = 0;

   # Analyse de chaque appel de la fonction
   for ($j = 0; $j <= $#synop2; $j++) {
      # recherche du nom de la fonction
      $synop2[$j] =~ m/\[?([^ \[\]]*?)\]? *=? *(\w+)\((.*)\)/;
      $OUTARG = $1;
      $NOMFONC2 = $2;
      $INARG = $3;
      # arguments sur la même ligne qui sera splitée
      if ($NOMFONC2){
         $normalCase = 1;
         $inarg0  = "$inarg0,$INARG";
         $outarg0 = "$outarg0,$OUTARG";
         $synop2[$j] = "[$1] = <tt>$NOMFONC2</tt>($3)";

         if ($NOMFONC ne $NOMFONC2) {
            print "WARNING ambiguite / non de la fonction : $NOMFONC ou $NOMFONC2\n";
         }
      }
      # Separation en deux ligne si trop long
      if (length($synop2[$j]) > 110) {
            $synop2[$j] =~ s/ = /=<br>/g;
      }
   }
   # en cas d'échec recherche sous la forme 'funct a b c'
   if ($normalCase == 0) {
         $synop = $SYNOP;
         $synop =~ s/BR_BR //g;
         $synop =~ s/BR_BR//g;
         # ligne(s) du synopsis
         @synop2 = split(/\n/,$synop);
         push(@synop2,'');
         # nom de la fonction
         $synop =~ s/\n//g;
         $synop =~ s/;//g;
         $synop =~ m/^ *(\w+) /;
         $NOMFONC2 = $1;
         # les arguments
         $synop =~ s/$1//g;
         $outarg0 = '';
         $inarg0 = $synop;
         $inarg0 =~ s/ +/,/g;
         $inarg0 =~ s/ *//g;
         $inarg0 =~ s/^,//;
   }

   @INARG  = split(/,/,$inarg0);
   @OUTARG = split(/,/,$outarg0);

   foreach $f (@INARG)  { if ($f) { unless ($f =~ m/\.+/) {$f =~s/[\]\[]*//g; push(@ARGS,$f);}} };
   foreach $f (@OUTARG) { if ($f) {$f =~s/[\]\[]*//g; push(@ARGS,$f);} };

   $ref_to_args = \@ARGS;

# Traiter le cas
# // f_mame in1 in2

#---------------------------------------------------------------------
# Traitement de $PURPO

   $purpo0 = $PURPO;
   $purpo0 =~ s/\n//g;
   $purpo0 =~ s/ +/ /g;
   $purpo0 =~ s/lfr- /lfr-/g;
   $purpo0 = &colorize($purpo0,$ref_to_functions,$ref_to_args);

#---------------------------------------------------------------------
# Traitement de $DESCR

   if ($DESCR) {
      $descr0 = $DESCR;
      $descr0 =~ s/lfr- /lfr-/g;
      $descr0 = &colorize($descr0,$ref_to_functions,$ref_to_args);
   }

#---------------------------------------------------------------------
# Traitement de $REMAR

   if ($REMAR) {
      $remar0 = $REMAR;
      $remar0 =~ s/lfr- /lfr-/g;
      $remar0 = &colorize($remar0,$ref_to_functions,$ref_to_args);
   }

#---------------------------------------------------------------------
# Traitement de $WARNI

   if ($WARNI) {
      $warni0 = $WARNI;
      $warni0 =~ s/lfr- /lfr-/g;
      $warni0 = &colorize($warni0,$ref_to_functions,$ref_to_args);
   }

#---------------------------------------------------------------------
# Traitement de $CAUTI

   if ($CAUTI) {
      $cauti0 = $CAUTI;
      $cauti0 =~ s/lfr- /lfr-/g;
      $cauti0 = &colorize($cauti0,$ref_to_functions,$ref_to_args);
   }

#---------------------------------------------------------------------
# Traitement de $INPUT

   if ($INPUT) {

       $input0 =  $INPUT;
       $input0 = &arguments($input0,$ref_to_args);
       $input0 = &colorize($input0,$ref_to_functions,$ref_to_args);
   }

#---------------------------------------------------------------------
# Traitement de $OUTPU

   if ($OUTPU) {

       $outpu0 =  $OUTPU;
       $outpu0 = &arguments($outpu0,$ref_to_args);
       $outpu0 = &colorize($outpu0,$ref_to_functions,$ref_to_args);
   }

#---------------------------------------------------------------------
# Traitement de $SEEAL

   if ($SEEAL){
      # Extraire les noms de fonctions à mettre en évidence
      $functions = '';
      $SEEAL =~ m/See *also *\:? *(.*?)\n/;
      $functions = $1;
      @FUNC0 = split(/, */,$functions);

      # Classe "function" et lien
      $seeal0 = "<font color=\"blue\"><b>See also</b></font>: ";
      for ($i=0; $i <= $#FUNC0; $i++){
         if ($FUNC0[$i]) {
            $FUNC0[$i] =~ s/\s//; # Not clear why but required for a few functions !
            $seeal0 .= "<a href=\"$FUNC0[$i].html\"><tt>$FUNC0[$i]</tt></a>, ";
         }
      };

      # Virgule finale remplacée par un point
      $seeal0 =~ s/, $/./;

      # Remplacement de obj/foo.html par %obj_foo.html dans <a href="">
      $seeal0 =~ s/"(\w+)?\/(\w+)\.html"/"%$1_$2.html"/g;
   }

#---------------------------------------------------------------------
# Traitement de $EXAMP

   if ($EXAMP) {
      $examp0 = $EXAMP;
   }

#---------------------------------------------------------------------
# CONTENU DE LA PAGE HTML
#---------------------------------------------------------------------
   if ($PURPO) {
      $milieu  =  "<p><font color=\"blue\"><b>Purpose</b><\/font></p>\n\n";
      $milieu .=  "<br>$purpo0\n\n";
   }

   if ($SYNOP) {
      $milieu .=  "<p><font color=\"blue\"><b>Synopsis</b><\/font></p>\n\n<ul>\n";
      for ($j = 0; $j < $#synop2; $j++) {
         $synop2[$j] =~ s/\[\] = //;
         $milieu .=  "<li><b><tt>$synop2[$j]</tt><\/b></li>\n";
      }
      $milieu .=  "</ul>\n<br>\n\n";
   }

   if ($DESCR) {
      $milieu .=  "<p><font color=\"blue\"><b>Description</b><\/font></p>\n\n";
      $milieu .= "<br>$descr0\n\n";
   }

   if ($REMAR) {
      $milieu .=  "<p><font color=\"blue\"><b>Remark</b><\/font></p>\n\n";
      $milieu .= "<br>$remar0\n\n";
   }

   if ($WARNI) {
      $milieu .=  "<p><font color=\"blue\"><b>Warning</b><\/font></p>\n\n";
      $milieu .= "<br>$warni0\n\n";
   }

   if ($CAUTI) {
      $milieu .= "<p><font color=\"blue\"><b>Caution</b><\/font></p>\n\n";
      $milieu .= "<br>$cauti0\n\n";
   }

   if ($INPUT){
      $milieu .= "<font color=\"blue\"><b>Input arguments</b><\/font>\n\n";
      $input0 =~ s/<br>//g;
      $milieu .= "<p>$input0</p>\n\n";
   };

   if ($OUTPU){
      $milieu .= "<font color=\"blue\"><b>Output arguments</b><\/font>\n\n";
      $outpu0 =~ s/<br>//g;
      $milieu .= "<p>$outpu0</p>\n\n";
   };

   if ($SEEAL){
      $milieu .= "<p>$seeal0</p>";
   };

   $milieu =~ s/<tt>/<font color=\"green\"><tt>/g;
   $milieu =~ s/<\/tt>/<\/tt><\/font>/g;
   $milieu =~ s/<p>/<br>/g;
   $milieu =~ s/<\/p>/<br>/g;

   if ($EXAMP) {
      $milieu .= "<hr>";
      $milieu .= "\n\n<font color=\"green\"><pre>\n$examp0</pre></font>\n";
   };

   $milieu =~ s/BR_BR//g;
   $milieu =~ s/<br><br>\s*<br><br>/<br><br>/gs;
   $milieu =~ s/<br><br>\s*<\/p>/<\/p>/gs;
   $milieu =~ s/<br><br>\s*<p>/<p>/gs;
   $milieu =~ s/<\/pre>\s*<br><br>/<\/pre>/gs;
   $milieu =~ s/<br><br>\s*<pre>/<pre>/gs;
   $milieu =~ s/([a-z])-\s+([a-z])/$1$2/gs; # Supprime les - entre deux mots, pb avec discrete-time...

#---------------------------------------------------------------------
# CREATION ET ECRITURE DANS LE FICHIER ./HTML
#---------------------------------------------------------------------

   if (! -e "man") {
      print "Creation de html\n";
      mkdir(man,0711);
   }

   print "Ecriture de $NOMFONC.html dans man\n";
   open(filehtml,">man/$NOMFONC.html") || die "Ouverture impossible";
   print filehtml "$debut$milieu$fin\n";
   close(filehtml);

}

#====================================================================
#====================================================================
# AUTRES SUBROUTINE
#====================================================================
#====================================================================

sub colorize {

# Pour traiter tous les champs sauf EXAMP, SYNOP: rajoute des <tt> </tt>
# aux variables (ou chaînes de caractères supposée telle) et
# <cc class="functions"> <.tt> aux fonctions de la toolbox. Traite
# aussi les line-breaks. Les champs <pre> </pre> des fichiers de
# fonctions sont préservés.
#
# synopsis: $x = &colorize($x,$ref_to_functions,$ref_to_args);

   my($strArg,$ref_to_functions,$ref_to_args) = @_;

   local(@FUNC,@ARGS,@PRE);
   @FUNC = @$ref_to_functions;
   @ARGS = @$ref_to_args;

# <PRE>, </PRE> et <BR> préservés

   $strArg =~ s/<PRE>/&lt;PRE&gt;/s;
   $strArg =~ s/<\/PRE>/&lt;\/PRE&gt;/s;
   $strArg =~ s/<BR>/&lt;BR&gt;/s;

# Protection des champs <pre>...</pre>
   $j = 0;
   while ($strArg =~ s/<pre>(.*?)<\/pre>/PRE#PRE/s){
      $prestr = $1;
      $prestr =~ s/^\n//;
      $prestr =~ s/\n *$//;
      $PRE[$j] = "<pre>$prestr</pre>";
      $PRE[$j] =~ s/<br>//g;
      $PRE[$j] =~ s/&nbsp;//g;
      $j++;
   }

# Blancs multiples et retour a la ligne
   $strArg =~ s/BR_BR[ \n]*BR_BR/BR_BR/g;
   $strArg =~ s/BR_BR/<br><br>\n/g;
   $strArg =~ s#^// {4,100}#&nbsp;&nbsp;&nbsp;#; # Retraits à droite
   $strArg =~ s/ +/ /g;

# Clip avec <tt> </tt> des arguments
   foreach $f (@ARGS) {
      $strArg  =~ s/([^\w><])$f([^\w><])/$1<tt>$f<\/tt>$2/g;
      $strArg  =~ s/^$f([^\w><])/<tt>$f<\/tt>$1/g;
   }

# Fonctions -> classe "function"
   foreach $f (@FUNC) {
      $strArg  =~ s/([\W])$f([\W])/$1<tt>$f<\/tt>$2/g;
      $strArg  =~ s/^$f([\W])/<tt>$f<\/tt>$1/;
   }

# Améliorations  cosmétiques
   # Clip entre <tt> </tt>
   $strArg =~ s/i\.e\.\,?/I#E/g;
   $strArg =~ s/e\.g\.\,?/E#G/g;
   $strArg =~ s/\'(\w{1,15})\'/<tt>\'$1\'<\/tt>/g;           # 'xxxxx
   $strArg =~ s/(\[[\w ,;*+\-\/]{1,40}?\])/<tt>$1<\/tt>/g;   # [xxxxx]
   $strArg =~ s/([a-zA-Z]*[0-9]+[a-zA-Z]*)/<tt>$1<\/tt>/g;   # A22c
   $strArg =~ s/([a-zA-Z0-9]*_[\w]*)/<tt>$1<\/tt>/g;         # xx_xx
   $strArg =~ s/([ ,(;\[.*\^\n])([b-zB-Z])([ ,);\].*\^\n])/$1<tt>$2<\/tt>$3/g; # x ou (x) ou x, etc... sauf pour a !
   $strArg =~ s/([ ,(])([b-zB-Z])([ ,)])/$1<tt>$2<\/tt>$3/g; # Répété  pour A,B,C,
   $strArg =~ s/(%[iI]nf)/<tt>$1<\/tt>/g;                    # %inf ou %Inf
   $strArg =~ s/(%eps)/<tt>$1<\/tt>/g;                       # %eps
   $strArg =~ s/(%[Nn]an)/<tt>$1<\/tt>/g;                    # %nan ou %Nan
   $strArg =~ s/(\W)([1I])\/s(\W)/$1<tt>$2\/s<\/tt>$3/g;     # 1/s
   $strArg =~ s/(\W)([1I])\/z(\W)/$1<tt>$2\/z<\/tt>$3/g;     # 1/z
   $strArg =~ s/\"ConstBlock\"/<tt>ConstBlock<\/tt>/g;
   $strArg =~ s/\"Int\"/<tt>Int<\/tt>/g;
   $strArg =~ s/\"Delay\"/<tt>Delay<\/tt>/g;

   $strArg =~ s/width *= *\"<tt>(\d*?)<\/tt>\%\"/width=\"$1\%\"/s;    # Corrections pour eviter width="<tt>100</tt>%"
   $strArg =~ s/border *= *\"<tt>(\d*?)<\/tt>\"/border=\"$1\"/s;

   $strArg =~ s/ +/ /g;
   $strArg =~ s/\s{2,}/\n/gs;
   $strArg =~ s/I#E/<i>i.e.,<\/i>/g;
   $strArg =~ s/E#G/<i>e.g.,<\/i>/g;

   # Expressions en majuscules -> bold minuscule
   $strArg =~ s/([\W])([A-Z ]{8,100})([\W])/$1<b>\L$2\E<\/b>$3/g;

   # Objets -> classe "function"
   # $strArg =~ s/(lfr-objects?)/<tt class=\"function\">$1<\/tt>/g;
   # $strArg =~ s/<tt class=\"function\">lfr<\/tt>-(objects?)/<tt class=\"function\">lfr-$1<\/tt>/g;
   # $strArg =~ s/(ss-objects?)/<tt class=\"function\">$1<\/tt>/g;
   # $strArg =~ s/(sym-objects?)/<tt class=\"function\">$1<\/tt>/g;
   # $strArg =~ s/(syslin-objects?)/<tt class=\"function\">$1<\/tt>/g;

# Restitution des champs <pre>...</pre>
   $j = 0;
   while($strArg =~ m/PRE#PRE/){
      $strArg =~ s/PRE#PRE/$PRE[$j]/;
      $j++;
   }

   return $strArg

}

#======================================================================


sub arguments {

# Pour traiter tous les champs INPUT et OUTPU. Crée une table HTML avec
# les arguments dans la colonne de gauche et les commentaires dans la
# colonne de droite. Les arguments sont clippés entre <tt> </tt>. Pour
# achever le travail, on peut fair appel à &colorize.
#
# synopsis: $x = &arguments($x,$ref_to_args);

   my($strArg,$ref_to_args) = @_;

# Clip avec <tt> </tt> des arguments
   foreach $f (@ARGS) {
      $strArg  =~ s/([^\w><])$f([^\w><])/$1<tt>$f<\/tt>$2/g;
      $strArg  =~ s/^$f([^\w><])/<tt>$f<\/tt>$1/g;
   }
   # <tt>arg1</tt>, <tt>arg2</tt> remplacé par <tt>arg1, arg2</tt>
   while ($strArg  =~ m/<tt>([,\w ]*?)<\/tt>[ ,]*<tt>(\w*?)<\/tt>/){
      $strArg  =~ s/<tt>([,\w ]*?)<\/tt>[ ,]*<tt>(\w*?)<\/tt>/<tt>$1, $2<\/tt>/;
   };

# Création des listes
   $strArg  =~ s/^<tt>([, \w]*?)<\/tt>/<li><b><tt>$1<\/tt><\/b>&nbsp;: &nbsp;\n/;
   $strArg  =~ s/\nBR_BR <tt>([, \w]*?)<\/tt>/<\/li>\n\n<li><b><tt>$1<\/tt><\/b>&nbsp;: &nbsp;\n/g;
   $strArg  =~ s/\n <tt>([, \w]*?)<\/tt>/<\/li>\n\n<li><b><tt>$1<\/tt><\/b>&nbsp;: &nbsp;\n/g;
   $strArg = "<ul>\n\n$strArg</li>\n\n</ul>";

# Supression des BR_BR à la fin
   $strArg  =~ s/(BR_BR[ \n]*)*$//g;

# supression de blancs
   $strArg  =~ s/ +/ /g;
   $strArg  =~ s/\n /\n/g;
   $strArg  =~ s/(<td[^>]*>) /$1/g;
   $strArg  =~ s/\s*<\/td>/<\/td>/gs;
   $strArg  =~ s/(BR_BR\s*)*<\/td>/<\/td>/gs;

# retour ligne restants

   return $strArg

}


