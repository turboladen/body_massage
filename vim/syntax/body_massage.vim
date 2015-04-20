" Vim syntax file
" Language:   BodyMassage
" -----------------------------------------------------------------------------

if exists("b:current_syntax")
  finish
endif

syn cluster bodyMassageNotTop contains=@bodyMassageExtendedStringSpecial,@bodyMassageRegexpSpecial,@bodyMassageDeclaration,bodyMassageConditional,bodyMassageExceptional,bodyMassageFunctionExceptional,bodyMassageTodo

" Operators
if exists("body_massage_operators")
  syn match  bodyMassageOperator "[~!^&|*/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\*\*\|\.\.\.\|\.\.\|::"
  syn match  bodyMassageOperator "->\|-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!="
  syn region bodyMassageBracketOperator matchgroup=bodyMassageOperator start="\%(\w[?!]\=\|[]})]\)\@<=\[\s*" end="\s*]" contains=ALLBUT,@bodyMassageNotTop
endif

syn match bodyMassageStringEscape "\\\\\|\\[abefnrstv]\|\\\o\{1,3}\|\\x\x\{1,2}"						    contained display
syn match bodyMassageStringEscape "\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)" contained display
syn match bodyMassageQuoteEscape  "\\[\\']"											    contained display

syn region bodyMassageInterpolation	      matchgroup=bodyMassageInterpolationDelimiter start="#{" end="}" contained contains=ALLBUT,@bodyMassageNotTop
syn match  bodyMassageInterpolation	      "#\%(\$\|@@\=\)\w\+"    display contained contains=bodyMassageInterpolationDelimiter,bodyMassageInstanceVariable,bodyMassageClassVariable,bodyMassageGlobalVariable,bodyMassagePredefinedVariable
syn match  bodyMassageInterpolationDelimiter "#\ze\%(\$\|@@\=\)\w\+" display contained
syn match  bodyMassageInterpolation	      "#\$\%(-\w\|\W\)"       display contained contains=bodyMassageInterpolationDelimiter,bodyMassagePredefinedVariable,bodyMassageInvalidVariable
syn match  bodyMassageInterpolationDelimiter "#\ze\$\%(-\w\|\W\)"    display contained
syn region bodyMassageNoInterpolation	      start="\\#{" end="}"            contained
syn match  bodyMassageNoInterpolation	      "\\#{"		      display contained
syn match  bodyMassageNoInterpolation	      "\\#\%(\$\|@@\=\)\w\+"  display contained
syn match  bodyMassageNoInterpolation	      "\\#\$\W"		      display contained

syn match bodyMassageDelimEscape	"\\[(<{\[)>}\]]" transparent display contained contains=NONE

syn region bodyMassageNestedParentheses    start="("  skip="\\\\\|\\)"  matchgroup=bodyMassageString end=")"	transparent contained
syn region bodyMassageNestedCurlyBraces    start="{"  skip="\\\\\|\\}"  matchgroup=bodyMassageString end="}"	transparent contained
syn region bodyMassageNestedAngleBrackets  start="<"  skip="\\\\\|\\>"  matchgroup=bodyMassageString end=">"	transparent contained
syn region bodyMassageNestedSquareBrackets start="\[" skip="\\\\\|\\\]" matchgroup=bodyMassageString end="\]"	transparent contained

" These are mostly Oniguruma ready
syn region bodyMassageRegexpComment	matchgroup=bodyMassageRegexpSpecial   start="(?#"								  skip="\\)"  end=")"  contained
syn region bodyMassageRegexpParens	matchgroup=bodyMassageRegexpSpecial   start="(\(?:\|?<\=[=!]\|?>\|?<[a-z_]\w*>\|?[imx]*-[imx]*:\=\|\%(?#\)\@!\)" skip="\\)"  end=")"  contained transparent contains=@bodyMassageRegexpSpecial
syn region bodyMassageRegexpBrackets	matchgroup=bodyMassageRegexpCharClass start="\[\^\="								  skip="\\\]" end="\]" contained transparent contains=bodyMassageStringEscape,bodyMassageRegexpEscape,bodyMassageRegexpCharClass oneline
syn match  bodyMassageRegexpCharClass	"\\[DdHhSsWw]"	       contained display
syn match  bodyMassageRegexpCharClass	"\[:\^\=\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\):\]" contained
syn match  bodyMassageRegexpEscape	"\\[].*?+^$|\\/(){}[]" contained
syn match  bodyMassageRegexpQuantifier	"[*?+][?+]\="	       contained display
syn match  bodyMassageRegexpQuantifier	"{\d\+\%(,\d*\)\=}?\=" contained display
syn match  bodyMassageRegexpAnchor	"[$^]\|\\[ABbGZz]"     contained display
syn match  bodyMassageRegexpDot	"\."		       contained display
syn match  bodyMassageRegexpSpecial	"|"		       contained display
syn match  bodyMassageRegexpSpecial	"\\[1-9]\d\=\d\@!"     contained display
syn match  bodyMassageRegexpSpecial	"\\k<\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\=>" contained display
syn match  bodyMassageRegexpSpecial	"\\k'\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\='" contained display
syn match  bodyMassageRegexpSpecial	"\\g<\%([a-z_]\w*\|-\=\d\+\)>" contained display
syn match  bodyMassageRegexpSpecial	"\\g'\%([a-z_]\w*\|-\=\d\+\)'" contained display

syn cluster bodyMassageStringSpecial	      contains=bodyMassageInterpolation,bodyMassageNoInterpolation,bodyMassageStringEscape
syn cluster bodyMassageExtendedStringSpecial contains=@bodyMassageStringSpecial,bodyMassageNestedParentheses,bodyMassageNestedCurlyBraces,bodyMassageNestedAngleBrackets,bodyMassageNestedSquareBrackets
syn cluster bodyMassageRegexpSpecial	      contains=bodyMassageInterpolation,bodyMassageNoInterpolation,bodyMassageStringEscape,bodyMassageRegexpSpecial,bodyMassageRegexpEscape,bodyMassageRegexpBrackets,bodyMassageRegexpCharClass,bodyMassageRegexpDot,bodyMassageRegexpQuantifier,bodyMassageRegexpAnchor,bodyMassageRegexpParens,bodyMassageRegexpComment

" Numbers and ASCII Codes
syn match bodyMassageASCIICode	"\%(\w\|[]})\"'/]\)\@<!\%(?\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\=\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)\)"
syn match bodyMassageInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[xX]\x\+\%(_\x\+\)*\>"								display
syn match bodyMassageInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)\>"						display
syn match bodyMassageInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[oO]\=\o\+\%(_\o\+\)*\>"								display
syn match bodyMassageInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[bB][01]\+\%(_[01]\+\)*\>"								display
syn match bodyMassageFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*\>"					display
syn match bodyMassageFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>"	display

" Identifiers
syn match bodyMassageLocalVariableOrFunction "\<[_[:lower:]][_[:alnum:]]*[?!=]\=" contains=NONE display transparent
syn match bodyMassageBlockArgument	    "&[_[:lower:]][_[:alnum:]]"		 contains=NONE display transparent

syn match  bodyMassageConstant		"\%(\%(^\|[^.]\)\.\s*\)\@<!\<\u\%(\w\|[^\x00-\x7F]\)*\>\%(\s*(\)\@!"
syn match  bodyMassageClassVariable	"@@\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*" display
syn match  bodyMassageInstanceVariable "@\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*"  display
syn match  bodyMassageGlobalVariable	"$\%(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\|-.\)"
syn match  bodyMassageSymbol		"[]})\"':]\@<!:\%(\^\|\~\|<<\|<=>\|<=\|<\|===\|[=!]=\|[=!]\~\|!\|>>\|>=\|>\||\|-@\|-\|/\|\[]=\|\[]\|\*\*\|\*\|&\|%\|+@\|+\|`\)"
syn match  bodyMassageSymbol		"[]})\"':]\@<!:\$\%(-.\|[`~<=>_,;:!?/.'"@$*\&+0]\)"
syn match  bodyMassageSymbol		"[]})\"':]\@<!:\%(\$\|@@\=\)\=\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*"
syn match  bodyMassageSymbol		"[]})\"':]\@<!:\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\%([?!=]>\@!\)\="
syn region bodyMassageSymbol		start="[]})\"':]\@<!:'"  end="'"  skip="\\\\\|\\'"  contains=bodyMassageQuoteEscape fold
syn region bodyMassageSymbol		start="[]})\"':]\@<!:\"" end="\"" skip="\\\\\|\\\"" contains=@bodyMassageStringSpecial fold

syn match  bodyMassageCapitalizedFunction	"\%(\%(^\|[^.]\)\.\s*\)\@<!\<\u\%(\w\|[^\x00-\x7F]\)*\>\%(\s*(\)*\s*(\@="

syn match  bodyMassageBlockParameter	  "\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*" contained
syn region bodyMassageBlockParameterList start="\%(\%(\<do\>\|{\)\s*\)\@<=|" end="|" oneline display contains=bodyMassageBlockParameter

syn match bodyMassageInvalidVariable	 "$[^ A-Za-z_-]"
syn match bodyMassagePredefinedVariable #$[!$&"'*+,./0:;<=>?@\`~]#
syn match bodyMassagePredefinedVariable "$\d\+"										   display
syn match bodyMassagePredefinedVariable "$_\>"											   display
syn match bodyMassagePredefinedVariable "$-[0FIKadilpvw]\>"									   display
syn match bodyMassagePredefinedVariable "$\%(deferr\|defout\|stderr\|stdin\|stdout\)\>"					   display
syn match bodyMassagePredefinedVariable "$\%(DEBUG\|FILENAME\|KCODE\|LOADED_FEATURES\|LOAD_PATH\|PROGRAM_NAME\|SAFE\|VERBOSE\)\>" display
syn match bodyMassagePredefinedConstant "\%(\%(^\|[^.]\)\.\s*\)\@<!\<\%(ARGF\|ARGV\|ENV\|DATA\|FALSE\|NIL\|STDERR\|STDIN\|STDOUT\|TOPLEVEL_BINDING\|TRUE\)\>\%(\s*(\)\@!"
syn match bodyMassagePredefinedConstant "\%(\%(^\|[^.]\)\.\s*\)\@<!\<\%(RUBY_\%(VERSION\|RELEASE_DATE\|PLATFORM\|PATCHLEVEL\|REVISION\|DESCRIPTION\|COPYRIGHT\|ENGINE\)\)\>\%(\s*(\)\@!"

" Normal Regular Expression
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="\%(\%(^\|\<\%(and\|or\|while\|until\|unless\|if\|elsif\|when\|not\|then\|else\)\|[;\~=!|&(,{[<>?:*+-]\)\s*\)\@<=/" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@bodyMassageRegexpSpecial fold
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="\%(\h\k*\s\+\)\@<=/[ \t=]\@!" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@bodyMassageRegexpSpecial fold

" Generalized Regular Expression
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="%r\z([~`!@#$%^&*_\-+=|\:;"',.? /]\)" end="\z1[iomxneus]*" skip="\\\\\|\\\z1" contains=@bodyMassageRegexpSpecial fold
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="%r{"				 end="}[iomxneus]*"   skip="\\\\\|\\}"	 contains=@bodyMassageRegexpSpecial fold
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="%r<"				 end=">[iomxneus]*"   skip="\\\\\|\\>"	 contains=@bodyMassageRegexpSpecial,bodyMassageNestedAngleBrackets,bodyMassageDelimEscape fold
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="%r\["				 end="\][iomxneus]*"  skip="\\\\\|\\\]"	 contains=@bodyMassageRegexpSpecial fold
syn region bodyMassageRegexp matchgroup=bodyMassageRegexpDelimiter start="%r("				 end=")[iomxneus]*"   skip="\\\\\|\\)"	 contains=@bodyMassageRegexpSpecial fold

" Normal String and Shell Command Output
if exists('bodyMassage_spellcheck_strings')
  syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="\"" end="\"" skip="\\\\\|\\\"" contains=@bodyMassageStringSpecial,@Spell fold
  syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="'"  end="'"  skip="\\\\\|\\'"  contains=bodyMassageQuoteEscape,@Spell    fold
else
  syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="\"" end="\"" skip="\\\\\|\\\"" contains=@bodyMassageStringSpecial fold
  syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="'"  end="'"  skip="\\\\\|\\'"  contains=bodyMassageQuoteEscape    fold
endif
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="`" end="`" skip="\\\\\|\\`" contains=@bodyMassageStringSpecial fold

" Generalized Single Quoted String, Symbol and Array of Strings
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[qwi]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)" end="\z1" skip="\\\\\|\\\z1" fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[qwi]{"				   end="}"   skip="\\\\\|\\}"	fold contains=bodyMassageNestedCurlyBraces,bodyMassageDelimEscape
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[qwi]<"				   end=">"   skip="\\\\\|\\>"	fold contains=bodyMassageNestedAngleBrackets,bodyMassageDelimEscape
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[qwi]\["				   end="\]"  skip="\\\\\|\\\]"	fold contains=bodyMassageNestedSquareBrackets,bodyMassageDelimEscape
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[qwi]("				   end=")"   skip="\\\\\|\\)"	fold contains=bodyMassageNestedParentheses,bodyMassageDelimEscape
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%q "				   end=" "   skip="\\\\\|\\)"	fold

syn region bodyMassageSymbol matchgroup=bodyMassageSymbolDelimiter start="%s\z([~`!@#$%^&*_\-+=|\:;"',.? /]\)"   end="\z1" skip="\\\\\|\\\z1" fold
syn region bodyMassageSymbol matchgroup=bodyMassageSymbolDelimiter start="%s{"				   end="}"   skip="\\\\\|\\}"	fold contains=bodyMassageNestedCurlyBraces,bodyMassageDelimEscape
syn region bodyMassageSymbol matchgroup=bodyMassageSymbolDelimiter start="%s<"				   end=">"   skip="\\\\\|\\>"	fold contains=bodyMassageNestedAngleBrackets,bodyMassageDelimEscape
syn region bodyMassageSymbol matchgroup=bodyMassageSymbolDelimiter start="%s\["				   end="\]"  skip="\\\\\|\\\]"	fold contains=bodyMassageNestedSquareBrackets,bodyMassageDelimEscape
syn region bodyMassageSymbol matchgroup=bodyMassageSymbolDelimiter start="%s("				   end=")"   skip="\\\\\|\\)"	fold contains=bodyMassageNestedParentheses,bodyMassageDelimEscape

" Generalized Double Quoted String and Array of Strings and Shell Command Output
" Note: %= is not matched here as the beginning of a double quoted string
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%\z([~`!@#$%^&*_\-+|\:;"',.?/]\)"	    end="\z1" skip="\\\\\|\\\z1" contains=@bodyMassageStringSpecial fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[QWIx]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)" end="\z1" skip="\\\\\|\\\z1" contains=@bodyMassageStringSpecial fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[QWIx]\={"				    end="}"   skip="\\\\\|\\}"	 contains=@bodyMassageStringSpecial,bodyMassageNestedCurlyBraces,bodyMassageDelimEscape    fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[QWIx]\=<"				    end=">"   skip="\\\\\|\\>"	 contains=@bodyMassageStringSpecial,bodyMassageNestedAngleBrackets,bodyMassageDelimEscape  fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[QWIx]\=\["				    end="\]"  skip="\\\\\|\\\]"	 contains=@bodyMassageStringSpecial,bodyMassageNestedSquareBrackets,bodyMassageDelimEscape fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[QWIx]\=("				    end=")"   skip="\\\\\|\\)"	 contains=@bodyMassageStringSpecial,bodyMassageNestedParentheses,bodyMassageDelimEscape    fold
syn region bodyMassageString matchgroup=bodyMassageStringDelimiter start="%[Qx] "				    end=" "   skip="\\\\\|\\)"   contains=@bodyMassageStringSpecial fold

" Here Document
syn region bodyMassageHeredocStart matchgroup=bodyMassageStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs\%(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\)+	 end=+$+ oneline contains=ALLBUT,@bodyMassageNotTop
syn region bodyMassageHeredocStart matchgroup=bodyMassageStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs"\%([^"]*\)"+ end=+$+ oneline contains=ALLBUT,@bodyMassageNotTop
syn region bodyMassageHeredocStart matchgroup=bodyMassageStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs'\%([^']*\)'+ end=+$+ oneline contains=ALLBUT,@bodyMassageNotTop
syn region bodyMassageHeredocStart matchgroup=bodyMassageStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs`\%([^`]*\)`+ end=+$+ oneline contains=ALLBUT,@bodyMassageNotTop

syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<\z(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2	matchgroup=bodyMassageStringDelimiter end=+^\z1$+ contains=bodyMassageHeredocStart,bodyMassageHeredoc,@bodyMassageStringSpecial fold keepend
syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<"\z([^"]*\)"\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2	matchgroup=bodyMassageStringDelimiter end=+^\z1$+ contains=bodyMassageHeredocStart,bodyMassageHeredoc,@bodyMassageStringSpecial fold keepend
syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<'\z([^']*\)'\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2	matchgroup=bodyMassageStringDelimiter end=+^\z1$+ contains=bodyMassageHeredocStart,bodyMassageHeredoc			fold keepend
syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<`\z([^`]*\)`\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2	matchgroup=bodyMassageStringDelimiter end=+^\z1$+ contains=bodyMassageHeredocStart,bodyMassageHeredoc,@bodyMassageStringSpecial fold keepend

syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-\z(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3    matchgroup=bodyMassageStringDelimiter end=+^\s*\zs\z1$+ contains=bodyMassageHeredocStart,@bodyMassageStringSpecial fold keepend
syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-"\z([^"]*\)"\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3  matchgroup=bodyMassageStringDelimiter end=+^\s*\zs\z1$+ contains=bodyMassageHeredocStart,@bodyMassageStringSpecial fold keepend
syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-'\z([^']*\)'\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3  matchgroup=bodyMassageStringDelimiter end=+^\s*\zs\z1$+ contains=bodyMassageHeredocStart		     fold keepend
syn region bodyMassageString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-`\z([^`]*\)`\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3  matchgroup=bodyMassageStringDelimiter end=+^\s*\zs\z1$+ contains=bodyMassageHeredocStart,@bodyMassageStringSpecial fold keepend

if exists('main_syntax') && main_syntax == 'ebodyMassage'
  let b:bodyMassage_no_expensive = 1
end

syn match  bodyMassageAliasDeclaration    "[^[:space:];#.()]\+" contained contains=bodyMassageSymbol,bodyMassageGlobalVariable,bodyMassagePredefinedVariable nextgroup=bodyMassageAliasDeclaration2 skipwhite
syn match  bodyMassageAliasDeclaration2   "[^[:space:];#.()]\+" contained contains=bodyMassageSymbol,bodyMassageGlobalVariable,bodyMassagePredefinedVariable
syn match  bodyMassageFunctionDeclaration   "[^[:space:];#(]\+"	 contained contains=bodyMassageConstant,bodyMassageBoolean,bodyMassagePseudoVariable,bodyMassageInstanceVariable,bodyMassageClassVariable,bodyMassageGlobalVariable
syn match  bodyMassageClassDeclaration    "[^[:space:];#<]\+"	 contained contains=bodyMassageConstant,bodyMassageOperator
syn match  bodyMassageModuleDeclaration   "[^[:space:];#<]\+"	 contained contains=bodyMassageConstant,bodyMassageOperator
syn match  bodyMassageFunction "\<[_[:alpha:]][_[:alnum:]]*[?!=]\=[[:alnum:]_.:?!=]\@!" contained containedin=bodyMassageFunctionDeclaration
syn match  bodyMassageFunction "\%(\s\|^\)\@<=[_[:alpha:]][_[:alnum:]]*[?!=]\=\%(\s\|$\)\@=" contained containedin=bodyMassageAliasDeclaration,bodyMassageAliasDeclaration2
syn match  bodyMassageFunction "\%([[:space:].]\|^\)\@<=\%(\[\]=\=\|\*\*\|[+-]@\=\|[*/%|&^~]\|<<\|>>\|[<>]=\=\|<=>\|===\|[=!]=\|[=!]\~\|!\|`\)\%([[:space:];#(]\|$\)\@=" contained containedin=bodyMassageAliasDeclaration,bodyMassageAliasDeclaration2,bodyMassageFunctionDeclaration

syn cluster bodyMassageDeclaration contains=bodyMassageAliasDeclaration,bodyMassageAliasDeclaration2,bodyMassageFunctionDeclaration,bodyMassageModuleDeclaration,bodyMassageClassDeclaration,bodyMassageFunction,bodyMassageBlockParameter

" Keywords
" Note: the following keywords have already been defined:
" begin case class def do end for if module unless until while
syn match   bodyMassageControl	       "\<\%(and\|break\|in\|next\|not\|or\|redo\|rescue\|retry\|return\)\>[?!]\@!"
syn match   bodyMassageOperator       "\<defined?" display
syn match   bodyMassageKeyword	       "\<\%(super\|yield\)\>[?!]\@!"
syn match   bodyMassageBoolean	       "\<\%(true\|false\)\>[?!]\@!"
syn match   bodyMassagePseudoVariable "\<\%(nil\|self\|__ENCODING__\|__dir__\|__FILE__\|__LINE__\|__callee__\|__method__\)\>[?!]\@!" " TODO: reorganise
syn match   bodyMassageBeginEnd       "\<\%(BEGIN\|END\)\>[?!]\@!"

" Expensive Mode - match 'end' with the appropriate opening keyword for syntax
" based folding and special highlighting of module/class/method definitions
if !exists("b:bodyMassage_no_expensive") && !exists("bodyMassage_no_expensive")
  syn match  bodyMassageDefine "\<alias\>"  nextgroup=bodyMassageAliasDeclaration  skipwhite skipnl
  syn match  bodyMassageDefine "\<func\>"    nextgroup=bodyMassageFunctionDeclaration skipwhite skipnl
  syn match  bodyMassageDefine "\<endfunc\>"  nextgroup=bodyMassageFunction	     skipwhite skipnl
  syn match  bodyMassageClass	"\<class\>"  nextgroup=bodyMassageClassDeclaration  skipwhite skipnl
  syn match  bodyMassageModule "\<module\>" nextgroup=bodyMassageModuleDeclaration skipwhite skipnl

  " syn region bodyMassageFunctionBlock start="\<func\>"	matchgroup=bodyMassageDefine endfunc="\%(\<func\_s\+\)\@<!\<endfunc\>" contains=ALLBUT,@bodyMassageNotTop fold
  syn region bodyMassageBlock	     start="\<class\>"	matchgroup=bodyMassageClass  end="\<end\>"		       contains=ALLBUT,@bodyMassageNotTop fold
  syn region bodyMassageBlock	     start="\<module\>" matchgroup=bodyMassageModule end="\<end\>"		       contains=ALLBUT,@bodyMassageNotTop fold

  " modifiers
  syn match bodyMassageConditionalModifier "\<\%(if\|unless\)\>"    display
  syn match bodyMassageRepeatModifier	     "\<\%(while\|until\)\>" display

  syn region bodyMassageDoBlock      matchgroup=bodyMassageControl start="\<do\>" end="\<end\>"                 contains=ALLBUT,@bodyMassageNotTop fold
  " curly bracket block or hash literal
  syn region bodyMassageCurlyBlock	matchgroup=bodyMassageCurlyBlockDelimiter  start="{" end="}"				contains=ALLBUT,@bodyMassageNotTop fold
  syn region bodyMassageArrayLiteral	matchgroup=bodyMassageArrayDelimiter	    start="\%(\w\|[\]})]\)\@<!\[" end="]"	contains=ALLBUT,@bodyMassageNotTop fold

  " statements without 'do'
  syn region bodyMassageBlockExpression       matchgroup=bodyMassageControl	  start="\<begin\>" end="\<end\>" contains=ALLBUT,@bodyMassageNotTop fold
  syn region bodyMassageCaseExpression	       matchgroup=bodyMassageConditional start="\<case\>"  end="\<end\>" contains=ALLBUT,@bodyMassageNotTop fold
  syn region bodyMassageConditionalExpression matchgroup=bodyMassageConditional start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+=-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![?!]\)\s*\)\@<=\%(if\|unless\)\>" end="\%(\%(\%(\.\@<!\.\)\|::\)\s*\)\@<!\<end\>" contains=ALLBUT,@bodyMassageNotTop fold

  syn match bodyMassageConditional "\<\%(then\|else\|when\)\>[?!]\@!"	contained containedin=bodyMassageCaseExpression
  syn match bodyMassageConditional "\<\%(then\|else\|elsif\)\>[?!]\@!" contained containedin=bodyMassageConditionalExpression

  syn match bodyMassageExceptional	  "\<\%(\%(\%(;\|^\)\s*\)\@<=rescue\|else\|ensure\)\>[?!]\@!" contained containedin=bodyMassageBlockExpression
  syn match bodyMassageFunctionExceptional "\<\%(\%(\%(;\|^\)\s*\)\@<=rescue\|else\|ensure\)\>[?!]\@!" contained containedin=bodyMassageFunctionBlock

  " statements with optional 'do'
  syn region bodyMassageOptionalDoLine   matchgroup=bodyMassageRepeat start="\<for\>[?!]\@!" start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!=?]\)\s*\)\@<=\<\%(until\|while\)\>" matchgroup=bodyMassageOptionalDo end="\%(\<do\>\)" end="\ze\%(;\|$\)" oneline contains=ALLBUT,@bodyMassageNotTop
  syn region bodyMassageRepeatExpression start="\<for\>[?!]\@!" start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!=?]\)\s*\)\@<=\<\%(until\|while\)\>" matchgroup=bodyMassageRepeat end="\<end\>" contains=ALLBUT,@bodyMassageNotTop nextgroup=bodyMassageOptionalDoLine fold

  if !exists("bodyMassage_minlines")
    let bodyMassage_minlines = 500
  endif
  exec "syn sync minlines=" . bodyMassage_minlines

else
  syn match bodyMassageControl "\<func\>[?!]\@!"    nextgroup=bodyMassageFunctionDeclaration skipwhite skipnl
  syn match bodyMassageControl "\<class\>[?!]\@!"  nextgroup=bodyMassageClassDeclaration  skipwhite skipnl
  syn match bodyMassageControl "\<module\>[?!]\@!" nextgroup=bodyMassageModuleDeclaration skipwhite skipnl
  syn match bodyMassageControl "\<\%(case\|begin\|do\|for\|if\|unless\|while\|until\|else\|elsif\|ensure\|then\|when\|end\)\>[?!]\@!"
  syn match bodyMassageKeyword "\<\%(alias\|undef\)\>[?!]\@!"
endif

" Special Functions
if !exists("bodyMassage_no_special_methods")
  syn keyword bodyMassageAccess    public protected private public_class_method private_class_method public_constant private_constant module_function
  " attr is a common variable name
  syn match   bodyMassageAttribute "\%(\%(^\|;\)\s*\)\@<=attr\>\(\s*[.=]\)\@!"
  syn keyword bodyMassageAttribute attr_accessor attr_reader attr_writer
  syn match   bodyMassageControl   "\<\%(exit!\|\%(abort\|at_exit\|exit\|fork\|loop\|trap\)\>[?!]\@!\)"
  syn keyword bodyMassageEval	    eval class_eval instance_eval module_eval
  syn keyword bodyMassageException raise fail catch throw
  " false positive with 'include?'
  syn match   bodyMassageInclude   "\<include\>[?!]\@!"
  syn keyword bodyMassageInclude   autoload extend load prepend refine require require_relative using
  syn keyword bodyMassageKeyword   callcc caller lambda proc
endif

" Comments and Documentation
syn match   bodyMassageSharpBang "\%^#!.*" display
syn keyword bodyMassageTodo	  FIXME NOTE TODO OPTIMIZE XXX todo contained
syn match   bodyMassageComment   "#.*" contains=bodyMassageSharpBang,bodyMassageSpaceError,bodyMassageTodo,@Spell
if !exists("bodyMassage_no_comment_fold")
  syn region bodyMassageMultilineComment start="\%(\%(^\s*#.*\n\)\@<!\%(^\s*#.*\n\)\)\%(\(^\s*#.*\n\)\{1,}\)\@=" end="\%(^\s*#.*\n\)\@<=\%(^\s*#.*\n\)\%(^\s*#\)\@!" contains=bodyMassageComment transparent fold keepend
  syn region bodyMassageDocumentation	  start="^=begin\ze\%(\s.*\)\=$" end="^=end\%(\s.*\)\=$" contains=bodyMassageSpaceError,bodyMassageTodo,@Spell fold
else
  syn region bodyMassageDocumentation	  start="^=begin\s*$" end="^=end\s*$" contains=bodyMassageSpaceError,bodyMassageTodo,@Spell
endif

" Note: this is a hack to prevent 'keywords' being highlighted as such when called as methods with an explicit receiver
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(alias\|and\|begin\|break\|case\|class\|func\|defined\|do\|else\)\>"		  transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(elsif\|end\|ensure\|false\|for\|if\|in\|module\|next\|nil\)\>"		  transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(not\|or\|redo\|refine\|rescue\|retry\|return\|self\|super\|then\|true\)\>"		  transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(undef\|unless\|until\|when\|while\|yield\|BEGIN\|END\|__FILE__\|__LINE__\)\>" transparent contains=NONE

syn match bodyMassageKeywordAsFunction "\<\%(alias\|begin\|case\|class\|func\|do\|end\)[?!]" transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\<\%(if\|module\|refine\|undef\|unless\|until\|while\)[?!]" transparent contains=NONE

syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(abort\|at_exit\|attr\|attr_accessor\|attr_reader\)\>"	transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(attr_writer\|autoload\|callcc\|catch\|caller\)\>"		transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(eval\|class_eval\|instance_eval\|module_eval\|exit\)\>"	transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(extend\|fail\|fork\|include\|lambda\)\>"			transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(load\|loop\|prepend\|private\|proc\|protected\)\>"		transparent contains=NONE
syn match bodyMassageKeywordAsFunction "\%(\%(\.\@<!\.\)\|::\)\_s*\%(public\|require\|require_relative\|raise\|throw\|trap\|using\)\>"	transparent contains=NONE

syn match  bodyMassageSymbol		"\%([{(,]\_s*\)\@<=\l\w*[!?]\=::\@!"he=e-1
syn match  bodyMassageSymbol		"[]})\"':]\@<!\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:[[:space:],]\@="he=e-1
syn match  bodyMassageSymbol		"\%([{(,]\_s*\)\@<=[[:space:],{]\l\w*[!?]\=::\@!"hs=s+1,he=e-1
syn match  bodyMassageSymbol		"[[:space:],{(]\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:[[:space:],]\@="hs=s+1,he=e-1

" __END__ Directive
syn region bodyMassageData matchgroup=bodyMassageDataDirective start="^__END__$" end="\%$" fold

hi def link bodyMassageClass			bodyMassageDefine
hi def link bodyMassageModule			bodyMassageDefine
hi def link bodyMassageFunctionExceptional	bodyMassageDefine
hi def link bodyMassageDefine			Define
hi def link bodyMassageFunction		Function
hi def link bodyMassageConditional		Conditional
hi def link bodyMassageConditionalModifier	bodyMassageConditional
hi def link bodyMassageExceptional		bodyMassageConditional
hi def link bodyMassageRepeat			Repeat
hi def link bodyMassageRepeatModifier		bodyMassageRepeat
hi def link bodyMassageOptionalDo		bodyMassageRepeat
hi def link bodyMassageControl			Statement
hi def link bodyMassageInclude			Include
hi def link bodyMassageInteger			Number
hi def link bodyMassageASCIICode		Character
hi def link bodyMassageFloat			Float
hi def link bodyMassageBoolean			Boolean
hi def link bodyMassageException		Exception
if !exists("bodyMassage_no_identifiers")
  hi def link bodyMassageIdentifier		Identifier
else
  hi def link bodyMassageIdentifier		NONE
endif
hi def link bodyMassageClassVariable		bodyMassageIdentifier
hi def link bodyMassageConstant		Type
hi def link bodyMassageGlobalVariable		bodyMassageIdentifier
hi def link bodyMassageBlockParameter		bodyMassageIdentifier
hi def link bodyMassageInstanceVariable	bodyMassageIdentifier
hi def link bodyMassagePredefinedIdentifier	bodyMassageIdentifier
hi def link bodyMassagePredefinedConstant	bodyMassagePredefinedIdentifier
hi def link bodyMassagePredefinedVariable	bodyMassagePredefinedIdentifier
hi def link bodyMassageSymbol			Constant
hi def link bodyMassageKeyword			Keyword
hi def link bodyMassageOperator		Operator
hi def link bodyMassageBeginEnd		Statement
hi def link bodyMassageAccess			Statement
hi def link bodyMassageAttribute		Statement
hi def link bodyMassageEval			Statement
hi def link bodyMassagePseudoVariable		Constant
hi def link bodyMassageCapitalizedFunction	bodyMassageLocalVariableOrFunction

hi def link bodyMassageComment			Comment
hi def link bodyMassageData			Comment
hi def link bodyMassageDataDirective		Delimiter
hi def link bodyMassageDocumentation		Comment
hi def link bodyMassageTodo			Todo

hi def link bodyMassageQuoteEscape		bodyMassageStringEscape
hi def link bodyMassageStringEscape		Special
hi def link bodyMassageInterpolationDelimiter	Delimiter
hi def link bodyMassageNoInterpolation		bodyMassageString
hi def link bodyMassageSharpBang		PreProc
hi def link bodyMassageRegexpDelimiter		bodyMassageStringDelimiter
hi def link bodyMassageSymbolDelimiter		bodyMassageStringDelimiter
hi def link bodyMassageStringDelimiter		Delimiter
hi def link bodyMassageHeredoc			bodyMassageString
hi def link bodyMassageString			String
hi def link bodyMassageRegexpEscape		bodyMassageRegexpSpecial
hi def link bodyMassageRegexpQuantifier	bodyMassageRegexpSpecial
hi def link bodyMassageRegexpAnchor		bodyMassageRegexpSpecial
hi def link bodyMassageRegexpDot		bodyMassageRegexpCharClass
hi def link bodyMassageRegexpCharClass		bodyMassageRegexpSpecial
hi def link bodyMassageRegexpSpecial		Special
hi def link bodyMassageRegexpComment		Comment
hi def link bodyMassageRegexp			bodyMassageString

hi def link bodyMassageInvalidVariable		Error
hi def link bodyMassageError			Error
hi def link bodyMassageSpaceError		bodyMassageError

let b:current_syntax = "bodyMassage"

" vim: nowrap sw=2 sts=2 ts=8 noet:
