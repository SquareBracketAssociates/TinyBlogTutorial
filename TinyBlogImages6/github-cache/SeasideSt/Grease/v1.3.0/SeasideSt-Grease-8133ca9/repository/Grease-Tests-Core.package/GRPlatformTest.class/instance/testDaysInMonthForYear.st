tests
testDaysInMonthForYear
	(1 to: 12) with: #(31 28 31 30 31 30 31 31 30 31 30 31) do: [ :month :days |
		self assert: days = (Date daysInMonth: (Date nameOfMonth: month) forYear: 2007) ]