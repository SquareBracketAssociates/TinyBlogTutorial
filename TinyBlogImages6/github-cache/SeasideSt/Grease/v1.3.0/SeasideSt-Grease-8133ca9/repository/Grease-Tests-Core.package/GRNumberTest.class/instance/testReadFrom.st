tests
testReadFrom
	"We test #readFrom: as the expected behaviour on all platforms, as we rely on it for WANumberAttribute and WAQualifiedValue"
	
	self assert: (Number readFrom: '123' readStream) = 123.
	
	self assert: (Float readFrom: '123.45' readStream) = 123.45.
	
	self assert:   (Number readFrom: '123.45' readStream) = 123.45