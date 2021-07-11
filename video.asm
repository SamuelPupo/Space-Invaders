%include "video.mac"

; (byte row, byte column)
%macro FBOFFSET 2.nolist
  xor eax, eax
  xor ebx, ebx
  mov al, COLS
  mov bl, %1
  mul bl
  add al, %2
  adc ah, 0
  shl ax, 1
%endmacro

; Fill the screen with the given background color
; (byte char)
%macro FILL_SCREEN 1
  push word %1
  call clear
  add esp, 2
%endmacro


section .text
; Procedure that clears the screen by filling it with char and attributes.
; (byte char, byte attributes)
;global clear
clear:
  mov ax, [esp + 4]
  mov edi, FBUFFER
  mov ecx, COLS * ROWS
  cld
  rep stosw
  ret

; Procedure that calculates the famebuffer offset 2 * (row * COLS + col)
; (byte char, byte color, byte row, byte col)
;global putc
putc:
  FBOFFSET [esp + 6], [esp + 7]
  mov bx, [esp + 4]
  mov [FBUFFER + eax], bx