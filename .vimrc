" plugins
call plug#begin('~/.vim/plugged')

" chrome
Plug 'roman/golden-ratio'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Tmux
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'edkolev/tmuxline.vim'

" Golang
Plug 'fatih/vim-go', {'for': 'go'}
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "10s"
let g:go_metalinter_enabled = ['aligncheck', 'deadcode', 'errcheck', 'gas', 'goconst', 'gocyclo', 'gofmt', 'goimports', 'golint', 'gosimple', 'gotype', 'ineffassign', 'interfacer', 'staticcheck', 'structcheck', 'unconvert', 'varcheck', 'vet', 'vetshadow']
let g:go_gocode_unimported_packages = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Terraform
Plug 'hashivim/vim-terraform', {'for': ['tf', 'terraform', 'tfvars']}
Plug 'juliosueiras/vim-terraform-completion', {'for': ['tf', 'terraform', 'tfvars']}
let g:terraform_fmt_on_save = 1

" Python
Plug 'scrooloose/syntastic', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
let python_highlight_all=1

" Docker
Plug 'docker/docker', {'for': 'dockerfile'}

" be the last wordbender
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'

call plug#end()

" welcome to the new millenium
set nocompatible

" enable syntax and plugins
syntax enable
filetype plugin on
set fdm=syntax
set foldlevelstart=20

" pretty-print JSON
function! JSONFmt()
:%!python -m json.tool
endfunction

" Search down into subfolders. Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NetRW
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
" hide gitignored files
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" remove trailing whitespace on save
au BufWritePre <buffer> :%s/\s\+$//e

" subtle hint for anything past col 80
hi OverLength ctermbg=0 ctermfg=1
match OverLength /\%81v.\+/

" line numbers with styling
hi CursorLineNr term=bold cterm=NONE ctermfg=LightGrey ctermbg=NONE
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
set number            " show line numbers
set relativenumber    " make line numbers relative
set cursorline        " highlight the cursor's line
set laststatus=2      " always display a status line
set smartcase         " case-insensitive search iff search pattern is all lowercase
set clipboard=unnamed " use system pasteboard

" file types and indention
set sw=2 ts=2 et
au FileType dockerfile,go setlocal sw=8 ts=8 noet tw=80
au FileType tf,json setlocal sw=2 ts=2 et
au FileType python setlocal sw=4 ts=4 et tw=79 softtabstop=4 autoindent fileformat=unix
au FileType gitcommit setlocal tw=72
au FileType sshconfig setlocal sw=4 ts=4 noet
au FileType cfg setlocal sw=4 ts=4 et
au BufRead,BufNewFile ~/.aws/config setlocal ft=cfg
au BufRead,BufNewFile ~/.aws/credentials setlocal ft=cfg
au BufRead,BufNewFile *.py setlocal ft=python
au BufRead,BufNewFile Terrafile setlocal ft=yaml

" sane paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

colorscheme jellybeans
