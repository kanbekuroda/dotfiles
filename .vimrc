" General Settings {{{1
"----------------------------------------------------------------
""vimrc整理用にモードラインを有効化 {{{2
" モードラインを有効にする
set modeline
" 上下3行目までをモードラインとして検索する
set modelines=3
""---------------------------------------------------------------

"" その他のGeneral Settings {{{2
set nocompatible

set t_Co=256
set mouse=a
set number
set numberwidth=5
set ruler
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set showtabline=2
set autoindent
" By default, Vim indents code by 8 spaces. Most people prefer 4 spaces:
set sw=4
set noerrorbells
set laststatus=2
set statusline=%f\ %m%r%h%w\ [FMT=%{&ff}]\ [ENC=%{&fileencoding}]\ [TYP=%Y]%=(Line:%l/%L\ Col:%c)
syntax on

set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" スワップファイル.swpの出力先
set swapfile
set directory=~/.vim/swp
" チルダファイル~の出力先
set backup
set backupdir=~/.vim/backup

"クリップボードにコピー
set clipboard+=unnamed,autoselect
"画面最後の行をできる限り表示する。
set display=lastline

"スペルチェックを有効にする(ただし日本語は除外する)
set spelllang+=cjk
set spell 

" IMEをオフにする
set imdisable

augroup cch
    autocmd! cch
augroup END
"set cursorline
"set cursorcolumn
"hi clear CursorLine
"hi CursorLine gui=underline
"highlight CursorLine ctermbg=black guibg=black

filetype off
filetype plugin indent off


if v:progname =~? "evim"
    finish
endif 
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

map Q gq "Exモードと呼ばれるモードはもともとQで呼び出せるが，あんまり使わないモードなので，代わりにgq(テキスト整形コマンド)として使えるようにしている

inoremap <C-U> <C-G>u<C-U>

if has('mouse')
    set mouse=a
endif

if &t_Co > 2 || has("gui_running")
    set hlsearch
endif

if has("autocmd")

    filetype plugin indent on
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78 
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END
else
    set autoindent		" always set autoindenting on
endif " has("autocmd")

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
end

"create directory automatically {{{2
"----------------------------------------------------------------
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'),v:cmdbang)

    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
                    \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction  
augroup END
"python {{{1
"----------------------------------------------------------------
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
" Execute python script C-P 
function! s:ExecPy()
    exe "!" . &ft . " %" 
    :endfunction
    command! Exec call <SID>ExecPy()
    autocmd FileType python map <silent> <C-P> :call <SID>ExecPy(<CR>)



    "KEY BIND {{{1 
    "----------------------------------------------------------------
    nmap <F1> :VimFiler<CR>

    "カーソルキーで行末／行頭の移動可能に設定。
    set whichwrap=b,s,[,],<,>

    "plugin {{{1
    "----------------------------------------------------
    "NeoBundle {{{2

    filetype off

    if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim
        "call neobundle#rc(expand('~/.vim/bundle/'))
        call neobundle#begin(expand('~/.vim/bundle/'))
    endif
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'ervandew/screen'
    NeoBundle 'https://github.com/h1mesuke/unite-outline.git'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimfiler'
    NeoBundle 'Shougo/vimproc.git'
    NeoBundle 'Shougo/vimshell.git'
    NeoBundle 'jalvesaq/R-Vim-runtime'
    "NeoBundle 'jcfaria/Vim-R-plugin' "development version
    NeoBundle 'vim-scripts/Vim-R-plugin' "stable version
    NeoBundle 'ervandew/screen'
    NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
    " NeoBundle 'Smooth-Scroll'
    NeoBundle 'eregex.vim'
    NeoBundle 'tyru/open-browser.vim'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'vim-ruby/vim-ruby'
    NeoBundle 'tpope/vim-rails'
    NeoBundle 'taglist.vim'
    NeoBundle 'Pydiction'
    NeoBundle 'errormarker.vim'
    NeoBundle 'nginx.vim'
    NeoBundle 'kchmck/vim-coffee-script'
    NeoBundle 'vtreeexplorer'
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'Lokaltog/vim-powerline'
    NeoBundle 'smartword'
    NeoBundle 'mitechie/pyflakes-pathogen'
    NeoBundle 'altercation/vim-colors-solarized'

    " vimproc
    NeoBundle 'Shougo/vimproc.vim', {
                \ 'build' : {
                \     'windows' : 'tools\\update-dll-mingw',
                \     'cygwin' : 'make -f make_cygwin.mak',
                \     'mac' : 'make -f make_mac.mak',
                \     'linux' : 'make',
                \     'unix' : 'gmake',
                \    },
                \ }

    "let vimplugin_screenplugin =0
    call neobundle#end()

    " vim-r-plugin {{{2

    filetype plugin on
    filetype indent on
    let maplocalleader = ","
    let mapleader = ","
    "Disable converting '_' into ' <- '
    let vimrplugin_assign = 0  
    let vimrplugin_term_cmd = "~/Applications/iTerm.app/Contents/MacOS/iTerm -t R"
    "If you prefer to split it vertically:
    let vimrplugin_vsplit = 1

    " neocomplete {{{2
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    "" Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ?
        neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplete#close_popup()
    inoremap <expr><C-e> neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left> neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up> neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down> neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setloca omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

    " Vim-LaTeX {{{2

    filetype plugin on
    filetype indent on
    set grepprg=grep\ -nH\ $*
    let g:tex_flavor='latex'
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_FormatDependency_pdf = 'dvi,pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_CompileRule_dvi = 'platex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_BibtexFlavor = 'pbibtex'
    let g:Tex_MakeIndexFlavor = 'mendex $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1
    let g:Tex_ViewRule_pdf = 'open -a Preview.app'
    let g:Tex_ViewRule_ps = 'open'
    let g:Tex_ViewRule_dvi = 'open'
    let g:Tex_IgnoredWarnings =
                \'Underfull'."\n".
                \'Overfull'."\n".
                \'specifier changed to'."\n".
                \'You have requested'."\n".
                \'Missing number, treated as zero.'."\n".
                \'There were undefined references'."\n".
                \'Citation %.%# undefined'."\n".
                \'LaTeX Font Warning'."\n"
    let g:Tex_IgnoreLevel = 8

    " quickrun {{{2
    " let g:quickrun_config.tex = {'command' : 'autolatex'}

    let g:quickrun_config = {
                \   'tex': {
                \       'command': 'autolatex'
                \   }
                \}

    " color {{{1
    "===============================================
    "
    " " シンタックスハイライトを有効にする
    "
    syntax enable
    "
    " " 背景色を dark にする
    "
    set background=dark
    "
    "
    "
    " " 輝度とコントラストは、最初はデフォルトを試すのがオススメです
    "
    " " 自分はコントラストだけ高くしています
    "
    " " (ここではコメントアウトしています)
    "
    "
    "
    " " 輝度を高くする
    " "let g:solarized_visibility = "high"
    "
    "
    "
    " " コントラストを高くする
    "let g:solarized_contrast = "high"
    " " カラースキーマを Solarized にする
    colorscheme solarized


    " vim: set foldmethod=marker :
    " vim: set foldcolumn=3 :
    " vim: set foldlevel=0 :
