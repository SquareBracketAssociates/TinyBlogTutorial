# TinyBlog

Objectif du projet: Développer un moteur de blog utilisant Pharo/Seaside/Mongo + frameworks de la stack

> utiliser Glorp ?

## Obtenir une base de données MongoDB

### Dans le cloud avec MongoLab

* Se connecter sur https://mongolab.com
* Cliquer sur signup,
* Créer un compte utilisateur (un mail de vérification de l'adresse mail est envoyé. Il faut confirmer le compte).
* Cliquer sur "Create New"
* modèle d'hébergement: option "Single-node" et on sélectionne "Sandbox" (gratuit pour 0.5 Go)
* On fournit un nom ("tinyblog") pour la base de données (Database name)
* On clique sur "Create new MongoDB deployment",
* En cliquant sur le nom de la base Mongo, on accède à l'écran de configuration,
    * Les paramètres de configuration sont dans l'URL,
    * On clique sur l'onglet "Users", puis le bouton "Add database user" pour ajouter un nouvel utilisateur,

#### Configuration du compte

|Champs       |Valeur                  |
|-------------|------------------------|
|Account name |tinyblog                |
|Username     |tinyblog                |
|Email        |olivier.auverlot@free.fr|
|Password     |tinyblog2015            |

#### Paramètres du serveur

|Paramètre      |Valeur                |
|---------------|----------------------|
|Serveur        |ds045064.mongolab.com |
|Port           |45064                 |
|Nom de la base |tinyblog              |

#### Utilisateur de la base tinyblog

|Champs       |Valeur      |
|-------------|------------|
|Compte       |tbuser      |
|Mot de passe |tbpassword  |


### Installation locale

####Mac OS X

Installer Brew (http://brew.sh)

Dans le terminal, mettre à jour les paquets et installer MongoDB:

```
brew update
brew install mongodb
```

Créer un répertoire pour le stockage des données et attribution des droits

```
mkdir -p /data/db
chmod -R /data/db
```

Lancement de mongo: `sudo mongod`

####Linux Debian

## Installation et préparation de Pharo

###Créer un projet sur SmalltalkHub
 
* Créer un projet sur http://smalltalkhub.com
    * Nommez le "TinyBlog",
    * Récupérer l'URL du projet: `http://smalltalkhub.com/mc/olivierauverlot/TinyBlog/main`

###Mettre en place Pharo

* Télécharger Pharo 4.0 à partir du site pharo.org
* A partir du "Configuration Browser", installer les paquets:
    * Seaside3,
    * VoyageMongo,
    * BootstrapMagritte,
    * Mustache
* Créez un paquet nommé TinyBlog,
* Créez un paquet nommé TinyBlog-Tests

###Créer la configuration du projet

* Créer un projet avec Versionner
    * Créer un nouveau projet "TinyBlog",
    * Dans development, ajoutez les paquets dont votre projet dépend:
        * Seaside3,
        * VoyageMongo,
        * BootstrapMagritte,
        * Mustache
    * Dans Packages, ajoutez le paquet TinyBlog,
    * Définissez le repository: `http://smalltalkhub.com/mc/olivierauverlot/TinyBlog/main`,
    * Cliquer sur le bouton "Save to development"

### Démarrer le serveur HTTP

* Aller dans Tools pour ouvrir le Seaside Control Panel,
* Faire un clic droit dans la partie supérieure et sélectionner le ZnZinServerAdaptor,
* Choisir le port 8080,
* Cliquer sur le serveur pour le sélectionner et cliquez sur le bouton "Start".


##Ecrire le modèle de TinyBlog


###La classe TBPost

```
Object subclass: #TBPost
	instanceVariableNames: 'title text date category visible'
	classVariableNames: ''
	category: 'TinyBlog'
```
####Description d'un post

Cinq variables d'instance pour décrire un post sur le blog.

|Variable      |Signification                |
|--------------|-----------------------------|
|title         |Titre du post                |
|text          |Texte du post                |
|date          |Date de rédaction            |
|category      |Rubrique contenant le post   |
|visible       |Post visible ou pas ?        |

Ces variables ont des setters et getters dans le protocole accessing.

```
TBPost >> title
	^ title

TBPost >> title: anObject
	title := anObject

TBPost >> text
	^ text

TBPost >> text: anObject
	text := anObject

TBPost >> date
	^ date

TBPost >> date: anObject
	date := anObject

TBPost >> visible
	^visible

TBPost >> visible: anObject
	visible := anObject
```

La variable d'instance `category` un traitement particulier car si elle n'est pas initialisée, le post est automatiquement placé dans la catégorie 'Unclassified'. La méthode de classe `unclassifiedTag` retourne la valeur par défaut d'une catégorie.

```
TBPost class >> unclassifiedTag
	^'Unclassified'

TBPost >> category
	^ category

TBPost >> category: anObject
	anObject
		ifNil: [ category := TBPost unclassifiedTag ]
		ifNotNil: [ category := anObject ]
```

La méthode `initialize` (protocole `initialize-release`) fixe par défaut la date et fixe par défaut la visibilité à false (l'utilisateur devra par la suite activer la visibilité ce qui permet de rédiger des brouillons et de publier lors que le post est terminé).

```
TBPost >> initialize
  self date: Date today.
  self visible: false.
```

####Savoir si un post est classé dans une catégorie

```
isUnclassified
	^self category = TBPost unclassifiedTag
```

####Gérer la visibilité d'un post

Il faut avoir la possibilité d'indiquer qu'un post est visible ou pas. Il faut également pouvoir demandé à un post s'il est visible. Les méthodes sont définies dans la protocole `action`.

```
TBPost >> beVisible
	self visible: true

TBPost >> notVisible
	self visible: false

TBPost >isVisible
	^self visible
```

###La classe TBBlog

La classe TBBlog a la responsabilité de la communication entre l'application et la base MongoDB. Elle regroupe les règles métiers.

```
Object subclass: #TBBlog
	instanceVariableNames: 'repository host port database username password'
	classVariableNames: ''
	category: 'TinyBlog'
```

Il y a une seule instance de la classe (singleton) et celle ci est construite coté classe.

```
TBBlog class
	instanceVariableNames: 'uniqueInstance'

TBBlog class >> initialize
	^uniqueInstance ifNil: [uniqueInstance := self new]

TBBlog class >> current
	^uniqueInstance

TBBlog class >> reset
	VORepository setRepository: nil.
	uniqueInstance := nil
```

Coté instance, les méthodes `initializeConnectionParameters` et `initialize` établissent la connexion vers la base de données.

```
TBBlog >> initializeConnectionParameters
	host := 'localhost'.
	database := 'tinyblog'

TBBlog >> initialize
	super initialize.
	self initializeConnectionParameters.
	
	repository := VOMongoRepository
		host: host
		"port: port"
		database: database.
		"username: username
		password: password"
	
	repository enableSingleton.
```

> Pas d'authentification utilisée car impossible de le faire avec MongoDB 3.0 (nouvelle méthode de chiffrement SCRAM pas encore supportée avec Pharo ?)

###Ecrire les tests pour les règles métiers

Les tests unitaires sont regroupées dans le paquet TinyBlog-tests qui contient la classe TBBlogTest.

```
TestCase subclass: #TBBlogTest
	instanceVariableNames: 'blog post repository'
	classVariableNames: ''
	category: 'TinyBlog-tests'
```

Avant le lancement des tests, la méthode setUp initialise la connexion vers la base, efface son contenu, ajoute un post et en crée un autre qui provisoirement n'est pas enregistré.

```
TBBlogTest >> setUp
	repository := TBBlog initialize.
	blog := TBBlog current.

	blog removeAll.

	TBBlog current writeBlogPost: (TBPost title: 'A title' text: 'A text' category: 'First Category').
 	post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible
```

On en profite pour tester différentes configuration. Les posts ne sont pas dans la même catégorie, l'un est visible, l'autre pas.

La méthode `tearDown` exécutée au terme des tests remet à zéro la connexion.

```
TBBlogTest >> tearDown
	TBBlog reset
```

####Obtenir le nombre de posts dans la base

```
TBBlogTest >> testSize
	self assert: blog size equals: 1
```

####Ajouter un post

```
TBBlogTest >> testAddBlogPost
	blog writeBlogPost: post.
	self assert: blog size equals: 2
```

####Obtenir l'ensemble des posts (visibles et invisibles)

```
TBBlogTest >> testAllBlogPosts
	blog writeBlogPost: post.
	self assert: (blog allBlogPosts) size equals: 2.
```

####Obtenir tous les posts visibles

```
TBBlogTest >> testAllVisibleBlogPosts
	blog writeBlogPost: post.
	self assert: (blog allVisibleBlogPosts) size equals: 1.
```

####Obtenir tous les posts d'une catégorie

```
TBBlogTest >> testAllBlogPostsFromCategory
	self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
```

####Obtenir tous les posts visibles d'une catégorie

```
TBBlogTest >> testAllVisibleBlogPostsFromCategory
	blog writeBlogPost: post.
	self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0.
	self assert: (blog allVisibleBlogPostsFromCategory: 'Second Category') size equals: 1.
```

####Vérifier la gestion des posts non classés

```
TBBlogTest >> testUnclassifiedBlogPosts
	self assert: (blog allBlogPosts select: [ :p | p isUnclassified ]) size equals: 0.
```

####Obtenir la liste des catégories

```
TBBlogTest >> testAllCategories
	blog writeBlogPost: post.
	self assert: (blog allCategories) size equals: 2.
```

####Effacer un post

```
TBBlogTest >> testRemoveBlogPost
	blog writeBlogPost: post.
	blog removeBlogPost: post.
	self assert: blog size equals: 1
```
####Effacer l'intégralité des posts

```
TBBlogTest >> testRemoveAllBlogPosts
	blog removeAll.
	self assert: blog size equals: 0.
```

###Implémentation des règles métiers

Les règles métiers sont regroupées dans le protocole `action` de la classe `TBBlog`.

####Obtenir le nombre de posts dans la base

```
TBBlog >> size
	^repository count: TBPost
```

####Enregistrer le contenu d'un post

```
TBBlog >> writeBlogPost: aPost
	aPost save.
```

####Effacer un post

```
TBBlog >> removeBlogPost: aPost
	repository remove: aPost
```

####Effacer l'ensemble des posts

```
TBBlog >> removeAll
	repository removeAll: TBPost
```
####Obtenir l'ensemble des posts

```
TBBlog >> allBlogPosts
	^repository selectAll: TBPost
```

####Obtenir l'ensemble des posts visibles

```
TBBlog >> allVisibleBlogPosts
	^(repository selectAll: TBPost) select: [ :p | p isVisible ]
```

####Obtenir la liste des catégories

```
TBBlog >> allCategories
	^(self allBlogPosts collect: [ :p | p category ]) asSet
```

####Obtenir l'ensemble des posts d'une catégorie

```
TBBlog >> allBlogPostsFromCategory: aCategory
	^repository selectMany: TBPost where: [ :p | p category = aCategory ]
```

####Obtenir l'ensemble des posts visibles d'une catégorie

```
TBBlog >> allVisibleBlogPostsFromCategory: aCategory
	^(repository selectMany: TBPost where: [ :p | p category = aCategory ]) select: [ :p | p isVisible ]
```

>Plusieurs évolutions peuvent être apportées telles que obtenir uniquement la liste des catégories contenant au moins un post visible, effacer une catégorie et les posts contenus, renommer un catégorie, déplacer un post d'une catégorie à une autre, rendre visible ou invisible une catégorie et son contenu, etc.

###Décrire les données avec Magritte

Les cinq variables d'instance de l'objet TBPost sont décrite à l'aide de Magritte. Ici, nous ne nous intéressons qu'aux données (les informations sur l'apparence des données dans l'application seront renseignées plus tard).

> Pourquoi utiliser Magritte ?

> Il évite d'écrire à la main les formulaires, de valider les données, permet de générer des rapports.

Les cinq méthodes sont dans le protocole `descriptions` de la classe `TBPost`.

Le titre d'un post est une chaine de caractères devant être obligatoirement complétée.

```
TBPost >> descriptionTitle
	<magritteDescription>
	^ MAStringDescription new
		accessor: #title;
		beRequired;
		yourself
```

Le texte d'un post est une chaine de caractères multi-lignes devant être obligatoirement complétée.

```
TBPost >> descriptionText
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #text;
		beRequired;
		yourself
```

La catégorie d'un post est une chaine de caractères qui peut ne pas être renseignée. Dans ce cas, le post sera de toute manière rangé dans la catégorie "Unclassified".

```
TBPost >> descriptionCategory
	<magritteDescription>
	^ MAStringDescription new
		accessor: #category;
		yourself
```

La date de création d'un post est importante car elle permet de définir l'ordre de tri pour l'affichage des posts. C'est donc une variable d'instance contenant obligatoirement une date.

```
TBPost >> descriptionDate
	<magritteDescription>
	^ MADateDescription new
		accessor: #date;
		beRequired;
		yourself
```

La variable d'instance `visible` doit obligatoirement contenir une valeur booléenne.

```
descriptionVisible
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #visible;
		beRequired;
		yourself
```
##Interface web publique

###Initialisation de l'application

Création d'une classe `TBRootComponent` qui est le point d'entrée de l'application. Il sert à l'initialisation de l'application.

On déclare l'application au serveur Seaside, coté classe, dans le protocole `Initialize`. On en profite pour intégrer les dépendances du framework Bootstrap (les fichiers css et js seront stockés dans l'application).

```
TBRootComponent class >> initialize
	| app |
	
	app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
	app
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: TBSDeploymentLibrary
```

Dans un Playground, on peut exécuter `TBRootComponent initialize` pour forcer l'exécution du code. Une connexion sur le serveur Seaside ("Browse the applications installed in your image") permet de vérifier que l'application est bien enregistrée.

Ajoutons également la méthode `canBeRoot` afin de préciser que la classe `TBRootComponent` est la première instanciée lors qu'un utilisateur se connecte sur l'application.

```
TBRootComponent >> canBeRoot
	^true
```

Ajoutons maintenant une méthode renderContentOn: afin de vérifier que notre application répond bien. La méthode est une méthode d'instance dans le protocole rendering.

```
TBRootComponent >> renderContentOn: html
	html text: 'TinyBlog'
```

Connexion avec un navigateur sur http://localhost:8080/TinyBlog. La page doit apparaître.

Ajoutons maintenant des informations dans l'entête de la page HTML afin que TinyBlog ait un titre et soit une application HTML5. L'ensemble des écrans de l'application hériteront de TBRootComponent et il ne sera donc pas nécessaire de reproduire cette opération.

```
TBRootComponent >> updateRoot: anHtmlRoot
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'TinyBlog'.
```

Dans le cadre du développement, automatisons la création d'un ensemble de posts à l'aide de la méthode `createDemoPosts` dans la classe `TBBlog`.

> à déplacer coté classe

```
TBBlog >> createDemoPosts
	self writeBlogPost: ((TBPost title: 'Welcome in TinyBlog' text: 'TinyBlog is a small blog engine made with Pharo.' category: 'TinyBlog') visible: true).
	self writeBlogPost: ((TBPost title: 'Report Pharo Sprint' text: 'Friday, June 12 there was a Pharo sprint / Moose dojo. It was a nice event with more than 15 motivated sprinters. With the help of candies, cakes and chocolate, huge work has been done' category: 'Pharo')visible: true).
	self writeBlogPost: ((TBPost title: 'Brick on top of Bloc - Preview' text: 'We are happy to announce the first preview version of Brick, a new widget set created from scratch on top of Bloc. Brick is being developed primarily by Alex Syrel (together with Alain Plantec, Andrei Chis and myself), and the work is sponsored by ESUG. Brick is part of the Glamorous Toolkit effort and will provide the basis for the new versions of the development tools.' category: 'Pharo') visible: true).
	self writeBlogPost: ((TBPost title: 'The sad story of unclassified blog posts' text: 'So sad that I can read this.' category: nil) visible: true).
	self writeBlogPost: ((TBPost title: 'Working with Pharo on the Raspberry Pi' text: 'Hardware is getting cheaper and many new small devices like the famous Raspberry Pi provide new computation power that was one once only available on regular desktop computers. This capable little device called “Pi” enables people of all ages to explore computing and combined with powerful software environments like Pharo the Pi can be used for interesting projects.' category: 'Pharo') visible: true).
```

###L'objet session

Un objet session est attribué à chaque utilisateur de l'application. Il permet de conserver principalement des informations.

```
WASession subclass: #TBSession
	instanceVariableNames: 'repository'
	classVariableNames: ''
	category: 'TinyBlog'
```

Nous allons l'utiliser pour fournir à chaque utilisateur la référence vers l'instance uniquement de `TBBlog`.

```
TBSession >> repository
	^ repository

TBSession >> repository: anObject
	repository := anObject
```

Le protocole initialize-release contient les méthodes `initialize` et`initializeRepository`. Celle-ci est appelée à chaque fois qu'un nouvel utilisateur se connecte à l'application. Elle demande la création d'une instance de TBBlog et celui ci ne contient aucun posts, elle déclenche la création des posts de démonstration.

```
TBSession initializeRepository
	TBBlog initialize.
	self repository: TBBlog current.
	self repository size = 0 ifTrue: [ self repository createDemoPosts ]

TBSession initialize
	super initialize.
	self initializeRepository
```

Ajoutons maintenant une méthode 'initialize' dans le protocole 'initialize-release' de la classe 'TBRootComponent'.

```
TBRootComponent >> initialize
	super initialize.
	TBBlog initialize.
	self repository size = 0 ifTrue: [ self repository createDemoPosts ]
```

Il vous faut maintenant spécifier à Seaside qu'il doit utiliser l'objet TBSession comme objet de session courant pour l'application TinyBlog. Pour cela, on utilise l'outil d'administration de Seaside.

* connexion sur `http://localhost:8080/config`,
* on clique sur "TinyBlog",
* Dans "General", cliquez sur le bouton "Override" de "Session Class",
* Choisir `TBSession` dans la liste déroulante,
* Cliquez sur le bouton "Apply" en bas du formulaire.

> ça serait bien d'automatiser cette étape à l'initialisation de l'application.

###Les écrans de TinyBlog

###Le composant TBScreenComponent

```
WAComponent subclass: #TBScreenComponent
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog'
```

Les différents écrans de TinyBlog auront besoin d'accéder aux règles métier de l'application. Dans le protocole `accessing`, créons un méthode `repository` qui retourne l'instance de `TBBlog`. Celle ci sera stockée dans la session de l'application et donc accessible dans tous les objets héritant de WAComponent.

```
repository
	^self session repository
```

Profitons également de ce composant pour insérer dans la partie supérieure de chaque écran, l'instance d'un composant représentant l'entête de l'application.

####Définition du composant TBHeaderComponent

```
WAComponent subclass: #TBHeaderComponent
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Components'
```

Le protocole `rendering` contient la méthode `renderContentOn:`chargée d'afficher l'entête.

```
TBHeaderComponent >> renderContentOn: html
	html tbsNavbar beDefault with: [
		html tbsNavbarBrand
			url: '#';
			with: 'TinyBlog' ]
```

L'entête est affiché à l'aide d'une barre de navigation BootStrap.

> Demander à ce que le nom du blog devienne paramêtrable à l'aide d'une variable d'instance dans un objet `TBConfiguration` ou à l'aide d'un document dans la base Mongo.

Il n'est pas souhaitable d'instancier systématiquement le composant à chaque fois qu'un écran est appelé. Créons une variable d'instance `header` dans `TBScreenComponent` qui sera initialisé une seule fois pour chaque utilisateur de l'application (gain de ressources).

```
WAComponent subclass: #TBScreenComponent
	instanceVariableNames: 'header'
	classVariableNames: ''
	category: 'TinyBlog'
```

Créons une méthode `ìnitialize` dans le protocole `initialize-release`:

```
TBScreenComponent >> initialize
	super initialize.
	header := TBHeaderComponent new.
```

Définissons que l'instance du composant TBHeaderComponent est un enfant de TBScreenComponent dans la hiérarchie Seaside.

```
children
	^ OrderedCollection with: header
```

Affichons maintenant le composant dans la méthode `renderContentOn:` (protocole `rendering`):

```
TBScreenComponent >> renderContentOn: html
	self render: header
```

###Afficher la liste des posts (écran public)

A l'aide du jeu de test, nous construisons l'écran public de l'application qui affiche les blogs.

Créons un composant `TBPublicPostsListComponent` qui hérite de `TBScreenComponent`:

```
TBScreenComponent subclass: #TBPublicPostsListComponent
	instanceVariableNames: 'report'
	classVariableNames: ''
	category: 'TinyBlog-Components'
```

Ajoutons une méthode renderContentOn: (protocole rendering) provisoire pour tester l'avancement de notre application.

```
TBPublicPostsListComponent >> renderContentOn: html
	super renderContentOn: html
	html text: 'Blog Posts here !!!'
```

Maintenant, revenons au composant TBRootComponent et ajoutons une variable d'instance `publicPostsList` qui contiendra (pour chaque utilisateur) l'instance de l'écran `TBPublicPostsListComponent` (économie de ressources).

```
WAComponent subclass: #TBRootComponent
	instanceVariableNames: 'publicPostsList'
	classVariableNames: ''
	category: 'TinyBlog'

TBRootComponent >> publicPostsList
	^ publicPostsList

TBRootComponent >> publicPostsList: anObject
	publicPostsList := anObject

TBRootComponent >> registerSubComponents
	self publicPostsList: TBPublicPostsListComponent new

TBRootComponent >> initialize
	super initialize.
	self registerSubComponents
```

La méthode `renderContentOn:` affiche, au démarrage de l'application, la liste des posts dans la base.

```
TBRootComponent >> renderContentOn: html
	html render: self publicPostsList
```

####Définition du composant TBPostContentComponent

Chaque post du blog est un composant TBPostContentComponent qui affiche le titre, la date et le contenu d'un post.

```
WAComponent subclass: #TBPostContentComponent
	instanceVariableNames: 'title text date'
	classVariableNames: ''
	category: 'TinyBlog-Components'

TBPostContentComponent >> title
	^ title

TBPostContentComponent >> title: anObject
	title := anObject

TBPostContentComponent >> text
	^ text

TBPostContentComponent >> text: anObject
	text := anObject

TBPostContentComponent >> date
	^ date

TBPostContentComponent >> date: anObject
	date := anObject
```

Créons une méthode de classe pour initialiser chaque post:

```
TBPostContentComponent class >> title: aTitle text: aText date: aDate
	^self new
		title: aTitle;
		text: aText;
		date: aDate
```

Ajoutons la méthode renderContentOn: qui définie l'affichage du post.

```
TBPostContentComponent renderContentOn: html
	html heading level: 2; with: self title.
	html heading level: 6; with: self date.
	html text: self text
```

####Affichage des posts présents dans la base

Il ne reste plus qu'à modifier la méthode TBPublicPostsListComponent >> renderContentOn: pour afficher l'ensemble des blogs visibles présents dans la base.

```
renderContentOn: html
	super renderContentOn: html.
	self repository allVisibleBlogPosts do: [ :p |
		html render: (TBPostContentComponent
			title: p title
			text: p text
			date: p date).
	]
```

###Affichage des posts par catégorie

####Création du composant TBCategoriesListComponent

Les posts sont classés par catégorie. Par défaut, si aucune catégorie n'a été précisée, ils sont rangés dans une catégorie spéciale dénommée "Unclassified".

Nous avons besoin d'un composant Seaside qui affiche la liste des catégories présentes dans la base et permet d'en sélectionner une. Ce composant devra donc avoir la possibilité de communiquer avec le composant `TBPublicPostsListComponent` afin de lui communiquer la catégorie choisie par l'utilisateur.

```
WAComponent subclass: #TBCategoriesListComponent
	instanceVariableNames: 'categories postsListScreen'
	classVariableNames: ''
	category: 'TinyBlog-Components'

TBCategoriesListComponent >> categories
	^ categories

TBCategoriesListComponent >> categories: anObject
	categories := anObject

TBCategoriesListComponent >> postsListScreen
	^ postsListScreen

TBCategoriesListComponent >> postsListScreen: anObject
	postsListScreen := anObject

TBCategoriesListComponent class >> categories: aCollectionOfCategories postsListScreen: aTBScreen
	^self new categories: aCollectionOfCategories; postsListScreen: aTBScreen
```

La méthode `selectCategory` (protocole `action`) communique au composant `TBPublicPostsListComponent` la nouvelle catégorie courante.

```
TBCategoriesListComponent >> selectCategory: aCategory
	self postsListScreen currentCategory: aCategory
```

Nous avons donc besoin d'ajouter une variable d'instance dans `TBPublicPostsListComponent`.

```
TBScreenComponent subclass: #TBPublicPostsListComponent
	instanceVariableNames: 'currentCategory'
	classVariableNames: ''
	category: 'TinyBlog-Components'

TBScreenComponent >> currentCategory
	^ currentCategory

TBScreenComponent >> currentCategory: anObject
	currentCategory := anObject
```

Nous pouvons ajouter une méthode (protocole `rendering`) pour afficher les catégories sur la page.

```
renderCategoryLinkOn: html with: aCategory
	html tbsLinkifyListGroupItem callback: [ self selectCategory: aCategory ]; with: aCategory
 
```

Reste maintenant à écrire la méthode de rendu du composant:

```
renderContentOn: html
	html tbsListGroup: [
		html tbsLinkifyListGroupItem beActive; with: 'Categories'.
		categories do: [ :c | self renderCategoryLinkOn: html with: c ].
	]
```

####Mettre à jour la liste des posts

Il faut gérer le raffraîchissement de la liste des posts en fonction de la catégorie choisie et donc modifier la méthode de rendu de l'écran `TBPublicPostsListComponent`.

La méthode `readSelectedPosts` récupère dans la base les posts à afficher. Si elle vaut `nil`, l'utilisateur n'a pas encore sélectionner une catégorie et l'ensemble des posts visibles de la base est affiché. Si elle contient une valeur autre que `nil`, l'utilisateur a sélectionner une catégorie et l'application affiche alors la liste des posts attachés à la catégorie.

```
TBPublicPostsListComponent >> readSelectedPosts
	self currentCategory
		ifNil: [ ^self repository allVisibleBlogPosts ]
		ifNotNil: [ ^self repository allVisibleBlogPostsFromCategory: self currentCategory  ].
```

Nous pouvons maintenant modifier la méthode chargé du rendu de la liste des posts:

```
TBPublicPostsListComponent >> renderContentOn: html
	super renderContentOn: html.

	html render: (TBCategoriesListComponent categories: (self repository allCategories) postsListScreen: self).

	self readSelectedPosts do: [ :p |
		html render: (TBPostContentComponent
			title: p title
			text: p text
			date: p date).
	]
```

Une instance du composant `TBCategoriesListComponent`est ajouté sur la page et permet de sélectionner la catégorie courante.


####Agencement de l'écran TBPublicPostsListComponent

Mise en place d'un responsive design pour la liste des posts. Les composants sont placés dans un container Bootstrap puis agencés sur une ligne avec deux colonnes. La dimension des colonnes est déterminée en fonction de la résolution (viewport) du terminal utilisé. Les 12 colonnes de Bootstrap sont réparties entre la liste des catégories et la liste des posts. Dans le cas d'une résolution faible, la liste des catégories est placée au dessus de la liste des posts (chaque élément occupant 100% de la largeur du container).

Tant que nous sommes dans les finitions, profitons en également pour afficher la date de chaque post dans un format compréhensible (sans l'heure).

```
TBPublicPostsListComponent >> renderContentOn: html

	super renderContentOn: html.
 	html tbsContainer: [
		html tbsRow showGrid;
			with: [
				html tbsColumn
					extraSmallSize: 12;
					smallSize: 2;
					mediumSize:  4;
					with: [
						html render: (TBCategoriesListComponent categories: (self repository allCategories) postsListScreen: self) ].
				html tbsColumn
					extraSmallSize: 12;
					smallSize: 10;
					mediumSize: 8;
					with: [ self readSelectedPosts do: [ :p |
						html render: (TBPostContentComponent
							title: p title
							text: p text
							date: p date asDate) ] ] ] ]
```

##Administration de TinyBlog

L'utilisateur doit s'authentifier pour accéder à la partie administration de TinyBlog. Il le fait à l'aide d'un compte et d'un mot de passe. Le lien permettant d'afficher le composant d'authentification sera placé sous la liste des catégories.

###Création d'un composant pour l'authentification

```
WAComponent subclass: #TBauthenticationComponent
	instanceVariableNames: 'password account component'
	classVariableNames: ''
	category: 'TinyBlog-Components'

TBauthenticationComponent >> account
	^ account

TBauthenticationComponent >> account: anObject
	^ account := anObject

TBauthenticationComponent >> password
	^ password

TBauthenticationComponent >> password: anObject
	^ password := anObject

TBauthenticationComponent >> screen
	^ screen

TBauthenticationComponent >> component
	^ component

TBauthenticationComponent >> component: anObject
	component := anObject
```

La variable d'instance `component` est initialisée par la méthode de classe suivante :

```
TBauthenticationComponent class >> from: aComponent
	^self new component: aComponent
```

La méthode `renderContentOn:` definie le contenu d'une boite de dialogue modale.

```
TBauthenticationComponent >> renderContentOn: html
  html tbsModal id: 'myAuthDialog'; with: [
    html tbsModalDialog: [
      html tbsModalContent: [
        html tbsModalHeader: [
          html tbsModalCloseIcon.
          html tbsModalTitle level: 4; with: 'Authentication'
        ].
        html tbsModalBody: [
          html form: [
            html text: 'Account:'.
            html break.
	    html textInput
              callback: [ :value | account := value ];
              value: account.
	    html break.
	    html text: 'Password:'.
	    html break.
	    html passwordInput
	      callback: [ :value | password := value ];
	      value: password.
	    html break.
	    html break.
	    html tbsModalFooter: [
	      html tbsSubmitButton value: 'Cancel'.
	        html tbsSubmitButton
	          bePrimary;
      	          callback: [ self validate ];
	          value: 'SignIn'.
	      ] ] ] ] ]
```
> Quelle critique peut on faire sur cette méthode ? Proposer une refactorisation à l'aide de plusieurs méthodes pour placer les différents éléments du formulaire.

Lorsque l'utilisateur clique sur le bouton 'SignIn', la méthode validate est appelée et vérifie que l'utilisateur a bien le compte "admin" et a saisi le mot de passe "password".

```
TBauthenticationComponent >> validate
	(self account = 'admin' and: [ self password = 'password' ]) ifTrue: [
		component gotoAdministrationScreen
	]
```

> Rechercher une autre méthode pour réaliser l'authentification de l'utilisateur (utilisation d'un backend de type base de données, LDAP ou fichier texte). En tout cas, ce n'est pas à la boite de login de faire ce travail, il faut le déléguer à un objet métier qui saura consulter le backend et authentifier l'utilisateur.

La méthode `validate` appelle la méthode gotoAdministration définie dans `TBPublicPostsListComponent`:

```
TBPublicPostsListComponent >> gotoAdministrationScreen
	self call: TBAdminComponent new
```

###Intégration de l'authentification

Il faut maintenant intégrer le lien qui déclenchera l'affichage de la boite modale d'authentification. Au tout début de la méthode `renderContentOn:` du composant `TBPublicPostsListComponent`, on ajoute le rendu du composant d'authentification. Ce composant reçoit en paramètre la référence vers l'écran affichant les posts (`self`).

```
TBPublicPostsListComponent >> renderContentOn: html
	super renderContentOn: html.
	html render: (TBauthenticationComponent from: self).
        ...
```

On définit maintenant une méthode qui affiche un pictogramme clé et un lien 'SignIn'.

```
TBPublicPostsListComponent >> renderSignInOn: html
	html tbsGlyphIcon perform: #iconLock.
	html html: '<a data-toggle="modal" href="#myAuthDialog" class="link">SignIn</a>'.
```

###Création de la liste des posts

La liste des posts est affiché à l'aide d'un rapport généré dynamiquement par le framework Magritte. Ce framework va être utilisé pour réaliser les différentes fonctionnalités de la partie administration de TinyBlog (liste des posts, création, édition et suppression d'un post).

Pour rester modulaire, nous allons créer un composant Seaside pour cette tâche. Nous lui transmettrons un moyen d'accéder au données (référence vers l'objet `TBBlog`) afin qu'il accède aux posts devant être affichés dans le rapport.

> Au sein du composant `TBPostReport`, nous aurions pu aussi utiliser la variable de session `repository` mais le code qui produira un peu plus tard une instance de `TBPostReport` sera plus lisible ainsi.

```
TBSMagritteReport subclass: #TBPostsReport
	instanceVariableNames: 'repository'
	classVariableNames: ''
	category: 'TinyBlog-Components'

repository
	^ repository

repository: anObject
	repository := anObject

TBPostsReport class >> from: aRepository
	^self rows: (aRepository allBlogPosts) description: (aRepository allBlogPosts first)
```

Par défaut, le rapport affiche l'intégralité des données présentes dans chaque posts mais certaines colonnes ne sont pas utiles. Il faut donc filtrer les colonnes. Nous ne retiendrons ici que le titre, la catégorie et la date de rédaction.

Il faut ajouter une méthode de classe pour la sélection des colonnes et modifier ensuite la méthode `with`.

```
TBPostsReport class >> filteredDescriptionsFrom: aBlogPost
	^ aBlogPost magritteDescription select: [ :each | #(title category date) includes: each accessor selector ]

TBPostsReport class >> from: aRepository
	^self rows: (aRepository allBlogPosts) description: (self filteredDescriptionsFrom: aRepository allBlogPosts first)
```

###Création d'un écran d'administration

Ajoutons l'écran d'administration et définissons la variable d'instance `report` qui contiendra une référence vers le composant rapport construit à l'aide de Magritte.

```
TBScreenComponent subclass: #TBAdminComponent
	instanceVariableNames: ''
	classVariableNames: 'report'
	category: 'TinyBlog-Components'

TBAdminComponent >> report
	^ report

TBAdminComponent >> report: anObject
	report := anObject

TBAdminComponent >> children
	^ OrderedCollection with: self report
```

La méthode initialize permet d'initialiser la définition du rapport. Nous fournissons au composant `TBPostReport` l'accès aux données.

```
TBAdminComponent >> initialize
	super initialize.
	self report: (TBPostsReport from: self repository)
```

Nous pouvons maintenant afficher le rapport sur l'écran.

```
TBAdminComponent >>  renderContentOn: html
	super renderContentOn: html.
	html tbsContainer: [
		html heading: 'Blog Manager'.
		html horizontalRule.
		html render: self report.
	]
```

Le rapport généré est brut. Il n'y a pas de titres sur les colonnes et l'ordre d'affichage des colonnes n'est pas fixé (il peut varier d'une instance à une autre). Pour gérer cela, il suffit de modifier les descriptions Magritte pour chaque variable d'instance.

```
TBPost >> descriptionTitle
	<magritteDescription>
	^ MAStringDescription new
		label: 'Title';
		priority: 100;
		accessor: #title;
		beRequired;
		yourself

TBPost >> descriptionText
	<magritteDescription>
	^ MAMemoDescription new
		label: 'Text';
		priority: 200;
		accessor: #text;
		beRequired;
		yourself

TBPost >> descriptionCategory
	<magritteDescription>
	^ MAStringDescription new
		label: 'Category';
		priority: 300;
		accessor: #category;
		yourself

TBPost >> descriptionDate
	<magritteDescription>
	^ MADateDescription new
		label: 'Date';
		priority: 400;
		accessor: #date;
		beRequired;
		yourself

TBPost >> descriptionVisible
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Visible';
		priority: 500;
		accessor: #visible;
		beRequired;
		yourself
```

###Gestion des posts

Il faut maintenant mettre en place un CRUD (Create Read Update Delete) permettant de gérer les posts. Pour cela, nous allons ajouter une colonne au rapport qui regroupera les différentes opérations. Ceci se fait lors de la création du rapport.

```
TBPostsReport class >> from: aRepository
	| report |
	
	report := self rows: (aRepository allBlogPosts) description: (self filteredDescriptionsFrom: aRepository allBlogPosts first).
	report repository: aRepository.
	report addColumn: (MACommandColumn new
		addCommandOn: report  selector: #viewPost: text: 'View'; yourself;
		addCommandOn: report selector: #editPost: text: 'Edit'; yourself;
		addCommandOn: report selector: #deletePost: text: 'Delete'; yourself).
	 ^report
```

L'ajout (add) est dissocié des posts et se trouvera donc juste avant le rapport. Etant donné qu'il fait parti du composant TBPostsReport, nous devons surcharger la méthode renderContentOn: de l'objet TBPostsReport pour insérer le lien `add`:


```
TBPostsReport >> renderContentOn: html
        html tbsGlyphIcon perform: #iconPencil.
	html anchor
		callback: [ self addPost ];
		with: 'Add post'.
	super renderContentOn: html

```

###Implémentation des actions du CRUD

A chaque action (Create/Read/Update/Delete) correspond une méthode de l'objet `TBPostsReport`. Nous allons maintenant les implémenter. Un formulaire personnalisé est construit en fonction de l'opération demandé (il n'est pas utile par exemple d'avoir un bouton "Sauver" alors que l'utilisateur veut simplement lire le post).

####Ajouter un post

```
TBPostsReport >> renderAddPostForm: aPost
	^ aPost asComponent
		addDecoration: (TBSMagritteFormDecoration buttons: (Array with: #save -> 'Add post' with: #cancel -> 'Cancel'));
		yourself

TBPostsReport >> addPost
	| post |
	post := self call: (self renderAddPostForm: TBPost new).
	post ifNotNil: [ self repository writeBlogPost: post ]
```
####Editer un post

```
TBPostsReport >> renderEditPostForm: aPost
	^ aPost asComponent
		addDecoration: (TBSMagritteFormDecoration buttons: (Array with: #save -> 'Save post' with: #cancel -> 'Cancel'));
		yourself

TBPostsReport >> editPost: aPost
	| post |
	post := self call: (self renderEditPostForm: aPost).
	post ifNotNil: [  "save the modified post" ]
```
####Consulter un post

```
TBPostsReport >> viewPost: aPost
	self call: (self renderViewPostForm: aPost)

TBPostsReport >> renderViewPostForm: aPost
	^ aPost asComponent
		addDecoration: (TBSMagritteFormDecoration buttons: (Array with: #cancel -> 'Back'));
		yourself
```
####Effacer un post

Pour éviter une opération accidentelle, nous utilisons une boite modale pour que l'utilisateur confirme la suppression du post. Une fois le post effacé, la liste des posts gérés par le composant TBPostsReport est actualisé et le rapport est raffraîchi.

```
TBPostsReport >> deletePost: aPost
	(self confirm: 'Do you want remove this post ?') ifTrue: [
		self repository removeBlogPost: aPost.
	]
```

###Gérer le problème du raffraichissement des données

Les méthodes `TBPostsReport >> addPost:` et `TBPostsReport >> deletePost:` font bien leur travail mais les données à l'écran ne sont pas à jour. Il faut donc raffraichir la liste des posts car il y a un décalage entre les données en mémoire et celles stockées dans la base de données.

```
TBPostsReport >> refreshReport
	self rows: (self repository allBlogPosts).
	self refresh.

TBPostsReport >> addPost
	| post |
	post := self call: (self renderAddPostForm: TBPost new).
	post ifNotNil: [
		self repository writeBlogPost: post.
 		self refreshReport
	]

TBPostsReport >> deletePost: aPost
	(self confirm: 'Do you want remove this post ?') ifTrue: [
		self repository removeBlogPost: aPost.
		self refreshReport
	]

```

> Le formulaire est fonctionnel maintenant et gère même les contraintes de saisie.

###Améliorer l'apparence du formulaire

Pour tirer partie de Bootstrap, nous allons modifier les définitions Magritte. Tout d'abord, spécifions que le rendu du formulaire doit se baser sur Bootstrap.

```
TBPost >> descriptionContainer
	<magritteContainer>
	^ super descriptionContainer
		componentRenderer: TBSMagritteFormRenderer;
		yourself
```

Nous pouvons maintenant nous occuper des différents champs de saisie et améliorer leur apparence.

````
TBPost >> descriptionTitle
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

TBPost >> descriptionText
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

TBPost >> descriptionCategory
	<magritteDescription>
	^ MAStringDescription new
		label: 'Category';
		priority: 300;
		accessor: #category;
		comment: 'Unclassified if empty';
		componentClass: TBSMagritteTextInputComponent;
		yourself

TBPost >> descriptionVisible
	<magritteDescription>
	^ MABooleanDescription new
		checkboxLabel: 'Visible';
		priority: 500;
		accessor: #visible;
		componentClass: TBSMagritteCheckboxComponent;
		beRequired;
		yourself
```

###Améliorer la gestion de l'authentification

L'administrateur du blog peut vouloir voyager entre la partie privée et la partie publique de TinyBlog. Pour savoir si l'utilisateur s'est authentifier, nous devons modifier l'objet session et ajouter une variable d'instance contenant une valeur booléenne.

```
WASession subclass: #TBSession
	instanceVariableNames: 'repository logged'
	classVariableNames: ''
	category: 'TinyBlog'

TBSession >> logged
	^ logged

TBSession >> logged: anObject
	logged := anObject

TBSession >> isLogged
	^self logged
```

Il faut ensuite initialiser à `false` cette variable d'instance à la création d'une session.

```
TBSession >> initialize
	super initialize.
	self initializeRepository.
	self logged: false.
```

Dans la partie privée de TinyBlog, ajoutons un lien permettant le retour à la partie publique. Nous utilisons ici la méthode `answer`puis l'écran d'administration a été appelé à l'aide de la méthode `call:`.

```
TBAdminComponent >> renderContentOn: html
	super renderContentOn: html.
	html tbsContainer: [
		html heading: 'Blog Manager'.
		html tbsGlyphIcon perform: #iconEyeOpen.
		html anchor
			callback: [ self answer ];
			with: 'Public Area'.
		html horizontalRule.
		html render: self report.
	]
```

Dans l'espace public, il nous faut modifier le comportement du lien permettant d'accéder à l'écran d'administration. Il doit provoquer l'affichage de la boite d'authentification uniquement si l'utilisateur ne s'est pas encore connecté.

```
TBPublicPostsListComponent >> renderSignInOn: html
	(self session isLogged)
		ifFalse: [
			html tbsGlyphIcon perform: #iconLock.
			html html: '<a data-toggle="modal" href="#myAuthDialog" class="link">SignIn</a>'
		]
		ifTrue: [
			html tbsGlyphIcon perform: #iconUser.
			html anchor callback: [ self gotoAdministrationScreen ]; with: 'Private area'
		]
```

Enfin, le composant `TBauthenticationComponent` doit mettre à jour la variable d'instance `logged` de la session si l'utilisateur est bien un administrateur.

```
TBauthenticationComponent >> validate
	(self account = 'admin' and: [ self password = 'password' ]) ifTrue: [
		self session logged: true.
		screen gotoAdministrationScreen
	]
```

> TP: Proposer l'ajout d'un bouton "Déconnexion"

##Localisation de l'interface

##Exposer le modèle de TinyBlog avec REST

##Exporter le contenu de TinyBlog (CSV,etc.)