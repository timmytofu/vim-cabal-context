# Cabal Context

A small Vim script that, when a Haskell source file is opened, climbs up the filesystem until it finds a `*.cabal` file and sets the buffer's pwd to the directory it finds the Cabal file in.

This way, if you run [ghc-mod](https://github.com/kazu-yamamoto/ghc-mod) through [ghcmod-vim](https://github.com/eagletmt/ghcmod-vim) and [syntastic](https://github.com/scrooloose/syntastic), you won't get false "Could not find module" errors when bouncing from one sandboxed project to another.

By default it will only climb seven directories up looking for a Cabal file before giving up.

Install this with [Pathogen](https://github.com/tpope/vim-pathogen) by cloning into your `~/.vim/bundle/` directory, or just copy-paste the contents of `ftdetect/vim-cabal-context.vim` into a file that will be sourced by Vim upon startup.

This is a quick script for convenience; there is probably a better way to do this, and the path separator string munging could potentially be brittle. This was developed and tested on a "typical" Linux box and comes with no guarantees — stated or implied — for its fitness anywhere else. Take it for what it's worth.
