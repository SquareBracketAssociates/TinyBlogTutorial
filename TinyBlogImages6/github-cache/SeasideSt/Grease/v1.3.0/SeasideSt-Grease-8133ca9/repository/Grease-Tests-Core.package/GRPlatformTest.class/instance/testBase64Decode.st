tests
testBase64Decode
	| input |
	input := #(
		'YW55IGNhcm5hbCBwbGVhc3VyZS4='  'any carnal pleasure.'
		'YW55IGNhcm5hbCBwbGVhc3VyZQ==' 'any carnal pleasure'
		'YW55IGNhcm5hbCBwbGVhc3Vy' 'any carnal pleasur'
		'YW55IGNhcm5hbCBwbGVhc3U=' 'any carnal pleasu'
		'YW55IGNhcm5hbCBwbGVhcw==' 'any carnal pleas').
	1 to: input size by: 2 do: [ :index |
		| decoded expected |
		decoded := GRPlatform current base64Decode: (input at: index).
		expected := input at: index + 1.
		self assert: decoded = expected ]