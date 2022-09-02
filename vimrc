
let mapleader = ',' "Set map leader

set hlsearch

set tabstop=2 "number of spaces in one tab
set shiftwidth=2 "number of spaces to indent
set expandtab "spaces in tabs

set nowrap

set colorcolumn=80 "set ruler (for max width line recommendation)

"colorscheme badwolf
colorscheme Tomorrow

"set guifont=Lucida_Console:h11
set guifont=Monaco:h13

"disable ruler for macvim
set guioptions=

set path+=**
set wildignore+=*/node_modules/*

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"-----------------Mappings----------{{{--"

"Make it easy to edit .vimrc file"
nmap <leader>ev :e $MYVIMRC<cr>

"Add simple hilight search removal"
nmap <leader><space> :nohlsearch<cr>

"Adjust class names for JSX
nmap <leader>cl :%s/class=/className=/g<cr>


nmap <leader>w :w<cr>
nmap <leader>wa :wa<cr>


"Make NERDTree easier to toggle
nmap <leader>1 :NERDTreeToggle<cr>

nmap <leader>11 :NERDTreeFocus<cr>
nmap <leader>111 :NERDTreeFind<cr>

nmap <Leader>dd :colorscheme Tomorrow<cr>
nmap <Leader>nn :colorscheme Tomorrow-Night<cr>

nmap <Leader>conc :%s/console.log/\/\/console.log/g<cr>:nohlsearch<cr>
nmap <Leader>cons :%s/\/\/console.log/console.log/g<cr>:nohlsearch<cr>

" tweak colorcheme
" see https://gist.github.com/ykrsm/a5f9f0e59c14ba498302b7780e988b99
highlight Search guifg=Black guibg=Yellow
highlight Cursor guifg=White guibg=Black

" Toggles between file and its test coverage
function! s:TestFileToggle()
  let l:filepath = @%
  let l:filepathArr = split(l:filepath, '\.')
  if (l:filepathArr[-2] == 'spec')
   " let l:preservedPart = join(l:filepathArr[:len(l:filepathArr) - 3], '.')
    let l:preservedPart = l:filepath[:-8]
    let l:fileExtenstion = 'ts'
  else
    let l:preservedPart = l:filepath[:-3]
   " let l:preservedPart = join(l:filepathArr[:len(l:filepathArr) - 2], '.')
    let l:fileExtenstion = 'spec.ts'
  endif
  let l:resultFilePath =  l:preservedPart . l:fileExtenstion
  "echo 'preservedPart: ' . l:preservedPart
  execute "e " . l:resultFilePath
endfunction

command! TestFileToggle call s:TestFileToggle()
nmap <Leader>tt :TestFileToggle<cr>

function! ColorschemeToggle()
  if g:colors_name == 'Tomorrow-Night'
    colorscheme Tomorrow
    highlight Search guifg=Black guibg=Yellow
    highlight Cursor guifg=White guibg=Black
  else
    colorscheme Tomorrow-Night
    highlight Search guifg=Black guibg=Yellow
    highlight Cursor guifg=White guibg=Orange
  endif
endfunction

nmap <Leader>ct :call ColorschemeToggle()<cr>

" Copy text to system clipboard. For vim (not macVim)) only this works
vmap <Leader>y :w !pbcopy<CR><CR>
"Copy current file name to clipboard
nnoremap <Leader>fy :!echo -n % \| pbcopy<cr><cr>


"toggle show/hide line numbers
noremap <leader>l :set invnumber<cr> 

" Auto close 
"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}
"inoremap (      ()<Left>
"inoremap (<CR>  (<CR>)<Esc>O
"inoremap ((     (
"inoremap ()     ()

"set cursorline
"set cursorcolumn


"-----------------coc.nvim----------{{{--"
" Copied from https://github.com/neoclide/coc.nvim

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"-----------------------------------}}}--"
"

highlight GitGutterAdd    guifg=#009900 guibg=#073642 ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 guibg=#073642 ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 guibg=#073642 ctermfg=1 ctermbg=0
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^_'
let g:gitgutter_sign_modified_removed = 'ww'

"Set Airline theme. Here're screenshots:
" Try new themes with :AirlineTheme <tab>
" https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme='sol'


"-- FOLDING --  
" taken from https://alldrops.info/posts/vim-drops/2018-04-25_javascript-folding-on-vim/
set foldmethod=syntax "syntax highlighting items specify folds  
set foldcolumn=1 "defines 1 col at window left, to indicate folding  
let javaScript_fold=1 "activate folding by JS syntax  
set foldlevelstart=99 "start file with all folds opened

" Auto source vimrc file on save
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC
