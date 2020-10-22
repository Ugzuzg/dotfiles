function! customise#before() abort
  let g:gruvbox_contrast_light="soft"
endfunction

function! customise#after() abort
  set list listchars=tab:»·,eol:¶,trail:·,extends:↷,precedes:↶

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

endfunction
