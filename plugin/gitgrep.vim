if exists("g:loaded_gitgrep") || &cp
    finish
endif
let g:loaded_gitgrep = 1

if !exists('g:git_grep_command')
  let g:git_grep_command = 'git grep -n '
endif

function! s:GitGrep(...)
  cgetexpr system(g:git_grep_command.join(a:000, ' '))
  cwin
  echo "Done!"
endfunction

command! -nargs=? GitGrep :call s:GitGrep(<f-args>)
