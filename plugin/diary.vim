if exists('g:loaded_diary')
    finish
endif
let g:loaded_diary = 1

" Set to 1 to insert a timestamp upon insert
let g:insert_diary_time = get(g:, 'insert_diary_time', 0)
" Set to 1 for d-m-y format, e.g. 13-Apr-2026, 0 for the default 2026-Apr-13
let g:diary_dmy_format = get(g:, 'diary_dmy_format', 0)

command! Diary call diary#Diary()
