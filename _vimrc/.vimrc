""""""""""""""""""""""""""""""
" setup plugin
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

  " ファイルオープンを便利に
  Plug 'Shougo/unite.vim'
  " Unite.vimで最近使ったファイルを表示できるようにする
  Plug 'Shougo/neomru.vim'
  " ファイルをtree表示してくれる
  Plug 'scrooloose/nerdtree'
  " Ruby向けにendを自動挿入してくれる
  Plug 'tpope/vim-endwise'
  " コメントON/OFFを手軽に実行
  Plug 'tomtom/tcomment_vim'
  " インデントに色を付けて見やすくする
  Plug 'nathanaelkane/vim-indent-guides'
  " 行末の半角スペースを可視化
  Plug 'bronson/vim-trailing-whitespace'

call plug#end()

  " vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  " 奇数インデントのカラー
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=242
  " 偶数インデントのカラー
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=238


  " タブ文字の表示幅
  set tabstop=2
  " Vimが挿入するインデントの幅
  set shiftwidth=2
  " 行番号を表示
	set number
	" ウインドウのタイトルバーにファイルのパス情報等を表示する
	set title
	" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
	set wildmenu
	" 入力中のコマンドを表示する
	set showcmd
	" 検索結果をハイライト表示する
	set hlsearch
	" 暗い背景色に合わせた配色にする
	set background=dark
	" タブ入力を複数の空白入力に置き換える
	set expandtab
	" 対応する括弧やブレースを表示する
	set showmatch
	" 改行時に前の行のインデントを継続する
	set autoindent
	" " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
	set smartindent
  " 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
  set smarttab
  " カーソルを行頭、行末で止まらないようにする
  set whichwrap=b,s,h,l,<,>,[,]]


  " 構文毎に文字色を変化させる
  syntax on
	" カラースキーマの指定
	colorscheme hybrid
  " 行番号の色
  highlight LineNr ctermfg=darkyellow


	" http://inari.hatenablog.com/entry/2014/05/05/231307
	""""""""""""""""""""""""""""""
  " 全角スペースの表示
	""""""""""""""""""""""""""""""
	function! ZenkakuSpace()
		highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
	endfunction

	if has('syntax')
    augroup ZenkakuSpace
	    autocmd!
	    autocmd ColorScheme * call ZenkakuSpace()
	    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
	  augroup END
	  call ZenkakuSpace()
	endif
  """"""""""""""""""""""""""""""

  " https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
  """"""""""""""""""""""""""""""
  " 挿入モード時、ステータスラインの色を変更
  """"""""""""""""""""""""""""""
  let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

  if has('syntax')
    augroup InsertHook
      autocmd!
      autocmd InsertEnter * call s:StatusLine('Enter')
      autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
  endif

  let s:slhlcmd = ''
  function! s:StatusLine(mode)
    if a:mode == 'Enter'
      silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
      silent exec g:hi_insert
    else
      highlight clear StatusLine
      silent exec s:slhlcmd
    endif
  endfunction

  function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
  endfunction

	""""""""""""""""""""""""""""""
	" 自動的に閉じ括弧を入力
  """"""""""""""""""""""""""""""
  imap { {}<LEFT>
	imap [ []<LEFT>
	imap ( ()<LEFT>
  """"""""""""""""""""""""""""""

