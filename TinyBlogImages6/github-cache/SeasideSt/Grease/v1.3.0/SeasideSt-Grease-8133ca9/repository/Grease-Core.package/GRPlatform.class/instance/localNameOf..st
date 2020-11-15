file library
localNameOf: aFilename
	"Answer the local name of a file identified by an absolute file path.
	
	Eg.
	If the platform is Windwos and aFilename is 'C:\Windows\win32.dll' then it would answer 'win32.dll'.
	If the platform is Unix and aFilename is '/usr/bin/vim' then it would answer 'vim'."
	self subclassResponsibility