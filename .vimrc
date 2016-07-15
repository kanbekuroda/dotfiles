" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
	execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1
" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " プラグインリストを収めた TOML ファイル
    let s:toml      = '~/.vim/dein.toml'
    let s:lazy_toml = '~/.vim/dein_lazy.toml'


    " TOML を読み込み、キャッシュしておく
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    " 設定終了
    call dein#end()
    call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
    call dein#install()
endif

call dein#call_hook('source')
call dein#call_hook('post_source')

syntax on
filetype plugin indent on


"settings for vim-powerline with powerline project
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Settings for solarized
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

"User Defined
set mouse=a "マウスによる操作を有効化
set backspace=indent,eol,start "Deleteキー有効化

"---------------------------------------------------------------------------
" Nvim-R
"
" TODO: ほんとはたぶん'dein_lazy.toml'に書くべきだけどなぜかうまくいかない

" Change Leader and LocalLeader keys:
let maplocalleader = ","
let mapleader = ";"

" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelecion
nmap <Space> <Plug>RDSendLine

" Split R windows vertically
let R_vsplit = 1

" Split help windows horizontally
let R_nvimpager = "horizontal"

" I prefer do not have the arguments of functions aligned
let r_indent_align_args = 0

" disable converting '_' to '->' feature
let R_assign = 0  
"-------------------------------------------------------------------------
" Gneral Settings
"

set number

" Highlight the last searched pattern:
set hlsearch

" Show where the next pattern is as you type it:
set incsearch

" By default, Vim indents code by 8 spaces. Most people prefer 4
" spaces:
set sw=4

set infercase           " 補完時に大文字小文字を区別しない
