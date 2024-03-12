## Des composants web pour TinyBlog
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
   "Return the current blog. In the future we will ask the
   session to return the blog of the currently logged in user."
   ^ TBBlog current
   html text: 'Hello from TBScreenComponent'
	instanceVariableNames: 'main'
	classVariableNames: ''
	package: 'TinyBlog-Components'
   super initialize.
   main := TBScreenComponent new
   html render: main
   ^ { main }
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
   instanceVariableNames: 'header'
   classVariableNames: ''
   package: 'TinyBlog-Components'
   super initialize.
   header := self createHeaderComponent
   ^ TBHeaderComponent new
   ^ { header }
   html render: header
	html tbsNavbar beDefault; with: [  
		 html tbsContainer: [ 
			self renderBrandOn: html
	]]
   html tbsNavbarHeader: [ 
      html tbsNavbarBrand
         url: self application url;
         with: 'TinyBlog' ]
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
   super initialize.
   main := TBPostsListComponent new 
   main := aComponent
   super renderContentOn: html.
   html text: 'Blog Posts here !!!'
   instanceVariableNames: 'post'
   classVariableNames: ''
   package: 'TinyBlog-Components'
      super initialize.
      post := TBPost new
   ^ post title
   ^ post text
   ^ post date
   html heading level: 2; with: self title.
   html heading level: 6; with: self date.
   html text: self text
   "DON'T WRITE THIS YET"
   html render: post asComponent
   super renderContentOn: html.
   self blog allVisibleBlogPosts do: [ :p |
      html render: (TBPostComponent new post: p) ]
    exceptionHandler: WADebugErrorHandler
   post := aPost
   super renderContentOn: html.
   html tbsContainer: [ 
      self blog allVisibleBlogPosts do: [ :p |
          html render: (TBPostComponent new post: p) ] ]
	super initialize.
	postComponents := OrderedCollection new
	postComponents := self readSelectedPosts
			collect: [ :each | TBPostComponent new post: each ].
	^ postComponents 
	^ self postComponents, super children
	super renderContentOn: html.
	html tbsContainer: [ 
		self postComponents do: [ :p |
				html render: p ] ]