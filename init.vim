let mapleader = ' '
let &t_ut=''


call plug#begin()

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
" commenter
Plug 'preservim/nerdcommenter'
" indent
Plug 'Yggdroot/indentLine'
" sandwich
Plug 'machakann/vim-sandwich'
"tagbar
Plug 'liuchengxu/vista.vim'
"markdown
Plug 'plasticboy/vim-markdown'
"floaterm
Plug 'voldikss/vim-floaterm'
" vim-gitgutter
Plug 'airblade/vim-gitgutter'
"ack.vim
Plug 'mileszs/ack.vim'
"coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"vim-im-select for wsl2 arch
Plug 'Leiyi548/vim-im-select'

call plug#end()

source ~/.config/nvim/basic.vim
source ~/.config/nvim/keymap.vim
source ~/.config/nvim/plugin.vim
