" File: gitgrep.vim
" Author: Ali Aghareza <aghareza AT gmail DOT com>

if exists("g:loaded_gitgrep") || &cp
    finish
endif

let g:loaded_gitgrep = 1

if !exists('g:git_grep_command')
  let g:git_grep_command = 'git grep -n '
endif

if !exists('g:git_grep_no_map')
  nnoremap <silent> <Leader>gg :GitGrepPrompt<CR>
  nnoremap <silent> <Leader>gw :GitGrepWord<CR>
endif

function! s:GitGrep(...)
  let expr = g:git_grep_command . '"' . join(a:000,' ') . '"'
  cgetexpr system(expr)
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction

function! s:GitGrepWord()
  call s:GitGrep(expand("<cword>"))
endfunction

function! s:GitGrepPrompt()
  call s:GitGrep(input('git grep for: '))
endfunction

command! -nargs=0 GitGrepWord :call s:GitGrepWord()
command! -nargs=0 GitGrepPrompt :call s:GitGrep()
