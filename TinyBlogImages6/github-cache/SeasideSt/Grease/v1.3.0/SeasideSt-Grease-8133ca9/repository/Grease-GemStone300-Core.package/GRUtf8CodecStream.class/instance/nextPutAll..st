streaming
nextPutAll: aString
  "conversion of smaller string is faster if not using the changeClassTo: trick"

  binary
    ifTrue: [ stream nextPutAll: aString asString ]
    ifFalse: [ 
      aString size > 8
        ifTrue: [ stream nextPutAll: (aString encodeAsUTF8 changeClassTo: String) ]
        ifFalse: [ 
          | str |
          str := aString encodeAsUTF8intoString.
          stream nextPutAll: str ] ]