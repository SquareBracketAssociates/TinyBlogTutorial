## Modèle de l'application TinyBlog
   instanceVariableNames: 'title text date category visible'
   classVariableNames: ''
   package: 'TinyBlog'
   ^ title
   title := aString
   ^ text
   text := aString
   ^ date
   date := aDate
   ^ visible
   visible := aBoolean
   ^ category
   category := anObject
   self visible: true
   self visible: false
   ^ 'Unclassified'
	super initialize.
	self category: TBPost unclassifiedTag.
	self date: Date today.
	self notVisible
   ^ self new
        title: aTitle;
        text: aText;
        yourself
   ^ (self title: aTitle text: aText)
            category: aCategory;
            yourself
	title: 'Welcome in TinyBlog'
	text: 'TinyBlog is a small blog engine made with Pharo.'
	category: 'TinyBlog'
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'TinyBlog-Tests'

	| post |
	post := TBPost
		title: 'Welcome to TinyBlog'
		text: 'TinyBlog is a small blog engine made with Pharo.'.
	self assert: post title equals: 'Welcome to TinyBlog' .
	self assert: post category = TBPost unclassifiedTag.

		| post |
		post := TBPost
			title: 'Welcome to TinyBlog'
			text: 'TinyBlog is a small blog engine made with Pharo.'
			category: 'TinyBlog'.
		self assert: post title equals: 'Welcome to TinyBlog' .
		self assert: post text equals: 'TinyBlog is a small blog engine made with Pharo.' .
   ^ self visible
   ^ self category = TBPost unclassifiedTag

	| post |
	post := TBPost
		title: 'Welcome to TinyBlog'
		text: 'TinyBlog is a small blog engine made with Pharo.'.
	self assert: post title equals: 'Welcome to TinyBlog' .
	self assert: post isUnclassified.
	self deny: post isVisible