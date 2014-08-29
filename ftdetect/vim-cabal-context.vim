if(!exists("*g:CCSetPwd")) " allow to be overridden before and after

  function! g:CCSetPwd()
    " force loading of ghcmod so we can test with exists(), swallow errors
    silent! call ghcmod#basedir()

    if(exists("*ghcmod#basedir"))
      exe "lcd " ghcmod#basedir()
    else " if ghcmod.vim isn't installed, try to climb ourselves
      function! l:cabalIn(path)
        if(strlen(globpath(a:path, "*.cabal")) ># 0)
          return 1
        endif
      endfunction

      function! l:climb(depth, path)
        if(a:depth < 0)
          return 0
        else
          if(l:cabalIn(a:path))
            exe "lcd " a:path
            return 1
          else
            call l:climb(a:depth - 1, fnamemodify(a:path, ":h"))
          endif
        endif
      endfunction

      let l:maxDepth = 7 " go back max 7 directories
      let l:fileDir = expand("%:p:h")

      call l:climb(l:maxDepth, expand("%p:h"))
    endif
  endfunction
endif

" run upon any FileType event fired with a haskell pattern
autocmd FileType haskell call g:CCSetPwd()
