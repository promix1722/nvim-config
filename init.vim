" general
  let mapleader = " "
  set number
  set nowrap
  set noswapfile
  set nobackup

" navigation
  nnoremap <C-j> <C-w>j
  nnoremap <C-h> <C-w>h
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " <C-i> does not work
  nnoremap <tab> gT
  nnoremap <C-o> gt

  nnoremap <leader>0 :tabmove 0<CR>
  nnoremap <leader>1 :tabmove 1<CR>
  nnoremap <leader>2 :tabmove 2<CR>
  nnoremap <leader>3 :tabmove 3<CR>
  nnoremap <leader>4 :tabmove 4<CR>
  nnoremap <leader>5 :tabmove 5<CR>
  nnoremap <leader>6 :tabmove 6<CR>
  nnoremap <leader>7 :tabmove 7<CR>
  nnoremap <leader>8 :tabmove 8<CR>
  nnoremap <leader>9 :tabmove $<CR>

  nnoremap <leader>n :tabnew<CR>
  nnoremap <leader>d :tab split<CR>:NERDTreeMirror<CR><C-w>l
  nnoremap <leader>v :vsp<CR>
  nnoremap <leader>h :sp<CR>

" filetypes
  autocmd FileType ruby   setlocal shiftwidth=2 tabstop=2 expandtab
  autocmd FileType c      setlocal shiftwidth=4 tabstop=4 expandtab
  autocmd FileType go     setlocal shiftwidth=4 tabstop=4 softtabstop=0 noexpandtab

" edit text
  nnoremap <leader><CR> a<CR><Esc>
  nnoremap <leader>q :s/"/'/g<CR>
  vnoremap <leader>q :s/"/'/g<CR>

" highlight errors
  au BufNewFile,BufRead * let w:trailing_ws   = matchadd('ErrorMsg', '\s\+$', -1)
  au BufWinEnter * let w:too_big_line_len     = matchadd('ErrorMsg', '\%>80v.\+', -1)
  au BufNewFile,BufRead * let w:tab_before_sp = matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
  au BufNewFile,BufRead * let w:tab_after_sp  = matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)

" F keys
  " fix tabs
  nnoremap <silent> <F3> :%s/\s\+$//<CR>:let @/=''<CR>
  " highlight tabs
  nnoremap <silent> <F4> :match Error /\t/<CR>

" folding
  set foldmethod=indent

" show folders
  nnoremap <leader>m :NERDTreeToggle<CR>
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
  " Close the tab if NERDTree is the only window remaining in it.
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
  " Start NERDTree and put the cursor back in the other window.
  autocmd VimEnter * NERDTree | wincmd p
  " Open the existing NERDTree on each new tab.
  autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif


" autocomplete
  let g:copilot_no_tab_map = v:true
  imap <tab> <Plug>(copilot-accept-word)
  nnoremap <silent> <F1> :Copilot panel<CR>zi
  inoremap <silent> <F1> <esc> :Copilot panel<CR>zi
  nnoremap <silent> <F2> :Copilot disable<CR>
  imap <C-Right> <Plug>(copilot-next)
  imap <C-Left> <Plug>(copilot-previous)
  imap <C-Down> <Plug>(copilot-accept-line)
  imap <silent><script><expr> <C-Up> copilot#Accept("\<CR>")

" search
" TODO

" bookmarks
" TODO

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'github/copilot.vim'
call plug#end()

" Old Trash
" set wildignore+=*/coverage/**
" set wildignore+=*/vendor/**
" set wildignore+=*/tmp/**
" set wildignore+=*/log/**
" function! Find(word)
"   tabnew
"   execute ':vimgrep /'.a:word.'/gj ./**/*'
"   execute ':cw'
"   execute ':.cc'
"   execute "normal! zR"
" endfunction
" function! FindCurrent()
"   call Find(expand("<cword>"))
" endfunction
" :command! -nargs=1 Find call Find('<args>')
" :command! -nargs=1 F    call Find('<args>')
" nnoremap <leader>w :call FindCurrent()<CR>
" nnoremap <leader>e :.cc<CR>zR
" nnoremap <leader>j <C-w>jj:.cc<CR>zR
" nnoremap <leader>k <C-w>jk:.cc<CR>zR
" nnoremap <leader>o $v%lohc<CR><CR><Up><C-r>"<Esc>:s/,/,\r/g<CR>:'[,']norm ==<CR>
