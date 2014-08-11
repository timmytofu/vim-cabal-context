if(!exists("*g:CCSetPwd")) " allow to be overridden before and after
  function! l:cabalIn(path)
    if(strlen(globpath(a:path, "*.cabal")) ># 0)
      return 1
    endif
  endfunction

  function! l:climb(depth, pathList)
    if(a:depth < 0 || a:pathList == [])
      return 0
    else
      let l:path = "/" . join(a:pathList,"/")
      if(l:cabalIn(l:path))
        exe "lcd  " l:path
        return 1
      else
        call l:climb(a:depth - 1, a:pathList[:-2])
      endif
    endif
  endfunction

  function! g:CCSetPwd()
    let l:maxDepth = 7 " go back max 7 directories
    let l:fileDir = expand("%:p:h")

    call l:climb(l:maxDepth, split(l:fileDir, "/"))
  endfunction
endif

" run upon any FileType event fired with a haskell pattern
autocmd FileType haskell call g:CCSetPwd()
