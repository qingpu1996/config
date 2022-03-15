let mapleader = " "
syntax on
syntax enable
colorscheme molokai
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set clipboard+=unnamedplus

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase


set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=''
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set laststatus=2
set autochdir
noremap <LEADER><CR> :nohlsearch<CR>
map S :w<CR>
map Q :q<CR>
map <LEADER>rr :source ~/.config/nvim/init.vim <CR>
noremap <LEADER>w <C-w>w
noremap <LEADER>i <C-w>k
noremap <LEADER>n <C-w>j
noremap <LEADER>y <C-w>h
noremap <LEADER>o <C-w>l

" The key map for norman key board layout
noremap q q
noremap w w
noremap d e
noremap f r
noremap k t
noremap j y
noremap u u
noremap r i
noremap l o
noremap h p
noremap a a
noremap e d
noremap t f
noremap g g
noremap y h
noremap n jzz
noremap i kzz
noremap o l
noremap z z
noremap x x
noremap c c
noremap v v
noremap b b
noremap p n
noremap m m
noremap D E
noremap F R
noremap K T
noremap J Y
noremap U U
noremap R I
noremap L O
noremap H P
noremap A A
noremap E D
noremap T F
noremap G Gzz
noremap Y ^
noremap N 5jzz
noremap I 5kzz
noremap O $
noremap Z Z
noremap X X
noremap C C
noremap V V
noremap P N
noremap M M

" vim-plug
call plug#begin(stdpath('data') . '/plugged')

Plug 'glepnir/dashboard-nvim'
" file
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" icon
Plug 'ryanoasis/vim-devicons'
" stateline
Plug 'vim-airline/vim-airline'
" bufferline
Plug 'bagrat/vim-buffet'
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" commenter
Plug 'preservim/nerdcommenter'
" indent
Plug 'Yggdroot/indentLine'
" json
Plug 'elzr/vim-json'
" sandwich
Plug 'machakann/vim-sandwich'
" vim-gitgutter
Plug 'airblade/vim-gitgutter'
"tagbar
Plug 'liuchengxu/vista.vim'

"ack.vim
Plug 'mileszs/ack.vim'

Plug 'plasticboy/vim-markdown'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'ybian/smartim'

Plug 'mzlogin/vim-markdown-toc'

Plug 'ferrine/md-img-paste.vim'

Plug 'SirVer/ultisnips',{'for':'markdown'}

Plug 'ppwwyyxx/vim-PinyinSearch'

call plug#end()
let g:dashboard_default_executive ='fzf'
"config ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

nmap <leader>st :Ack!<SPACE>
nmap <silent> W <Plug>(coc-ci-w)
nmap <silent> B <Plug>(coc-ci-b)

let g:ackhighlight = 1
let g:ack_qhandler = "botright copen 15"
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1
let g:ack_apply_qmappings = 1


let g:ack_mappings={
  \ "l" : "<CR>"
  \ }

" buffer plug map
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
let g:buffet_powerline_separators=1
let g:buffet_show_index=1
nnoremap <S-Tab> :bn<CR>
nnoremap <LEADER><Tab> :Bw<CR>
nnoremap <LEADER><S-Tab> :Bw!<CR>
nnoremap <C-t> :tabnew split<CR>

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" indentLine config
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
let g:indentLine_color_term = 239
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'CocCommand', 'json']
let g:indentLine_bufNameExclude = ['dashboard', 'CoC Explorer', 'file']
let g:indentLine_concealcursor = ''
let g:indentLine_conceallevel = 2

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

"format 
nmap <leader>rc :CocCommand prettier.formatFile<CR>

" Use K to show documentation in preview window.

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <LEADER>h :call <SID>show_documentation()<CR>

nmap <leader>rn <Plug>(coc-rename)
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>si  <Plug>(coc-codeaction-selected)
nmap <leader>si  <Plug>(coc-codeaction)
nmap <leader>sf  <Plug>(coc-fix-current)
" coc-extension
let g:coc_global_extensions = ['coc-json', 'coc-marketplace', 'coc-ultisnips', 'coc-leetcode',
                                \ 'coc-html', 'coc-css', 'coc-prettier', 'coc-tsserver', 'coc-pyright', 'coc-explorer',
                                \ 'coc-floaterm', 'coc-actions', 'coc-diagnostic', 'coc-snippets', 'coc-pairs', 'coc-emmet', 'coc-syntax', 'coc-highlight',
                                \ 'coc-tailwindcss', 'coc-java', 'coc-ci', 'coc-clangd', '@yaegassy/coc-volar']
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"coc-explorer config
nnoremap <leader>ee :CocCommand explorer<CR>
nmap <silent> <space>en <Plug>(coc-diagnostic-next)
nmap <silent> <space>ei <Plug>(coc-diagnostic-prev)
" format
nmap <leader>rc :CocCommand prettier.formatFile<CR>
xmap <leader>ft  <Plug>(coc-format-selected)
nmap <leader>ft  <Plug>(coc-format-selected)

" sandwich map
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1

" add
silent! nmap <unique> sa <Plug>(operator-sandwich-add)
silent! xmap <unique> sa <Plug>(operator-sandwich-add)
silent! omap <unique> sa <Plug>(operator-sandwich-g@)

" delete
silent! xmap <unique> se <Plug>(operator-sandwich-delete)
silent! nmap <unique><silent> se <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
silent! nmap <unique><silent> seb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

" replace
silent! xmap <unique> sf <Plug>(operator-sandwich-replace)
silent! nmap <unique><silent> sf <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
silent! nmap <unique><silent> sfb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
silent! omap <unique> rb <Plug>(textobj-sandwich-auto-i)
silent! xmap <unique> rb <Plug>(textobj-sandwich-auto-i)
silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

silent! omap <unique> rs <Plug>(textobj-sandwich-query-i)
silent! xmap <unique> rs <Plug>(textobj-sandwich-query-i)
silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)
" vista config
let g:vista_default_executive = 'coc'
nnoremap <leader>vv :Vista!!<CR>
"fuzzyfind
nmap <leader>se :GFiles<CR>
"gitgutter map
let g:gitgutter_map_keys = 0
"markdown config
"" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" java
nnoremap <leader>lr :CocCommand java.action.organizeImports<CR>
let g:smartim_default = 'com.apple.keylayout.ABC'
let g:vmt_auto_update_on_save = 0

autocmd FileType markdown nnoremap <silent> <leader>; :call mdip#MarkdownClipboardImage()<CR>F%i
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'

" PinyinSearch
let g:PinyinSearch_Dict = '/Users/qingpu/.local/share/nvim/plugged/vim-PinyinSearch/PinyinSearch.dict'
nnoremap ? :call PinyinSearch()<CR>
