tests
testReadWriteToFileInFolderText
	| text |
	text := 'Ph''nglui mglw''nafh Cthulhu R''lyeh wgah''nagl fhtagn'.
	self 
		writeToFile: text 
		withFileNameDo:[ :fileName |
			self assert: (text = (GRPlatform current contentsOfFile: fileName binary: false)) ] 