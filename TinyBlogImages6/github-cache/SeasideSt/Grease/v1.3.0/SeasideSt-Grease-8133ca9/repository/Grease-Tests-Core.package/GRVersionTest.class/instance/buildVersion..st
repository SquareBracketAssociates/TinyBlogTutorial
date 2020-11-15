private
buildVersion: anArray
	^ (GRVersion
		major: (anArray at: 1 ifAbsent: [ nil ])
		minor: (anArray at: 2 ifAbsent: [ nil ])
		revision: (anArray at: 3 ifAbsent: [ nil ]))
			stage: (anArray at: 4 ifAbsent: [ nil ]) number: (anArray at: 5 ifAbsent: [ nil ]);
			yourself