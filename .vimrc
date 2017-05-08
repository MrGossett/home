" plugins
call plug#begin('~/.vim/plugged')

" chrome
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" looks best when the Terminal's color scheme is modified to be Solarized
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Plug 'mattn/gist-vim'
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0
au FileType gitcommit set tw=72 " auto-wrap git commits at col 72

Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'edkolev/tmuxline.vim'

" color theme
Plug 'flazz/vim-colorschemes'
let g:solarized_termtrans = 1 " let vim bg fall through to Terminal bg

" Golang
Plug 'Valloric/YouCompleteMe', {'for': 'go'}
Plug 'fatih/vim-go', {'for': 'go'}
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_auto_type_info = 1
let g:go_gocode_unimported_packages = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Markdown
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_fenced_languages = ['bash=sh']
" au FileType markdown setlocal tw=80

" Plug 'wannesm/wmgraphviz.vim'
" let g:WMGraphviz_output = 'svg'

" be the last wordbender
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'

" don't make me think
au FileType json setlocal sw=2 ts=2 et

" Plug 'ciaranm/detectindent'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'roman/golden-ratio'

" Plug 'vim-ruby/vim-ruby'
" au FileType ruby setlocal sw=2 ts=2 et

Plug 'docker/docker', {'for': 'dockerfile'}
au FileType dockerfile setlocal sw=8 ts=8 noet tw=80

Plug 'hashivim/vim-terraform'
au FileType tf setlocal sw=2 ts=2 et
let g:terraform_fmt_on_save = 1

" others
" Plug 'vim-syntastic/syntastic'
" Plug 'myint/syntastic-extras'
" let g:syntastic_cfg_checkers = ['cfg']
" let g:syntastic_make_checkers = ['gnumake']
" let g:syntastic_javascript_checkers = ['json_tool']
" let g:syntastic_gitcommit_checkers = ['language_check']
" let g:syntastic_yaml_checkers = ['pyyaml']

call plug#end()

color solarized

" subtle hint for anything past col 80
hi OverLength ctermbg=0
match OverLength /\%81v.\+/
" line numbers with styling
set number
set relativenumber
set cursorline
hi iCursor ctermfg=1
hi CursorLineNr ctermbg=none
hi LineNr ctermbg=none
hi GitGutterAdd ctermbg=none ctermfg=2
hi GitGutterChange ctermbg=none ctermfg=3
hi GitGutterDelete ctermbg=none ctermfg=1
hi GitGutterChangeDelete ctermbg=none ctermfg=1
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

au BufRead,BufNewFile ~/.aws setlocal ft=cfg

" sane paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

