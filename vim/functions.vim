function! PromoteToLet()
  normal! dd
  " :exec '?^\s*it\>'
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction
command! PromoteToLet :call PromoteToLet()

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

" async test running

function! SetTestFileToCurrentFile()
  let g:CurrentTestFile = @%
endfunction

function! GetCurrentTestFile()
  return g:CurrentTestFile
endfunction

function! GetTestRunner()
  return "bundle exec rspec -f d"
endfunction

function! GetCurrentTestCommand()
  return "" . GetTestRunner() . " " . GetCurrentTestFile()
endfunction

function! SendCurrentTestToPipe()
  let pipeName = ".test-commands"
  call system("echo " . GetCurrentTestCommand() .  " > " . pipeName)
endfunction

function! ModalRunCurrentTest()
  exec "!" . GetCurrentTestCommand()
endfunction
