;; MIT License
;; 
;; Copyright (c) 2023 Arumino
;; 
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;; 
;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.
;; 
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

extern  _GetStdHandle@4
extern  _WriteFile@20
extern  _ExitProcess@4

section .data:
    msg01:      db "Hello, World",10
    msg01_end:  db 0

    msg02:      db "This program is written in assembly.",10
    msg02_end:  db 0

    msg03:      db "ÇøÇ·ÇÒÇ∆ì˙ñ{åÍÇ‡èoóÕÇ≈Ç´ÇÈÇÊ (Shift-JISÇæÇØÇ«)",10
    msg03_end:  db 0

section .text
    global  _start


;; Program start position
_start:
    ; handle = GetStdHandle(-11)
    push    -11
    call    _GetStdHandle@4
    mov     ebx, eax

    ; initialize and call "print" function
    lea     eax, [msg01_end - msg01]
    push    eax     ; count
    push    msg01   ; text
    push    ebx     ; handle
    call    print

    lea     eax, [msg02_end - msg02]
    push    eax
    push    msg02
    push    ebx
    call    print

    lea     eax, [msg03_end - msg03]
    push    eax
    push    msg03
    push    ebx
    call    print

    ; ExitProcess(0)
    push    0
    call    _ExitProcess@4

    hlt


;; Print speficied text. (for Microsoft Windows)
;; usage:   push [HANDLE]
;;          push [MESSAGE]
;;          push [COUNT_OF_MESSAGE]
;;          call print
print:
    ; backup registers
    push    ebp
    mov     ebp, esp

    ; initialize variable "wrote_per_bytes"
    push    0

    ; WriteFile(handle, msg, msg_length, &wrote_per_bytes, 0)
    push    0
    lea     eax, [esp + 4]  ; &wrote_per_bytes
    push    eax
    mov     eax, [ebp + 16] ; count
    push    eax
    mov     eax, [ebp + 12] ; msg
    push    eax
    mov     eax, [ebp + 8]  ; handle
    push    eax
    call    _WriteFile@20

    ; restore registers
    mov     esp, ebp
    pop     ebp
    mov     eax, 0
    ret