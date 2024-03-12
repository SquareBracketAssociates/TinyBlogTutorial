## Utiliser des modèles de mise en page avec Mustache
 	html div class: 'footer'; with: [
		html text: 'I''am the footer!'
	]

TBPostListComponent >> renderContentOn: html
	super renderContentOn: html.
	html render: (TBAuthentificationComponent from: self).
	html
		tbsContainer: [ 
			html tbsRow
				showGrid;
				with: [ 
					self renderCategoryColumnOn: html.
					self renderPostColumnOn: html
			]. 
			self renderFooterOn: html 		
		]
	| styles |
	styles := CascadingStyleSheetBuilder new.
	self 
		applyTitleStyleOn: styles;
		applyParagraphSubtitleStyleOn: styles;
		applyParagraphContentStyleOn: styles;
		applyFooterStyleOn: styles.
	^styles build asString
	^aSheet declareRuleSetFor: [ :selector | selector div class: 'footer' ]
			with: [ :style | self footerStyleOn: style ]
	aStyle
		position: CssConstants absolute;
		bottom: 0 pixels;
		paddingTop: 25 pixels;
		height: 150 pixels;
		width: 100 percent;
		backgroundColor: (CssRGBColor red: 239 green: 239 blue: 239);	
		textAlign: CssConstants center;
		yourself
	html text: ('Powered by {{language}}, {{framework}} and {{tool}}.' asMustacheTemplate value: { 
		'language' -> 'Pharo'. 
		'framework' -> 'Seaside'.
		'tool' -> 'Bootstrap'
	} asDictionary)
 	html div class: 'footer'; with: [
		self renderPoweredByOn: html.
	]
	html text: ('The date today is {{today}}.' asMustacheTemplate value: { 'today' -> [ Date today ] } asDictionary)
 	html div class: 'footer'; with: [
		self renderDateTodayOn: html.
		html break.
		self renderPoweredByOn: html.
	]