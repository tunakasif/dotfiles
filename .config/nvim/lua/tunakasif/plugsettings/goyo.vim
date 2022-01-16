function! s:goyo_leave()
  hi Normal guibg=NONE ctermbg=NONE
endfunction

augroup GoyoFunc
    autocmd! 
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END


