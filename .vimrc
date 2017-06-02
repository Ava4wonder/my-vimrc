"JackieTseng 2017.05.27
"source a global configuration file if available  
if filereadable("/etc/vim/vimrc.local")  
	source /etc/vim/vimrc.local  
endif
"properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"syntax highlight
if has("syntax")
	syntax on
endif
"cancel vi's compatibility
set nocompatible
filetype off
"show line number
set number
"mouse off in server, set 'a' in PC
set mouse=a
set background=dark
set fileencodings=utf-8,gbk
set termencoding=utf-8,gbk
set encoding=utf-8
"change to the dir of current file
set autochdir
"sqlit windows in same heigth and width
set equalalways
"show search result
set incsearch
"highlight searched items
"set hlsearch
"---- PEP8 coding style ----
"set tab length
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set laststatus=2
"Set my own autocomplete dictionary
"[C-X] + [C-K] to bring up the suggestions
"[C-N] + [C-P] to select next/previous items
set dictionary+=~/.vim/dict.txt
"status line
set fillchars+=stl:\ ,stlnc:-
"Generate backup when writing files
set writebackup
"auto indent when entering new line
set smartindent
"ignore when searching
set ignorecase
" 光标移动到buffer的顶部和底部时保持3行距离
"always retain 3 lines when cursor move to top or bottom of buffer
set scrolloff=3
"---------------------------

"------ Vundle Plugin ------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'godlygeek/tabular'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Rip-Rip/clang_complete'
"Bundle 'tell-k/vim-autopep8'
"Bundle 'altercation/solarized'

call vundle#end()
filetype plugin indent on     " required!

"---------------------------

"------Solarized Theme------
"[To install]
"cd ~/.vim/bundle
"git clone git://github.com/altercation/solarized.git
"
"syntax enable
"set background=dark                                                                                      
"set t_Co=16
"let g:solarized_termcolors=256
"colorscheme solarized
"---------------------------

"-----Clang_Complete--------
"let g:clang_complete_copen=1
"let g:clang_snippets=1
"let g:clang_hl_errors=1
"let g:clang_close_preview=1
"let g:clang_use_library=1
"set completeopt=longest
let g:clang_library_path='/usr/lib/llvm-3.8/lib'
"--------------------------

"----------YCM-------------
"autocmd FileType c set omnifunc=ccomplete
autocmd FileType python set omnifunc=pythoncomplete
autocmd FileType python setlocal completeopt-=preview
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"Make Vim completion menu act as normal IDE
set completeopt=longest,menu
"Close Preview window after leaving insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"location of python interpreter
let g:ycm_path_to_python_interpreter='/usr/bin/python'
"turn on semantic completion
let g:ycm_seed_identifiers_with_syntax=1
"turn on semantic completion in annotations
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"number of character to begin completion
let g:ycm_min_num_of_chars_for_completion=2
"auto close preview window after completion
let g:ycm_autoclose_preview_window_after_completion=1
"not to cash matched items, just regenerate items everytime
let g:ycm_cache_omnifunc=0
"match in srings
let g:ycm_complete_in_strings = 1
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"--------------------------


"--------Nerd Tree----------
map <F2> :call Filelist()<CR>
func! Filelist()
    exec ":NERDTreeToggle"
endfunc

"Open NERDTree while opening vim without files
autocmd vimenter * if !argc() | NERDTree | endif
"Close VIM when there is only NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=1
"Show bookmarks
let NERDTreeShowBookmarks=1
"Set which files to be ignored
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
"Set Window size
let NERDTreeWinSize=25
"---------------------------

"-------Quick Run-----------
map <F3> :call QuickRun()<CR>
func! QuickRun()
    exec "w"<CR>
    exec ":! clear"<CR>
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    endif
endfun
"---------------------------

"---------------------------
"Press F4 to run python without input"
"map <F4> :Autopep8<CR> :w<CR> :call RunPython()<CR>
"map <F4> :w<CR>: !python %<CR>
map <F4> :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction
"---------------------------

"-----------Cursor----------
"red, white, black, green，yellow, blue, purple,
"gray, brown, tan, syan
"more color :h highlight
map <F5> :call Cursor_Line_Column()<CR>
func! Cursor_Line_Column()
    set cursorline!
    set cursorcolumn!
    highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
    highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
endfunc 
"---------------------------

"---Class Outline Viewer----
map <F6> :TagbarToggle<CR>
let g:tagbar_width=30
"let g:tagbar_left=1
"---------------------------

"--------New Tab------------
map <F10> <Esc>:tabnew<CR>
"---------------------------

inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap < <><ESC>i
"inoremap > <c-r>=ClosePair('>')<CR>
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap #inci<TAB> #include <iostream>
inoremap #inca<TAB> #include <algorithm>
inoremap #incs<TAB> #include <string>
inoremap #incc<TAB> #include <cstring>
inoremap us<TAB> using namespace std;
inoremap main<TAB> int main(int argc, const char *argv[]) {<CR>}<ESC>i<CR><TAB>return 0;<CR><ESC>kki<TAB>
inoremap {<CR> {<CR><CR>}<ESC>ki<TAB>
inoremap for<TAB> for (int x = 0; x < ; x++) {<CR>}<ESC>k2f;i
noremap <C-l> <C-w>l
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
"inoremap class<CR> class<CR>{<CR><CR>};<ESC>kkk$a<SPACE>
"inoremap class<CR><CR> class<CR>{<CR><CR>};<ESC>ggO#ifndef<C-r>%<ESC>hr_bgUwywo#define <ESC>po<ESC>Go#endif<ESC>O<ESC>ggO// definition for class <C-r>%<ESC>hd$/class<CR>ea <C-r>%<ESC>hd$jjcc

"new file syntax setting
"let g:extension=expand('%:e')
"if "flex" == g:extension
"    set syntax=lex
"endif
