" Save buffer's current syntax
let s:bcs = b:current_syntax
unlet b:current_syntax

" Magic happens here.
syntax include @RUBY syntax/ruby.vim

" Restore buffer's current syntax
let b:current_syntax = s:bcs

" Match shell heredoc formats
syntax region shellRuby matchgroup=Statement start=+<<-\?RUBY+ end=+^\s*RUBY$+ contains=@RUBY
