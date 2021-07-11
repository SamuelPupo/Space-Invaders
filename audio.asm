%include "notes.mac"


extern delay


section .data
shotstimer dd 0
timetop dw 0
currentsong dw 0
currentnote dw 0

cancionnavidadlength dw 55
cancionnavidadfrequency dw Do4, Fa4, Fa4, Sol4, Fa4, Mi4, Re4, Re4, Re4, Sol4,   Sol4, La4, Sol4, Fa4, Mi4, Do4, Do4, La4, La4, Las4,   La4, Sol4, Fa4, Re4, Do4, Do4, Re4, Sol4, Mi4, Fa4,   Do4, Fa4, Fa4, Fa4, Fa4, Mi4, Mi4, Fa4, Mi4, Re4,   Do4, Sol4, La4, Sol4, Sol4, Fa4, Fa4, Do5, Do4, Do4,   Do4, Re4, Sol4, Mi4, Fa4
cancionnavidadinterval dw 2, 2, 3, 3, 3, 3, 2, 2, 2, 2,                          3, 3, 3, 3, 2, 2, 2, 2, 3, 3,                          3, 3, 2, 2, 3, 3, 2, 2, 2, 1,                         2, 2, 2, 2, 1, 2, 2, 2, 2, 1,                       2, 2, 3, 3, 3, 3, 2, 2, 3, 3,                          2, 2, 2, 1, 2

stairwaytoheavenlength dw 28
stairwaytoheavenfrequency dw Sil, La3, Do4, Mi4, La4, Si4, Mi4, Do4, Si4,   Do5, Mi4, Do4, Do5, Fa#4, Re4, La3, Fa#4,   Mi4, Do4, La3, Do4, Mi4, Do4, La3,   Si3, Do3, Do3, Do2
stairwaytoheaveninterval dw 60, 30, 30, 30, 30, 30, 30, 30, 30,             30, 30, 30, 30, 30, 30, 30, 30,             30, 30, 30, 60, 30, 30, 30,          30, 30, 60, 120

sweetshildominelength dw 128
sweetshildominefrequency dw Sil, Do4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Do4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Re4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Re4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Fa4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Fa4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Do4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Do4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Do4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Do4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Re4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Re4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Fa4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,   Fa4, Do5, Sol4, Fa4, Fa5, Do5, Mi5, Do5,    Re5, Sol4, Do5, Sol4, Re5, Sol4, Mi5, Sol4,   Fa5, Sol4, Mi5, Sol4, Re5, Sol4, Do5, Do5
sweetshildomineinterval dw 60, 30, 30, 30, 30, 30, 30, 30, 30,              30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,            30, 30, 30, 30, 30, 30, 30, 30,             30, 30, 30, 30, 30, 30, 30, 30,           30, 30, 30, 30, 30, 30, 30,  30,           30, 30, 30, 30, 30, 30, 30, 30,             30, 30, 30, 30, 30, 30, 30, 30,               30, 30, 30, 30, 30, 30, 30, 30

shotlength dw 1
shotfrequency dw Do2
shotinterval dw 2

gameoverlength dw 1
gameoverfrequency dw Do5
gameoverinterval dw 100


; (word frequency)
%macro SET_FREQUENCY 1
  push edx
  push ecx
  push eax
  xor edx, edx
  mov dx, 0x12
  mov ax, 0x34dc
  mov cx, %1
  div cx
  push ax
  mov al, 0b6h
  out 43h, al
  pop ax
  out 42h, al
  mov al, ah
  out 42h, al
  pop eax
  pop ecx
  pop edx
%endmacro

; (word length, word frequency, word interval)
%macro NEXT_NOTE_SONG 3
  inc word[currentnote]
  xor eax, eax
  mov ax, [currentnote]
  cmp ax, word[%1]
  jl %%play
  mov word[currentnote], 0
  %%play:
    xor eax, eax
    mov ax, [currentnote]
    mov bx, [%2 + eax * 2]
    SET_FREQUENCY bx
    xor eax, eax
    mov ax, [currentnote]
    mov bx, [%3 + eax * 2]
    mov [timetop], bx
%endmacro


section .text
global audio_on
audio_on:
  push ax
  in al, 61h
  or al, 3h
  out 61h, al
  pop ax
  ret

global audio_off
audio_off:
  push ax
  in al, 61h
  and al, 0fch
  out 61h, al
  pop ax
  ret

global play_next_note
play_next_note:
  call audio_on
  mov eax, [esp + 4]
  cmp al, 1
  jne .song2
  NEXT_NOTE_SONG cancionnavidadlength, cancionnavidadfrequency, cancionnavidadinterval
  jmp .end
  .song2:
    cmp al, 2    
    jne .song3
    NEXT_NOTE_SONG stairwaytoheavenlength, stairwaytoheavenfrequency, stairwaytoheaveninterval
    jne .end
  .song3:
    NEXT_NOTE_SONG sweetshildominelength, sweetshildominefrequency, sweetshildomineinterval
  .end:
    ret

global shot_sound
shot_sound:
  call audio_on
  SET_FREQUENCY La2
  .for:
    push dword 20
    push dword shotstimer
    call delay
    add esp, 8
    cmp eax, 0
    jne .off
    jmp .for
  .off:
    call audio_off
    mov dword[shotstimer], 0
    ret

global enemy_shot_sound
enemy_shot_sound:  
  call audio_on
  SET_FREQUENCY Fa5
  .for:
    push dword 20
    push dword shotstimer
    call delay
    add esp, 8
    cmp eax, 0
    jne .off
    jmp .for
  .off:
    call audio_off
    mov dword[shotstimer], 0
    ret
  ret

global game_over_music
game_over_music:
  call audio_on
  NEXT_NOTE_SONG gameoverlength, gameoverfrequency, gameoverinterval
  ret

global victory_sound
victory_sound:
  ret