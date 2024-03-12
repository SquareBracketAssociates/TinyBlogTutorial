## TinyBlog : extension du modèle et tests unitaires
   instanceVariableNames: 'posts'
   classVariableNames: ''
   package: 'TinyBlog'
   super initialize.
   posts := OrderedCollection new. 
   instanceVariableNames: 'uniqueInstance'
   uniqueInstance := nil
   "Answer the instance of the class"
   ^ uniqueInstance ifNil: [ uniqueInstance := self new ]
   self reset
   instanceVariableNames: 'blog post first'
   classVariableNames: ''
   package: 'TinyBlog-Tests'
   blog := TBBlog current.
   blog removeAllPosts.

   first := TBPost title: 'A title' text: 'A text' category: 'First Category'.
   blog writeBlogPost: first.

   post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible
   TBBlog reset
   blog writeBlogPost: post.
   self assert: blog size equals: 2
   posts := OrderedCollection new
   "Add the blog post to the list of posts."
   posts add: aPost
   ^ posts size
   self assert: blog size equals: 1
   blog removeAllPosts.
   self assert: blog size equals: 0
   blog writeBlogPost: post.
   self assert: blog allBlogPosts size equals: 2
   ^ posts
   blog writeBlogPost: post.
   self assert: blog allVisibleBlogPosts size equals: 1
   ^ posts select: [ :p | p isVisible ]
   self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
   ^ posts select: [ :p | p category = aCategory ]
   blog writeBlogPost: post.
   self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0.
   self assert: (blog allVisibleBlogPostsFromCategory: 'Second Category') size equals: 1
	^ posts select: [ :p | p category = aCategory 
									and: [ p isVisible ] ]
   self assert: (blog allBlogPosts select: [ :p | p isUnclassified ]) size equals: 0
   blog writeBlogPost: post.
   self assert: blog allCategories size equals: 2
   ^ (self allBlogPosts collect: [ :p | p category ]) asSet
   "TBBlog createDemoPosts"
   self current 
      writeBlogPost: ((TBPost title: 'Welcome in TinyBlog' text: 'TinyBlog is a small blog engine made with Pharo.' category: 'TinyBlog') visible: true);
      writeBlogPost: ((TBPost title: 'Report Pharo Sprint' text: 'Friday, June 12 there was a Pharo sprint / Moose dojo. It was a nice event with more than 15 motivated sprinters. With the help of candies, cakes and chocolate, huge work has been done' category: 'Pharo') visible: true);
      writeBlogPost: ((TBPost title: 'Brick on top of Bloc - Preview' text: 'We are happy to announce the first preview version of Brick, a new widget set created from scratch on top of Bloc. Brick is being developed primarily by Alex Syrel (together with Alain Plantec, Andrei Chis and myself), and the work is sponsored by ESUG. 
      Brick is part of the Glamorous Toolkit effort and will provide the basis for the new versions of the development tools.' category: 'Pharo') visible: true);
      writeBlogPost: ((TBPost title: 'The sad story of unclassified blog posts' text: 'So sad that I can read this.') visible: true);
      writeBlogPost: ((TBPost title: 'Working with Pharo on the Raspberry Pi' text: 'Hardware is getting cheaper and many new small devices like the famous Raspberry Pi provide new computation power that was one once only available on regular desktop computers.' category: 'Pharo') visible: true)