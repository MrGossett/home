" plugins
call plug#begin('~/.vim/plugged')

" chrome
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

Plug 'mattn/gist-vim'
Plug 'airblade/vim-gitgutter'
au FileType gitcommit set tw=72 " auto-wrap git commits at col 72

Plug 'tmux-plugins/vim-tmux'

" color theme
Plug 'flazz/vim-colorschemes'

" Golang
Plug 'Valloric/YouCompleteMe', {'for': 'go'}
Plug 'fatih/vim-go'
au FileType sshconfig setlocal sw=4 ts=4 noet
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Markdown
Plug 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['html', 'bash=sh', 'go', 'json']
au FileType markdown setlocal tw=80

Plug 'wannesm/wmgraphviz.vim'
let g:WMGraphviz_output = 'svg'

Plug 'elzr/vim-json'
au FileType json setlocal sw=2 ts=2 et

Plug 'vim-ruby/vim-ruby'
au FileType ruby setlocal sw=2 ts=2 et

Plug 'docker/docker'
au FileType dockerfile setlocal sw=8 ts=8 noet tw=80

Plug 'hashivim/vim-terraform'
au FileType tf setlocal sw=2 ts=2 et
let g:terraform_fmt_on_save = 1

" don't make me think
Plug 'chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'AutoClose'
Plug 'ciaranm/detectindent'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdcommenter'

call plug#end()
color mrg256
" red-on-red for anything past col 80
hi OverLength ctermbg=52 ctermfg=124
match OverLength /\%81v.\+/
" line numbers with styling
set number
set relativenumber
set cursorline
set noshowmode
set backspace=2
set laststatus=2
set ignorecase
set incsearch
set hlsearch
set clipboard=unnamed " use system pasteboard

au BufWritePre <buffer> :%s/\s\+$//e " remove trailing whitespace on save
filetype plugin indent on
set sw=2 ts=2 et " globally use 2-spacewidth expanded tabs
au FileType sshconfig setlocal sw=4 ts=4 noet

" sane paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

