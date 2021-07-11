%include "keyboard.mac"
%include "video.asm"
%include "video.mac"
%include "printer.asm"


extern calibrate
extern scan
extern interval
extern delay

extern print_loading
extern print_presentation
extern print_menu_pointer
extern print_lights
extern print_options_menu
extern print_options_menu_mode
extern print_options_menu_level
extern print_options_menu_music
extern print_records
extern print_about_menu
extern print_start
extern print_play
extern print_pause
extern print_shot_type
extern print_score
extern print_lives
extern clean
extern print_hero
extern print_hero_death
extern print_shot
extern print_enemy
extern print_enemy_shot
extern print_bonus
extern print_victory
extern print_game_over

extern audio_on
extern audio_off
extern play_next_note
extern shot_sound
extern enemy_shot_sound
extern game_over_music

section .data
lights db 0
easyrecords dw 0, 0, 0, 0, 0
normalrecords dw 0, 0, 0, 0, 0
hardrecords dw 0, 0, 0, 0, 0
menupointerrow db 21
menupointercol db 10
menu db 1
mode db 0
level db 1
speed dd 50
levelbonus db 10
score dw 0
lives db 3
paused db 0
death db 0
deathtimes db 0
gameover db 0
victory db 0
herorow db 23
heroleft db 37
heroright db 41
enemycount db 50
moveright db 1
enemyup db 1
enemydown db 5
enemyleft db 1
enemyright db 30
shotcount db 0
currentshot db 1
shot db 0
shotrow db 0
shotcol db 0
penetrativeshot db 1
grenadeshot db 10
enemyshotcount db 0
enemyshot db 0
enemyshotrow db 0
enemyshotcol db 0
pointer db 0
turn db 0
enemyturn db 2
enemyline dd 0
enemyline1 db ' 0  0  0  0  0  0  0  0  0  0 '
enemyline2 db ' 0  0  0  0  0  0  0  0  0  0 '
enemyline3 db ' 0  0  0  0  0  0  0  0  0  0 '
enemyline4 db ' 0  0  0  0  0  0  0  0  0  0 '
enemyline5 db ' 0  0  0  0  0  0  0  0  0  0 '
enemylinecount dd 0
enemyline1count db 10
enemyline2count db 10
enemyline3count db 10
enemyline4count db 10
enemyline5count db 10
enemylevel1 db '/o\/o\/o\/o\/o\/o\/o\/o\/o\/o\'
enemylevel2 db '_o_-o-_o_-o-_o_-o-_o_-o-_o_-o-'
enemylevel3 db '<o><o><o><o><o><o><o><o><o><o>'
enemylevel4 db 'o^o[o]o^o[o]o^o[o]o^o[o]o^o[o]'
enemylevel5 db '{o}{o}{o}{o}{o}{o}{o}{o}{o}{o}'
killenemy db 0, 0, 0, 0, 0, 0, 0, 0, 0
bonusturn dw 500
bonus db 0
bonusrow db 1
bonusleft db 0
bonuspoints dw 100
music db 1
currentmusic db 1
musictimer dd 0


; Macro that binds a key to a procedure
%macro BIND 2
  cmp byte[esp], %1
  jne %%next
  call %2
  %%next:
%endmacro


section .text
; Main procedure of the game
global game
game:
  ; Initialize game
  FILL_SCREEN BG.BLACK
  call print_loading

  ; Calibrate the timing
  call calibrate

  call print_presentation

  ; Main loop
  game.loop:
    call get_input
    call review_lights
    call select_music
    .control:
      cmp byte[gameover], 1
      je .end
      cmp byte[menu], 0
      jne .end
      cmp byte[paused], 1
      je .end
      cmp byte[enemycount], 0
      jne .continue
      call next_level
      jmp .end
    .continue:
      push dword[speed]
      push dword 0
      call interval
      add esp, 8
      cmp eax, 0
      je .end
      mov al, [turn]
      cmp [enemyturn], al
      jne .shots
      call move_bonus
      mov byte[turn], 1
      cmp byte[moveright], 0
      je .left
      call move_enemy_right
      jmp .shots
    .left:
      call move_enemy_left
    .shots:
      cmp byte[gameover], 1
      je .end
      inc byte[turn]
      dec word[bonusturn]
      call move_shot
      call move_enemy_shot
      call start_enemy_shot
      call hero_death
      cmp word[bonusturn], 0
      jne .end
      call start_bonus
    .end:
      jmp game.loop

; Procedure that calls to the macro BIND
;global get_input
get_input:
  call scan
  push ax
  ; The value of the input is on 'word [esp]'
  BIND KEY.ESC, key_esc
  BIND KEY.M, key_m
  BIND KEY.DOT, key_dot
  BIND KEY.COMMA, key_comma
  cmp byte[gameover], 1
  je .end
  BIND KEY.ENTER, key_enter
  BIND KEY.RIGHT, key_right
  BIND KEY.LEFT, key_left
  BIND KEY.UP, key_up
  BIND KEY.DOWN, key_down
  cmp byte[menu], 0
  jne .end
  BIND KEY.P, key_p
  BIND KEY.SPACE, key_space
  .end:
    ; Free the stack
    add esp, 2
    ret

; Procedure that is executed when the key "Esc" is pressed
;global key_esc
key_esc:
  cmp byte[menu], 1
  je .end
  mov byte[lights], 0
  mov byte[menu], 1
  mov byte[menupointerrow], 21
  mov byte[menupointercol], 10
  mov byte[gameover], 0
  mov byte[paused], 0
  call print_presentation
  .end:
    ret

; Procedure that is executed when the key "M" is pressed
;global key_m
key_m:
  cmp byte[music], 0
  je .on
  mov byte[music], 0
  jmp .continue
  .on:
    mov byte[music], 1
  .continue:
    cmp byte[menu], 2
    jne .end
    push dword[music]
    call print_options_menu_music
    add esp, 4
  .end:
    ret

; Procedure that is executed when the key "." is pressed
;global key_dot
key_dot:
  cmp byte[menu], 0
  je .end
  cmp byte[currentmusic], 3
  je .restart
  inc byte[currentmusic]
  jmp .end
  .restart:
    mov byte[currentmusic], 1
  .end:
    ret

; Procedure that is executed when the key "," is pressed
;global key_comma
key_comma:
  cmp byte[menu], 0
  je .end
  cmp byte[currentmusic], 1
  je .restart
  dec byte[currentmusic]
  jmp .end
  .restart:
    mov byte[currentmusic], 3
  .end:
    ret

; Procedure that is executed when the key "Enter" is pressed
;global key_enter
key_enter:
  cmp byte[menu], 0
  je .end
  cmp byte[menu], 1
  jne .options
  call main_menu_select
  jmp .end
  .options:
    cmp byte[menu], 2
    jne .end
    call options_menu_select
  .end:
    ret

; Procedure that is executed when the key "Right" is pressed
;global key_right
key_right:
  cmp byte[menu], 0
  jne .main_menu
  call move_hero_right
  jmp .end
  .main_menu:
    cmp byte[menu], 1
    jne .options
    call main_menu_move_pointer_right
    jmp .end  
  .options:
    cmp byte[menu], 2
    jne .end
    call options_menu_move_pointer_right
  .end:
    ret

; Procedure that is executed when the key "Left" is pressed
;global key_left
key_left:
  cmp byte[menu], 0
  jne .main_menu
  call move_hero_left
  jmp .end
  .main_menu:
    cmp byte[menu], 1
    jne .options
    call main_menu_move_pointer_left
    jmp .end
  .options:
    cmp byte[menu], 2
    jne .end
    call options_menu_move_pointer_left
  .end:
    ret

; Procedure that is executed when the key "Up" is pressed
;global key_up
key_up:
  cmp byte[menu], 0
  je .change_shot
  cmp byte[menu], 2
  jne .end
  call options_menu_move_pointer_up
  jmp .end
  .change_shot:
    call change_shot_up
  .end:
    ret

; Procedure that is executed when the key "Down" is pressed
;global key_down
key_down:
  cmp byte[menu], 0
  je .change_shot
  cmp byte[menu], 2
  jne .end
  call options_menu_move_pointer_down
  jmp .end
  .change_shot:
    call change_shot_down
  .end:
  ret

; Procedure that is executed when the key "P" is pressed
;global key_p
key_p:
  cmp byte[paused], 0
  je .pause_game
  mov byte[paused], 0
  call print_play
  jmp .end
  .pause_game:
    mov byte[paused], 1
    call print_pause
  .end:
    ret

; Procedure that is executed when the key "Space" is pressed
;global key_space
key_space:
  cmp byte[paused], 1
  je .end
  cmp byte[shotcount], 1
  je .end
  cmp byte[music], 0
  je .no_music
  call shot_sound
  .no_music:
    cmp byte[mode], 1
    jne .continue
    cmp byte[currentshot], 2
    jne .grenade
    cmp byte[penetrativeshot], 0
    je .end
    dec byte[penetrativeshot]
    jmp .continue
  .grenade:
    cmp byte[currentshot], 3
    jne .continue
    cmp byte[grenadeshot], 0
    je .end
    dec byte[grenadeshot]
  .continue:
    inc byte[shotcount]
    mov al, [herorow]
    dec al
    mov [shotrow], al
    mov al, [heroleft]
    add al, [heroright]
    shr al, 1
    mov [shotcol], al
    mov al, [currentshot]
    mov [shot], al
    call review_shot_position
  .end:
    ret

; Procedure that executes the selection of the Main menu pointer
;global main_menu_select
main_menu_select:
  cmp byte[menupointercol], 10
  jne .options
  call restart
  call initialize
  call start
  jmp .end
  .options:
    cmp byte[menupointercol], 27
    jne .records
    call options_menu
    jmp .end
  .records:
    cmp byte[menupointercol], 44
    jne .about
    call records
    jmp .end
  .about:
    call about
  .end:
    ret

; Procedure that increases to the column of the Main menu pointer
;global main_menu_move_pointer_right
main_menu_move_pointer_right:
  xor eax, eax
  mov al, [menupointercol]
  cmp byte[menupointercol], 61
  je .restart
  add byte[menupointercol], 17
  jmp .end
  .restart:
    mov byte[menupointercol], 10
  .end:
    push dword[menupointerrow]
    push eax
    push dword 1
    call clean
    add esp, 12
    push dword[menupointerrow]
    push dword[menupointercol]
    push dword[menu]
    call print_menu_pointer
    add esp, 12
    ret

; Procedure that decreases to the column of the Main menu pointer
;global main_menu_move_pointer_left
main_menu_move_pointer_left:
  xor eax, eax
  mov al, [menupointercol]
  cmp byte[menupointercol], 10
  je .restart
  sub byte[menupointercol], 17
  jmp .end
  .restart:
    mov byte[menupointercol], 61
  .end:
    push dword[menupointerrow]
    push eax
    push dword 1
    call clean
    add esp, 12
    push dword[menupointerrow]
    push dword[menupointercol]
    push dword[menu]
    call print_menu_pointer
    add esp, 12
    ret

; Procedure that shows the Options menu
;global options_menu
options_menu:
  mov byte[lights], 0
  mov byte[menu], 2
  mov byte[menupointerrow], 10
  mov byte[menupointercol], 14
  push dword[mode]
  push dword[level]
  push dword[music]
  call print_options_menu
  add esp, 12
  ret

; Procedure that allows to change the game status in the Options menu
;global options_menu_select
options_menu_select:
  cmp byte[menupointercol], 14
  jne .column2
  push dword[menupointerrow]
  call print_options_menu_mode
  add esp, 4
  cmp byte[menupointerrow], 10
  jne .row2
  mov byte[mode], 0
  jmp .end
  .row2:
    cmp byte[menupointerrow], 12
    jne .row3
    mov byte[mode], 1
    jmp .end
  .row3:
    mov byte[mode], 2
    jmp .end
  .column2:
    cmp byte[menupointercol], 34
    jne .column3
    push dword[menupointerrow]
    call print_options_menu_level
    add esp, 4
    cmp byte[menupointerrow], 10
    jne .level2
    mov byte[level], 1
    jmp .end
    .level2:
      cmp byte[menupointerrow], 12
      jne .level3
      mov byte[level], 2
      jmp .end
    .level3:
      cmp byte[menupointerrow], 14
      jne .level4
      mov byte[level], 3
      jmp .end
    .level4:
      cmp byte[menupointerrow], 16
      jne .level5
      mov byte[level], 4
      jmp .end
    .level5:
      mov byte[level], 5
      jmp .end
  .column3:
    cmp byte[music], 0
    jne .off
    mov byte[music], 1
    jmp .music
    .off:
      mov byte[music], 0
    .music:
      push dword[music]
      call print_options_menu_music
      add esp, 4
  .end:
    ret

; Procedure that increases to the column of the Options menu pointer
;global options_menu_move_pointer_right
options_menu_move_pointer_right:
  xor eax, eax
  xor ebx, ebx
  mov al, [menupointerrow]
  mov bl, [menupointercol] 
  cmp byte[menupointercol], 54
  je .restart
  add byte[menupointercol], 20
  jmp .end
  .restart:
    mov byte[menupointercol], 14
  .end:
    push eax
    push ebx
    push dword 1
    call clean
    add esp, 12
    mov byte[menupointerrow], 10
    push dword[menupointerrow]
    push dword[menupointercol]
    push dword[menu]
    call print_menu_pointer
    add esp, 12
    ret


; Procedure that decreases to the column of the Options menu pointer
;global options_menu_move_pointer_left
options_menu_move_pointer_left:
  xor eax, eax
  xor ebx, ebx
  mov al, [menupointerrow]
  mov bl, [menupointercol]
  cmp byte[menupointercol], 14
  je .restart
  sub byte[menupointercol], 20
  jmp .end
  .restart:
    mov byte[menupointercol], 54
  .end:
    push eax
    push ebx
    push dword 1
    call clean
    add esp, 12
    mov byte[menupointerrow], 10
    push dword[menupointerrow]
    push dword[menupointercol]
    push dword[menu]
    call print_menu_pointer
    add esp, 12
    ret

; Procedure that decreases to the row of the Options menu pointer
;global options_menu_move_pointer_up
options_menu_move_pointer_up:
  xor eax, eax
  mov al, [menupointerrow]
  cmp byte[menupointerrow], 10
  je .restart
  sub byte[menupointerrow], 2
  jmp .end
  .restart:
    cmp byte[menupointercol], 14
    jne .column2
    mov byte[menupointerrow], 14
    jmp .end
  .column2:
    cmp byte[menupointercol], 34
    jne .end
    mov byte[menupointerrow], 18
  .end:
    push eax
    push dword[menupointercol]
    push dword 1
    call clean
    add esp, 12
    push dword[menupointerrow]
    push dword[menupointercol]
    push dword[menu]
    call print_menu_pointer
    add esp, 12
    ret

; Procedure that increases to the row of the Options menu pointer
;global options_menu_move_pointer_down
options_menu_move_pointer_down:
  xor eax, eax
  mov al, byte[menupointerrow]
  cmp byte[menupointercol], 14
  jne .column2
  cmp byte[menupointerrow], 14
  je .restart
  add byte[menupointerrow], 2
  jmp .end
  .column2:
    cmp byte[menupointercol], 34
    jne .end
    cmp byte[menupointerrow], 18
    je .restart
    add byte[menupointerrow], 2
    jmp .end
  .restart:
    mov byte[menupointerrow], 10
  .end:
    push eax
    push dword[menupointercol]
    push dword 1
    call clean
    add esp, 12
    push dword[menupointerrow]
    push dword[menupointercol]
    push dword[menu]
    call print_menu_pointer
    add esp, 12
    ret

; Procedure that shows the Records menu
;global records
records:
  mov byte[lights], 0
  mov byte[menu], 3
  push dword easyrecords
  push dword normalrecords
  push dword hardrecords
  call print_records
  add esp, 12
  ret

; Procedure that shows the About menu
;global about
about:
  mov byte[lights], 0
  mov byte[menu], 4
  call print_about_menu
  ret

; Procedure that restarts the value of some variables
;global restart
restart:
  mov byte[speed], 50
  mov word[score], 0
  ret

; Procedure that initializes the value of the other variables
;global initialize
initialize:
  mov al, [level]
  mov bl, 10
  mul bl
  mov byte[levelbonus], al
  cmp byte[level], 1
  jne .level2
  mov byte[speed], 50
  mov word[bonuspoints], 100
  jmp .easy
  .level2:
    cmp byte[level], 2
    jne .level3
    mov byte[speed], 40
    mov word[bonuspoints], 200
    jmp .easy
  .level3:
    cmp byte[level], 3
    jne .level4
    mov byte[speed], 30
    mov word[bonuspoints], 300
    jmp .easy
  .level4:
    cmp byte[level], 4
    jne .level5
    mov byte[speed], 20
    mov word[bonuspoints], 400
    jmp .easy
  .level5:
    mov byte[speed], 10
    mov word[bonuspoints], 500
  .easy:
    cmp byte[mode], 0
    jne .normal
    mov byte[lives], 3
    jmp .continue
  .normal:
    cmp byte[mode], 1
    jne .hard
    mov byte[lives], 3
    mov byte[penetrativeshot], 1
    mov byte[grenadeshot], 10
    jmp .continue
  .hard:
    mov byte[lives], 1
    mov byte[penetrativeshot], 0
    mov byte[grenadeshot], 0
  .continue:
    mov byte[menu], 0
    mov byte[paused], 0
    mov byte[death], 0
    mov byte[deathtimes], 0
    mov byte[gameover], 0
    mov byte[victory], 0
    mov byte[herorow], 23
    mov byte[heroleft], 37
    mov byte[heroright], 41
    mov byte[enemycount], 50
    mov byte[moveright], 1
    mov byte[enemyup], 1
    mov byte[enemydown], 5
    mov byte[enemyleft], 1
    mov byte[enemyright], 30
    mov byte[shotcount], 0
    mov byte[currentshot], 1
    mov byte[shot], 0
    mov byte[shotrow], 0
    mov byte[shotcol], 0
    mov byte[enemyshotcount], 0
    mov byte[enemyshot], 0
    mov byte[enemyshotrow], 0
    mov byte[enemyshotcol], 0
    mov byte[pointer], 0
    mov byte[turn], 0
    mov byte[enemyturn], 3
    mov dword[enemyline], 0
    mov dword[enemylinecount], 0
    mov byte[enemyline1count], 10
    mov byte[enemyline2count], 10
    mov byte[enemyline3count], 10
    mov byte[enemyline4count], 10
    mov byte[enemyline5count], 10
    mov word[bonusturn], 500
    mov byte[bonus], 0
    mov byte[bonusrow], 1
    mov byte[bonusleft], 0
    ret

; Procedure that initializes the game
;global start
start:
  push dword[level]
  push dword[score]
  push dword[lives]
  call print_start
  add esp, 12
  push dword[herorow]
  push dword[heroleft]
  call print_hero
  add esp, 8
  call start_enemy
  call call_print_enemy
  .end:
    ret

; Procedure that initializes the enemy according to the Level
;global start_enemy
start_enemy:
  xor eax, eax
  cmp byte[level], 1
  jne .level2
  mov eax, enemylevel1
  jmp .end
  .level2:
    cmp byte[level], 2
    jne .level3
    mov eax, enemylevel2
    jmp .end
  .level3:
    cmp byte[level], 3
    jne .level4
    mov eax, enemylevel3
    jmp .end
  .level4:
    cmp byte[level], 4
    jne .level5
    mov eax, enemylevel4
    jmp .end
  .level5:
    mov eax, enemylevel5
  .end:
    mov ecx, 30
    mov esi, eax
    mov edi, enemyline1
    cld
    rep movsb
    mov ecx, 30
    mov esi, eax
    mov edi, enemyline2
    cld
    rep movsb
    mov ecx, 30
    mov esi, eax
    mov edi, enemyline3
    cld
    rep movsb
    mov ecx, 30
    mov esi, eax
    mov edi, enemyline4
    cld
    rep movsb
    mov ecx, 30
    mov esi, eax
    mov edi, enemyline5
    cld
    rep movsb
    call call_print_enemy
    ret

; Procedure that moves the enemy to the right
;global move_enemy_right
move_enemy_right:
  cmp byte[enemyright], 78
  jne .continue
  call move_enemy_down
  mov byte[moveright], 0
  jmp .end
  .continue:
    push dword[enemyleft]
    call move_enemy_clean
    add esp, 4
    inc byte[enemyright]
    inc byte[enemyleft]
    call call_print_enemy
  .end:
    ret

; Procedure that moves the enemy to the left
;global move_enemy_left
move_enemy_left:
  cmp byte[enemyleft], 1
  jne .continue
  call move_enemy_down
  mov byte[moveright], 1
  jmp .end
  .continue:
    push dword[enemyright]
    call move_enemy_clean
    add esp, 4
    dec byte[enemyleft]
    dec byte[enemyright]
    call call_print_enemy
  .end:
    ret

; Procedure that cleans the column that leaves the enemy behind when moving
;global move_enemy_clean
move_enemy_clean:
  call review_enemy_down
  mov [pointer], al
  .cicle:
    mov al, [pointer]
    sub al, [enemyup]
    add al, 1
    cmp al, 0
    je .end
    push dword[pointer]
    push dword[esp + 8]
    push dword 1
    call clean
    add esp, 12
    dec byte[pointer]
    jmp .cicle
  .end:
    ret

; Procedure que mueve los enemigos hacia abajo
;global move_enemy_down
move_enemy_down:
  call review_enemy_down
  cmp al, 22
  jne .continue
  call show_game_over
  jmp .end
  .continue:
    call move_enemy_down_clean
    inc byte[enemyup]
    inc byte[enemydown]
    call call_print_enemy
  .end:
    ret

; Procedure that returns the enemy's last line
;global review_enemy_down
review_enemy_down:
  mov al, [enemydown]
  cmp byte[enemyline5count], 0
  jne .end
  dec al
  cmp byte[enemyline4count], 0
  jne .end
  dec al
  cmp byte[enemyline3count], 0
  jne .end
  dec al
  cmp byte[enemyline2count], 0
  jne .end
  dec al
  cmp byte[enemyline1count], 0
  jne .end
  dec al
  .end:
    ret

; Procedure that cleans the row that leaves the enemy behind when moving
;global move_enemy_down_clean
move_enemy_down_clean:
  xor eax, eax
  mov al, 1
  add al, [enemyright]
  sub al, [enemyleft]
  push dword[enemyup]
  push dword[enemyleft]
  push eax
  call clean
  add esp, 12
  ret

; Procedure that moves the hero to the right
;global move_hero_right
move_hero_right:
  cmp byte[paused], 1
  je .end
  cmp byte[heroright], 79
  je .end
  push dword[herorow]
  push dword[heroleft]
  push dword 1
  call clean
  add esp, 12
  inc byte[heroright]
  inc byte[heroleft]
  push dword[herorow]
  push dword[heroleft]
  call print_hero
  add esp, 8
  .end:
    ret

; Procedure that moves the hero to the left
;global move_hero_left
move_hero_left:
  cmp byte[paused], 1
  je .end
  cmp byte[heroleft], 0
  je .end
  push dword[herorow]
  push dword[heroright]
  push dword 1
  call clean
  add esp, 12
  dec byte[heroleft]
  dec byte[heroright]
  push dword [herorow]
  push dword[heroleft]
  call print_hero
  add esp, 8
  .end:
    ret

; Procedure that changes the shot type to the following one
;global change_shot_up
change_shot_up:
  cmp byte[paused], 1
  je .end
  cmp byte[mode], 2
  je .end
  cmp byte[currentshot], 3
  je .restart
  inc byte[currentshot]
  jmp .end
  .restart:
    mov byte[currentshot], 1
  .end:
    push dword[currentshot]
    call print_shot_type
    add esp, 4
    ret

; Procedure that changes the shot type to the previous one
;global change_shot_down
change_shot_down:
  cmp byte[paused], 1
  je .end
  cmp byte[mode], 2
  je .end
  cmp byte[currentshot], 1
  je .restart
  dec byte[currentshot]
  jmp .end
  .restart:
    mov byte[currentshot], 3
  .end:
    push dword[currentshot]
    call print_shot_type
    add esp, 4
    ret

; Procedure that reviews the next position of the shot
;global review_shot_position
review_shot_position:
  push dword[shotrow]
  push dword[shotcol]
  call review
  add esp, 8
  cmp bl, 0
  je .continue
  cmp byte[bonus], 0
  je .enemy
  cmp byte[shotrow], 1
  jne .enemy
  call destroy_bonus
  jmp .end
  .enemy:
    mov al, [enemydown]
    cmp [shotrow], al
    jg .no_enemy
    call destroy_enemy
  .no_enemy:
    cmp byte[shot], 2
    je .continue
    dec byte[shotcount]
    push dword[shotrow]
    push dword[shotcol]
    push dword 1
    call clean
    add esp, 12
    jmp .end
  .continue:
    push dword[shotrow]
    push dword[shotcol]
    push dword[shot]
    call print_shot
    add esp, 12
  .end:
    ret

; Procedure that returns the content of the position that is assigned
;global review
review:
  FBOFFSET [esp + 8], [esp + 4]
  mov bx, [FBUFFER + eax]
  ret

; Procedure that moves the hero's shot
;global move_shot
move_shot:
  cmp byte[shotcount], 0
  je .end
  push dword[shotrow]
  push dword[shotcol]
  push dword 1
  call clean
  add esp, 12
  cmp byte[shotrow], 1
  jne .continue
  mov byte[shotcount], 0
  jmp .end
  .continue:
    dec byte[shotrow]
    call review_shot_position
  .end:
    ret

; Procedure that makes the enemy to shot
;global start_enemy_shot
start_enemy_shot:
  cmp byte[enemyshotcount], 1
  je .end
  cmp byte[music], 0
  je .no_music
  call enemy_shot_sound
  .no_music:
    inc byte[enemyshotcount]
    mov al, [enemydown]
    mov byte[enemyshotrow], al
    call random
    add al, [enemyleft]
    mov byte[enemyshotcol], al
  .cicle:
    xor eax, eax
    mov al, [enemyshotrow]
    push eax
    push dword[enemyshotcol]
    call review
    add esp, 4
    pop eax
    cmp bl, 35
    je .other
    cmp bl, 0
    jne .continue
    .other:
      cmp byte[moveright], 0
      jne .right
      sub byte[enemyshotcol], 3
      mov al, [enemyleft]
      cmp byte[enemyshotcol], al
      jge .end_cicle
      mov al, [enemyright]
      mov [enemyshotcol], al
      dec byte[enemyshotrow]
      jmp .end_cicle
    .right:
      add byte[enemyshotcol], 3
      mov al, [enemyright]
      cmp byte[enemyshotcol], al
      jbe .end_cicle
      mov al, [enemyleft]
      mov [enemyshotcol], al
      dec byte[enemyshotrow]
    .end_cicle:
      mov al, [enemyup]
      cmp byte[enemyshotrow], al
      jge .cicle
      mov al, [enemydown]
      mov byte[enemyshotrow], al
      jmp .cicle
  .continue:
    .cicle2:
      inc byte[enemyshotrow]
      cmp byte[enemyshotrow], 23
      jbe .review
      dec byte[enemyshotcount]
      jmp .end
      .review:
        push dword[enemyshotrow]
        push dword[enemyshotcol]
        call review
        add esp, 8
        cmp bl, 35
        je .end_continue
        cmp bl, 0
        jne .cicle2
    .end_continue:
      call review_enemy_shot_position
  .end:
    ret

; Procedure that makes random the origin of the enemy's shot
;global random
random:
    rdtsc
    xor edx, edx
    mov ebx, 30
    div ebx
    mov eax, edx
    ret

; Procedure that moves the enemy's shot
;global move_enemy_shot
move_enemy_shot:
  cmp byte[enemyshotrow], 23
  jbe .clean
  push dword[enemyshotrow]
  push dword[enemyshotcol]
  call review
  add esp, 8
  cmp bl, 0
  je .clean
  dec byte[lives]
  push dword[lives]
  call print_lives
  add esp, 4
  mov byte[deathtimes], 15
  jmp .no_clean
  .clean:
    push dword[enemyshotrow]
    push dword[enemyshotcol]
    push dword 1
    call clean
    add esp, 12
  .no_clean:
    cmp byte[enemyshotcount], 0
    je .end
    cmp byte[enemyshotrow], 23
    jne .continue
    dec byte[enemyshotcount]
    jmp .end
  .continue:
    inc byte[enemyshotrow]
    call review_enemy_shot_position
  .end:
    ret

; Procedure that reviews the next position of the enemy's shot
;global review_enemy_shot_position
review_enemy_shot_position:
  push dword[enemyshotrow]
  push dword[enemyshotcol]
  call review
  add esp, 8
  cmp bl, 0
  je .continue
  mov al, [herorow]
  cmp byte[enemyshotrow], al
  jne .no_hero
  cmp byte[lives], 0
  jne .print
  call show_game_over
  jmp .end
  .print:
    dec byte[lives]
    push dword[lives]
    call print_lives
    add esp, 4
    mov byte[deathtimes], 15
  .no_hero:
    dec byte[enemyshotcount]
    push dword[enemyshotrow]
    push dword[enemyshotcol]
    push dword 1
    call clean
    add esp, 12
    jmp .end
  .continue:
    push dword[enemyshotrow]
    push dword[enemyshotcol]
    push dword[level]
    call print_enemy_shot
    add esp, 12
  .end:
    ret

; Procedure that destroys the enemy with the hero's shot
;global destroy_enemy
destroy_enemy:
  call select_enemy_line
  mov esi, killenemy
  mov edi, [enemyline]
  xor eax, eax
  mov al, [shotcol]
  sub al, [enemyleft]
  add edi, eax
  mov bl, 3
  div bl
  mov al, ah
  xor ah, ah
  sub edi, eax
  mov ecx, 3
  cmp byte[shot], 3
  jne .end
  mov al, [shotcol]
  sub al, [enemyleft]
  cmp al, 2
  jbe .find_next
  sub edi, 3
  add ecx, 3
  cmp word[edi], 0
  je .find_next
  dec byte[enemycount]
  mov ebx, [enemylinecount]
  dec byte[ebx]
  xor eax, eax
  mov al, [level]
  add [score], ax
  .find_next:
    mov al, [enemyright]
    sub al, [shotcol]
    cmp al, 2
    jbe .end
    add ecx, 3
    mov ebx, edi
    add ebx, ecx
    sub ebx, 3
    cmp word[ebx], 0
    je .end
    dec byte[enemycount]
    mov ebx, [enemylinecount]
    dec byte[ebx]
    xor eax, eax
    mov al, [level]
    add [score], ax
  .end:
    cld
    rep movsb
    call call_print_enemy
    dec byte[enemycount]
    mov ebx, [enemylinecount]
    dec byte[ebx]
    xor eax, eax
    mov al, [level]
    add [score], ax
    push dword 24
    push dword 40
    push dword[score]
    call print_score
    add esp, 12
    ret

; Procedure that selects the enemy's line that received the shot
;global select_enemy_line
select_enemy_line:
  mov al, [enemydown]
  sub al, [shotrow]
  cmp al, 4
  jne .two
  mov eax, enemyline1
  mov ebx, enemyline1count
  jmp .end
  .two:
    cmp al, 3
    jne .three
    mov eax, enemyline2
    mov ebx, enemyline2count
    jmp .end
  .three:
    cmp al, 2
    jne .four
    mov eax, enemyline3
    mov ebx, enemyline3count
    jmp .end
  .four:
    cmp al, 1
    jne .five
    mov eax, enemyline4
    mov ebx, enemyline4count
    jmp .end
  .five:
    mov eax, enemyline5
    mov ebx, enemyline5count
  .end:
    mov [enemyline], eax
    mov [enemylinecount], ebx
    ret

; Procedure that makes the animation of the hero's death
;global hero_death
hero_death:
  cmp byte[gameover], 1
  je .end
  cmp byte[deathtimes], 0
  je .end
  cmp byte[deathtimes], 1
  jne .death
  mov byte[death], 0
  .death:
    dec byte[deathtimes]
    cmp byte[death], 1
    je .alive
    mov byte[death], 1
    push dword[herorow]
    push dword[heroleft]
    call print_hero
    add esp, 8
    jmp .end
  .alive:
    mov byte[death], 0
    push dword[herorow]
    push dword[heroleft]
    call print_hero_death
    add esp, 8
  .end:
    ret

; Procedure that makes the bonus
;global start_bonus
start_bonus:
  cmp byte[bonus], 1
  je .end
  mov byte[bonus], 1
  mov byte[bonusleft], 0
  push dword[bonusrow]
  push dword[bonusleft]
  call print_bonus
  add esp, 8
  .end:
    ret

; Procedure that moves the bonus
;global move_bonus
move_bonus:
  cmp byte[bonus], 0
  je .end
  cmp byte[bonusleft], 80
  jne .continue
  mov word[bonusturn], 500
  mov byte[bonus], 0
  mov byte[bonusleft], 0
  jmp .end
  .continue:
    push dword[bonusrow]
    push dword[bonusleft]
    push dword 1
    call clean
    add esp, 12
    inc byte[bonusleft]
    cmp byte[bonusleft], 76
    jge .end
    push dword[bonusrow]
    push dword[bonusleft]
    call print_bonus
    add esp, 8
  .end:
    ret

; Procedure that destroys the bonus
;global destroy_bonus
destroy_bonus:
  cmp byte[bonus], 0
  je .end
  push dword[bonusrow]
  push dword[bonusleft]
  push dword 5
  call clean
  add esp, 12
  mov word[bonusturn], 500
  mov byte[bonus], 0
  mov byte[bonusleft], 0
  xor eax, eax
  mov ax, [bonuspoints]
  add [score], ax
  push dword 24
  push dword 40
  push dword[score]
  call print_score
  add esp, 12
  cmp byte[lives], 3
  je .shots
  inc byte[lives]
  push dword[lives]
  call print_lives
  add esp, 4
  .shots:
    inc byte[penetrativeshot]
    add byte[grenadeshot], 10
  .end:
    ret

; Procedure that moves the game to the next level
;global next_level
next_level:
  xor eax, eax
  mov al, [levelbonus]
  add [score], ax
  cmp byte[level], 5
  jne .continue
  call show_victory
  jmp .end
  .continue:
    inc byte[level]
    call initialize
    call start
  .end:
    ret

; Procedure that shows the game "Victory"
;global show_victory
show_victory:
  call compare_score
  mov byte[gameover], 1
  mov byte[victory], 1
  mov byte[level], 1
  call print_victory
  ret

; Procedure that shows the "Game Over"
;global show_game_over
show_game_over:
  call compare_score
  mov byte[gameover], 1
  mov byte[level], 1
  call print_game_over  
  ret

; Procedure that decides which records array to upgrade
;global compare_score
compare_score:
  cmp byte[mode], 0
  jne .normal
  mov eax, easyrecords
  jmp .end
  .normal:
    cmp byte[mode], 1
    jne .hard
    mov eax, normalrecords
    jmp .end
  .hard:
    mov eax, hardrecords
  .end:
    call actualize_records
    ret

; Procedure that upgrades the records
;global actualize_records
actualize_records:
  xor ecx, ecx
  .cicle:
    cmp cl, 5
    je .end
    mov bx, [eax]
    cmp word[score], bx
    jbe .continue
    mov dx, word[score]
    mov [eax], dx
    mov [score], bx
    .continue:
      add eax, 2
      inc cl
      jmp .cicle
  .end:
    ret

; Procedure that makes be painted to the lights of the screen borders
;global review_lights
review_lights:
  cmp byte[menu], 0
  jne .continue
  cmp byte[gameover], 1
  jne .end
  .continue:
    push 700
    push 0
    call interval
    add esp, 8
    cmp eax, 0
    je .end
    cmp byte[lights], 0
    jne .color
    mov byte[lights], 1
    push dword 0
    call print_lights
    add esp, 4
    jmp .end
  .color:
    mov byte[lights], 0
    call call_print_lights
    jmp .end
  .end:
    ret

; Procedure that selects of which color will be colored the lights of the screen borders
;global call_print_lights
call_print_lights:
  cmp byte[menu], 0
  jne .presentation
  cmp byte[victory], 1
  jne .gameover
  push dword 5
  call print_lights
  add esp, 4
  jmp .end
  .gameover:
    cmp byte[gameover], 1
    jne .end
    push dword 6
    call print_lights
    add esp, 4
    jmp .end
  .presentation:
    cmp byte[menu], 1
    jne .options
    push dword 1
    call print_lights
    add esp, 4
    jmp .end
  .options:
    cmp byte[menu], 2
    jne .records
    push dword 2
    call print_lights
    add esp, 4
    jmp .end
  .records:
    cmp byte[menu], 3
    jne .about
    push dword 3
    call print_lights
    add esp, 4
    jmp .end
  .about:
    push dword 4
    call print_lights
    add esp, 4
    jmp .end
  .end:
    ret

; Procedure that makes be painted to the enemies
;global call_print_enemy
call_print_enemy:
  xor edx, edx
  mov al, [enemydown]
  mov [pointer], al
  cmp byte[enemyline5count], 0
  je .line4
  mov dl, 1
  push dword[pointer]
  push dword[enemyleft]
  push dword enemyline5
  push dword[level]
  call print_enemy
  add esp, 16
  .line4:
    dec byte[pointer]
    cmp dl, 1
    je .continue_line4
    cmp byte[enemyline4count], 0
    je .line3
    mov dl, 1
    .continue_line4:
      push dword[pointer]
      push dword[enemyleft]
      push dword enemyline4
      push dword[level]
      call print_enemy
      add esp, 16
  .line3:
    dec byte[pointer]
    cmp dl, 1
    je .continue_line3
    cmp byte[enemyline3count], 0
    je .line2
    mov dl, 1
    .continue_line3:
      push dword[pointer]
      push dword[enemyleft]
      push dword enemyline3
      push dword[level]
      call print_enemy
      add esp, 16
  .line2:
    dec byte[pointer]
    cmp dl, 1
    je .continue_line2
    cmp byte[enemyline2count], 0
    je .line1
    mov dl, 1
    .continue_line2:
      push dword[pointer]
      push dword[enemyleft]
      push dword enemyline2
      push dword[level]
      call print_enemy
      add esp, 16
  .line1:
    dec byte[pointer]
    cmp dl, 1
    je .continue_line1
    cmp byte[enemyline1count], 0
    je .end
    mov dl, 1
    .continue_line1:
      push dword[pointer]
      push dword[enemyleft]
      push dword enemyline1
      push dword[level]
      call print_enemy
      add esp, 16
  .end:
    ret

select_music:
  cmp byte[gameover], 1
  jne .start
  call call_game_over_music
  jmp .end
  .start:
    cmp byte[menu], 0
    je .off
    call start_music
    jmp .end
  .off:
    call audio_off
  .end:
    ret

;global start_music
start_music:
  cmp byte[music], 0
  je .off
  push dword 250
  push dword musictimer
  call delay
  add esp, 8
  cmp eax, 0
  je .end
  push dword[currentmusic]
  call play_next_note
  add esp, 4
  jmp .end
  .off:
    call audio_off
  .end:
    ret

;global call_game_over_music
call_game_over_music:
  cmp byte[music], 0
  je .off
  cmp byte[victory], 1
  je .off
  push dword 250
  push dword musictimer
  call delay
  add esp, 8
  cmp eax, 0
  je .end
  call game_over_music
  jmp .end
  .off:
    call audio_off
  .end:
    ret