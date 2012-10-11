set guifont=Inconsolata:h16
set antialias
set encoding=utf-8
set guioptions-=T
set fu

set guioptions-=r
set nolist
set listchars=tab:▸\ ,eol:¬
set go-=L

highlight NonText guifg=#1a3c46
highlight SpecialKey guifg=#1a3c46

if has("gui_macvim")
  set fuoptions=maxhorz,maxvert
end
