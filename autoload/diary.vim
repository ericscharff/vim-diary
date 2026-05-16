" Create a new diary entry. This assumes files with entries like
"
" 2026-Apr-13
"
" First thing of the day
" Second thing of the day
"
" 2026-Apr-12
"
" The older entry
"
" New dates are added to the top of the file. If the current date exists, the
" cursor is moved to the end of the entry. If it doesn't yet exist, it is
" added. In either case, the cursor is left in insert mode in an appropriate
" location.
function! diary#Diary()
  if g:diary_dmy_format
    let l:t = strftime("%d-%b-%Y")
    " Drop leading zero for first 10 days of month
    let l:t = substitute(l:t, "^0", "", "")
    let l:pattern = '^\d\d\?-\w\w\w-\d\d\d\d$'
  else
    let l:t = strftime("%Y-%b-%d")
    let l:pattern = '^\d\d\d\d-\w\w\w-\d\d\?$'
  endif
  let l:time = ''
  if g:insert_diary_time
    let l:time = strftime("%H:%M") . " - "
  endif
  " Jump to top of file
  normal! gg
  if search(l:t, 'cW')
    " The current entry exists so start adding to it
    " Jump past entry (first line starting with just a date)
    if search(l:pattern, 'W')
      " Found older entry, insert above it
      execute "normal! kO" . l:time
    else
      " No older entry exists (this is the only entry). Jump to EOF.
      normal! G
      execute "normal! o" . l:time
    endif
  else
    " No entry exists for that day, start a new one
    execute "normal! i" . l:t . "\<cr>\<cr>" . l:time . "\<cr>\<cr>\<esc>kk"
  endif
  startinsert!
endfunction
