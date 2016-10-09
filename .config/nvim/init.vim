scriptencoding utf-8
call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/unite.vim'
Plug 'jreybert/vimagit'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
"Plug 'suan/vim-instant-markdown'
"Plug '~/src/deoplete-rtags'
Plug 'zchee/deoplete-jedi'
"Plug 'zchee/deoplete-clang'
Plug 'pignacio/vim-yapf-format'
Plug 'tfnico/vim-gradle'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'alfredodeza/coveragepy.vim'
Plug 'rhysd/vim-clang-format'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'https://github.com/vim-scripts/Relaxed-Green'
Plug 'https://github.com/vim-scripts/greenvision'
Plug 'https://github.com/ratazzi/blackboard.vim'
Plug 'heavenshell/vim-pydocstring'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
"Plug 'bbchung/Clamp'
Plug 'https://github.com/mrtazz/DoxygenToolkit.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'https://github.com/tomasr/molokai'
Plug 'https://github.com/justinmk/molokai'
"Plug 'Yggdroot/indentLine'
Plug 'https://github.com/tikhomirov/vim-glsl'
Plug 'git://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/altercation/vim-colors-solarized'
"Plug 'https://github.com/Shougo/neocomplete.vim'
"Plug 'justmao945/vim-clang'
Plug 'lyuts/vim-rtags'
"Plug 'https://github.com/Rip-Rip/clang_complete'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
"Plug 'https://github.com/davidhalter/jedi-vim'
"Plug 'klen/python-mode'
Plug 'https://github.com/terryma/vim-multiple-cursors'
"Plug 'https://github.com/Valloric/YouCompleteMe'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/wellsjo/wellsokai.vim'
Plug 'https://github.com/sickill/vim-monokai'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/eagletmt/neco-ghc'
Plug 'carlitux/deoplete-ternjs'
call plug#end()

set nocompatible
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set showcmd

set smartcase
set autoindent
set smartindent
set cindent

"syntax on
filetype plugin indent on

map <F10> :source ~/.vimrc<CR>
set mouse=a
set nu
set relativenumber
set showmatch

set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab

"set autochdir

set wildmenu

let mapleader = ","

map <Leader>w :call <SID>StripTrailingWhitespaces()<CR>
map <Leader>f :call <SID>FixIndents()<CR>

map <Leader>ta :tabnew<cr>
map <Leader>tc :tabclose<cr>
map <Leader>tp :tabp<cr>
map <Leader>tn :tabn<cr>
map <Leader>tf :tabr<cr>
map <Leader>tl :tabl<cr>

colorscheme molokai
set nowrap
set ruler
set cursorline
set incsearch

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>FixIndents()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute "normal G=gg"
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function s:yapf_job_handler(job_id, data, event)
    if a:event == 'stdout'
        call extend(self.lines, a:data)
    elseif a:event == 'exit'
        let _s=@/
        let l = line(".")
        let c = col(".")
        silent 1,$delete
        call append(0, self.lines)
        silent! %s#\($\n\s*\)\+\%$#
        let @/=_s
        call cursor(l, c)
        echo "Formatting done"
    endif
endfunction

function! <SID>YapfRun()
    let file_path = expand('%:p')
    let job_data = {
                \ 'on_stdout': function('s:yapf_job_handler'),
                \ 'on_stderr': function('s:yapf_job_handler'),
                \ 'on_exit' : function('s:yapf_job_handler'),
                \ 'lines' : [],
                \ }
    let command_line = "yapf " . file_path
    "let command_line = "autopep8 " . file_path
    echomsg command_line
    let job_id = jobstart(command_line, job_data)
endfunction

highlight extrawhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Limit popup menu height
set pumheight=20
set completeopt=longest,menuone,preview

"set spell
set spelllang=pl

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:SuperTabDefaultCompletionType = 'context'

"learn to stop using arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

set textwidth=80
set colorcolumn=+1
"let &synmaxcol = &textwidth+1

"nvim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>q :CtrlPCmdPalette<cr>
" inoremap jj <ESC>
nnoremap Q <nop>

let g:ycm_confirm_extra_conf = 0

nmap cc viw~

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:syntastic_java_javac_config_file_enabled = 1

autocmd FileType python nnoremap <leader>y :call <SID>YapfRun()<CR>

inoremap <silent><expr> <C-Space>
            \ pumvisible() ? "\<C-n>" :
            \ deoplete#mappings#manual_complete()

let g:livepreview_previewer = 'zathura'
let g:airline_powerline_fonts=1

"set splitbelow
"set splitright

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = []


let deoplete#sources#jedi#show_docstring=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['standard']

