function! ChangeBackground()
  if system("gsettings get org.gnome.desktop.interface gtk-theme") =~ "Arc-Dark"
    set background=dark   " for the dark version of the theme
    let g:spacevim_colorscheme = 'zenburn'
  else
    set background=light  " for the light version of the theme
    let g:spacevim_colorscheme = 'one'
  endif

  exe 'colorscheme ' . g:spacevim_colorscheme
  syntax on
endfunction

function! customise#before() abort
endfunction

function! customise#after() abort
  set list listchars=tab:»·,eol:¶,trail:·,extends:↷,precedes:↶
  set title

  let g:vimfiler_quick_look_command='preview'
  let g:ale_linters = {
  \  'javascript': ['eslint'],
  \}
  let g:ale_fixers = {
  \  'javascript': ['prettier'],
  \  'css': ['prettier'],
  \}
  " let g:ale_fix_on_save=1

  " orgmode
  let g:org_heading_shade_leading_stars=0
  let g:org_indent=1

  call timer_start(0, { tid -> ChangeBackground() })
  autocmd Signal SIGUSR1 call timer_start(0, { tid -> ChangeBackground() })
endfunction
