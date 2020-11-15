private
writeToFile: aStringOrByteArray
	| fileName directory |
	fileName :=  'GRPharoPlatformTest'.
	directory := FileDirectory default.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory pathName
		] ensure: [
			directory deleteFileNamed: fileName ]