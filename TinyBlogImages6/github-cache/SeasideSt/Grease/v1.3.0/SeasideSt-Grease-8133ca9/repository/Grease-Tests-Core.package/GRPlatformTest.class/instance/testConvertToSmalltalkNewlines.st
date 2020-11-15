tests
testConvertToSmalltalkNewlines
	| expected |
	expected := 'a' , GRPlatform current newline , 'b'.
	self assert: (GRPlatform current convertToSmalltalkNewlines: nil) isNil.
	self assert: (GRPlatform current convertToSmalltalkNewlines: '') = ''.
	self assert: (GRPlatform current convertToSmalltalkNewlines: 'abc') = 'abc'.
	self 
		assert: (GRPlatform current convertToSmalltalkNewlines: 'a' , (String with: Character cr with: Character lf) , 'b')
			= expected
		description: 'Multics, Unix and Unix-like systems (GNU/Linux, AIX, Xenix, Mac OS X, FreeBSD, etc.), BeOS, Amiga, RISC OS, and others'.
	self
		assert: (GRPlatform current convertToSmalltalkNewlines: 'a' , (String with: Character lf) , 'b')
			= expected
		description: 'DEC RT-11 and most other early non-Unix, non-IBM OSes, CP/M, MP/M, MS-DOS, OS/2, Microsoft Windows, Symbian OS'.
	self 
		assert: (GRPlatform current convertToSmalltalkNewlines: 'a' , (String with: Character cr) , 'b')
			= expected
		description: 'Commodore 8-bit machines, TRS-80, Apple II family, Mac OS up to version 9 and OS-9'