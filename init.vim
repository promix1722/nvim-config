call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'github/copilot.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'nvim-pack/nvim-spectre'
  Plug 'FrankRoeder/parrot.nvim'
call plug#end()

" general
  colorscheme shine

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
  " fix trailing whitespaces
  nnoremap <silent> <F12> :%s/\s\+$//<CR>:let @/=''<CR>

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


" ai autocomplete
  let g:copilot_no_tab_map = v:true
  inoremap <tab> <Plug>(copilot-accept-word)
  inoremap <C-Right> <Plug>(copilot-next)
  inoremap <C-Left> <Plug>(copilot-previous)
  inoremap <C-Down> <Plug>(copilot-accept-line)
  inoremap <silent> <script> <expr> <C-Up> copilot#Accept("\<CR>")

  nnoremap <silent> <F1> :PrtTabnew<CR>
  vnoremap <silent> <F1> :PrtTabnew<CR>

  vnoremap <silent> <F2> :PrtRewrite<CR>

  vnoremap <silent> <F3> :Copilot panel<CR>zi

  nnoremap <silent> <F4> :Copilot disable<CR>

" search & replace
  set wildignore+=*/coverage/**
  set wildignore+=*/vendor/**
  set wildignore+=*/tmp/**
  set wildignore+=*/log/**
  nnoremap <silent> <F5> :Telescope find_files<CR>
  nnoremap <silent> <F6> :Telescope live_grep<CR>
  nnoremap <silent> <expr> <F7> ':Telescope find_files<cr>' . expand('<cword>')
  nnoremap <silent> <F8> :tabnew<CR>:Spectre<CR>
  nnoremap <silent> <F9> <cmd>lua require('spectre.actions').run_current_replace()<CR>
  nnoremap <silent> <F10> <cmd>lua require('spectre.actions').run_replace()<CR>

" init parrot
lua << EOF
require("parrot").setup {
  -- Providers must be explicitly added to make them available.
  providers = {
    -- pplx = {
    --   api_key = os.getenv "PERPLEXITY_API_KEY",
    -- },
    openai = {
      api_key = os.getenv "OPENAI_API_KEY",
    },
  },
}
EOF
