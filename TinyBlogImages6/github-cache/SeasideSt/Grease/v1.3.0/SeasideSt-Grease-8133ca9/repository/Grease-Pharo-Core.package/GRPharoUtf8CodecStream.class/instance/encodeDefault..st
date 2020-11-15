private
encodeDefault: aString
	"Convert the given string from UTF-8 using the fast path if converting to Latin-1"
	1 to: aString size by: 1 do: [ :index |
		converter nextPut: (aString at: index) toStream: stream ]