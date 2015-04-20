" Vim filetype plugin
" Language: BodyMassage
" -----------------------------------------------------------------------------

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal include=^\\s*\\<\\(load\\>\\\|require\\>\\\|autoload\\s*:\\=[\"']\\=\\h\\w*[\"']\\=,\\)
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.rb','')
setlocal suffixesadd=.bm

setlocal comments=:#
setlocal commentstring=#\ %s

if has("autocmd")
  autocmd BufNewFile,BufRead *.bm set filetype=body_massage
  autocmd Filetype body_massage setlocal ts=2 sts=2 sw=2 expandtab
endif
