## Authentification et Session 
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
   super renderContentOn: html.
   html tbsContainer: [
      html heading: 'Blog Admin'.
      html horizontalRule ]
		html tbsNavbar beDefault; with: [  
			 html tbsContainer: [ 
				self renderBrandOn: html.	
				self renderButtonsOn: html
		]]
   self renderSimpleAdminButtonOn: html 
	html form: [ 
	   html tbsNavbarButton 
		   tbsPullRight;
		   with: [
            html tbsGlyphIcon iconListAlt.
            html text: ' Admin View' ]]
	instanceVariableNames: 'component'
	classVariableNames: ''
	package: 'TinyBlog-Components'
   component := anObject
	
TBHeaderComponent >> component
   ^ component
   ^ self new
		component: aComponent;
		yourself
	^ TBHeaderComponent from: self
	html form: [ 
	html tbsNavbarButton 
		tbsPullRight;
		callback: [ component goToAdministrationView ];
		with: [
				html tbsGlyphIcon iconListAlt.
				html text: ' Admin View' ]]
	self call: TBAdminComponent new
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'TinyBlog-Components'
   html form: [ self renderDisconnectButtonOn: html ]
   ^ TBAdminHeaderComponent from: self
   html tbsNavbarButton 
      tbsPullRight; 
      callback: [ component goToPostListView ];
      with: [  
         html text: 'Disconnect '.
         html tbsGlyphIcon iconLogout ]
	self answer
   instanceVariableNames: 'password account component'
   classVariableNames: ''
   package: 'TinyBlog-Components'
   ^ account
   account := anObject
   ^ password
   password := anObject
   ^ component
   component := anObject
   ^ self new
      component: aComponent;
      yourself
   html tbsModal
      id: 'myAuthDialog';
      with: [
         html tbsModalDialog: [
            html tbsModalContent: [
               self renderHeaderOn: html.
               self renderBodyOn: html ] ] ]
   html
      tbsModalHeader: [
         html tbsModalCloseIcon.
         html tbsModalTitle
            level: 4;
            with: 'Authentication' ]
    html
        tbsModalBody: [
            html tbsForm: [
                self renderAccountFieldOn: html.
                self renderPasswordFieldOn: html.
                html tbsModalFooter: [ self renderButtonsOn: html ] ] ]
   html
      tbsFormGroup: [ html label with: 'Account'.
         html textInput
            tbsFormControl;
            attributeAt: 'autofocus' put: 'true';
            callback: [ :value | account := value ];
            value: account ]
   html tbsFormGroup: [
      html label with: 'Password'.
      html passwordInput
         tbsFormControl;
         callback: [ :value | password := value ];
         value: password ]
   html tbsButton 
      attributeAt: 'type' put: 'button'; 
      attributeAt: 'data-dismiss' put: 'modal';
      beDefault;
      value: 'Cancel'.
   html tbsSubmitButton
      bePrimary;
      callback: [ self validate ];
      value: 'SignIn'
	^ component tryConnectionWithLogin: self account andPassword: self password
   self renderModalLoginButtonOn: html
   html render: (TBAuthentificationComponent from: component).
   html tbsNavbarButton
      tbsPullRight;
      attributeAt: 'data-target' put: '#myAuthDialog';
      attributeAt: 'data-toggle' put: 'modal';
      with: [
         html tbsGlyphIcon iconLock.
         html text: ' Login' ]
   (login = 'admin' and: [ password = 'topsecret' ])
         ifTrue: [ self goToAdministrationView ]
         ifFalse: [ self loginErrorOccurred ]
   instanceVariableNames: 'currentCategory showLoginError'
   classVariableNames: ''
   package: 'TinyBlog-Components'
	showLoginError := true
   ^ showLoginError ifNil: [ false ]
   ^ 'Incorrect login and/or password'
   html tbsColumn
      extraSmallSize: 12;
      smallSize: 10;
      mediumSize: 8;
      with: [ 
         self renderLoginErrorMessageIfAnyOn: html. 
         self basicRenderPostsOn: html ] 
   self hasLoginError ifTrue: [ 
      showLoginError := false.
      html tbsAlert 
         beDanger ;
         with: self loginErrorMessage
   ]
	instanceVariableNames: 'login password'
	classVariableNames: ''
	package: 'TinyBlog'
   ^ login
   login := anObject
   ^ password
   password := MD5 hashMessage: anObject
	^ self new 
			login: login;
			password: password;
			yourself	
	instanceVariableNames: 'adminUser posts'
	classVariableNames: ''
	package: 'TinyBlog'
   ^ adminUser
   ^ 'topsecret'
   ^ 'admin'
	^ TBAdministrator
			login: self class defaultAdminLogin
			password: self class defaultAdminPassword
   super initialize.
   posts := OrderedCollection new.
   adminUser := self createAdministrator
admin := TBBlog current administrator.
admin login: 'luke'.
admin password: 'thebrightside'.
TBBlog current save
   (login = self blog administrator login and: [ 
      (MD5 hashMessage: password) = self blog administrator password ])
         ifTrue: [ self goToAdministrationView ]
         ifFalse: [ self loginErrorOccurred ]
    instanceVariableNames: 'currentAdmin'
    classVariableNames: ''
    package: 'TinyBlog-Components'
    ^ currentAdmin
    currentAdmin := anObject
    ^ self currentAdmin notNil
      "self initialize"
      | app |
      app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
      app
         preferenceAt: #sessionClass put: TBSession.
      app
         addLibrary: JQDeploymentLibrary;
         addLibrary: JQUiDeploymentLibrary;
         addLibrary: TBSDeploymentLibrary
   (login = self blog administrator login and: [ 
      (MD5 hashMessage: password) = self blog administrator password ])
         ifTrue: [ 
            self session currentAdmin: self blog administrator.
            self goToAdministrationView ]
         ifFalse: [ self loginErrorOccurred ]
    self session isLogged
        ifTrue: [ self renderSimpleAdminButtonOn: html ]
		  ifFalse: [ self renderModalLoginButtonOn: html ]     
   currentAdmin := nil.
	self requestContext redirectTo: self application url.
	self unregister.
   html tbsNavbarButton 
      tbsPullRight; 
      callback: [ self session reset ];
      with: [  
         html text: 'Disconnect '.
         html tbsGlyphIcon iconLogout ]
	html form: [ 
		self renderDisconnectButtonOn: html.
		self renderPublicViewButtonOn: html ]
   self session isLogged ifTrue: [ 		 
      html tbsNavbarButton 
         tbsPullRight; 
         callback: [ component goToPostListView ];
         with: [  
            html tbsGlyphIcon iconEyeOpen.
            html text: ' Public View' ]]