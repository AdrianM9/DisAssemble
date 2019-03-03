BITS 32
extern print_line
global mystery1:function
global mystery2:function
global mystery3:function
global mystery4:function
global mystery6:function
global mystery7:function
global mystery8:function
global mystery9:function

section .text

; SAMPLE FUNCTION
; Description: adds two integers and returns their sum
; @arg1: int a - the first number
; @arg2: int b - the second number
; Return value: int
; Suggested name: add
mystery0:
  push ebp
  mov ebp, esp
  mov eax, [ebp+8]
  mov ebx, [ebp+12]
  add eax, ebx
  leave
  ret

mystery1:
  push ebp
  mov ebp, esp
  
  xor ecx, ecx
  dec ecx
  xor eax, eax
  mov edi, [ebp + 0x8]
  cld
  repne scasb
  
  not ecx
  dec ecx
  or eax, ecx
  
  leave
  ret

mystery2:
  push ebp
  mov ebp, esp
  
  xor ecx, ecx
  dec ecx
  mov eax, [ebp + 0xc]
  mov edi, [ebp + 0x8]
  cld
  repne scasb
  
  not ecx
  dec ecx
  mov eax, ecx
  
  leave
  ret

mystery3:
  push ebp
  mov ebp, esp

  xor eax, eax
  mov edi, [ebp + 0x8]
  mov esi, [ebp + 0xc]
  mov ecx, [ebp + 0x10]
  cld
  repe cmpsb

  jz mystery3_l1
  inc eax

mystery3_l1:
  leave
  ret

mystery4:
  push ebp
  mov ebp, esp

  push ebx
  mov eax, [ebp + 0x8]
  mov ebx, [ebp + 0xc]
  mov ecx, [ebp + 0x10]

mystery4_l1:
  mov dl, [ebx]
  mov byte [eax], dl
  inc eax
  inc ebx
  loop mystery4_l1
  pop ebx

  leave
  ret

mystery5:
  push ebp
  mov ebp, esp

  xor eax, eax
  mov ebx, [ebp + 0x8]
  cmp bl, 0x30
  jl mystery5_l1
  cmp bl, 0x39
  jg mystery5_l1
  inc eax

mystery5_l1:
  leave
  ret

mystery6:
  push ebp
  mov ebp, esp

  mov edi, [ebp + 0x8]
  push edi
  call mystery1
  add esp, 0x4
  mov edi, [ebp + 0x8]
  mov ecx, eax
  sub esp, eax
  mov ebx, ebp
  sub ebx, eax

mystery6_l1:
  mov dl, byte [edi + ecx - 0x1]
  mov byte [ebx], dl
  inc ebx
  loop mystery6_l1
  push eax
  mov ebx, ebp
  sub ebx, eax
  push ebx
  push edi
  call mystery4
  add esp, 0xc

  leave
  ret

mystery7:
  push ebp
  mov ebp, esp

  xor edx, edx
  xor ebx, ebx
  mov eax, [ebp + 0x8]
  sub esp, 0x4
  mov dword [ebp - 0x4], 0x0
  push eax
  call mystery1
  add esp, 0x4
  mov ecx, eax
  mov esi, [ebp + 0x8]
  xor edx, edx

mystery7_l1:
  mov bl, byte [esi + edx]
  push ebx
  push ebx
  call mystery5
  add esp, 0x4
  cmp eax, 0x0
  je mystery7_l3
  pop ebx
  sub bl, 0x30
  push ebx
  mov eax, [ebp - 0x4]
  mov ebx, eax
  shl eax, 3
  shl ebx, 1
  add eax, ebx
  pop ebx
  add eax, ebx
  mov [ebp - 0x4], eax
  inc edx
  loop mystery7_l1
  jmp mystery7_l2

mystery7_l3:
  dec eax
  add esp, 0x4

mystery7_l2:
  leave
  ret

mystery8:
  push ebp
  mov ebp, esp
  
  mov edi, [ebp + 0x8]
  mov al, 0xa
  cld
    
mystery8_l1:
  mov esi, [ebp + 0xc]
  mov ecx, [ebp + 0x10]
    
mystery8_l2:
  scasb
  je mystery8_l3
  dec edi
  cmpsb
  jne mystery8_l1
  loop mystery8_l2
  
  mov eax, 1
  jmp mystery8_l4
    
mystery8_l3:
  xor eax, eax

mystery8_l4:
  leave
  ret

mystery9:
  push ebp
  mov ebp, esp
  sub esp, 0x8
  mov edx, [ebp + 0x14]
  push edx
  call mystery1
  add esp, 0x4
  mov [ebp - 0x4], eax
  mov esi, [ebp + 0x8]
  mov ebx, [ebp + 0xc]
  mov ecx, [ebp + 0x10]
  add ecx, esi
  mov [ebp - 0x8], ecx
  add esi, ebx
  mov edi, esi

mystery9_l1:
  mov eax, 0xa
  push eax
  push edi
  call mystery2
  pop edi
  add esp, 0x4
  mov ecx, [ebp - 0x8]
  add eax, edi
  inc eax
  cmp eax, ecx
  jg mystery9_l3
  mov ebx, eax
  mov eax, [ebp - 0x4]
  mov edx, [ebp + 0x14]
  push esi
  push eax
  push edx
  push edi
  call mystery8
  pop edi
  add esp, 0x8
  pop esi
  test al, al
  je mystery9_l2

  push edi
  call print_line
  add esp, 0x4

mystery9_l2:
  mov al, [ebx]
  test al, al
  je mystery9_l3
  mov edi, ebx
  jmp mystery9_l1

mystery9_l3:
  leave
  ret
