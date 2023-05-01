" Use :help xxx to check how the details of xxx

set nocompatible  " Make Vim not Vi-compatible and behave in a more useful way

" Disable arrow keys
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

if has('nvim')
  " Switching between terminal mode and normal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>
  " Distinguishing the terminal cursor from normal cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

set hidden " Allow modified buffer to be hidden and not displayed
set noswapfile " Not to create a swpfile for a new buffer 
set backspace=start,eol,indent " Ensure backspace to delete everything in the insert mode including automatically inserted indentation...
set number " Turn on absolute line numbers
set relativenumber " Turn on relative line numbering mode.
set ignorecase smartcase
set hlsearch " Highlight search terms
set incsearch " Show search matches as you are typing
set splitbelow splitright " Splits and Tabbed Files
set clipboard^=unnamed,unnamedplus " let yank also update Clipboard("+) and Selection("*) registers
set cursorline " highlight current line
syntax on " Enable syntax highlighting
filetype plugin on " Enable loading the plugin files for specific file types
filetype indent on " Enable loading the indent files for specific file types

" Show the full path of file at the bottom
set laststatus=2
set statusline+=%F

" Use <CTRL>+j/k/h/l to switch panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set path=.,** " use :find to search files in the directory of the current file and all the directories traversing downward the current working directory

" map the <Leader> string from a backslash to ,
let mapleader = ","

" ========== mappings using <Leader> start ==========
" open vimrc in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>x :xa<CR>

" ========== mappings using <Leader> start ==========

" Traverse Vim's buffer lists
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Search for visually selected text
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" load skeletons
augroup templates
  au!
  " read in template files
  autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END

" enable auto-saving, add CursorHoldI to make it work while insert mode is active
set updatetime=100
autocmd CursorHold * silent! update

set autoread
autocmd CursorHold * checktime

" enable auto-sourcing vimrc, replace BufWritePost with CursorHold since it is not triggered by auto-saving
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded vimrc"

" Search for the current selection for visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Resolve the issue that not able to navigating from a netrw menu 
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
  nnoremap <buffer> <C-l> <C-W>l
endfunction

" swap grep with ack for :grep
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" explicitly define Alt(Option)+s as the chars sent by pressing the keys
if !has('nvim')
    execute "set <M-s>=\es"
endif

" ========== Plugins setups start==========
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
" Plug '~/.fzf'
" enable fzf and automatically download the latest version of the binary
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
" manually execution of :call mkdp#util#install() to avoid post-update hook error is required
" check https://github.com/iamcco/markdown-preview.nvim/issues/497
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-surround'
Plug 'preservim/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'slim-template/vim-slim' " syntax highlighting
" status bar setup
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 
Plug 'tpope/vim-commentary' 
Plug 'airblade/vim-gitgutter' 
Plug 'github/copilot.vim' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-pydocstring', {'do': 'yarn install --frozen-lockfile'}
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()
" ===== Plugins setups end=====


" =====fzf.vim setups start=====
let g:fzf_preview_window = ['right,70%', 'ctrl-/']
let g:fzf_layout = {'window': {'width':1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal'}}
" customize :Files
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>,
                        \ {'window': {'width':1, 'height': 0.3, 'yoffset': 1, 'border': 'horizontal'},
			\ 'options': ['--preview-window=right,70%:hidden', '--bind=ctrl-/:toggle-preview', '--layout=default', '--info=inline',
		        \             '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nmap <C-p> :Files<CR>
nmap <leader>f :Rg<CR>
" =====fzf.vim setups end=====

" =====Markdown Preview for (Neo)vim setups start=====
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
" dark or light
let g:mkdp_theme = 'dark'
" =====Markdown Preview for (Neo)vim setups end=====

" ===== F Keys mapping starts =====
nmap <F5> :!ctags -R<CR> " execute ctags
nmap <F8> :TagbarToggle<CR> " Toggle the Tagbar window
set pastetoggle=<F10> " switch between paste and nopaste modes
" ===== F Keys mapping ends =====

" set vim-airline theme
" raven, luna, badwolf have more distinctive inactive tabs
let g:airline_theme='raven'
" let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline_extensions = ['branch']

" set vim-gitgutter
let g:gitgutter_enabled = 0 " turn it off at startup
nmap <leader>g :GitGutterToggle<CR>

" key mapping for coc-pydocstring
nmap <silent> ga <Plug>(coc-codeaction-line)
xmap <silent> ga <Plug>(coc-codeaction-selected)
nmap <silent> gA <Plug>(coc-codeaction)

" key bindings for gelguy/wilder.nvim
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline(),
      \     wilder#search_pipeline(),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))
