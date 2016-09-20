" plugins
call plug#begin('~/.vim/plugged')

" chrome
Plug 'bling/vim-airline'
Plug 'mattn/gist-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tmux-plugins/vim-tmux'

" color theme
Plug 'flazz/vim-colorschemes'

" languages
Plug 'Valloric/YouCompleteMe',  { 'for': 'go' }
Plug 'fatih/vim-go',            { 'for': 'go' }
Plug 'tpope/vim-markdown',      { 'for': 'markdown' }
Plug 'wannesm/wmgraphviz.vim',  { 'for': 'dot' }
Plug 'elzr/vim-json',           { 'for': 'json' }
Plug 'vim-ruby/vim-ruby',       { 'for': 'ruby' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }

" don't make me think
Plug 'tpope/vim-surround'
Plug 'AutoClose'
Plug 'ciaranm/detectindent'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdcommenter'

call plug#end()

color twilight256

let g:markdown_fenced_languages = ['html', 'bash=sh', 'go', 'json']
let g:WMGraphviz_output = 'svg'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=234
highlight LineNr ctermfg=234
highlight CursorLineNr ctermfg=237

set number
set relativenumber
set noshowmode
set backspace=2
set laststatus=2
set ignorecase
set incsearch
set hlsearch
set cursorline

autocmd BufWritePre <buffer> :%s/\s\+$//e " remove trailing whitespace when writing
filetype plugin indent on
autocmd FileType sh,ruby,html,json,yaml setlocal sw=2 ts=2 et
autocmd FileType go setlocal sw=4 ts=4 noet
autocmd FileType dockerfile setlocal sw=8 ts=8 noet

