" plugins
call plug#begin('~/.vim/plugged')

" chrome
Plug 'ahw/vim-pbcopy'
" Plug 'roman/golden-ratio'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
Plug 'tpope/vim-fugitive'

" Tmux
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'edkolev/tmuxline.vim'

" Golang
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'for': 'go'}
let g:go_gopls_enabled = 1
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"
let g:go_imports_mode = "gopls"
let g:go_implements_mode = "gopls"
let g:go_referrers_mode = "gopls"
let g:go_rename_command = "gopls"
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fold_enable = ["block", "import", "varconst", "package_comment", "comment"]
let g:go_gocode_unimported_packages = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:go_metalinter_enabled = []
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_deadline = "60s"
let g:go_statusline_duration = "15s"
let g:go_test_show_name = 1

" code completion
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" IDLs
Plug 'hsanson/vim-openapi'
Plug 'jasdel/vim-smithy'

" Terraform
Plug 'hashivim/vim-terraform', {'for': ['tf', 'terraform', 'tfvars']}
Plug 'juliosueiras/vim-terraform-completion', {'for': ['tf', 'terraform', 'tfvars']}
let g:terraform_fmt_on_save = 1

" YAML
Plug 'nathanaelkane/vim-indent-guides', {'for': ['yaml', 'python']}

" Python
Plug 'nvie/vim-flake8', {'for': 'python'}
let python_highlight_all=1

" Docker
Plug 'docker/docker', {'for': 'dockerfile'}

" be the last wordbender
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

" welcome to the new millenium
set nocompatible

" enable syntax and plugins
syntax enable
syntax sync minlines=256
filetype plugin on
set fdm=syntax
set foldlevelstart=20
set nocursorcolumn
set re=1

" Spelling
set spelllang=en_us                         " 'Merica!
set dictionary+=/usr/share/dict/words       " use standard dictionary
set spellfile=$HOME/.vim/my-words.utf-8.add " my (public) allowlist

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

" spelling hints
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad    ctermfg=9
hi SpellCap    ctermfg=3    cterm=underline
hi SpellRare   ctermfg=13   cterm=underline
hi SpellLocal  cterm=None

" subtle hint for anything past col 80
hi OverLength ctermbg=0 ctermfg=1
match OverLength /\%81v.\+/

" line numbers with styling
hi CursorLineNr term=bold cterm=NONE ctermfg=LightGrey ctermbg=NONE
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
set number                " show line numbers
set relativenumber        " make line numbers relative
set cursorline            " highlight the cursor's line
set laststatus=2          " always display a status line
set smartcase             " case-insensitive search iff search pattern is all lowercase
" set clipboard=unnamedplus " use system pasteboard

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let mapleader = ","
" file types and indention
set sw=2 ts=2 et
au FileType dockerfile,go setlocal sw=8 ts=8 noet tw=80
au FileType go setlocal autowrite

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>l <Plug>(go-metalinter)
au FileType go nmap <Leader>f :GoFmt
au FileType go nmap <Leader>i :GoImports
au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
au FileType go setlocal sw=4 ts=4 noet
au FileType tf,json setlocal sw=2 ts=2 et
au FileType python setlocal sw=4 ts=4 et softtabstop=4 autoindent fileformat=unix
au FileType gitcommit setlocal tw=72
au FileType sshconfig setlocal sw=4 ts=4 noet
au FileType cfg setlocal sw=4 ts=4 et
au FileType gitconfig setlocal sw=4 ts=4 noet
au FileType yaml setlocal foldmethod=indent sw=2 ts=2 et
au FileType markdown setlocal tw=80
au FileType mail setlocal tw=72 wrap nocp
au BufRead,BufNewFile ~/.config/git/config* setlocal ft=gitconfig
au BufRead,BufNewFile ~/.config/ssh/* setlocal ft=sshconfig
au BufRead,BufNewFile ~/.aws/alias setlocal ft=gitconfig foldmethod=indent
au BufRead,BufNewFile ~/.aws/config setlocal ft=cfg
au BufRead,BufNewFile ~/.aws/credentials setlocal ft=cfg
au BufRead,BufNewFile *.py setlocal ft=python
au BufRead,BufNewFile *.yml setlocal ft=yaml
au BufRead,BufNewFile *.tf,*.tfvars setlocal ft=terraform
au BufRead,BufNewFile *.tmux setlocal ft=tmux
autocmd ColorScheme * highlight CocErrorFloat guifg=#ffffff
autocmd ColorScheme * highlight CocInfoFloat guifg=#ffffff
autocmd ColorScheme * highlight CocWarningFloat guifg=#ffffff
autocmd ColorScheme * highlight SignColumn guibg=#adadad

" sane paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" quickfix navigation: ctrl-n for next, ctrl-p for previous.
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

colorschem jellybeans
