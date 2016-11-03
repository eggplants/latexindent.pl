#!/bin/bash
# set verbose mode, 
# see http://stackoverflow.com/questions/2853803/in-a-shell-script-echo-shell-commands-as-they-are-executed
#
# hugely useful, for example:
#       vim opt-args-test-cases.sh && ./opt-args-test-cases.sh && vim -p environments-second-opt-args.tex environments-second-opt-args-mod2.tex
silentMode=0
# check flags, and change defaults appropriately
while getopts 's' OPTION
do
 case $OPTION in 
  s)    
   echo "Silent mode on...next thing you'll see is git status."
   silentMode=1
   ;;
  ?)    printf "Usage: %s: [-s]  args\n" $(basename $0) >&2
        exit 2
        ;;
 # end case
 esac 
done

# if silentMode is not active, verbose
[[ $silentMode == 0 ]] && set -x 

# optional arguments in environments
latexindent.pl environments-first-opt-args.tex -m  -tt -s -o=environments-first-opt-args-mod0.tex
latexindent.pl environments-first-opt-args-remove-linebreaks1.tex -m  -tt -s -o=environments-first-opt-args-remove-linebreaks1-mod0.tex
latexindent.pl environments-simple-opt-args.tex -m  -tt -s -o=environments-simple-opt-args-out.tex
# loop through -opt-args-mod<i>.yaml, from i=1...16
[[ $silentMode == 0 ]] && set +x
for (( i=1 ; i <= 16 ; i++ )) 
do 
   [[ $silentMode == 0 ]] && set -x
   # one optional arg
   latexindent.pl environments-first-opt-args.tex -m  -tt -s -o=environments-first-opt-args-mod$i.tex -l=opt-args-mod$i.yaml 
   latexindent.pl environments-first-opt-args.tex -m  -tt -s -o=environments-first-opt-args-mod-supp$i.tex -l=opt-args-mod$i.yaml,opt-args-supp.yaml 
   latexindent.pl environments-first-opt-args-remove-linebreaks1.tex -m  -tt -s -o=environments-first-opt-args-remove-linebreaks1-mod$i.tex -l=opt-args-mod$i.yaml 
   latexindent.pl environments-first-opt-args-remove-linebreaks1.tex -m  -tt -s -o=environments-first-opt-args-remove-linebreaks1-mod-supp$i.tex -l=opt-args-mod$i.yaml,opt-args-supp.yaml
   latexindent.pl environments-first-opt-args-remove-linebreaks2.tex -m  -tt -s -o=environments-first-opt-args-remove-linebreaks2-mod-supp$i.tex -l=opt-args-mod$i.yaml,unprotect-blank-lines.yaml
   # two optional args
   latexindent.pl environments-second-opt-args.tex -m -l=opt-args-mod$i.yaml -tt -s -o=environments-second-opt-args-mod$i.tex 
   latexindent.pl environments-second-opt-args-remove-linebreaks1.tex -m -l=opt-args-mod$i.yaml -tt -s -o=environments-second-opt-args-remove-linebreaks1-mod$i.tex 
   latexindent.pl environments-second-opt-args-remove-linebreaks1.tex -m -l=opt-args-mod$i.yaml,unprotect-blank-lines.yaml -tt -s -o=environments-second-opt-args-remove-linebreaks1-mod-unprotect$i.tex 
   latexindent.pl environments-second-opt-args-remove-linebreaks1.tex -m -l=opt-args-mod$i.yaml,unprotect-blank-lines.yaml,condense-blank-lines.yaml -tt -s -o=environments-second-opt-args-remove-linebreaks1-mod-unprotect-condense$i.tex 
   # three, ah ah ah
   latexindent.pl environments-third-opt-args-remove-linebreaks1-trailing-comments.tex -m -l=opt-args-mod$i.yaml -s -tt -o=environments-third-opt-args-remove-linebreaks1-trailing-comments-mod$i.tex
   latexindent.pl environments-third-opt-args.tex -m -l=opt-args-mod$i.yaml,addPercentAfterBegin.yaml -tt -s -o=environments-third-opt-args-mod$i.tex -g=other.log
    [[ $silentMode == 0 ]] && set +x
done
# multi switches set to 2
latexindent.pl environments-third-opt-args-remove-linebreaks1-trailing-comments.tex -m -l=opt-args-mod1.yaml,addPercentAfterBegin.yaml -s -tt -o=environments-third-opt-args-remove-linebreaks1-trailing-comments-mod1-addPercentAfterBegin.tex
latexindent.pl environments-third-opt-args.tex -l=opt-args-mod1.yaml,addPercentBeforeBegin.yaml -m -s -o=environments-third-opt-args-percent-before-begin.tex
latexindent.pl environments-third-opt-args.tex -l=addPercentAfterEnd.yaml -m -s -o=environments-third-opt-args-percent-after-end.tex
latexindent.pl environments-third-opt-args.tex -l=addPercentAfterBody.yaml -m -s -o=environments-third-opt-args-percent-after-body.tex
latexindent.pl -s -m -w environments-first-opt-args-mod-supp1.tex -l=addPercentAfterBody.yaml -o=environments-first-opt-args-mod-supp1-mod1.tex 
latexindent.pl -s environments-first-opt-args-more-comments.tex -m -l=addPercentAfterBegin.yaml  -tt -o=environments-first-opt-args-more-comments-addPercentAfterBegin.tex
latexindent.pl environments-third-opt-args.tex -l=addPercentAll.yaml -m -s -o=environments-third-opt-args-percent-after-all.tex
# noAdditionalIndent experiments   
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent.yaml -m -s -o=environments-third-opt-args-noAddtionalIndentScalar.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-mod1.yaml -m -s -o=environments-third-opt-args-noAddtionalIndentHash-mod1.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-mod2.yaml -m -s -o=environments-third-opt-args-noAddtionalIndentHash-mod2.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-mod3.yaml -m -s -o=environments-third-opt-args-noAddtionalIndentHash-mod3.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-mod4.yaml -m -s -o=environments-third-opt-args-noAddtionalIndentHash-mod4.tex
# indent rules
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-indent-rules1.yaml -m -s -o=environments-third-opt-args-indent-rules1.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-indent-rules2.yaml -m -s -o=environments-third-opt-args-indent-rules2.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-indent-rules3.yaml -m -s -o=environments-third-opt-args-indent-rules3.tex
latexindent.pl environments-third-opt-args.tex -l=addPercent-noAdditionalIndent-opt-args-indent-rules4.yaml -m -s -o=environments-third-opt-args-indent-rules4.tex
# multiple lines in optional arguments
latexindent.pl environments-third-opt-args-multiple-lines.tex -w -s
# noAdditionalIndent
latexindent.pl environments-third-opt-args-mod1.tex -l=noAdditionalIndentGlobal.yaml -s -o=environments-third-opt-args-mod1-global.tex -tt
# indentRules
latexindent.pl environments-third-opt-args-mod1.tex -l=indentRulesGlobal.yaml -s -o=environments-third-opt-args-mod1-indent-rules-global.tex -tt
[[ $silentMode == 0 ]] && set -x
git status
exit
