
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

" indentLine config
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
let g:indentLine_color_term = 239
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'CocCommand', 'json']
let g:indentLine_bufNameExclude = ['dashboard', 'CoC Explorer', 'file']
let g:indentLine_concealcursor = ''
let g:indentLine_conceallevel = 2

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

"fuzzyfind
nmap <leader>se :GFiles<CR>
"gitgutter
let g:gitgutter_map_keys = 0
"dashboard
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

"coc
"coc extensions
let g:coc_global_extensions = ['coc-marketplace', 'coc-explorer', 'coc-prettier']

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

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
"coc-explorer config
nnoremap <leader>ee :CocCommand explorer<CR>
nmap <silent> <space>en <Plug>(coc-diagnostic-next)
nmap <silent> <space>ei <Plug>(coc-diagnostic-prev)
" format
nmap <leader>rc :CocCommand prettier.formatFile<CR>
xmap <leader>ft  <Plug>(coc-format-selected)
nmap <leader>ft  <Plug>(coc-format-selected)
