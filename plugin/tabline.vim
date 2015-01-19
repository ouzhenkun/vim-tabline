if exists("g:loaded_vim_tabline") || &cp
  finish
endif

let g:loaded_vim_tabline = 1

function! BuildTabLine()
  let result = ''
  for i in range(tabpagenr('$'))
    let tab     = i + 1
    let winnr   = tabpagewinnr(tab)
    let winlen  = tabpagewinnr(tab, '$')
    let buflist = tabpagebuflist(tab)
    let bufnr   = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':p:t')

    " tab color
    let result .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

    " tab label
    let result .= ' ' . tab . ':'
    let result .= (bufname != '' ? bufname : '[No Name] ')

    " bufnr modified
    if getbufvar(bufnr, "&modified")
      let result .= '+'
    endif

    " buflist modified
    if winlen > 1
      let result .= '[' . winnr . '/' . winlen . ']'
      for winindex in range(winlen)
        if getbufvar(buflist[winindex], "&modified")
          let result .= '+'
          break
        endif
      endfor
    endif

    let result .= ' '
  endfor
  let result .= '%T%#TabLineFill#%='
  return result
endfunction

set tabline=%!BuildTabLine()
