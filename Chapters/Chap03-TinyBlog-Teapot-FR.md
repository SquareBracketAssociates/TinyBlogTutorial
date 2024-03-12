## Construire une interface Web avec Teapot pour TinyBlog
    instanceVariableNames: 'teapot'
    classVariableNames: 'Server'
    package: 'TinyBlog-Teapot'
    super initialize.
    teapot := Teapot configure: {
       #port -> 8081. 
       #debugMode -> true }.
    ^ '<html><body><h1>TinyBlog Web App</h1></body></html>'
    "a get / is now returning an html welcome page"
    teapot
        GET: '/' -> [ self homePage ];
        start
    teapot stop
    Server ifNil: [ Server := self new start ]    
    Server ifNotNil: [ Server stop. Server := nil ]
   ^ TBBlog current allVisibleBlogPosts 
    ^ String streamContents: [ :s | 
            self renderPageHeaderOn: s.
            s << '<h1>TinyBlog Web App</h1>'.
            s << '<ul>'.
            self allPosts do: [ :aPost |
                s << ('<li>', aPost title, '</li>') ].
            s << '</ul>'.
            self renderPageFooterOn: s.
        ]
    aStream << '<html><body>' 
    aStream << '</body></html>' 
    ^ String streamContents: [ :s | 
        self renderPageHeaderOn: s. 
        s << '<p>Oups, an error occurred</p>'.
        self renderPageFooterOn: s.
        ]
    teapot
       GET: '/' -> [ self homePage ];
       GET: '/post/<id>' -> [ :request | self pageForPostNumber: (request at: #id) asNumber ];
       start
    |currentPost|
    currentPost := self allPosts at: aPostNumber ifAbsent: [ ^ self errorPage ].
    ^ String streamContents: [ :s | 
        self renderPageHeaderOn: s. 
        s << ('<h1>', currentPost title, '</h1>').
        s << ('<h3>', currentPost date mmddyyyy, '</h3>').
        s << ('<p> Category: ', currentPost category, '</p>').
        s << ('<p>', currentPost text, '</p>').
        self renderPageFooterOn: s.
        ]
    ^ String streamContents: [ :s | 
         self renderPageHeaderOn: s.
         s << '<h1>TinyBlog Web App</h1>'.
         s << '<ul>'.
         self allPosts withIndexDo: [ :aPost :index |
              s << '<li>';
                << ('<a href="/post/', index asString, '">');
                << aPost title ;
                << '</a></li>' ].
            s << '</ul>'.
            self renderPageFooterOn: s
        ]