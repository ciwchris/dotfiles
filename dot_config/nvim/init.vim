" Plugins {{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'moll/vim-bbye'
Plug 'simeji/winresizer'
Plug 'vimwiki/vimwiki'
Plug 'luochen1990/rainbow'

" Have to set up Java
Plug 'dpelle/vim-LanguageTool'

" Just haven't used it
" Plug 'beloglazov/vim-online-thesaurus'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Only used for Janet and DataWeave
" Plug 'skywind3000/asyncrun.vim'

" Interesting language but not using
" Plug 'janet-lang/janet.vim'
" Duplicate?
" Plug 'junegunn/fzf'
" Didn't use
" Plug 'michal-h21/vim-zettel'
" Didn't use
" Plug 'tpope/vim-fugitive'
" Connect to fugitive
" Plug 'rbong/vim-flog'
" Didn't use
" Plug 'lambdalisue/gina.vim'

call plug#end()

" }}}

" Basic options {{{

" Clear all autocmds so they won't get loaded twice. This needs to be up top!
autocmd!

" Set to auto read when a file is changed from the outside
" set autoread

" allow backspacing over everything in insert mode
" set backspace=indent,eol,start

set encoding=utf-8
set nomodeline                      " Security vulnerablity when on
set history=1000
set ruler                           " Show the cursor position all the time
set cmdheight=1                     " The commandbar height
set noshowcmd                       " Display incomplete commands
" perl/python regex (comment can't appear on line below)
nnoremap / /\v
vnoremap / /\v
set incsearch                       " Do incremental searching
set hlsearch
set tabstop=2

set wildmenu
set wildmode=list:longest,full      " Tab complete to longest string
set visualbell
set ttyfast

set number                          " Line numbers off
set relativenumber

set cindent
set autoindent
set smartindent
set mouse=a                         " Use mouse in xterm to scroll
set scrolloff=3                     " 3 lines before and after the current line when scrolling
set ignorecase                      " Ignore case
set smartcase                       " But don't ignore it, when search string contains uppercase letters
set hid                             " Allow switching buffers, which have unsaved changes
set shiftwidth=4                    " 4 characters for indenting
set showmatch                       " Showmatch: Show the matching bracket for the last ')'?
set expandtab                       " Use spaces instead of tabs
" Insert only one space when joining lines containing sentence terminating punctuation
set nojoinspaces

set nowrap                          " Don't wrap by default
set completeopt=menu,longest,preview
" Complete from current buffer, window, buffer, unloaded buffer and dictionary (when spelling is turned on)
set complete=.,w,b,u,kspell
set confirm
syn on

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:mapleader = "\<Space>"



" Change to directory of current file automatically
autocmd BufEnter,BufRead,BufNewFile,BufFilePost *     execute ":lcd " . expand("%:p:h")
" Turn on folding using markers
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Place previous files in buffer then use `gf` to open that file
nnoremap <leader>f :put =execute('bro ol')<cr>gg

" Fast saving
nnoremap <leader>w :w!<cr>

" Fast unloading buffer
nnoremap <leader>d :bd!<cr>

" Fast edit single file (close any other windows on focus on current window)
nnoremap <leader>on :on<cr>

" Fast switching to previous buffer
nnoremap <leader>bp :b#<cr>

" Fast editing of the .vimrc
nnoremap <leader>ev :e! $MYVIMRC<cr>

" When vimrc is edited, reload it
augroup write_vimrc
    autocmd!
    autocmd BufWritePost init.vim source $MYVIMRC
augroup END

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>:set wrap<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convient Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <a-j> <down>
inoremap <a-k> <up>
" Use as leader instead
" nnoremap <space> <c-f>
" Up and down for screen not file line
nnoremap j gj
nnoremap k gk

" Copy & paster system clipboard
vmap <Leader>y "+y 
vmap <Leader>d "+d 
nmap <Leader>p "+p 
nmap <Leader>P "+P 
vmap <Leader>p "+p 
vmap <Leader>P "+P

" Ignores
set wildignore+=*.gif,*.png,*.jpg

""""""" Turn off toolbar
set guioptions-=T

""""""" Remove search highlighting with escape
" ISSUE! When using this after vim starts up we're left in insert mode
"nnoremap <esc> :noh<return><esc>

""""""" viminfo to turn off saving global marks across sessions
set viminfo='100,f0


""""""" show chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬


""""""" Copy working directory of current buffer
:nmap ,p :let @p=substitute(expand("%:p:h"), "/", "\\", "g")<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In command mode type 
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%


" }}}

" NeoVim {{{

if has('nvim')
    " Snow substitution while typing (nosplit for no preview window)
    :set inccommand=split

    " Arch fzf install location of plugin
    set runtimepath+=/usr/share/vim/vimfiles/

    " Easy exit terminal
    tnoremap <Esc> <C-\><C-n>
endif

" }}}
"
" Digraphs {{{

" To use: ":set digraph" then in insert mode type: ".<BS>-"
silent! dig -. 8230 "U+2026=…  HORIZONTAL ELLIPSIS  

" }}}
"
" Backups {{{


""""""" do not use swap or backup files
" set nobackup
" set nowritebackup
" set noswapfile


" From Steve Losh
set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

" Plugin mappings {{{


" Settings for Vimwiki
let g:vimwiki_list = [{'path':'~/notes/vimwiki/markdown/','ext':'.md','syntax':'markdown'}, {"path":"~/notes/vimwiki/wiki/"}]
"let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "
"let g:zettel_options = [{"template" :  "~/notes/vimwiki/template.tpl"}]
"let g:zettel_format = "%y%m%d-%H%M-%title"

" Rainbow paren
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" lightline
set laststatus=2 " always show
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': { 'left': [['filename','modified']], 'right': [['column']]},
      \ 'inactive': { 'left': [['filename','modified']], 'right': [['column']]}
      \ }


" vim-script html indentation
let g:html_ident_inctags = "html,body,head,tbody"
let g:html_ident_script1 = "inc"
let g:html_ident_style1 = "inc"

" Theme
" let s:background_color=readfile($HOME."/.bin/color-mode/current-color-mode","",1)
syntax enable
" let &background=s:background_color[0]
" colorscheme solarized

" ALE
" Not using ALE

" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 1
" let g:ale_sign_column_always = 0
" 
" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '❱'
" 
" highlight ALEWarning ctermbg=DarkMagenta
" highlight ALEError ctermbg=DarkRed
" 
" highlight clear SignColumn

" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

"nnoremap <leader>an :ALENextWrap<cr>
"nnoremap <leader>ap :ALEPreviousWrap<cr>

" Syntastic
" Not using syntastic

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" " Setting to work with roslyn
" "let g:syntastic_cs_checkers = ['code_checker']
" let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" 
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'


" FZF

nnoremap <leader>zb :Buffers<cr>
nnoremap <leader>zh :History<cr>
nnoremap <leader>zf :Files<cr>
nnoremap <leader>zl :BLines<cr>
nnoremap <leader>zg :GFiles?<cr>


" OmniSharp
" Not using

"let g:OmniSharp_server_type = 'roslyn'
" let g:OmniSharp_selector_ui='fzf'
" 
" 
" augroup omnisharp_commands
"     autocmd!
" 
"     "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
"     autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
" 
"     " Synchronous build (blocks Vim)
"     "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
"     " Builds can also run asynchronously with vim-dispatch installed
"     autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuild<cr>
"     " automatic syntax check on events (TextChanged requires Vim 7.4)
"     autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
" 
"     " Automatically add new cs files to the nearest project on save
"     autocmd BufWritePost *.cs call OmniSharp#AddToProject()
" 
"     "show type information automatically when the cursor stops moving
"     autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
" 
"     "The following commands are contextual, based on the current cursor position.
"     autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
"     autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
"     autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
"     autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
"     autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
"     "
"     " cursor can be anywhere on the line containing an issue
"     autocmd FileType cs nnoremap <leader>xi :OmniSharpFixIssue<cr>
"     autocmd FileType cs nnoremap <leader>xu :OmniSharpFixUsings<cr>
"     autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
"     autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
" augroup END
"
"
" Preview window at bottom
" set splitbelow
" 
" " Contextual code actions (requires CtrlP or unite.vim)
" nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" " Run code actions with text selected in visual mode to extract method
" vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
" 
" nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" nnoremap <leader>nm :OmniSharpRename<cr>
" nnoremap <leader>tp :OmniSharpAddToProject<cr>
" nnoremap <leader>th :OmniSharpHighlightTypes<cr>

" AsyncRun

" :let g:asyncrun_open = 8
" :nnoremap <leader>dwt :AsyncRun! -cwd=%:p:h -save=1 -strip dw -input payload %:r.json "$(< %:p)" <cr> 
" :nnoremap <leader>dwi :AsyncRun! -cwd=%:p:h -save=1 -strip dw -input payload %:p "$(< %:r.dwl)" <cr> 
" 
" 
" :nnoremap <leader>jj :AsyncRun! -cwd=%:p:h -save=1 -strip janet %:p <cr> 

" LanguageTool

:let g:languagetool_jar='$HOME/.bin/LanguageTool/languagetool-commandline.jar'


" }}}

" Highlight word {{{

highlight InterestingWord1 ctermbg=LightGreen ctermfg=Black
highlight InterestingWord2 ctermbg=LightBlue ctermfg=Black
highlight InterestingWord3 ctermbg=LightMagenta ctermfg=Black

nnoremap <silent> <leader>he :execute 'match ErrorMsg /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>
nnoremap <leader>hc :match none<cr>:2match none<cr>:3match none<cr>

" I often use one word form accidentially in place of another.
" This will highlight these occurences so I can review them
iabbrev there there<esc>b<leader>heea
iabbrev their their<esc>b<leader>heea
iabbrev attend attend<esc>b<leader>heea
iabbrev our our<esc>b<leader>heea
" }}}

