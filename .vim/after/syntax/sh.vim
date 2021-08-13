" safe b:current_syntax to restore it afterwards
" Value could be 'sh', 'posix', 'ksh' or 'bash'
let s:cs_safe = b:current_syntax

" unlet b:current_syntax, so json.vim will load
unlet b:current_syntax
syntax include @JSON syntax/json.vim

" restore saved syntax
let b:current_syntax = s:cs_safe

syn region shHereDoc matchgroup=shHereDocJSON start="<<\s*\\\=\z(JSON\)" matchgroup=shHereDocJSON end="^\z1\s*$"   contains=@JSON
hi def link shHereDocSql        shRedir
