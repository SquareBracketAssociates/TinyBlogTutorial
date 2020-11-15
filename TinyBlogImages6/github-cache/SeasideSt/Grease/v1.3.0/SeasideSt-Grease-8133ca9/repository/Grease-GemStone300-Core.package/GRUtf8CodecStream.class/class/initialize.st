initialization
initialize
  "self initialize"

  Latin1ToUtf8Encodings := Array new: 256.
  1 to: 256 do: [ :index | 
    index > 128
      ifTrue: [ 
        Latin1ToUtf8Encodings
          at: index
          put:
            (String with: (Character codePoint: index - 1)) encodeAsUTF8 asString ] ]
