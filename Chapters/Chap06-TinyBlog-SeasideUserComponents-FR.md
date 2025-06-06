## Des composants web pour TinyBlog


Dans ce chapitre, commençons par définir une interface publique permettant d'afficher les bulletins (posts) du blog. Nous raffinons cela dans le chapitre suivant. 

Si vous avez le sentiment d'être un peu perdu, la figure *@ApplicationArchitectureUserWithoutCategory@* vous montre les composants sur lesquels nous allons travailler dans ce chapitre. 

![L'architecture des composants utilisateurs (par opposition à administration).](figures/ApplicationArchitectureUserWithoutCategory.pdf width=75&label=ApplicationArchitectureUserWithoutCategory)

Le travail présenté dans la suite est indépendant de celui sur Voyage et sur la base de données MongoDB.
Les instructions pour charger le code des chapitres précédents sont disponibles dans le chapitre *@cha:loading@*.

### Composants visuels 


Nous sommes maintenant prêts à définir les composants visuels de notre application Web. La figure *@ComponentOverview@* montre les différents composants que nous allons développer dans ce chapitre et où ils se situent.

![Les composants visuels de l'application TinyBlog.](figures/ComponentOverview-ListPosts.pdf width=75&label=ComponentOverview)

#### Le composant TBScreenComponent


Le composant `TBApplicationRootComponent` contiendra des composants sous-classes de la classe abstraite `TBScreenComponent`. Cette classe nous permet de factoriser les comportements que nous souhaitons partager entre tous nos composants.

```
WAComponent subclass: #TBScreenComponent
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


Les différents composants d'interface de TinyBlog ont besoin d'accéder aux règles métier de l'application. Dans le protocole 'accessing', créons une méthode `blog` qui retourne une instance de `TBBlog` (ici notre singleton). Notez que cette méthode pourrait renvoyer l'instance de blog avec laquelle elle a été configurée au préalable.

```
TBScreenComponent >> blog
   "Return the current blog. In the future we will ask the
   session to return the blog of the currently logged in user."
   ^ TBBlog current
```


Par la suite, si l'on souhaite étendre TinyBlog pour qu'un utilisateur puisse avoir plusieurs blogs, il suffira de modifier cette méthode pour utiliser des informations stockées dans la session active (Voir `TBSession` dans le chapitre suivant).

Définissez la méthode `renderContentOn:` de ce composant comme suit temporairement. Notez que pour l'instant, nous n'affichons pas ce composant
donc rafraichir votre browser ne vous montre rien de nouveau et c'est normal.

```
TBScreenComponent >> renderContentOn: html
   html text: 'Hello from TBScreenComponent'
```


### Utilisation du composant Screen


Bien que le composant `TBScreenComponent` n'ait pas vocation à être utilisé directement, nous allons l'utiliser de manière temporaire pendant que nous développons les autres composants. 


Nous ajoutons la variable d'instance `main` dans la classe `TBApplicationRootComponent`. 
```
WAComponent subclass: #TBApplicationRootComponent
	instanceVariableNames: 'main'
	classVariableNames: ''
	package: 'TinyBlog-Components'
```


![Le composant `ApplicationRootComponent` utilise de manière temporaire le composant `ScreenComponent` qui a un `HeaderComponent`.](figures/ComponentRelationship1.pdf width=75&label=compt1)

Nous initialisons cette variable d'instance dans la méthode `initialize` suivante et redéfinissons la méthode `children`. Nous obtenons la situation décrite par la figure *@compt1@*.


```
TBApplicationRootComponent >> initialize
   super initialize.
   main := TBScreenComponent new
```



```
TBApplicationRootComponent >> renderContentOn: html
   html render: main
```


Nous déclarons aussi la relation de contenu en retournant le composant référencé par la variable `main` parmi les enfants de `TBApplicationRootComponent`.
```
TBApplicationRootComponent >> children
   ^ { main }
```


Si vous rafraichissez votre browser, vous allez voir l'affichage produit par le sous-composant `TBScreenComponent` qui affiche pour l'instant le texte: `Hello from TBScreenComponent` (voir la figure *@fig:Hello@*).

![Premier visuel du composant `TBScreenComponent`.](figures/HelloFromScreenComponent.png width=75&label=fig:Hello)


### Pattern de définition  de composants


Nous allons souvent utiliser la même façon de procéder:
- nous définissons d'abord la classe et le comportement d'un nouveau composant;
- puis, nous allons y faire référence depuis la classe qui utilisera ce composant pour satisfaire les contraintes de Seaside;
- en particulier, nous exprimons la relation entre un composant et un sous-composant en redéfinissant la méthode `children`.


### Ajouter quelques bulletins au blog


Vérifiez que votre blog a quelques bulletins : 
```
TBBlog current allBlogPosts size
```


Si il n'en contient aucun, recréez-en : 
```
TBBlog createDemoPosts
```



### Définition du composant TBHeaderComponent


Définissons une en-tête commune à toutes les pages de TinyBlog dans un composant nommé `TBHeaderComponent`.
Ce composant sera inséré dans la partie supérieure de chaque composant (`TBPostsListComponent` par exemple). Nous appliquons le schéma décrit ci-dessus: définition d'une classe, référence depuis la classe utilisatrice, et redéfinition de la méthode `children`.

Nous définissons d'abord sa classe, puis nous allons y faire référence depuis la classe qui l'utilise. Ce faisant, nous allons montrer comment un composant exprime sa relation à un sous-composant. 

```
WAComponent subclass: #TBHeaderComponent
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
```



### Utilisation du composant header


Complétons maintenant la classe `TBScreenComponent` afin qu'elle affiche une instance de `TBHeaderComponent`.
Pour rappel, `TBScreenComponent` est la super-classe abstraite (nous l'utilisons directement pour l'instant) de tous nos composants dans l'architecture finale. Cela signifie que toutes les sous-classes de  `TBScreenComponent` seront des composants avec une en-tête.
Pour éviter d'instancier systématiquement le composant `TBHeaderComponent` à chaque fois qu'un composant est appelé, créons et initialisons une variable d'instance `header` dans `TBScreenComponent`.

```
WAComponent subclass: #TBScreenComponent
   instanceVariableNames: 'header'
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


Créons une méthode `initialize` dans le protocole 'initialization' :

```
TBScreenComponent >> initialize
   super initialize.
   header := self createHeaderComponent
```


```
TBScreenComponent >> createHeaderComponent
   ^ TBHeaderComponent new
```


Notez que nous avons une méthode spécifique pour créer le composant en-tête. Nous pouvons ainsi redéfinir cette méthode afin de changer le composant en-tête. Cela sera utile pour la partie administration du site.

### Relation composite-composant


En Seaside, les sous-composants d'un composant doivent être retournés par le composite en réponse au message `children`. Définissons que l'instance du composant `TBHeaderComponent` est un enfant de `TBScreenComponent` dans la hiérarchie des composants Seaside (et non entre classes Pharo). Dans cet exemple, nous spécialisons la méthode `children` pour qu'elle retourne une collection contenant un seul élément qui est l'instance de `TBHeaderComponent` référencée depuis la variable `header`.

```
TBScreenComponent >> children
   ^ { header }
```


### Rendu visuel de la barre de navigation


Affichons maintenant le composant dans la méthode `renderContentOn:` (protocole 'rendering') :

```
TBScreenComponent >> renderContentOn: html
   html render: header
```


Si vous rafraichissez votre navigateur web, rien ne se passe car le composant `TBHeaderComponent`
n'a pas de rendu visuel. Pour cela, définissons la méthode `renderContentOn:` chargée d'afficher l'en-tête comme suit :

```
TBHeaderComponent >> renderContentOn: html
	html tbsNavbar beDefault; with: [  
		 html tbsContainer: [ 
			self renderBrandOn: html
	]]
```


```
TBHeaderComponent >> renderBrandOn: html
   html tbsNavbarHeader: [ 
      html tbsNavbarBrand
         url: self application url;
         with: 'TinyBlog' ]
```


L'en-tête (header) est affichée à l'aide d'une barre de navigation Bootstrap.
Si vous faites un rafraichissement de l'application dans votre navigateur web vous devez voir apparaitre l'en-tête comme sur la figure *@navBlog@*.

![TinyBlog avec une barre de navigation.](figures/navBlog.png width=75&label=navBlog)

Par défaut dans une barre de navigation Bootstrap, il y a un lien sur le titre de l'application (`tbsNavbarBrand` ) qui permet de revenir à la page de départ du site. 

#### Améliorations possibles


Le nom du blog devrait être paramétrable à l'aide d'une variable d'instance dans la classe `TBBlog` et l'en-tête pourrait afficher ce titre.

### Liste des posts


Créons un composant `TBPostsListComponent` pour afficher la liste des bulletins (posts) - ce qui reste d'ailleurs le but d'un blog. Ce composant constitue la partie publique du blog offerte aux lecteurs du blog. 

Pour cela, définissons une sous-classe de `TBScreenComponent` (comme illustré dans la figure *@compt2@*):

```
TBScreenComponent subclass: #TBPostsListComponent
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
```



![Le composant `ApplicationRootComponent` utilise le composant `PostsListComponent`.](figures/ComponentRelationship2.pdf width=75&label=compt2)

Nous pouvons maintenant modifier le composant principal de l'application (`TBApplicationRootComponent`) pour qu'il affiche ce nouveau composant. Pour cela nous modifions sa méthode `initialize` ainsi: 

```
TBApplicationRootComponent >> initialize
   super initialize.
   main := TBPostsListComponent new 
```


Ajoutons également une méthode setter (`main:`) qui nous permettra par la suite, de changer dynamiquement le sous-composant à afficher tout en gardant le composant actuel (instance de `TBPostsListComponent`) par défaut. 

```
TBApplicationRootComponent >> main: aComponent
   main := aComponent
```



Ajoutons une méthode `renderContentOn:` (protocole rendering) provisoire pour tester l'avancement de notre application (voir figure *@elementary@*). Notez que cette méthode fait un appel à la méthode `renderContentOn:` de la super-classe qui va afficher le composant en-tête. 

```
TBPostsListComponent >> renderContentOn: html
   super renderContentOn: html.
   html text: 'Blog Posts here !!!'
```



![TinyBlog avec une liste de bulletins plutot élémentaire.](figures/ElementaryListPost.png width=65&label=elementary)

Si vous rafraichissez la page de TinyBlog dans votre navigateur, vous devriez obtenir la même chose que sur la figure *@elementary@*.


### Le composant Post


Nous allons maintenant définir le composant `TBPostComponent` qui affiche le contenu d'un bulletin (post).

Chaque bulletin du blog sera représenté visuellement par une instance de  `TBPostComponent` qui affiche le titre, la date et le contenu d'un bulletin. Nous allons obtenir la situation décrite par la figure *@compt3@*.

![Ajout du composant Post.](figures/ComponentRelationship3.pdf width=75&label=compt3)

```
WAComponent subclass: #TBPostComponent
   instanceVariableNames: 'post'
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


```
TBPostComponent >> initialize
      super initialize.
      post := TBPost new
```


```
TBPostComponent >> title
   ^ post title
```


```
TBPostComponent >> text
   ^ post text
```


```
TBPostComponent >> date
   ^ post date
```


Ajoutons la méthode `renderContentOn:` qui définit l'affichage du post.

```
TBPostComponent >> renderContentOn: html
   html heading level: 2; with: self title.
   html heading level: 6; with: self date.
   html text: self text
```



#### A propos des formulaires


Dans le chapitre sur l'interface d'administration, nous utiliserons Magritte et montrerons qu'il est rare de définir un composant de manière aussi manuelle comme ci-dessus. En effet, Magritte permet de décrire les données manipulées et offre ensuite la possibilité de générer automatiquement des composants Seaside. Le code équivalent à celui ci-dessus en Magritte serait comme suit: 

```
TBPostComponent >> renderContentOn: html
   "DON'T WRITE THIS YET"
   html render: post asComponent
```



### Afficher les bulletins (posts)


Il ne reste plus qu'à modifier la méthode `renderContentOn:` de la classe `TBPostsListComponent` pour afficher l'ensemble des bulletins visibles présents dans la base.

```
TBPostsListComponent >> renderContentOn: html
   super renderContentOn: html.
   self blog allVisibleBlogPosts do: [ :p |
      html render: (TBPostComponent new post: p) ]
```


Rafraichissez la page de votre navigateur et vous devez obtenir une page d'erreur.

### Débugger les erreurs


Par défaut, lorsqu'une erreur se produit dans une application, Seaside retourne une page HTML contenant un message. Vous pouvez changer ce message, mais le plus pratique pendant le développement de l'application est de configurer Seaside pour qu'il ouvre un debugger dans Pharo. Pour cela, exécuter le code suivant :

```
(WAAdmin defaultDispatcher handlerAt: 'TinyBlog') 
    exceptionHandler: WADebugErrorHandler
```


Rafraîchissez la page de votre navigateur et vous devez obtenir un debugger côté Pharo.
L'analyse de la pile d'appels montre qu'il manque la méthode suivante :

```
TBPostComponent >> post: aPost
   post := aPost
```


Vous pouvez ajouter cette méthode dans le debugger avec le bouton `Create`. Quand c'est fait, appuyez sur le bouton `Proceed`. La page de votre navigateur doit maintenant montrer la même chose que la figure *@better@*.

![TinyBlog avec une liste de posts.](figures/betterListPosts.png width=65&label=better)


### Affichage de la liste des posts avec Bootstrap


Nous allons utiliser Bootstrap pour rendre la liste un peu plus jolie à l'aide d'un container en utilisant le message `tbsContainer: ` comme suit :

```
TBPostsListComponent >> renderContentOn: html
   super renderContentOn: html.
   html tbsContainer: [ 
      self blog allVisibleBlogPosts do: [ :p |
          html render: (TBPostComponent new post: p) ] ]
```


Rafraichissez la page et vous devez obtenir la figure *@ComponentOverview@*.
%  +TinyBlog avec une liste de posts affichée avec Bootstrap.>file://figures/ContainerList.png|width=65|label=container+

### Cas d'instanciation de composants dans renderContentOn:


Nous avons dit que la méthode `children` d'un composant devait retourner ses sous-composants.
En effet, avant d'exécuter la méthode `renderContentOn:` d'un composite, Seaside a besoin de retrouver tous les sous-composants de ce composite et notamment leurs états. 

Toutefois, si des sous-composants sont instanciés systématiquement dans la méthode `renderContentOn:` du composite,  comme c'est le cas dans la méthode `renderContentOn:` de la classe `TBPostsListComponent` ci-dessus, il n'est pas nécessaire qu'ils soient stockés et retournés par la méthode  `children` du composite.
Bien évidemment, instancier systématiquement des sous-composants dans la méthode `renderContentOn:` n'est pas forcément une bonne pratique car cela allonge le délai de rendu d'une page Web.

Si nous voulions stocker les sous-composants permettant d'afficher les bulletins, nous aurions ajouté et initialisé une variable d'instance `postComponents`.

```
TBPostsListComponent >> initialize
	super initialize.
	postComponents := OrderedCollection new
```


Nous aurions ajouté la méthode `postComponents` calculant les composants pour les bulletins. 

```
TBPostsListComponent >> postComponents 
	postComponents := self readSelectedPosts
			collect: [ :each | TBPostComponent new post: each ].
	^ postComponents 
```


Et nous aurions finalement modifié la méthode `children` et `renderContentOn:` 
```
TBPostsListComponent >> children 
	^ self postComponents, super children
```


```
TBPostsListComponent >> renderContentOn: html
	super renderContentOn: html.
	html tbsContainer: [ 
		self postComponents do: [ :p |
				html render: p ] ]
```


Nous ne le faisons pas car cela complique le code et n'apporte pas grand chose puisque les sous-composants sont tout de même instanciés à chaque rendu du composant `TBPostsListComponent`.


### Conclusion


Nous avons développé le rendu d'une liste de bulletins et dans le chapitre suivant nous allons ajouter la gestion des catégories. 

Avec Seaside, le programmeur n'a pas à se soucier de gérer les requêtes web, ni l'état de l'application. Il définit des composants qui sont créés et sont proches des composants pour applications de bureau.

Un composant Seaside est responsable d'assurer son rendu en spécialisant la méthode `renderContentOn:`.
De plus un composant doit retourner ses sous-composants en spécialisant la méthode `children`.
