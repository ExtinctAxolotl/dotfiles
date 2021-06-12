" ░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
" ░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
" ░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀

" FILE: ~/.config/nvim/init.vim
" NOTICE: Served best with neovim-0.5

" Some Basics
" Plugins {{{
" Check if plug.vim is installed {{{
if empty(globpath(&runtimepath, '/autoload/plug.vim'))
  echoerr 'Unable to find autoload/plug.vim. Download it from https://github.com/junegunn/vim-plug'
  finish
endif
" }}}

" Plug.vim {{{
call plug#begin(stdpath('data') . '/plugged')
" Completion
if has('nvim-0.5')
  Plug 'hrsh7th/nvim-compe'
  Plug 'neovim/nvim-lspconfig'
endif
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'


" Functionality
Plug 'preservim/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'lambdalisue/vim-manpager'
Plug 'lambdalisue/suda.vim'
Plug 'lambdalisue/pastefix.vim'
Plug 'dstein64/vim-startuptime'

" Fuzzy finder
if has('nvim-0.5')
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
endif


" Trees
Plug 'simnalamburt/vim-mundo'
if has('nvim-0.5')
  Plug 'kyazdani42/nvim-tree.lua'
else
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
endif

" Productivity
Plug 'tricktux/pomodoro.vim'
Plug 'itchyny/calendar.vim'

" UI
" Plug 'arcticicestudio/nord-vim'
Plug 'shaunsingh/nord.nvim'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

if has('nvim-0.5')
  Plug 'hoob3rt/lualine.nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
else
  Plug 'itchyny/lightline.vim'
endif


Plug 'liuchengxu/vim-which-key'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'norcalli/nvim-colorizer.lua'
"Plug 'roman/golden-ratio'
Plug 'mhinz/vim-startify'
call plug#end()
" }}}

" Install Plugins automatically {{{
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
" }}}
" }}}
" Basics {{{
"  Sets {{{
syntax on
set exrc
set nohlsearch
set noerrorbells
set hidden

" Tabs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent

" Numbers
set relativenumber number

set nowrap

set ignorecase
set smartcase
filetype plugin on

set noswapfile
set nobackup
set undofile
set undodir=~/.local/share/nvim/undodir

set incsearch
set scrolloff=10

set foldmethod=marker
set signcolumn=yes
set cursorline

set updatetime=200
set timeoutlen=500
set noshowmode

set completeopt=menuone,noselect
" }}}

" Remaps {{{
let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

let g:which_key_map = {
      \ 'y': [ '"+y"', 'Yank to clipboard' ],
      \ 'p': ['"+p', 'Paste from clipboard'],
      \}
" }}}
"}}}

" User Iterface
" Colors {{{
set termguicolors
let g:nord_contrast = 1
let g:nord_borders = 0
let g:nord_disable_background = 0
let g:nord_cursorline_transparent = 1
colorscheme nord
" lua require('nord').set()
" }}}
" Statuslines/Tablines {{{
set laststatus=2 " Recommended Settings
" functions {{{
function! PomodoroStatus() abort "{{{
  if pomo#remaining_time() ==# '0'
    return " PoDea"
  else
    return " ".pomo#remaining_time()
  endif
endfunction "}}}
" }}}

" Lightline {{{
" let g:lightline = {}
" let g:lightline.colorscheme = 'nord'
" let g:lightline.active = {
"         \   'left': [ [ 'winnr', 'mode', 'paste'],
"         \             [ 'readonly', 'relativepath', 'gitbranch', 'modified'] ],
"         \   'right': [[ 'lineinfo' ],
"         \             [ 'percent' , 'pomodoro'],
"         \             [ 'fileformat', 'fileencoding', 'filetype_icon', 'filetype'] ]
"         \
"         \ }
"
" let g:lightline.inactive = {
"         \   'left': [ [ 'winnr','mode', 'paste'],
"         \             [ 'readonly', 'fullpath', 'modified'] ],
"         \   'right': [[ 'percent', 'fileformat' ],
"         \             [ 'fileformat', 'fileencoding', 'filetype_icon', 'filetype' ] ]
"         \
"         \ }
"
" let g:lightline.tab = {
"       \   'active': [ 'tabnum', 'filename', 'modified'],
"       \   'inactive': [ 'tabnum', 'filename', 'modified'],
"       \ }
"
" let g:lightline.component_function = {
"       \   'gitbranch': 'FugitiveHead',
"       \   'filetype_icon': 'WebDevIconsGetFileTypeSymbol',
"       \   'pomodoro': 'PomodoroStatus',
"       \ }
" let g:lightline.tabline_separator = { 'left': "", 'right': "" }
" let g:lightline.tabline_subseparator = { 'left': ")", 'right': "(" }
"
" let g:lightline.separator = { 'left': "", 'right': "" }
" let g:lightline.subseparator = { 'left': ")", 'right': "(" }

" }}}

" barbar.nvim {{{


" }}}

" lualine.nvim {{{
lua << EOL
config = {
  
  options = {
    theme = 'nord',
    section_separators = {'', ''},
    component_separators = {'', ''}
    },
  
  sections = {
      lualine_a = {'winnr','mode'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress', 'PomodoroStatus'},
      lualine_z = {'location'}
    },
 
  inactive_sections = {
    lualine_a = {'winnr'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'}
    },

  extensions = {nerdtree}
  }


lualine = require('lualine').setup(config)
EOL
" }}}
" }}}
" NVIM-Colorizer {{{
lua require'colorizer'.setup()
" }}}
" vim-which-key {{{
call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_use_floating_win = 1
let g:which_key_map = {
      \ 'name': 'Alpha',
      \}

let g:which_key_map.e = {'name': '+edit'}
let g:which_key_map.s = {'name': '+source'}
" }}}
" vim-startify {{{
" vim_header {{{

let g:vim_header = [
      \" ▄▄▄· ▐▄• ▄       ▄▄▌        ▄▄▄▄▄▪   ▄▄·    ▌ ▐·▪  • ▌ ▄ ·.",
      \"▐█ ▀█  █▌█▌▪ ▄█▀▄ ██•   ▄█▀▄ •██  ██ ▐█ ▌▪  ▪█·█▌██ ·██ ▐███▪",
      \"▄█▀▀█  ·██· ▐█▌.▐▌██ ▪ ▐█▌.▐▌ ▐█.▪▐█·██ ▄▄  ▐█▐█•▐█·▐█ ▌▐▌▐█·",
      \"▐█▪ ▐▌▪▐█·█▌▐█▌.▐▌▐█▌ ▄▐█▌.▐▌ ▐█▌·▐█▌▐███▌   ███ ▐█▌██ ██▌▐█▌",
      \" ▀  ▀ •▀▀ ▀▀ ▀█▄▀▪.▀▀▀  ▀█▄▀▪ ▀▀▀ ▀▀▀·▀▀▀   . ▀  ▀▀▀▀▀  █▪▀▀▀"
      \]

" }}}
let g:startify_shoutout=["","","made with \uf004  on \ue712  by @ExtinctAxolotl"]

let g:startify_custom_header =
      \ startify#center( startify#pad(g:vim_header)) + startify#center(startify#pad(g:startify_shoutout))

" }}}
" Treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF

" }}}
" LSP {{{
" LSP Language Servers {{{
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.rls.setup{}
EOF
" }}}
" Compe {{{
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" }}}
" }}}

"Productivity
" Mundo {{{
let g:mundo_right=1
" nnoremap <leader>u :MundoToggle <CR>
let g:which_key_map["u"] = [ ':MundoToggle', 'Toggle UndoTree' ]
" }}}
" Pomodoro.vim {{{

" totally not copy and pasted from sainnhe's dotfiles (https://github.com/sainnhe/dotfiles) {{{
let g:Pomodoro_Status = 0
function! Toggle_Pomodoro()
  if g:Pomodoro_Status == 0
    let g:Pomodoro_Status = 1
    execute 'PomodoroStart'
  elseif g:Pomodoro_Status == 1
    let g:Pomodoro_Status = 0
    execute 'PomodoroStop'
  endif
endfunction
" end totally not copy and pasted }}}

let g:pomodoro_time_work = 25
let g:pomodoro_time_slack = 5 

let g:pomodoro_do_log = 1 
let g:pomodoro_log_file = "/tmp/pomodoro.log" 

let g:pomodoro_notification_cmd = "notify-send --icon=neovim 'Pomodoro Timer' 'Your time is up!' --urgency=critical"

let g:which_key_map = {'P': [ ':<c-u>call Toggle_Pomodoro()','Toggle Pomodoro' ] }

" }}}
" NERDCommenter {{{
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" WhichKeys
let g:which_key_map["c"] = { 'name': '+commenting',
      \ "\<space>": "Toggle Line Commenting",
      \ "$": "Comment to EOL",
      \ "a": "Comment while respecting Alternative Delimiters",
      \ "A": "Append Comment",
      \ "c": "Comment (no toggling)",
      \ "i": "Invert Comment",
      \ "l": "Align Left",
      \ "m": "Minimal Comment",
      \ "n": "Nested Comment",
      \ "s": "S e x y Comment",
      \ "u": "Uncomment Comment",
      \ "y": "Yank, then Comment",
      \}

" }}}
" suda.vim {{{
let g:suda_smart_edit=1
" }}}
" Fuzzy Finder {{{
" nnoremap <leader>s <cmd>Telescope find_files<cr>
" let g:which_key_map.s = "Fuzzy Finder"
let g:which_key_map['s'] = [':Telescope find_files', 'Fuzzy search files']
" }}}
" Nvim-tree.lua {{{
let g:which_key_map['f'] = [ ':NvimTreeToggle', 'Toggle File Explorer' ]
" }}}
" Other
" VIMRC {{{
let g:which_key_map["e"]= {'name': '+edit',
      \ "v": [ ':vsp ~/.config/nvim/init.vim', 'Edit VimRC in VSplit' ], 
      \ }
" }}}

"vim:foldmethod=marker
