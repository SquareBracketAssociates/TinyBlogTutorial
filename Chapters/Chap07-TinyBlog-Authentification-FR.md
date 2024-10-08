## Authentification et Session 


Le scénario assez classique que nous allons développer dans ce chapitre est le suivant : l'utilisateur doit s'authentifier pour accéder à la partie administration de TinyBlog. Il le fait à l'aide d'un compte et d'un mot de passe. 

La figure *@ApplicationArchitectureAdminHeader@* montre un aperçu de l'architecture visée dans ce chapitre.

![Gérant l'authentification pour accéder à l'administration.](figures/ApplicationArchitectureAdminHeader.pdf width=75&label=ApplicationArchitectureAdminHeader)

Nous commençons par mettre en place une première version permettant de naviguer entre la partie publique TinyBlog rendue par le composant
gérant la liste des bulletins (`TBPostsListComponent`) et une première version de la partie d'administration du site comme sur la figure *@SimpleAdminLink@*.
Cela va nous permettre d'illustrer l'invocation de composant.

Nous intègrerons ensuite un composant d'identification sous la forme d'une boîte modale.
Cela va nous permettre d'illustrer comment la saisie de champs utilise de manière élégante les variables d'instances d'un composant.

Enfin, nous montrerons aussi comment stocker l'utilisateur connecté dans la session courante.

### Composant d'administration simple (v1)


Définissons un composant d'administration très simple. Ce composant hérite de la classe `TBScreenComponent` comme mentionné dans un chapitre précédent et illustré dans la figure *@ApplicationArchitectureAdminHeader@*.

```
TBScreenComponent subclass: #TBAdminComponent
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


Nous définissons une première version de la méthode de rendu afin de pourvoir tester.

```
TBAdminComponent >> renderContentOn: html
   super renderContentOn: html.
   html tbsContainer: [
      html heading: 'Blog Admin'.
      html horizontalRule ]
```


### Ajout d'un bouton 'admin'


Ajoutons maintenant un bouton dans l'en-tête du site (composant `TBHeaderComponent`) afin d'accéder à la partie administration du site comme sur la figure *@SimpleAdminLink@*.
Pour cela, modifions les composants existants: `TBHeaderComponent` (en-tête) et `TBPostsListComponent` (partie publique).

![Lien simple vers la partie administration.](figures/SimpleAdminLink.png width=100&label=SimpleAdminLink)

Commençons par ajouter le bouton 'admin' dans l'en-tête :

```
TBHeaderComponent >> renderContentOn: html	
		html tbsNavbar beDefault; with: [  
			 html tbsContainer: [ 
				self renderBrandOn: html.	
				self renderButtonsOn: html
		]]
```


```
TBHeaderComponent >> renderButtonsOn: html
   self renderSimpleAdminButtonOn: html 
```


```
TBHeaderComponent >> renderSimpleAdminButtonOn: html
	html form: [ 
	   html tbsNavbarButton 
		   tbsPullRight;
		   with: [
            html tbsGlyphIcon iconListAlt.
            html text: ' Admin View' ]]
```


Si vous rafraichissez votre navigateur, le bouton admin est bien présent mais il n'a aucun effet pour l'instant (voir la figure *@withAdminView1@*).
Il faut définir un `callback:` sur ce bouton (un bloc) qui remplace le composant courant (`TBPostsListComponent`) par le composant d'administration (`TBAdminComponent`).

![Barre de navigation avec un button admin.](figures/withAdminView1.png width=80&label=withAdminView1)

### Revisons la barre de navigation


Commençons par réviser la définition de `TBHeaderComponent` en lui ajoutant une variable d'instance `component` pour stocker et accéder au composant courant (qui sera soit la liste de bulletins, soit le composant d'administration). Ceci va nous permettre de pouvoir accéder au composant depuis la barre de navigation :

```
WAComponent subclass: #TBHeaderComponent
	instanceVariableNames: 'component'
	classVariableNames: ''
	package: 'TinyBlog-Components'
```


```
TBHeaderComponent >> component: anObject
   component := anObject
	
TBHeaderComponent >> component
   ^ component
```


Nous ajoutons une méthode de classe.
```
TBHeaderComponent class >> from: aComponent
   ^ self new
		component: aComponent;
		yourself
```



### Activation du bouton d'admin

Modifions l'instanciation du composant en-tête définie dans la méthode du component `TBScreenComponent` afin de passer le composant qui sera sous la barre de navigation à celle-ci :

```
TBScreenComponent >> createHeaderComponent
	^ TBHeaderComponent from: self
```


Notez que la méthode `createHeaderComponent` est bien définie dans la superclasse
`TBScreenComponent` car elle est applicable pour toutes ses sous-classes.

Nous pouvons maintenant ajouter le callback (message `callback:`) sur le bouton :

```
TBHeaderComponent >> renderSimpleAdminButtonOn: html
	html form: [ 
	html tbsNavbarButton 
		tbsPullRight;
		callback: [ component goToAdministrationView ];
		with: [
				html tbsGlyphIcon iconListAlt.
				html text: ' Admin View' ]]
```


Il ne reste plus qu'à définir la méthode `goToAdministrationView` sur le composant `TBPostsListComponent` dans le protocole 'actions' :

```
TBPostsListComponent >> goToAdministrationView
	self call: TBAdminComponent new
```


Avant de cliquer sur le bouton 'Admin' dans votre navigateur, vous devez cliquer sur 'New Session' afin de recréer le composant `TBHeaderComponent`. 
Vous devez obtenir la situation présentée dans la figure *@withAdminCom@*.
Le bouton 'Admin' permet maintenant de voir la partie administraion v1 s'afficher.
Attention à ne cliquer qu'une seule fois car ce bouton 'Admin' est toujours présent dans la partie administration bien qu'il ne soit pas fonctionnel.
Nous allons le remplacer par un bouton 'Disconnect'.

![Affichage du composant admin en cours de définition.](figures/WithAdminComp.png width=80&label=withAdminCom)


### Ajout d'un bouton 'disconnect'


Lorsqu'on affiche la partie administration, nous allons remplacer le composant en-tête par un autre.
Cette nouvelle en-tête affichera un bouton 'Disconnect'.

Définissons un nouveau composant en-tête:
```
TBHeaderComponent subclass: #TBAdminHeaderComponent
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'TinyBlog-Components'
```


```
TBAdminHeaderComponent >> renderButtonsOn: html
   html form: [ self renderDisconnectButtonOn: html ]
```


Indiquons au composant `TBAdminComponent` d'utiliser cette en–tête :

```
TBAdminComponent >> createHeaderComponent
   ^ TBAdminHeaderComponent from: self
```


Maintenant nous pouvons spécialiser notre nouvelle barre de navigation dédiée à l'administration pour afficher un bouton de déconnexion.

```
TBAdminHeaderComponent >> renderDisconnectButtonOn: html
   html tbsNavbarButton 
      tbsPullRight; 
      callback: [ component goToPostListView ];
      with: [  
         html text: 'Disconnect '.
         html tbsGlyphIcon iconLogout ]
```


```
TBAdminComponent >> goToPostListView
	self answer
```


Le message `answer` donne le contrôle au component qui l'a invoqué. Ici nous retournons donc à la liste de bulletins. 

Cliquez sur 'New Session' en bas à gauche de votre navigateur et ensuite sur le bouton 'Admin', vous devez maintenant voir la partie administration v1 s'afficher avec un bouton 'Disconnect' permettant de revenir à la partie publique comme sur la figure *@SimpleAdminLink@*.


#### Notion call:/answer:


Si vous étudiez le code précédent, vous verrez que nous avons utilisé le mécanisme `call:`/`answer:` de Seaside pour mettre en place la navigation entre les composants `TBPostsListComponent` et `TBAdminComponent`.
Le message `call:` remplace le composant courant par le composant passé en argument et lui donne le flot de calcul. Le message `answer:` retourne une valeur à cet appel et redonne le contrôle au composant appelant.
Ce mécanisme puissant et élégant est expliqué dans la vidéo 1 de la semaine 5 du Mooc ([http://rmod-pharo-mooc.lille.inria.fr/MOOC/WebPortal/co/content\_5.html](http://rmod-pharo-mooc.lille.inria.fr/MOOC/WebPortal/co/content_5.html)).

### Composant fenêtre modale d'identification 


Développons maintenant un composant d'identification qui lorsqu'il sera invoqué ouvrira une boite de dialogue pour demander un login et un mot de passe. 
Le résultat que nous voulons obtenir est montré sur la figure *@authentification@*. 

Sachez qu'il existe des bibliothèques de composants Seaside prêt à l'emploi.
Par exemple, le projet Heimdal disponible sur [http://www.github.com/DuneSt/](http://www.github.com/DuneSt/) offre un composant d'identification ou  
le projet Steam [https://github.com/guillep/steam](https://github.com/guillep/steam) offre d'autres composants permettant d'interroger google ou twitter.

![Aperçu du composant d'identification.](figures/Authentification.png width=75&label=authentification)

#### Définition d'un composant d'identification


Nous définissons une nouvelle sous-classe de la classe `WAComponent` et des accesseurs. 
Ce composant contient un login, un mot de passe ainsi que le composant qui l'a invoqué pour accéder à la partie administration.

```
WAComponent subclass: #TBAuthentificationComponent
   instanceVariableNames: 'password account component'
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


```
TBAuthentificationComponent >> account
   ^ account
```


```
TBAuthentificationComponent >> account: anObject
   account := anObject
```


```
TBAuthentificationComponent >> password
   ^ password
```


```
TBAuthentificationComponent >> password: anObject
   password := anObject
```


```
TBAuthentificationComponent >> component
   ^ component
```


```
TBAuthentificationComponent >> component: anObject
   component := anObject
```


La variable d'instance `component` sera initialisée par la méthode de classe suivante :

```
TBAuthentificationComponent class >> from: aComponent
   ^ self new
      component: aComponent;
      yourself
```



### Rendu du composant d'identification


La méthode `renderContentOn:` suivante définit le contenu d'une boîte de dialogue modale avec l'identifiant `myAuthDialog`. Cet identifiant sera utilisé pour sélectionner le composant qui sera rendu visible en mode modal plus tard.
Cette boite de dialogue est composée d'une en-tête et d'un corps. Notez l'utilisation des messages `tbsModal`, `tbsModalBody:` et `tbsModalContent:`  qui permettent une interaction modale avec ce composant.

```
TBAuthentificationComponent >> renderContentOn: html
   html tbsModal
      id: 'myAuthDialog';
      with: [
         html tbsModalDialog: [
            html tbsModalContent: [
               self renderHeaderOn: html.
               self renderBodyOn: html ] ] ]
```


L'en-tête affiche un bouton pour fermer la boîte de dialogue et un titre avec de larges fontes. 
Notez que vous pouvez également utiliser la touche `esc` du clavier pour fermer la fenêtre modale.

```
TBAuthentificationComponent >> renderHeaderOn: html
   html
      tbsModalHeader: [
         html tbsModalCloseIcon.
         html tbsModalTitle
            level: 4;
            with: 'Authentication' ]
```


Le corps du composant affiche un masque de saisie pour l'identifiant, le mot de passe et finalement des boutons. 

```
TBAuthentificationComponent >> renderBodyOn: html
    html
        tbsModalBody: [
            html tbsForm: [
                self renderAccountFieldOn: html.
                self renderPasswordFieldOn: html.
                html tbsModalFooter: [ self renderButtonsOn: html ] ] ]
```



La méthode `renderAccountFieldOn:` montre comment la valeur d'un input field est passée puis stockée dans une variable d'instance du composant quand l'utilisateur confirme sa saisie. 
Le paramètre de la méthode `callback:` est un bloc qui prend lui-même un argument représentant la valeur du champ textInput.

```
TBAuthentificationComponent >> renderAccountFieldOn: html
   html
      tbsFormGroup: [ html label with: 'Account'.
         html textInput
            tbsFormControl;
            attributeAt: 'autofocus' put: 'true';
            callback: [ :value | account := value ];
            value: account ]
```


Le même procédé est utilisé pour le mot de passe.

```
TBAuthentificationComponent >> renderPasswordFieldOn: html
   html tbsFormGroup: [
      html label with: 'Password'.
      html passwordInput
         tbsFormControl;
         callback: [ :value | password := value ];
         value: password ]
```



Deux boutons sont ajoutés en bas de la fenêtre modale.
Le bouton `'Cancel'` qui permet de fermer la fenêtre modale grâce à son attribut 'data-dismiss' et le bouton `'SignIn'` associé à un bloc de callback qui envoie le message `validate`.
La touche `enter` du clavier permet également d'activer le bouton `'SignIn'` car c'est le seul dont l'attribut 'type' a la valeur 'submit' (ceci est réalisé par la méthode `tbsSubmitButton`). 


```
TBAuthentificationComponent >> renderButtonsOn: html
   html tbsButton 
      attributeAt: 'type' put: 'button'; 
      attributeAt: 'data-dismiss' put: 'modal';
      beDefault;
      value: 'Cancel'.
   html tbsSubmitButton
      bePrimary;
      callback: [ self validate ];
      value: 'SignIn'
```


Dans la méthode `validate`, nous envoyons simplement un message au composant principal en lui passant les identifiants rentrés par l'utilisateur.

```
TBAuthentificationComponent >> validate
	^ component tryConnectionWithLogin: self account andPassword: self password
```





%  !!!!! Améliorations
%  Rechercher une autre méthode pour réaliser l'authentification de l'utilisateur (utilisation d'un backend de type base de données, LDAP ou fichier texte). En tout cas, ce n'est pas à la boite de login de faire ce travail, il faut le déléguer à un objet métier qui saura consulter le backend et authentifier l'utilisateur.

%  De plus le composant ==TBAuthentificationComponent== pourrait afficher l'utilisateur lorsque celui-ci est logué.

### Intégration du composant d'identification


Pour intégrer notre composant d'identification, modifions le bouton 'Admin' de la barre d'en-tête (`TBHeaderComponent`) ainsi:

```
TBHeaderComponent >> renderButtonsOn: html
   self renderModalLoginButtonOn: html
```


```
TBHeaderComponent >> renderModalLoginButtonOn: html
   html render: (TBAuthentificationComponent from: component).
   html tbsNavbarButton
      tbsPullRight;
      attributeAt: 'data-target' put: '#myAuthDialog';
      attributeAt: 'data-toggle' put: 'modal';
      with: [
         html tbsGlyphIcon iconLock.
         html text: ' Login' ]
```


La méthode `renderModalLoginButtonOn:` commence par intégrer le code du composant `TBAuthentificationComponent` dans la page web (`render:`). 
Le composant étant instancié à chaque affichage, il n'a pas besoin d'être retourné par la méthode `children`.
On ajoute également un bouton nommé 'Login' avec un pictogramme clé.
Lorsque l'utilisateur clique sur ce bouton, la boîte modale ayant l'identifiant `myAuthDialog` est affichée.

En rechargeant la page de TinyBlog dans votre navigateur, nous voyons maintenant un bouton 'Login' dans l'en-tête permettant d'ouvrir la fenêtre modale comme illustré sur la figure *@authentification@*.

### Gestion naive des logins


Toutefois, si vous cliquez sur le bouton 'SignIn', une erreur se produit. 
En utilisant le debugger Pharo, on comprend qu'il faut définir la méthode `tryConnectionWithLogin:andPassword:` sur le composant `TBPostsListComponent` car c'est le message envoyé par le callback du bouton 'SignIn' de la fenêtre modale: 

```
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password
   (login = 'admin' and: [ password = 'topsecret' ])
         ifTrue: [ self goToAdministrationView ]
         ifFalse: [ self loginErrorOccurred ]
```


Pour l'instant, le login et le mot de passe pour accéder à la partie administration sont directement stockés en dur dans le code de cette méthode ce qui n'est pas très bon. 

### Gestion des erreurs


Nous avons déjà défini la méthode `goToAdministrationView` précédemment.
Ajoutons la méthode `loginErrorOccured` et un mécanisme pour afficher un message d'erreur lorsque l'utilisateur n'utilise pas les bons identifiants comme sur la figure *@loginErrorMessage@*.

Pour cela nous ajoutons une variable d'instance `showLoginError` qui représente le fait que nous devons afficher une erreur. 

```
TBScreenComponent subclass: #TBPostsListComponent
   instanceVariableNames: 'currentCategory showLoginError'
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


La méthode `loginErrorOccurred` spécifie qu'une erreur doit être affichée. 

```
TBPostsListComponent >> loginErrorOccurred
	showLoginError := true
```


Nous ajoutons une méthode pour tester cet état.
```
TBPostsListComponent >> hasLoginError
   ^ showLoginError ifNil: [ false ]
```

	
Nous définissons aussi un message d'erreur. 

```
TBPostsListComponent >> loginErrorMessage
   ^ 'Incorrect login and/or password'
```



Nous modifions la méthode `renderPostColumnOn:` afin de faire un traitement 
spécifique en cas d'erreur. 

```
TBPostsListComponent >> renderPostColumnOn: html
   html tbsColumn
      extraSmallSize: 12;
      smallSize: 10;
      mediumSize: 8;
      with: [ 
         self renderLoginErrorMessageIfAnyOn: html. 
         self basicRenderPostsOn: html ] 
```


La méthode `renderLoginErrorMessageIfAnyOn:` affiche si nécessaire un message d'erreur. Elle repositionne 
la variable d'instance `showLoginError` pour que le message ne soit pas affiché indéfiniment.

```
TBPostsListComponent >> renderLoginErrorMessageIfAnyOn: html
   self hasLoginError ifTrue: [ 
      showLoginError := false.
      html tbsAlert 
         beDanger ;
         with: self loginErrorMessage
   ]
```


![Message d'erreur en cas d'identifiants erronnés.](figures/LoginErrorMessage.png width=75&label=loginErrorMessage)


### Modélisation des administrateurs


Nous ne souhaitons pas stocker les identifiants administrateur du blog dans le code comme nous l'avons fait précédemment.
Nous allons maintenant réviser cela et stocker ces identifiants dans le modèle.

Commençons par enrichir notre modèle de Tinyblog avec la notion d'administrateur.
Ajoutons donc une nouvelle classe nommée `TBAdministrator` caractérisée par son pseudo, son login et son mot de passe.

```
Object subclass: #TBAdministrator
	instanceVariableNames: 'login password'
	classVariableNames: ''
	package: 'TinyBlog'
```


```
TBAdministrator >> login
   ^ login
```


```
TBAdministrator >> login: anObject
   login := anObject
```


```
TBAdministrator >> password
   ^ password
```


Notez que nous ne stockons pas le mot de passe administrateur en clair dans la variable d'instance `password` mais son hash en MD5.

```
TBAdministrator >> password: anObject
   password := MD5 hashMessage: anObject
```


Nous définissons aussi une méthode de création.

```
TBAdministrator class >> login: login password: password
	^ self new 
			login: login;
			password: password;
			yourself	
```


Vous pouvez vérifier cela en inspectant l'expression suivante :

```
luc := TBAdministrator login: 'luc' password: 'topsecret'.
```


### Administrateur pour un blog


Un blog possède un administrateur qui peut s'identifier sur le blog afin administrer les posts qu'il contient. 
Ajoutons donc un champ `adminUser` et un accesseur en lecture dans la classe `TBBlog` afin d'y stocker l'administrateur du blog:

```
Object subclass: #TBBlog
	instanceVariableNames: 'adminUser posts'
	classVariableNames: ''
	package: 'TinyBlog'
```


```
TBBlog >> administrator
   ^ adminUser
```


Nous définissons le login et password que nous utiliserons par défaut. Comme vous allez le voir plus loin, nous allons modifier les attributs de l'administrateur et ceux-ci seront sauvés en même temps que le blog dans la base de données.

```
TBBlog class >> defaultAdminPassword
   ^ 'topsecret'
```


```
TBBlog class >> defaultAdminLogin
   ^ 'admin'
```


Maintenant nous pouvons créer un administrateur par défaut.
```
TBBlog >> createAdministrator
	^ TBAdministrator
			login: self class defaultAdminLogin
			password: self class defaultAdminPassword
```



Lors de l'initialisation d'un blog ajoutons un administrateur par défaut.

```
TBBlog >> initialize
   super initialize.
   posts := OrderedCollection new.
   adminUser := self createAdministrator
```


### Définir un administrateur 


Il ne faut pas oublier de re-créer le blog ainsi:

```
	TBBlog reset; createDemoPosts
```


Vous pouvez maintenant modifier le login et le mot de passe administrateur de votre blog ainsi:

```
|admin|
admin := TBBlog current administrator.
admin login: 'luke'.
admin password: 'thebrightside'.
TBBlog current save
```


Notez que sans rien faire, l'administrateur du blog a été sauvegardé par Voyage dans la base de données.
En effet, la classe `TBBlog` étant une racine Voyage, tous ces attributs sont stockés dans la base automatiquement lors de l'envoi du message `save`.

#### Améliorations possibles


Etendre le modèle de l'application ainsi nécessite l'écriture de nouveaux tests unitaires.  A vous de jouer!


### Intégration du compte administrateur


Modifions maintenant la méthode `tryConnectionWithLogin:andPassword:` pour qu'elle utilise les identifiants de l'administrateur du blog courant.  Notez que nous comparons les hash MD5 des mots de passe car nous ne stockons pas le mot de passe en clair dans le modèle.

```
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password
   (login = self blog administrator login and: [ 
      (MD5 hashMessage: password) = self blog administrator password ])
         ifTrue: [ self goToAdministrationView ]
         ifFalse: [ self loginErrorOccurred ]
```


### Stocker l'administrateur courant en session


Actuellement, si l'administrateur du blog veut naviguer entre la partie privée et la partie publique de TinyBlog, il doit se reconnecter à chaque fois.
Nous allons simplifier cela en stockant l'administrateur courant en session lors d'une connexion réussie.


Un objet session est attribué à chaque instance de l'application.
Il permet de conserver principalement des informations qui sont partagées et accessibles entre les composants.
Nous stockerons donc l'administrateur courant en session et modifierons les composants pour afficher des boutons permettant une navigation simplifiée lorsque l'administrateur est connecté.
Lorsqu'il se déconnecte explicitement ou que la session expire, nous supprimerons la session courante.

La figure *@SessionNavigation@* illustre la navigation entre les pages que nous souhaitons mettre en place dans TinyBlog.

![Navigation et identification dans TinyBlog.](figures/sessionAuthSimplifiedNavigation.pdf width=100&label=SessionNavigation)


### Définition et utilisation d'une classe session spécifique


Commençons par définir une nouvelle sous-classe de `WASession` nommée `TBSession` dans laquelle nous ajoutons une variable d'instance pour stocker l'administrateur connecté.

```
WASession subclass: #TBSession
    instanceVariableNames: 'currentAdmin'
    classVariableNames: ''
    package: 'TinyBlog-Components'
```


```
TBSession >> currentAdmin
    ^ currentAdmin
```


```
TBSession >> currentAdmin: anObject
    currentAdmin := anObject
```


Nous définissons une méthode `isLogged` qui nous permettra de savoir si l'administrateur est logué.

```
TBSession >> isLogged
    ^ self currentAdmin notNil
```


Indiquons maintenant à Seaside qu'il doit utiliser l'objet `TBSession` comme objet de session courant pour l'application TinyBlog.
Cette initialisation s'effectue dans la méthode `initialize` de la classe `TBApplicationRootComponent` que l'on modifie ainsi:

```
TBApplicationRootComponent class >> initialize
      "self initialize"
      | app |
      app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
      app
         preferenceAt: #sessionClass put: TBSession.
      app
         addLibrary: JQDeploymentLibrary;
         addLibrary: JQUiDeploymentLibrary;
         addLibrary: TBSDeploymentLibrary
```


Pensez à exécuter cette méthode via `TBApplicationRootComponent initialize` avant de tester à nouveau l'application.

### Stockage de l'administrateur courant en session


Lors d'une connexion réussie, nous ajoutons l'objet administrateur dans la session grâce à l'accesseur en écriture `currentAdmin:`. Notez que tout composant Seaside peut accéder à la session en cours en invoquant le message `self session`.

```
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password
   (login = self blog administrator login and: [ 
      (MD5 hashMessage: password) = self blog administrator password ])
         ifTrue: [ 
            self session currentAdmin: self blog administrator.
            self goToAdministrationView ]
         ifFalse: [ self loginErrorOccurred ]
```



### Navigation simplifiée vers la partie administration


Pour mettre en place une navigation simplifiée, modifions l'en-tête pour afficher soit le bouton de connexion soit un bouton de navigation simple vers la partie administration sans étape de connexion si un administrateur est déjà connecté c'est-à-dire présent en session. 

```
TBHeaderComponent >> renderButtonsOn: html
    self session isLogged
        ifTrue: [ self renderSimpleAdminButtonOn: html ]
		  ifFalse: [ self renderModalLoginButtonOn: html ]     
```


Vous pouvez tester dans votre navigateur en commençant une nouvelle session (bouton 'New Session' en bas à gauche).
Une fois connecté, l'administrateur est ajouté en session.
Remarquez que le bouton déconnexion ne fonctionne plus correctement car il n'invalide pas la session.

### Déconnexion


Ajoutons une méthode `reset` sur notre objet session afin de supprimer l'administrateur courant, invalider la session courante et rediriger vers le point d'entrée de l'application.

```
TBSession >> reset
   currentAdmin := nil.
	self requestContext redirectTo: self application url.
	self unregister.
```


Modifions maintenant le bouton déconnexion de l'en-tête de la partie administration pour envoyer ce message `reset` à la session courante:

```
TBAdminHeaderComponent >> renderDisconnectButtonOn: html
   html tbsNavbarButton 
      tbsPullRight; 
      callback: [ self session reset ];
      with: [  
         html text: 'Disconnect '.
         html tbsGlyphIcon iconLogout ]
```


Le bouton 'Disconnect' fonctionne à nouveau correctement.

### Navigation simplifiée vers la partie publique


Ajoutons maintenant un nouveau bouton dans l'en-tête de la partie administration pour revenir à la partie publique sans se déconnecter.

```
TBAdminHeaderComponent >> renderButtonsOn: html
	html form: [ 
		self renderDisconnectButtonOn: html.
		self renderPublicViewButtonOn: html ]
```


```
TBAdminHeaderComponent >> renderPublicViewButtonOn: html
   self session isLogged ifTrue: [ 		 
      html tbsNavbarButton 
         tbsPullRight; 
         callback: [ component goToPostListView ];
         with: [  
            html tbsGlyphIcon iconEyeOpen.
            html text: ' Public View' ]]
```



Vous pouvez maintenant tester la navigation dans votre application qui doit correspondre avec la représentation sur la figure *@SessionNavigation@*.

### Conclusion


Nous avons mis en place une gestion de l'identification pour TinyBlog.
Cela comprend un composant réutilisable d'identification sous la forme d'une fenêtre modale.
Nous avons également différencié les composants affichés lorsqu'un administrateur est connecté ou non.
Enfin, nous avons utilisé la session pour faciliter la navigation d'un administrateur connecté jusqu'à sa déconnexion.

Nous voici prêts à définir la partie administrative de l'application ce qui est l'objet du chapitre suivant.
Nous en profiterons pour vous montrer un aspect avancé qui permet la définition automatique de formulaires ou d'objets ayant de nombreux champs.

#### Améliorations possibles


A titre d'exercice, vous pouvez :
- afficher le login de l'administrateur dans l'en-tête lorsqu'il est connecté,
- ajouter la possibilité d'avoir plusieurs comptes d'administrateur : chacun avec ses propres identifiants.

