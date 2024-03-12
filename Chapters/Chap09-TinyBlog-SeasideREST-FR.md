## Une interface REST pour TinyBlog
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'TinyBlog-REST'
	   "self initialize"
	   | app |
	   app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
		app
			preferenceAt: #sessionClass put: TBSession.
	   app
	      addLibrary: JQDeploymentLibrary;
	      addLibrary: JQUiDeploymentLibrary;
	      addLibrary: TBSDeploymentLibrary.
		
		app addFilter: TBRestfulFilter new.
	<get>
	<produces: 'application/json'>
	<get>
	<path: '/posts'>
	<produces: 'application/json'>
	<get>
	<path: '/posts'>
	<produces: 'application/json'>

	TBRestServiceListAll new applyServiceWithContext: self requestContext
	instanceVariableNames: 'result context'
	classVariableNames: ''
	category: 'TinyBlog-Rest'	
	^ context
	context := anObject
	super initialize.
	result := TBRestResponseContent new.	
	self context: aRequestContext.
	self execute.
	self subclassResponsibility
	self context response contentType: aDataType greaseString.
	self context respond: [ :response | response nextPutAll: aResultSet ]
	instanceVariableNames: 'data'
	classVariableNames: ''
	category: 'TinyBlog-Rest'
	super initialize.
	data := OrderedCollection new.
	data add: aValue	
	^String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
		for: Date
		customDo: [ :mapping | mapping encoder: [ :value | value asDateAndTime printString ] ];
		nextPut: data ]	
	TBBlog current allBlogPosts do: [ :each | result add: (each asDictionary) ].
	self dataType: (WAMimeType applicationJson) with: (result toJson)	
	| result |
	result := self allVisibleBlogPosts select: [ :post | post title = aTitle ].
	result ifNotEmpty: [ ^result first ] ifEmpty: [ ^nil ]
	<get>
	<path: '/posts/search?title={aTitle}'>
	<produces: 'application/json'>
	instanceVariableNames: 'title'
	classVariableNames: ''
	category: 'TinyBlog-Rest'
	^ title
	title := anObject
	| post |

	post := TBBlog current postWithTitle: title urlDecoded.
	
	post 
		ifNotNil: [ result add: (post asDictionary) ] 
		ifNil: [ self context response notFound ].
	self dataType: (WAMimeType applicationJson) with: result toJson
	<get>
	<path: '/posts/search?title={aTitle}'>
	<produces: 'application/json'>

	TBRestServiceSearch new
		title: aTitle;
		applyServiceWithContext: self requestContext	
	<get>
	<path: '/posts/search?begin={beginString}&end={endString}'>
	<produces: 'application/json'>
	instanceVariableNames: 'from to'
	classVariableNames: ''
	package: 'TinyBlog-Rest'
	^from
	from := anObject
	^to
	to := anObject	
	| posts dateFrom dateTo |
		
	dateFrom := Date fromString: self from.
	dateTo := Date fromString: self to.

	posts := TBBlog current allBlogPosts
		select: [  :each | each date between: dateFrom and: dateTo ].
	
	posts do: [ :each | result add: (each asDictionary) ].
	self dataType: (WAMimeType applicationJson) with: result toJson	
	<get>
	<path: '/posts/search?begin={beginString}&end={endString}'>
	<produces: 'application/json'>
	
	TBRestServiceSearchDate new
		from: beginString;
		to: endString;
		applyServiceWithContext: self requestContext
	<post>
	<consumes: '*/json'>
	<path: '/posts'>
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Rest'
	| post |

	[ 
		post := NeoJSONReader fromString: (self context request rawBody).
		TBBlog current writeBlogPost: (TBPost title: (post at: #title) text: (post at: #text) category: (post at: #category)). 
	] on: Error do: [ self context request badRequest ].

	self dataType: (WAMimeType textPlain) with: ''	
	<post>
	<consumes: '*/json'>
	<path: '/posts'>
	
	TBRestServiceAddPost new
		applyServiceWithContext: self requestContext	