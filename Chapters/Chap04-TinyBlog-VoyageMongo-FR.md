## Persistance des données de TinyBlog avec Voyage et Mongo
   "Indicates that instances of this class are top level documents in noSQL databases"
   ^ true
   VOMemoryRepository new enableSingleton
      self initializeVoyageOnMemoryDB
      self reset
   ^ self selectAll 
			ifNotEmpty: [ :x | x anyOne ]
			ifEmpty: [ self new save ]
	instanceVariableNames: ''
	"Write the blog post in database"
	self allBlogPosts add: aPost.
	self save
	posts := OrderedCollection new.
	self save.
	instanceVariableNames: 'blog post first previousRepository'
	classVariableNames: ''
	package: 'TinyBlog-Tests'
	previousRepository := VORepository current.
	VORepository setRepository: VOMemoryRepository new.
	blog := TBBlog current.
	first := TBPost title: 'A title' text: 'A text' category: 'First Category'.
	blog writeBlogPost: first.
	post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible
	VORepository setRepository: previousRepository
>1
   "Indicates that instances of this class are top level documents in noSQL databases"
   ^ true
   "Write the blog post in database"
   posts add: aPost.
   aPost save. 
   self save 
   posts do: [ :each | each remove ].
   posts := OrderedCollection new.
   self save.
	docker stop mongo
	
	# pour re-démarrer votre conteneur
	docker start mongo
	
	# pour détruire votre conteneur. Ce dernier doit être stoppé avant.
	docker rm mongo
   | repository |
   repository := VOMongoRepository database: 'tinyblog'.
   repository enableSingleton.
   self initializeLocalhostMongoDB
TBBlog createDemoPosts 
   host: 'localhost'
   database: 'tinyblog') dropDatabase