## Exportation de données
   html paragraph class: 'title'; with: self title.
   html paragraph class: 'subtitle'; with: self date.
   html paragraph class: 'content'; with: self text.
   html div 
      with: [ 
         html anchor
         callback: [ self exportPostAsPdf ];
         with: [
			   html tbsGlyphIcon iconSave.
			   html text: 'pdf' ] ].
   | pdfStream |
   pdfStream := TBPostPDFExport post: post.
   self requestContext respond: [:response | 
      response 
   	   contentType: 'application/pdf; charset=UTF-8';
   	   attachmentWithFileName: post title, '.pdf';
   	   binary;
   	   nextPutAll: pdfStream contents ]
	instanceVariableNames: 'post pdfdoc'
	classVariableNames: ''
	category: 'TinyBlog-Export'

TBPostPDFExport >> post
	^ post

TBPostPDFExport >> post: aPost
    post := aPost       
	^ self new
		post: aPost;
		exportPdf   
	| pdfStream |
	pdfStream := MultiByteBinaryOrTextStream on: String new.
	self renderPostAsPdfInto: pdfStream.
	^ pdfStream reset
   | aPage titleFont titleColor layout pharoLogo metaDataColor defaultFont | 
   pharoLogo := Morph new 
      extent: PolymorphSystemSettings pharoLogo extent;
      color: Color white;
      addMorph: PolymorphSystemSettings pharoLogo.
   
   pdfdoc := PDFDocument new.
   
   titleColor := PDFColor r: 13 g: 100 b: 175.
   titleFont := PDFHelveticaFont new
      fontSize: 22 pt;
      bold: true.
   
   metaDataColor := PDFColor greyLevel: 0.3.
   
   defaultFont := PDFHelveticaFont new
      fontSize: 12 pt ; yourself.
   
   aPage := PDFPage new.
   aPage add: ((PDFPngElement fromMorph: pharoLogo)
      from: 10 mm @ 20 mm;
      dimension: 80mm @ 27mm).
   
   layout := PDFVerticalLayout on: {
      (PDFFormattedTextElement new
         font: titleFont;
         textColor: titleColor;
         text: post title).
      
      (PDFFormattedTextElement new
         textColor: metaDataColor;
         text: post date asString).
      
      (PDFParagraphElement new
         dimension: 150 mm @ 35 mm;
         font: defaultFont;
         text: post text ) }.
      		
   layout from: 25 mm @ 80 mm.
   layout spacing: 1 cm.
   aPage add: layout.
   pdfdoc add: aPage.
   pdfdoc exportTo: aStream
	html tbsGlyphIcon perform: #iconPencil.
   	html anchor
   		callback: [ self addPost ];
      	with: 'Add post'.
	
	super renderContentOn: html.
	
	html tbsGlyphIcon perform: #iconCloudDownload.
   	html anchor
   		callback: [ self exportToCSV ];
      	with: 'Export to CSV'. 	
	html tbsGlyphIcon perform: #iconPencil.
	html anchor
		callback: [ self addPost ];
		with: 'Add post'

TBPostsReport>>renderExportToCSVAnchor: html
	html tbsGlyphIcon perform: #iconCloudDownload.
	html anchor
		callback: [ self exportToCSV ];
		with: 'Export to CSV'

TBPostsReport>>renderContentOn: html
	self renderAddPostAnchor: html.
	super renderContentOn: html.
	self renderExportToCSVAnchor: html		
	TBPostsCSVExport context: self requestContext blog: self blog	
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Export'

TBPostsCSVExport class >> context: anHTTPContext blog: aBlog
	^ self new
		sendPostsToCSVFrom: aBlog to: anHTTPContext 
		yourself	
	| outputStream |
	
	outputStream := (MultiByteBinaryOrTextStream on: (OrderedCollection new)) binary.
		(NeoCSVWriter on: stream)
			nextPut: #('Title' 'Date' 'Content');
			addObjectFields: { 
				[ :post | post title ].
				[ :post | post date ].
				[ :post | post text ] }; 
			nextPutAll: (aBlog allBlogPosts)
	]).
		response 
			contentType: 'text/csv; charset=UTF-8';
			attachmentWithFileName: 'posts.xml';
			binary;
			nextPutAll: (outputStream reset contents)
	]
	html tbsGlyphIcon perform: #iconCloudDownload.
	html anchor
		callback: [ self exportToXML ];
		with: 'Export to XML'

TBPostsReport >> renderContentOn: html
	self renderAddPostAnchor: html.
	super renderContentOn: html.
	self renderExportToCSVAnchor: html.
	self renderExportToXMLAnchor: html
	self renderExportToCSVAnchor: html.
	html text: ' '.
	self renderExportToXMLAnchor: html

TBPostsReport >> renderContentOn: html
	self renderAddPostAnchor: html.
	super renderContentOn: html.
	self renderExportOptionsOn: html	
	TBPostsXMLExport context: self requestContext blog: self blog
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Export'

TBPostsXMLExport class >> context: anHTTPContext blog: aBlog
	^ self new
		sendPostsToXMLFrom: aBlog to: anHTTPContext 
		yourself	
	| xml |

	xml := XMLWriter new enablePrettyPrinting.
		writer xml.
		writer tag 
			name: 'posts';
			xmlnsAt: 'TinyBlog' put: 'www.pharo.org/tinyblog';
			with: [  
				aBlog allBlogPosts do: [ :post | 
					writer tag: 'post' with: [
						writer tag: 'title' with: post title.
						writer tag: 'date' with: (post date yyyymmdd).
						writer tag: 'text' with: [ writer cdata: post text ].
					] 
				]
			]
	].
	response 
		contentType: 'application/xml; charset=UTF-8';
		attachmentWithFileName: 'posts.xml';
		nextPutAll: (xml contents)
	]	