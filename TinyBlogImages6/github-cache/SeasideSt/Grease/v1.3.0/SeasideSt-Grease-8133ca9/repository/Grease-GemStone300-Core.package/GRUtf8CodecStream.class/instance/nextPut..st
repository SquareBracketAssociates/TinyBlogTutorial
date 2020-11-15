streaming
nextPut: aCharacter
  "old implementation is very slow !!"

  "   self nextPutAll: (String with: aCharacter)"

  | codePoint |
  codePoint := aCharacter codePoint.
  codePoint > 127
    ifTrue: [ 
      codePoint > 255
        ifTrue: [ 
          | str |
          str := (String with: aCharacter) encodeAsUTF8intoString.
          stream nextPutAll: str ]
        ifFalse: [ stream nextPutAll: (Latin1ToUtf8Encodings at: codePoint + 1) ] ]
    ifFalse: [ stream nextPut: aCharacter ]