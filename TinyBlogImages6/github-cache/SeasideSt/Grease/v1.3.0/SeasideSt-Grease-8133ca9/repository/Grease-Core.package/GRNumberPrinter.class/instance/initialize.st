initialization
initialize
	super initialize.
	self lowercase.
	self base: 10.
	self delimiter: $..
	self infinite: 'Infinite'.
	self nan: 'NaN'.
	self padding: $ .
	self precision: 0