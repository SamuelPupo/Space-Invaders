%include "video.mac"


section .data
i db 0
j db 0
fgcolor dw 0
bgcolor dw 0


; Macro that paints the string that is assigned
; (byte row, byte column, dword direction, dword length, word fgcolor, word bgcolor)
%macro PRINT 6
  mov eax, %1
  mov [i], al
  mov ebx, %2
  mov [j], bl
  mov word[fgcolor], %5
  mov word[bgcolor], %6
  push %4
  push %3
  call print_string
  add esp, 8
%endmacro

; Macro that paints the char that is assigned
; (byte row, byte column, byte char)
%macro PRINT_CHAR 3
  xor eax, eax
  xor ebx, ebx
  mov al, COLS
  mov bl, %1
  mul bl
  add al, %2
  adc ah, 0
  shl ax, 1
  xor ebx, ebx
  mov bl, %3
  add bx, [fgcolor]
  add bx, [bgcolor]
  mov word[FBUFFER + eax], bx
%endmacro


section .text
; Procedure that paints the string char to char
; (dword direction, dword length)
;global print_string
print_string:
  mov ecx, [esp + 8]
  mov edi, [esp + 4]
  .cicle:
    PRINT_CHAR [i], [j], [edi]
    dec ecx
    jz .end
    inc edi
    inc byte[j]
    jmp .cicle
  .end:
    ret