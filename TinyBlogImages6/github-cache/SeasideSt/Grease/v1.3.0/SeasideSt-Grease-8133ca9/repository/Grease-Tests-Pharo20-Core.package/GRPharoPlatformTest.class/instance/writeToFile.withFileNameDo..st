private
writeToFile: aStringOrByteArray withFileNameDo: aBlock
	| fileName directory |
	fileName :=  'GRPharoPlatformTest'.
	directory := FileSystem disk workingDirectory.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory fullName.
	aBlock value: directory fullName,GRPlatform current pathSeparator,fileName
		] ensure: [
			(directory / fileName) delete ]