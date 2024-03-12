## Interface web d'administration et génération automatique
   <magritteDescription>
   ^ MAStringDescription new
      accessor: #title;
      beRequired;
      yourself
   <magritteDescription>
   ^ MAMemoDescription new
      accessor: #text;
      beRequired;
      yourself
   <magritteDescription>
   ^ MAStringDescription new
      accessor: #category;
      yourself
   <magritteDescription>
   ^ MADateDescription new
      accessor: #date;
      beRequired;
      yourself
   <magritteDescription>
   ^ MABooleanDescription new
      accessor: #visible;
      beRequired;
      yourself
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
   | allBlogs |
   allBlogs := aBlog allBlogPosts.
   ^ self rows: allBlogs description: allBlogs anyOne magritteDescription
	instanceVariableNames: 'report'
	classVariableNames: ''
	package: 'TinyBlog-Components'
   ^ report
   report := aReport
   ^ super children copyWith: self report
   super initialize.
   self report: (TBPostsReport from: self blog)
   super renderContentOn: html.
   html tbsContainer: [
      html heading: 'Blog Admin'.
      html horizontalRule.
      html render: self report ]
	"Filter only some descriptions for the report columns."

	^ aBlogPost magritteDescription
		select: [ :each | #(title category date) includes: each accessor selector ]
   | allBlogs |
   allBlogs := aBlog allBlogPosts.
   ^ self rows: allBlogs description: (self filteredDescriptionsFrom: allBlogs anyOne)
   <magritteDescription>
   ^ MAStringDescription new
      label: 'Title';
      priority: 100;
      accessor: #title;
      beRequired;
      yourself
   <magritteDescription>
   ^ MAMemoDescription new
      label: 'Text';
      priority: 200;
      accessor: #text;
      beRequired;
      yourself
   <magritteDescription>
   ^ MAStringDescription new
      label: 'Category';
      priority: 300;
      accessor: #category;
      yourself
   <magritteDescription>
   ^ MADateDescription new
      label: 'Date';
      priority: 400;
      accessor: #date;
      beRequired;
      yourself
   <magritteDescription>
   ^ MABooleanDescription new
      label: 'Visible';
      priority: 500;
      accessor: #visible;
      beRequired;
      yourself
    instanceVariableNames: 'blog'
    classVariableNames: ''
    package: 'TinyBlog-Components'
   ^ blog
   blog := aTBBlog
    | report blogPosts |
    blogPosts := aBlog allBlogPosts.
    report := self rows: blogPosts description: (self filteredDescriptionsFrom: blogPosts anyOne).
    report blog: aBlog.
    report addColumn: (MACommandColumn new
        addCommandOn: report selector: #viewPost: text: 'View'; yourself;
        addCommandOn: report selector: #editPost: text: 'Edit'; yourself;
        addCommandOn: report selector: #deletePost: text: 'Delete'; yourself).
     ^ report
   html tbsGlyphIcon iconPencil.
   html anchor
      callback: [ self addPost ];
      with: 'Add post'.
   super renderContentOn: html
    ^ aPost asComponent
        addDecoration: (TBSMagritteFormDecoration buttons: { #save -> 'Add post' .  #cancel -> 'Cancel'});
        yourself
    | post |
    post := self call: (self renderAddPostForm: TBPost new).
    post ifNotNil: [ blog writeBlogPost: post ]
   ^ aPost asComponent 
       addDecoration: (TBSMagritteFormDecoration buttons: { #cancel -> 'Back' });
       readonly: true;
       yourself
   self call: (self renderViewPostForm: aPost)
   ^ aPost asComponent addDecoration: (
      TBSMagritteFormDecoration buttons: {
         #save -> 'Save post'.
         #cancel -> 'Cancel'});
      yourself
   | post |
   post := self call: (self renderEditPostForm: aPost).
   post ifNotNil: [ blog save ]
    posts remove: aPost ifAbsent: [ ].
    self save.
    self assert: blog size equals: 1.
    blog removeBlogPost: blog allBlogPosts anyOne.
    self assert: blog size equals: 0
    (self confirm: 'Do you want remove this post ?')
        ifTrue: [ blog removeBlogPost: aPost ]
    self rows: blog allBlogPosts.
    self refresh.
	| post |
	post := self call: (self renderAddPostForm: TBPost new).
	post
		ifNotNil: [ blog writeBlogPost: post.
			self refreshReport ]
    (self confirm: 'Do you want remove this post ?')
        ifTrue: [ blog removeBlogPost: aPost.
                 self refreshReport ]
    <magritteContainer>
    ^ super descriptionContainer
        componentRenderer: TBSMagritteFormRenderer;
        yourself
    <magritteDescription>
    ^ MAStringDescription new
        label: 'Title';
        priority: 100;
        accessor: #title;
        requiredErrorMessage: 'A blog post must have a title.';
        comment: 'Please enter a title';
        componentClass: TBSMagritteTextInputComponent;
        beRequired;
        yourself
    <magritteDescription>
    ^ MAMemoDescription new
        label: 'Text';
        priority: 200;
        accessor: #text;
        beRequired;
        requiredErrorMessage: 'A blog post must contain a text.';
        comment: 'Please enter a text';
        componentClass: TBSMagritteTextAreaComponent;
        yourself
    <magritteDescription>
    ^ MAStringDescription new
        label: 'Category';
        priority: 300;
        accessor: #category;
        comment: 'Unclassified if empty';
        componentClass: TBSMagritteTextInputComponent;
        yourself
    <magritteDescription>
    ^ MABooleanDescription new
        checkboxLabel: 'Visible';
        priority: 500;
        accessor: #visible;
        componentClass: TBSMagritteCheckboxComponent;
        beRequired;
        yourself