%include "printer.asm"
%include "video.asm"
%include "video.mac"


section .data
value db 0
row db 0
column db 0
pointer db 0

loadingstring1 db 'LOADING'
lengthloadingstring1 equ $ - loadingstring1
loadingstring2 db 'PLEASE WAIT A SEC'
lengthloadingstring2 equ $ - loadingstring2

presentationstring1 db '  #@#                              $     $'
lengthpresentationstring1 equ $ - presentationstring1
presentationstring2 db ' #@#    $$$$  ####   @@@  &&&&    &$     $&  &&&&  @@@@  #     $$$'
lengthpresentationstring2 equ $ - presentationstring2
presentationstring3 db '#@#     $  $  #  #  @     &       &#     #&  &  &  @  @  #     $  $'
lengthpresentationstring3 equ $ - presentationstring3
presentationstring4 db ' #@#    $$$$  ####  @     &&&     &#     #&  &  &  @@@@  #     $  $'
lengthpresentationstring4 equ $ - presentationstring4
presentationstring5 db '  #@#   $     #  #  @     &       &#  $  #&  &  &  @ @   #     $  $'
lengthpresentationstring5 equ $ - presentationstring5
presentationstring6 db '   #@#  $     #  #   @@@  &&&&    &# # # #&  &&&&  @  @  ####  $$$'
lengthpresentationstring6 equ $ - presentationstring6
presentationstring7 db '  #@#                              *## ##*'
lengthpresentationstring7 equ $ - presentationstring7
presentationstring8 db ' #@#                                #   #'
lengthpresentationstring8 equ $ - presentationstring8
presentationstring9 db '#####  $   $  &       &         ####   $$$$$  &&&&&   @@@@'
lengthpresentationstring9 equ $ - presentationstring9
presentationstring10 db '  #    $$  $   &     &          #   #  $      &   &  @'
lengthpresentationstring10 equ $ - presentationstring10
presentationstring11 db '  #    $ $ $    &   &           #   #  $$$$   &&&&&   @@@ '
lengthpresentationstring11 equ $ - presentationstring11
presentationstring12 db '  #    $  $$     & &            #   #  $      &  &       @'
lengthpresentationstring12 equ $ - presentationstring12
presentationstring13 db '#####  $   $      &             ####   $$$$$  &   &  @@@@'
lengthpresentationstring13 equ $ - presentationstring13

rocketstring1 db '    #'
lengthrocketstring1 equ $ - rocketstring1
rocketstring2 db '  @#@'
lengthrocketstring2 equ $ - rocketstring2
rocketstring3 db '   @#@'
lengthrocketstring3 equ $ - rocketstring3
rocketstring4 db '   @@@'
lengthrocketstring4 equ $ - rocketstring4
rocketstring5 db '  @@ @@'
lengthrocketstring5 equ $ - rocketstring5
rocketstring6 db ' @#@ @#@'
lengthrocketstring6 equ $ - rocketstring6
rocketstring7 db '  ^   ^'
lengthrocketstring7 equ $ - rocketstring7
rocketstring8 db ' ^^^ ^^^'
lengthrocketstring8 equ $ - rocketstring8
rocketstring9 db '^^^^^^^^^'
lengthrocketstring9 equ $ - rocketstring9

newgame db 'NEW GAME'
lengthnewgame equ $ - newgame
options db 'OPTIONS'
lengthoptions equ $ - options
records db 'RECORDS'
about db 'ABOUT'
lengthabout equ $ - about

optionsstring1 db '#####  $$$$$  @@@@@  &&&&&  #####  $   $   @@@@'
lengthoptionsstring1 equ $ - optionsstring1
optionsstring2 db '#   #  $   $    @      &    #   #  $$  $  @'
lengthoptionsstring2 equ $ - optionsstring2
optionsstring3 db '#   #  $$$$$    @      &    #   #  $ $ $   @@@ '
lengthoptionsstring3 equ $ - optionsstring3
optionsstring4 db '#   #  $        @      &    #   #  $  $$      @'
lengthoptionsstring4 equ $ - optionsstring4
optionsstring5 db '#####  $        @    &&&&&  #####  $   $  @@@@ '
lengthoptionsstring5 equ $ - optionsstring5

easy db 'EASY'
lengtheasy equ $ - easy
normal db 'NORMAL'
lengthnormal equ $ - normal
hard db 'HARD'
level1 db 'LEVEL 1'
lengthlevel1 equ $ - level1
level2 db 'LEVEL 2'
level3 db 'LEVEL 3'
level4 db 'LEVEL 4'
level5 db 'LEVEL 5'
music db 'MUSIC'
on db 'ON '
lengthon equ $ - on
off db 'OFF'

recordsstring1 db '#####  $$$$$  @@@@@  &&&&&  #####  $$$$    @@@@'
lengthrecordsstring1 equ $ - recordsstring1
recordsstring2 db '#   #  $      @      &   &  #   #  $   $  @'
lengthrecordsstring2 equ $ - recordsstring2
recordsstring3 db '#####  $$$$   @      &   &  #####  $   $   @@@'
lengthrecordsstring3 equ $ - recordsstring3
recordsstring4 db '#  #   $      @      &   &  #  #   $   $      @'
lengthrecordsstring4 equ $ - recordsstring4
recordsstring5 db '#   #  $$$$$  @@@@@  &&&&&  #   #  $$$$   @@@@'
lengthrecordsstring5 equ $ - recordsstring5

aboutstring1 db '#####  $$$$   @@@@@  &   &  #####'
lengthaboutstring1 equ $ - aboutstring1
aboutstring2 db '#   #  $   $  @   @  &   &    #'
lengthaboutstring2 equ $ - aboutstring2
aboutstring3 db '#####  $$$$   @   @  &   &    #'
lengthaboutstring3 equ $ - aboutstring3
aboutstring4 db '#   #  $   $  @   @  &   &    #'
lengthaboutstring4 equ $ - aboutstring4
aboutstring5 db '#   #  $$$$   @@@@@  &&&&&    #'
lengthaboutstring5 equ $ - aboutstring5

descriptionstring1 db 'DESCRIPTION:'
lengthdescriptionstring1 equ $ - descriptionstring1
descriptionstring2 db 'PM(I) PROJECT 2018-2019'
lengthdescriptionstring2 equ $ - descriptionstring2
developersstring1 db 'DEVELOPERS:'
lengthdevelopersstring1 equ $ - developersstring1
developersstring2 db 'DAVID ORLANDO DE QUESADA OLIVA  C-211'
lengthdevelopersstring2 equ $ - developersstring2
developersstring3 db 'SAMUEL EFRAIN PUPO WONG         C-212'
place db 'COMPUTER SCIENCE FACULTY, HAVANA UNIVERSITY'
lengthplace equ $ - place

menupointer db '>'
empty db 0
normalshot db '!'
penetrativeshot db '$'
grenadeshot db '@'
enemyshot db '|'

play db 'PLAYING'
lengthplay equ $ - play
stop db 'PAUSED '
shot db 'SHOT:'
level db 'LEVEL:'
score db 'SCORE:'
lives db 'LIVES:'
livescount3 db '<^> <^> <^>'
lengthlivescount3 equ $ - livescount3
livescount2 db '<^> <^>    '
livescount1 db '<^>        '
livescount0 db '           '

hero db '<=^=>'
lengthhero equ $ - hero
herodeath db '=>*<='

shieldsstring1 db '####'
lengthshieldsstring1 equ $ - shieldsstring1
shieldsstring2 db '########'
lengthshieldsstring2 equ $ - shieldsstring2

enemy db ' 0  0  0  0  0  0  0  0  0  0 '
lengthenemy equ $ - enemy

bonus db 'OoOoO'
lengthbonus equ $ - bonus

victorystring1 db '##       ##  $$$$$$    @@@@@@   &&&&&&&&  ######  $$$$$$  @@  @@'
lengthvictorystring1 equ $ - victorystring1
victorystring2 db ' ##     ##     $$     @@    @@     &&     ##  ##  $$  $$  @@  @@'
lengthvictorystring2 equ $ - victorystring2
victorystring3 db '  ##   ##      $$    @@            &&     ##  ##  $$$$$$   @@@@'
lengthvictorystring3 equ $ - victorystring3
victorystring4 db '   ## ##       $$    @@            &&     ##  ##  $$ $$     @@'
lengthvictorystring4 equ $ - victorystring4
victorystring5 db '    ###        $$     @@    @@     &&     ##  ##  $$  $$    @@'
lengthvictorystring5 equ $ - victorystring5
victorystring6 db '     #       $$$$$$    @@@@@@      &&     ######  $$  $$    @@'
lengthvictorystring6 equ $ - victorystring6

gameoverstring1 db '   ###  $$$$$  &     &  @@@@@     $$$$$$  &      &  #####  @@@@@'
lengthgameoverstring1 equ $ - gameoverstring1
gameoverstring2 db '  #     $   $  &&   &&  @         $    $  &      &  #      @   @'
lengthgameoverstring2 equ $ - gameoverstring2
gameoverstring3 db ' #      $   $  & & & &  @         $    $  &      &  #      @   @'
lengthgameoverstring3 equ $ - gameoverstring3
gameoverstring4 db '#       $   $  &  &  &  @         $    $  &      &  #      @   @'
lengthgameoverstring4 equ $ - gameoverstring4
gameoverstring5 db '#  ###  $$$$$  &     &  @@@@@     $    $  &      &  #####  @@@@@'
lengthgameoverstring5 equ $ - gameoverstring5
gameoverstring6 db '#    #  $   $  &     &  @         $    $  &      &  #      @ @'
lengthgameoverstring6 equ $ - gameoverstring6
gameoverstring7 db ' #   #  $   $  &     &  @         $    $   &    &   #      @  @'
lengthgameoverstring7 equ $ - gameoverstring7
gameoverstring8 db '  #  #  $   $  &     &  @         $    $    &  &    #      @   @'
lengthgameoverstring8 equ $ - gameoverstring8
gameoverstring9 db '   ###  $   $  &     &  @@@@@     $$$$$$     &&     #####  @   @'
lengthgameoverstring9 equ $ - gameoverstring9

lightsstring1 db '! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! '
lengthlightsstring1 equ $ - lightsstring1
lightsstring2 db '!'
lengthlightsstring2 equ $ - lightsstring2

facestring1 db ' @@@@@@@@@@@'
lengthfacestring1 equ $ - facestring1
facestring2 db '@           @'
lengthfacestring2 equ $ - facestring2
eyestring db '**   **'
lengtheyestring equ $ - eyestring

mouthstring1 db '#     #'
lengthmouthstring1 equ $ - mouthstring1
mouthstring2 db ' #   #'
lengthmouthstring2 equ $ - mouthstring2
mouthstring3 db '  ###'
lengthmouthstring3 equ $ - mouthstring3


section .text
; Procedure that paints the loading strings
global print_loading
print_loading:
  PRINT 10, 36, loadingstring1, lengthloadingstring1, FG.WHITE, BG.BLACK
  PRINT 11, 31, loadingstring2, lengthloadingstring2, FG.WHITE, BG.BLACK
  ret

; Procedure that paints the presentation
global print_presentation
print_presentation:
  push word 0
  call clear
  add esp, 2
  PRINT 2, 6, presentationstring1, lengthpresentationstring1, FG.WHITE, BG.BLACK
  PRINT 3, 6, presentationstring2, lengthpresentationstring2, FG.WHITE, BG.BLACK
  PRINT 4, 6, presentationstring3, lengthpresentationstring3, FG.WHITE, BG.BLACK
  PRINT 5, 6, presentationstring4, lengthpresentationstring4, FG.WHITE, BG.BLACK
  PRINT 6, 6, presentationstring5, lengthpresentationstring5, FG.WHITE, BG.BLACK
  PRINT 7, 6, presentationstring6, lengthpresentationstring6, FG.WHITE, BG.BLACK
  PRINT 8, 6, presentationstring7, lengthpresentationstring7, FG.WHITE, BG.BLACK
  PRINT 9, 6, presentationstring8, lengthpresentationstring8, FG.WHITE, BG.BLACK
  PRINT 11, 11, presentationstring9, lengthpresentationstring9, FG.LIGHTGREEN, BG.BLACK
  PRINT 12, 11, presentationstring10, lengthpresentationstring10, FG.LIGHTGREEN, BG.BLACK
  PRINT 13, 11, presentationstring11, lengthpresentationstring11, FG.LIGHTGREEN, BG.BLACK
  PRINT 14, 11, presentationstring12, lengthpresentationstring12, FG.LIGHTGREEN, BG.BLACK
  PRINT 15, 11, presentationstring13, lengthpresentationstring13, FG.LIGHTGREEN, BG.BLACK
  PRINT 10, 33, rocketstring1, lengthrocketstring1, FG.LIGHTGREEN, BG.BLACK
  PRINT 11, 34, rocketstring2, lengthrocketstring2, FG.LIGHTGREEN, BG.BLACK
  PRINT 12, 33, rocketstring3, lengthrocketstring3, FG.LIGHTGREEN, BG.BLACK
  PRINT 13, 33, rocketstring4, lengthrocketstring4, FG.LIGHTGREEN, BG.BLACK
  PRINT 14, 33, rocketstring5, lengthrocketstring5, FG.LIGHTGREEN, BG.BLACK
  PRINT 15, 33, rocketstring6, lengthrocketstring6, FG.LIGHTGREEN, BG.BLACK
  PRINT 16, 33, rocketstring7, lengthrocketstring7, FG.YELLOW, BG.BLACK
  PRINT 17, 33, rocketstring8, lengthrocketstring8, FG.YELLOW, BG.BLACK
  PRINT 18, 33, rocketstring9, lengthrocketstring9, FG.YELLOW, BG.BLACK
  push dword 21
  push dword 10
  push dword 1
  call print_menu_pointer
  add esp, 12
  ret

; Procedure that paints the pointer of Main menu
; (byte row, byte column, byte menu)
global print_menu_pointer
print_menu_pointer:
  PRINT [esp + 12], [esp + 8], menupointer, 1, FG.WHITE, BG.BLACK
  mov ecx, [esp + 4]
  cmp cl, 1
  jne .end
  mov eax, [esp + 8]
  call print_main_menu_select
  .end:
    ret

; Procedure that changes the pointer selection of Main menu
;global print_main_menu_select
print_main_menu_select:
  push eax
  PRINT 21, 12, newgame, lengthnewgame, FG.WHITE, BG.BLACK
  PRINT 21, 29, options, lengthoptions, FG.WHITE, BG.BLACK
  PRINT 21, 46, records, lengthoptions, FG.WHITE, BG.BLACK
  PRINT 21, 63, about, lengthabout, FG.WHITE, BG.BLACK
  pop eax
  cmp al, 10
  jne .options
  PRINT 21, 12, newgame, lengthnewgame, FG.LIGHTGREEN, BG.BLACK
  jmp .end
  .options:
    cmp al, 27
    jne .records
    PRINT 21, 29, options, lengthoptions, FG.LIGHTGREEN, BG.BLACK
    jmp .end
  .records:
    cmp al, 44
    jne .about
    PRINT 21, 46, records, lengthoptions, FG.LIGHTGREEN, BG.BLACK
    jmp .end
  .about:
    PRINT 21, 63, about, lengthabout, FG.LIGHTGREEN, BG.BLACK
  .end:
    ret

; Procedure that paints the Options menu
; (byte mode, byte level, byte music)
global print_options_menu
print_options_menu:
  push word 0
  call clear
  add esp, 2
  PRINT 3, 16, optionsstring1, lengthoptionsstring1, FG.ORANGE, BG.BLACK
  PRINT 4, 16, optionsstring2, lengthoptionsstring2, FG.ORANGE, BG.BLACK
  PRINT 5, 16, optionsstring3, lengthoptionsstring3, FG.ORANGE, BG.BLACK
  PRINT 6, 16, optionsstring4, lengthoptionsstring4, FG.ORANGE, BG.BLACK
  PRINT 7, 16, optionsstring5, lengthoptionsstring5, FG.ORANGE, BG.BLACK
  push dword 10
  push dword 14
  push dword 2
  call print_menu_pointer
  add esp, 12
  mov eax, [esp + 12]
  cmp al, 0
  jne .normal
  mov al, 10
  jmp .level1
  .normal:
    cmp al, 1
    jne .hard
    mov al, 12
    jmp .level1
  .hard:
    mov al, 14
  .level1:
    push eax
    call print_options_menu_mode
    add esp, 4
    mov eax, [esp + 8]
    cmp al, 1
    jne .level2
    mov al, 10
    jmp .music
  .level2:
    cmp al, 2
    jne .level3
    mov al, 12
    jmp .music
  .level3:
    cmp al, 3
    jne .level4
    mov al, 14
    jmp .music
  .level4:
    cmp al, 4
    jne .level5
    mov al, 16
    jmp .music
  .level5:
    mov al, 18
  .music:
    push eax
    call print_options_menu_level
    add esp, 4
    push dword[esp + 4]
    call print_options_menu_music
    add esp, 4
    ret

; Procedure that paints the selected Mode in Options menu
; (byte row)
global print_options_menu_mode
print_options_menu_mode:
  PRINT 10, 16, easy, lengtheasy, FG.WHITE, BG.BLACK
  PRINT 12, 16, normal, lengthnormal, FG.WHITE, BG.BLACK
  PRINT 14, 16, hard, lengtheasy, FG.WHITE, BG.BLACK
  mov eax, [esp + 4]
  cmp al, 10
  jne .normal
  PRINT 10, 16, easy, lengtheasy, FG.ORANGE, BG.BLACK
  jmp .end
  .normal:
    cmp al, 12
    jne .hard
    PRINT 12, 16, normal, lengthnormal, FG.ORANGE, BG.BLACK
    jmp .end
  .hard:
    PRINT 14, 16, hard, lengtheasy, FG.ORANGE, BG.BLACK
  .end:
    ret

; Procedure that paints the selected Level in Options menu
; (byte row)
global print_options_menu_level
print_options_menu_level:
  PRINT 10, 36, level1, lengthlevel1, FG.WHITE, BG.BLACK
  PRINT 12, 36, level2, lengthlevel1, FG.WHITE, BG.BLACK
  PRINT 14, 36, level3, lengthlevel1, FG.WHITE, BG.BLACK
  PRINT 16, 36, level4, lengthlevel1, FG.WHITE, BG.BLACK
  PRINT 18, 36, level5, lengthlevel1, FG.WHITE, BG.BLACK
  mov eax, [esp + 4]
  cmp al, 10
  jne .level2
  PRINT 10, 36, level1, lengthlevel1, FG.ORANGE, BG.BLACK
  jmp .end
  .level2:
    cmp al, 12
    jne .level3
    PRINT 12, 36, level2, lengthlevel1, FG.ORANGE, BG.BLACK
    jmp .end
  .level3:
    cmp al, 14
    jne .level4
    PRINT 14, 36, level3, lengthlevel1, FG.ORANGE, BG.BLACK
    jmp .end
  .level4:
    cmp al, 16
    jne .level5
    PRINT 16, 36, level4, lengthlevel1, FG.ORANGE, BG.BLACK
    jmp .end
  .level5:
    PRINT 18, 36, level5, lengthlevel1, FG.ORANGE, BG.BLACK
  .end:
    ret

; Procedure that paints the Music status in Options menu
; (byte music)
global print_options_menu_music
print_options_menu_music:
  mov eax, [esp + 4]
  cmp al, 0
  jne .on
  PRINT 10, 56, music, lengthabout, FG.WHITE, BG.BLACK
  PRINT 10, 62, off, lengthon, FG.WHITE, BG.BLACK
  jmp .end
  .on:
    PRINT 10, 56, music, lengthabout, FG.ORANGE, BG.BLACK
    PRINT 10, 62, on, lengthon, FG.ORANGE, BG.BLACK
  .end:
    ret

; Procedure that paints the Records menu
; (dword easyrecords, dword normalrecords, dword hardrecords)
global print_records
print_records:
  push word 0
  call clear
  add esp, 2
  PRINT 3, 16, recordsstring1, lengthrecordsstring1, FG.LIGHTYELLOW, BG.BLACK
  PRINT 4, 16, recordsstring2, lengthrecordsstring2, FG.LIGHTYELLOW, BG.BLACK
  PRINT 5, 16, recordsstring3, lengthrecordsstring3, FG.LIGHTYELLOW, BG.BLACK
  PRINT 6, 16, recordsstring4, lengthrecordsstring4, FG.LIGHTYELLOW, BG.BLACK
  PRINT 7, 16, recordsstring5, lengthrecordsstring5, FG.LIGHTYELLOW, BG.BLACK
  PRINT 10, 18, easy, lengtheasy, FG.LIGHTYELLOW, BG.BLACK
  PRINT 10, 37, normal, lengthnormal, FG.LIGHTYELLOW, BG.BLACK
  PRINT 10, 58, hard, lengtheasy, FG.LIGHTYELLOW, BG.BLACK
  mov eax, [esp + 12]
  xor ebx, ebx
  xor ecx, ecx
  mov edx, 12
  .easy:
    cmp cl, 5
    je .next
    mov bx, [eax]
    push eax
    push ecx
    push edx
    push dword 21
    push ebx
    call print_score
    pop ebx
    add esp, 4
    pop edx
    pop ecx
    pop eax
    add eax, 2
    add cl, 1
    add dl, 2
    jmp .easy
  .next:
    mov eax, [esp + 8]
    xor ebx, ebx
    xor ecx, ecx
    mov edx, 12
  .normal:
    cmp cl, 5
    je .last
    mov bx, [eax]
    push eax
    push ecx
    push edx
    push dword 41
    push ebx
    call print_score
    pop ebx
    add esp, 4
    pop edx
    pop ecx
    pop eax
    add eax, 2
    add cl, 1
    add dl, 2
    jmp .normal
  .last:
    mov eax, [esp + 4]
    xor ebx, ebx
    xor ecx, ecx
    mov edx, 12
  .hard:
    cmp cl, 5
    je .end
    mov bx, [eax]
    push eax
    push ecx
    push edx
    push dword 61
    push ebx
    call print_score
    pop ebx
    add esp, 4
    pop edx
    pop ecx
    pop eax
    add eax, 2
    add cl, 1
    add dl, 2
    jmp .hard
  .end:
    ret

; Procedure that paints the About menu
global print_about_menu
print_about_menu:
  push word 0
  call clear
  add esp, 2
  PRINT 3, 23, aboutstring1, lengthaboutstring1, FG.CYAN, BG.BLACK
  PRINT 4, 23, aboutstring2, lengthaboutstring2, FG.CYAN, BG.BLACK
  PRINT 5, 23, aboutstring3, lengthaboutstring3, FG.CYAN, BG.BLACK
  PRINT 6, 23, aboutstring4, lengthaboutstring4, FG.CYAN, BG.BLACK
  PRINT 7, 23, aboutstring5, lengthaboutstring5, FG.CYAN, BG.BLACK
  PRINT 10, 21, descriptionstring1, lengthdescriptionstring1, FG.CYAN, BG.BLACK
  PRINT 10, 34, descriptionstring2, lengthdescriptionstring2, FG.WHITE, BG.BLACK
  PRINT 13, 15, developersstring1, lengthdevelopersstring1, FG.CYAN, BG.BLACK
  PRINT 13, 27, developersstring2, lengthdevelopersstring2, FG.WHITE, BG.BLACK
  PRINT 15, 27, developersstring3, lengthdevelopersstring2, FG.WHITE, BG.BLACK
  PRINT 18, 18, place, lengthplace, FG.CYAN, BG.BLACK
  ret

; Procedure that paints the beginning of the game
; (byte level, byte score, byte lives)
global print_start
print_start:
  push word 0
  call clear
  add esp, 2
  call print_play
  PRINT 0, 71, shot, lengthabout, FG.WHITE, BG.BLACK
  PRINT 24, 1, level, lengthnormal, FG.WHITE, BG.BLACK
  PRINT 24, 30, score, lengthnormal, FG.WHITE, BG.BLACK
  PRINT 24, 60, lives, lengthnormal, FG.WHITE, BG.BLACK
  call print_shields
  push dword 1
  call print_shot_type
  add esp, 4
  push dword[esp + 12]
  call print_level
  add esp, 4
  mov eax, [esp + 8]
  push dword 24
  push dword 40
  push eax
  call print_score
  add esp, 12
  push dword[esp + 4]
  call print_lives
  add esp, 4
  ret

; Procedure that paints the game status as "Playing"
global print_play
print_play:
  PRINT 0, 1, play, lengthplay, FG.WHITE, BG.BLACK
  ret

; Procedure that paints the game status as "Paused"
global print_pause
print_pause:
  PRINT 0, 1, stop, lengthplay, FG.WHITE, BG.BLACK
  ret

; Procedure that paints the current Shot type
; (byte shottype)
global print_shot_type
print_shot_type:
  mov eax, [esp + 4]
  push dword 0
  push dword 77
  push eax
  call print_shot
  add esp, 12
  ret

; Procedure that paints the current Level
; (byte level)
global print_level
print_level:
  mov eax, [esp + 4]
  mov [value], al
  add byte[value], 48
  PRINT 24, 8, value, 1, FG.WHITE, BG.BLACK
  ret

; Procedure that paints the current Score
; (byte row, byte column, word score)
global print_score
print_score:
  mov eax, [esp + 12]
  mov byte[row], al
  mov eax, [esp + 8]
  mov byte[column], al
  mov eax, [esp + 4]
  mov byte[pointer], 4
  xor ecx, ecx
  mov cl, [column]
  .cicle:
    cmp byte[pointer], 0
    je .end
    xor edx, edx
    mov ebx, 10
    div bx
    mov [value], dl
    add byte[value], 48
    mov bl, [row]
    push eax
    push ebx
    push ecx
    PRINT ebx, ecx, value, 1, FG.WHITE, BG.BLACK
    pop ecx
    pop ebx
    pop eax
    dec byte[pointer]
    dec cl
    jmp .cicle 
  .end:
    ret

; Procedure that paints the current Lives
; (byte lives)
global print_lives
print_lives:
  mov eax, [esp + 4]
  cmp al, 3
  jne .two
  PRINT 24, 67, livescount3, lengthlivescount3, FG.WHITE, BG.BLACK
  jmp .end
  .two:    
    cmp al, 2
    jne .one
    PRINT 24, 67, livescount2, lengthlivescount3, FG.WHITE, BG.BLACK
    jmp .end
  .one:
    cmp al, 1
    jne .zero
    PRINT 24, 67, livescount1, lengthlivescount3, FG.WHITE, BG.BLACK
    jmp .end
  .zero:
    PRINT 24, 67, livescount0, lengthlivescount3, FG.WHITE, BG.BLACK
  .end:
    ret

; Procedure that paints the shields
global print_shields
print_shields:
  PRINT 17, 10, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 18, 8, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 19, 8, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 20, 10, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 17, 29, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 18, 27, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 19, 27, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 20, 29, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 17, 47, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 18, 45, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 19, 45, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 20, 47, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 17, 66, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  PRINT 18, 64, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 19, 64, shieldsstring2, lengthshieldsstring2, FG.BRIGHT, BG.BLACK
  PRINT 20, 66, shieldsstring1, lengthshieldsstring1, FG.BRIGHT, BG.BLACK
  ret

; Procedure that cleans the screen space that is assigned
; (byte row, byte column, byte length)
global clean
clean:
  mov eax, [esp + 12]
  mov [row], al
  mov ebx, [esp + 8]
  mov [column], bl
  mov ecx, [esp + 4]
  mov [pointer], cl
  .cicle:
    cmp byte[pointer], 0
    je .end
    PRINT [row], [column], empty, 1, FG.RED, BG.BLACK
    dec byte[pointer]
    inc byte[column]
    jmp .cicle
  .end:
    ret

; Procedure that paints the hero
; (byte row, byte column)
global print_hero
print_hero:
  mov eax, [esp + 8]
  mov ebx, [esp + 4]
  PRINT eax, ebx, hero, lengthhero, FG.WHITE, BG.BLACK
  ret

; Procedure that paints the hero satus as death
; (byte row, byte column)
global print_hero_death
print_hero_death:
  mov eax, [esp + 8]
  mov ebx, [esp + 4]
  PRINT eax, ebx, herodeath, lengthhero, FG.WHITE, BG.BLACK
  ret

; Procedure that paints the shots of the hero
; (byte row, byte column, byte shottype)
global print_shot
print_shot:
  mov eax, [esp + 12]
  mov ebx, [esp + 8]
  mov ecx, [esp + 4]
  cmp cl, 1
  jne .penetrative
  PRINT eax, ebx, normalshot, 1, FG.WHITE, BG.BLACK
  jmp .end
  .penetrative:
    cmp cl, 2
    jne .grenade
    PRINT eax, ebx, penetrativeshot, 1, FG.WHITE, BG.BLACK
    jmp .end
  .grenade:
    PRINT eax, ebx, grenadeshot, 1, FG.WHITE, BG.BLACK
  .end:
    ret

; Procedure that paints the enemy
; (byte show, byte column, dword direction, byte level)
global print_enemy
print_enemy:
  mov eax, [esp + 16]
  mov ebx, [esp + 12]
  mov ecx, 30
  mov esi, [esp + 8]
  mov edi, enemy
  cld
  rep movsb
  mov ecx, [esp + 4]
  call select_level_color
  PRINT eax, ebx, enemy, lengthenemy, cx, BG.BLACK
  ret

; Procedure that chooses the color of the enemy according to the current Level
;global select_level_color
select_level_color:
  cmp cl, 1
  jne .level2
  mov cx, FG.RED
  jmp .end
  .level2:
    cmp cl, 2
    jne .level3
    mov cx, FG.CYAN
    jmp .end
  .level3:
    cmp cl, 3
    jne .level4
    mov cx, FG.YELLOW
    jmp .end
  .level4:
    cmp cl, 4
    jne .level5
    mov cx, FG.LIGHTBLUE
    jmp .end
  .level5:
    mov cx, FG.MAGENTA
  .end:
    ret

; Procedure that paints the shots of the enemy
; (byte row, byte column, byte level)
global print_enemy_shot
print_enemy_shot:
  mov eax, [esp + 12]
  mov ebx, [esp + 8]
  mov ecx, [esp + 4]
  call select_level_color
  PRINT eax, ebx, enemyshot, 1, cx, BG.BLACK
  ret

; Procedure that paints the bonus
; (byte row, byte column)
global print_bonus
print_bonus:
  mov eax, [esp + 8]
  mov ebx, [esp + 4]
  PRINT eax, ebx, bonus, lengthbonus, FG.GRAY, BG.BLACK
  ret

; Procedure that paints the game "Victory"
global print_victory
print_victory:
  push word 0
  call clear
  add esp, 2
  PRINT 3, 7, victorystring1, lengthvictorystring1, FG.LIGHTBLUE, BG.BLACK
  PRINT 4, 7, victorystring2, lengthvictorystring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 5, 7, victorystring3, lengthvictorystring3, FG.LIGHTBLUE, BG.BLACK
  PRINT 6, 7, victorystring4, lengthvictorystring4, FG.LIGHTBLUE, BG.BLACK
  PRINT 7, 7, victorystring5, lengthvictorystring5, FG.LIGHTBLUE, BG.BLACK
  PRINT 8, 7, victorystring6, lengthvictorystring6, FG.LIGHTBLUE, BG.BLACK
  PRINT 12, 33, facestring1, lengthfacestring1, FG.LIGHTBLUE, BG.BLACK
  PRINT 13, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 14, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 15, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 16, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 17, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 18, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 19, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 20, 33, facestring2, lengthfacestring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 21, 33, facestring1, lengthfacestring1, FG.LIGHTBLUE, BG.BLACK
  PRINT 14, 36, eyestring, lengtheyestring, FG.LIGHTBLUE, BG.BLACK
  PRINT 15, 36, eyestring, lengtheyestring, FG.LIGHTBLUE, BG.BLACK
  PRINT 17, 36, mouthstring1, lengthmouthstring1, FG.LIGHTBLUE, BG.BLACK
  PRINT 18, 36, mouthstring2, lengthmouthstring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 19, 36, mouthstring3, lengthmouthstring3, FG.LIGHTBLUE, BG.BLACK
  PRINT 14, 18, rocketstring1, lengthrocketstring1, FG.LIGHTBLUE, BG.BLACK
  PRINT 15, 19, rocketstring2, lengthrocketstring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 16, 18, rocketstring3, lengthrocketstring3, FG.LIGHTBLUE, BG.BLACK
  PRINT 17, 18, rocketstring4, lengthrocketstring4, FG.LIGHTBLUE, BG.BLACK
  PRINT 18, 18, rocketstring5, lengthrocketstring5, FG.LIGHTBLUE, BG.BLACK
  PRINT 19, 18, rocketstring6, lengthrocketstring6, FG.LIGHTBLUE, BG.BLACK
  PRINT 14, 52, rocketstring1, lengthrocketstring1, FG.LIGHTBLUE, BG.BLACK
  PRINT 15, 53, rocketstring2, lengthrocketstring2, FG.LIGHTBLUE, BG.BLACK
  PRINT 16, 52, rocketstring3, lengthrocketstring3, FG.LIGHTBLUE, BG.BLACK
  PRINT 17, 52, rocketstring4, lengthrocketstring4, FG.LIGHTBLUE, BG.BLACK
  PRINT 18, 52, rocketstring5, lengthrocketstring5, FG.LIGHTBLUE, BG.BLACK
  PRINT 19, 52, rocketstring6, lengthrocketstring6, FG.LIGHTBLUE, BG.BLACK
  ret

; Procedure that paints the "Game Over"
global print_game_over
print_game_over:
  push word 0
  call clear
  add esp, 2
  PRINT 2, 7, gameoverstring1, lengthgameoverstring1, FG.RED, BG.BLACK
  PRINT 3, 7, gameoverstring2, lengthgameoverstring2, FG.RED, BG.BLACK
  PRINT 4, 7, gameoverstring3, lengthgameoverstring3, FG.RED, BG.BLACK
  PRINT 5, 7, gameoverstring4, lengthgameoverstring4, FG.RED, BG.BLACK
  PRINT 6, 7, gameoverstring5, lengthgameoverstring5, FG.RED, BG.BLACK
  PRINT 7, 7, gameoverstring6, lengthgameoverstring6, FG.RED, BG.BLACK
  PRINT 8, 7, gameoverstring7, lengthgameoverstring7, FG.RED, BG.BLACK
  PRINT 9, 7, gameoverstring8, lengthgameoverstring8, FG.RED, BG.BLACK
  PRINT 10, 7, gameoverstring9, lengthgameoverstring9, FG.RED, BG.BLACK
  PRINT 13, 33, facestring1, lengthfacestring1, FG.RED, BG.BLACK
  PRINT 14, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 15, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 16, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 17, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 18, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 19, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 20, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 21, 33, facestring2, lengthfacestring2, FG.RED, BG.BLACK
  PRINT 22, 33, facestring1, lengthfacestring1, FG.RED, BG.BLACK
  PRINT 15, 36, eyestring, lengtheyestring, FG.RED, BG.BLACK
  PRINT 16, 36, eyestring, lengtheyestring, FG.RED, BG.BLACK
  PRINT 18, 36, mouthstring3, lengthmouthstring3, FG.RED, BG.BLACK
  PRINT 19, 36, mouthstring2, lengthmouthstring2, FG.RED, BG.BLACK
  PRINT 20, 36, mouthstring1, lengthmouthstring1, FG.RED, BG.BLACK
  PRINT 15, 18, rocketstring6, lengthrocketstring6, FG.RED, BG.BLACK
  PRINT 16, 18, rocketstring5, lengthrocketstring5, FG.RED, BG.BLACK
  PRINT 17, 18, rocketstring4, lengthrocketstring4, FG.RED, BG.BLACK
  PRINT 18, 18, rocketstring3, lengthrocketstring3, FG.RED, BG.BLACK
  PRINT 19, 19, rocketstring2, lengthrocketstring2, FG.RED, BG.BLACK
  PRINT 20, 18, rocketstring1, lengthrocketstring1, FG.RED, BG.BLACK
  PRINT 15, 52, rocketstring6, lengthrocketstring6, FG.RED, BG.BLACK
  PRINT 16, 52, rocketstring5, lengthrocketstring5, FG.RED, BG.BLACK
  PRINT 17, 52, rocketstring4, lengthrocketstring4, FG.RED, BG.BLACK
  PRINT 18, 52, rocketstring3, lengthrocketstring3, FG.RED, BG.BLACK
  PRINT 19, 53, rocketstring2, lengthrocketstring2, FG.RED, BG.BLACK
  PRINT 20, 52, rocketstring1, lengthrocketstring1, FG.RED, BG.BLACK
  ret

; Procedure that paints the lights of the screen borders
; (byte menu)
global print_lights
print_lights:
  mov eax, [esp + 4]
  cmp al, 0
  jne .continue
  call print_color_lights
  call print_white_lights
  jmp .end
  .continue:
    call print_white_lights
    call print_color_lights
  .end:
    ret

; Procedure that paints of white color the lights of the screen borders
;global print_white_lights
print_white_lights:
  cmp al, 0
  jne .continue
  mov dx, FG.WHITE
  jmp .end
  .continue:
    mov dx, FG.BLACK
  .end:
    mov [value], al
    PRINT 0, 0, lightsstring1, lengthlightsstring1, dx, BG.BLACK
    PRINT 2, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 4, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 6, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 8, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 10, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 12, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 14, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 16, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 18, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 20, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 22, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 1, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 3, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 5, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 7, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 9, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 11, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 13, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 15, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 17, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 19, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 21, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 23, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 24, 0, lightsstring1, lengthlightsstring1, dx, BG.BLACK
    mov al, [value]
    ret

; Procedure that paints of different colors the lights of the screen borders
;global print_color_lights
print_color_lights:
  cmp al, 0
  jne .presentation
  mov dx, FG.BLACK
  jmp .end
  .presentation:
    cmp al, 1
    jne .options
    mov dx, FG.LIGHTGREEN
    jmp .end
  .options:
    cmp al, 2
    jne .records
    mov dx, FG.ORANGE
    jmp .end
  .records:
    cmp al, 3
    jne .about
    mov dx, FG.LIGHTYELLOW
    jmp .end
  .about:
    cmp al, 4
    jne .victory
    mov dx, FG.CYAN
    jmp .end
  .victory:
    cmp al, 5
    jne .game_over
    mov dx, FG.BLUE
    jmp .end
  .game_over:
    mov dx, FG.RED
  .end:
    mov [value], al
    PRINT 0, 1, lightsstring1, lengthlightsstring1, dx, BG.BLACK
    PRINT 1, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 3, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 5, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 7, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 9, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 11, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 13, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 15, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 17, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 19, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 21, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 23, 0, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 0, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 2, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 4, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 6, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 8, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 10, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 12, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 14, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 16, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 18, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 20, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 22, 79, lightsstring2, lengthlightsstring2, dx, BG.BLACK
    PRINT 24, 1, lightsstring1, lengthlightsstring1, dx, BG.BLACK
    mov al, [value]
    ret