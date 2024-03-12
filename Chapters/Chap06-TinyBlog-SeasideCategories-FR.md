## Gestion des catégories
	self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
   instanceVariableNames: 'categories postsList'
   classVariableNames: ''
   package: 'TinyBlog-Components'
   ^ categories
   categories := aCollection asSortedCollection
      postsList := aComponent
   ^ postsList
   ^ self new categories: categories; postsList: aTBScreen 
   instanceVariableNames: 'currentCategory'
   classVariableNames: ''
   package: 'TinyBlog-Components'
   ^ currentCategory
   currentCategory := anObject
   postsList currentCategory: aCategory
   html tbsLinkifyListGroupItem
      callback: [ self selectCategory: aCategory ];
      with: aCategory
   html tbsListGroup: [
      html tbsListGroupItem
         with: [  html strong: 'Categories' ].
      categories do: [ :cat | 
         self renderCategoryLinkOn: html with: cat ] ]
   ^ self currentCategory
      ifNil: [ self blog allVisibleBlogPosts ]
      ifNotNil: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]
   super renderContentOn: html.
   html render: (TBCategoriesComponent
               categories: (self blog allCategories)
               postsList: self).
   html tbsContainer: [ 
      self readSelectedPosts do: [ :p |
         html render: (TBPostComponent new post: p) ] ]
   super renderContentOn: html.
   html tbsContainer: [
      html tbsRow showGrid;
         with: [
            html tbsColumn
               extraSmallSize: 12;
               smallSize: 2;
               mediumSize:  4;
               with: [
                  html render: (TBCategoriesComponent
                    categories: (self blog allCategories)
                    postsList: self) ].
      html tbsColumn
               extraSmallSize: 12;
               smallSize: 10;
               mediumSize: 8;
               with: [
         self readSelectedPosts do: [ :p |
             html render: (TBPostComponent new post: p) ] ] ] ]
   html tbsLinkifyListGroupItem
      class: 'active' if: aCategory = self postsList currentCategory;
      callback: [ self selectCategory: aCategory ]; 
      with: aCategory
	^ TBCategoriesComponent 
			categories: self blog allCategories 
			postsList: self
	^ TBPostComponent new post: aPost
	super renderContentOn: html.
	html
		tbsContainer: [ html tbsRow
				showGrid;
				with: [ 
					html tbsColumn
						extraSmallSize: 12;
						smallSize: 2;
						mediumSize: 4;
						with: [ html render: self categoriesComponent ].
					html tbsColumn
						extraSmallSize: 12;
						smallSize: 10;
						mediumSize: 8;
						with: [ self readSelectedPosts
								do: [ :p | html render: (self postComponentFor: p) ] ] ] ]
	html render: self categoriesComponent 
	self readSelectedPosts do: [ :p | 
		html render: (self postComponentFor: p) ]
   super renderContentOn: html.
   html
      tbsContainer: [ 
         html tbsRow
            showGrid;
            with: [ self renderCategoryColumnOn: html.
                  self renderPostColumnOn: html ] ]
   html tbsColumn
      extraSmallSize: 12;
      smallSize: 2;
      mediumSize: 4;
      with: [ self basicRenderCategoriesOn: html ]
   html tbsColumn
         extraSmallSize: 12;
         smallSize: 10;
         mediumSize: 8;
         with: [ self basicRenderPostsOn: html ] 