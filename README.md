# assembly-abc
アセンブリ (x86, Win32) のコードを置いていく場所

## ビルド
このリポジトリ内のコードは、全て nasm(Win32) 用に書かれています。

1. `nasm -fwin32 [NAME].asm`
2. `link [NAME].asm /ENTRY:[entry] /SUBSYSTEM:CONSOLE /defaultlib:kernel32`

## 備忘録
### Windows API の呼び出し方
引数付きの場合は、以下のようにして呼び出す。

```asm
extern _[FUNC_NAME]@[args_count * 4]

; example
extern _WriteFile@20    ; 5 * 4 = 20
extern _ExitProcess@4   ; 1 * 4 = 4
```