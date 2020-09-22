call plug#begin('~/.config/nvim/plugged')

  Plug 'sainnhe/sonokai'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sheerun/vim-polyglot'

  "PHP Autocompletion
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
  Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
  Plug 'ncm2/ncm2-ultisnips'

  "Php Custom snippets Ex: fore means foreach
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'phux/vim-snippets'

  
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  " tabular plugin is used to format tables
  Plug 'godlygeek/tabular'
  " JSON front matter highlight plugin
  Plug 'elzr/vim-json'
  Plug 'plasticboy/vim-markdown'

  "PHP Syntax Hoghlight
  Plug 'StanAngeloff/php.vim', {'for': 'php'}

  "Less messy code with ale
  Plug 'w0rp/ale'

  "PHP refactoring toolbox
  Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}

  " PHP Namespace Handling
  Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}

  " Open Php manual
  Plug 'alvan/vim-php-manual', {'for': 'php'}

  " fuzy searching
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  "git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  "File Explorer
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'

  " Comment
  Plug 'preservim/nerdcommenter'
call plug#end()

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

colorscheme sonokai
"let g:airline_theme='one'
"let g:one_allow_italics = 1
"colorscheme one


"Explorer
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>

" the ignore patterns are regular expression strings and seprated by comma
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

"show current root as relative path from $HOME in status bar
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"


" PHP7
let g:ultisniips_php_scalar_typesi = 1

augroup ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
augroup END

" parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

" use 4 spaces instead of tab (to replace existing tab use :retab)
" copy indent from current line when starting a new line
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" highlight the line which is longer than the defined margin (120 character)
highlight MaxLineChar ctermbg=red
autocmd FileType php,js,vue,go call matchadd('MaxLineChar', '\%120v', 100)


" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
imap <c-s> <esc>:w<cr>:Silent php-cs-fixer fix %:p --level=symfony<cr>

" refactoring toolbox
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>

" context-aware menu with all functions (ALT-m)
nnoremap <m-m> :call phpactor#ContextMenu()<cr>

nnoremap gd :call phpactor#GotoDefinition()<CR>
nnoremap gr :call phpactor#FindReferences()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
" extract variable
vnoremap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
nnoremap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" extract interface
nnoremap <silent><Leader>rei :call phpactor#ClassInflect()<CR>

let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'

function! PHPModify(transformer)
    :update
    let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    execute l:cmd
endfunction

nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<cr>
function! PhpConstructorArgumentMagic()
    " update phpdoc
    if exists("*UpdatePhpDocIfExists")
        normal! gg
        /__construct
        normal! n
        :call UpdatePhpDocIfExists()
        :w
    endif
    :call PHPModify("complete_constructor")
endfunction


nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>

nnoremap <leader>raa :call PHPModify("add_missing_properties")<cr>

nnoremap <leader>rmc :call PHPMoveClass()<cr>
function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction

nnoremap <leader>rmd :call PHPMoveDir()<cr>
function! PHPMoveDir()
    :w
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
endfunction

" Namespace Handling
nnoremap <Leader>u :PHPImportClass<cr>
nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
nnoremap <Leader>E :PHPExpandFQCN<cr>

" Php Manual
let g:php_manual_online_search_shortcut = '<leader>k'

" Fuzzy
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" requires silversearcher-ag

" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"MD-------------------------------"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> to trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

"MD-------------------------------"
