syn clear    ocamlCharacter
syn match    ocamlCharacter    "[^a-zA-Z0-9_']'\(\\x\x\x\|\\\d\d\d\|\\[\'ntbr]\|.\)'"lc=1
syn match    ocamlCharacter    "^'\(\\x\x\x\|\\\d\d\d\|\\[\'ntbr]\|.\)'"

syn clear    ocamlCharErr
syn match    ocamlCharErr      "[^a-zA-Z0-9_']'\(\\\d\d\|\\\d\|\\[^\'ntbr]\)'"lc=1
syn match    ocamlCharErr      "^'\(\\\d\d\|\\\d\|\\[^\'ntbr]\)'"
