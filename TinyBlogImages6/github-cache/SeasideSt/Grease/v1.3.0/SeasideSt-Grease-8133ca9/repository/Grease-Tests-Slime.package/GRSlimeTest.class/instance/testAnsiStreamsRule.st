tests-transform
testAnsiStreamsRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'writeStream ^ '''' writeStream' in: class.
	self compile: 'writeCr | stream | stream := WriteStream on: ''''. stream cr. stream nextPut: Character cr' in: class.
	self compile: 'writeLf | stream | stream := WriteStream on: ''''. stream lf. stream nextPut: Character lf' in: class.
	self 
		runTransformation: GRAnsiStreamsRule
		changes: #( 
			'writeStream ^ WriteStream on: '''''
			'writeCr | stream | stream := WriteStream on: ''''. stream nextPut: Character cr. stream nextPut: Character cr'
			'writeLf | stream | stream := WriteStream on: ''''. stream nextPut: Character lf. stream nextPut: Character lf')