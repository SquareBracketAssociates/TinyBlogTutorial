## TinyBlog : extension du modèle et tests unitaires

@chapModelExtensionAndUnitTests

%  full hash of full code 35785aaaf1284f1a472980f07522fc7d0d4743e6

Dans ce chapitre nous étendons le modèle et ajoutons des tests. Notez qu'un bon développeur de méthodologies agiles tel que Test-Driven Development aurait commencé par écrire des tests. En plus, avec Pharo, nous aurions aussi codé dans le débuggeur pour être encore plus productif. Nous ne l'avons pas fait car le modèle est simpliste et expliquer comment coder dans le débuggeur demande plus de description textuelle. Vous pouvez voir cette pratique dans la vidéo du Mooc intitulée _Coding a Counter in the Debugger_ \([http://rmod-pharo-mooc.lille.inria.fr/MOOC/WebPortal/co/content\_26.html](http://rmod-pharo-mooc.lille.inria.fr/MOOC/WebPortal/co/content_26.html)\) et lire le livre _Learning Object-Oriented Programming, Design with TDD in Pharo_ \([http://books.pharo.org](http://books.pharo.org)\).

Avant de commencer, reprenez votre code ou reportez-vous au dernier chapitre du livre pour charger le code du chapitre précédent.

%  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### La classe TBBlog

%  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nous allons développer la classe `TBBlog` qui contient des bulletins \(posts\), en écrivant des tests puis en les implémentant \(voir la figure *@postBlogUML@*\).

![TBBlog une classe très simple.](figures/postBlogUML.pdf width=60&label=postBlogUML)

```
Object subclass: #TBBlog
   instanceVariableNames: 'posts'
   classVariableNames: ''
   package: 'TinyBlog'
```


Nous initialisons la variable d'instance `posts` avec une collection vide.
```
TBBlog >> initialize
   super initialize.
   posts := OrderedCollection new. 
```


### Un seul blog


Dans un premier temps nous supposons que nous allons gérer qu'un seul blog. 
Dans le futur, vous pourrez ajouter la possibilité de gérer plusieurs blogs comme un par utilisateur de notre application. Pour l'instant, nous utilisons donc un singleton pour la classe `TBBlog`. 
Faites attention car le schéma de conception Singleton est rarement bien utilisé et peut rendre votre conception rapidement de mauvaise qualité. 
En effet, un singleton est souvent une sorte de variable globale et rend votre conception moins modulaire. 
Evitez de faire des références explicites au Singleton dans votre code. 
Quand vous utilisez un Singleton le mieux est d'y accéder via une variable d'instance qui pourra dans un second
temps faire référence à un autre objet sans vous forcer à tout réécrire.
Donc ne généralisez pas ce que nous faisons ici.

Comme la gestion du singleton est un comportement de classe, ces méthodes sont définies sur le coté classe de la classe `TBBlog`.
Nous définissons une variable d'instance au niveau classe:

```
TBBlog class
   instanceVariableNames: 'uniqueInstance'
```


Nous définissons deux méthodes pour gérer le singleton.
```
TBBlog class >> reset
   uniqueInstance := nil
```

```
TBBlog class >> current
   "Answer the instance of the class"
   ^ uniqueInstance ifNil: [ uniqueInstance := self new ]
```


Nous redéfinissons la méthode de classe `initialize` afin que la classe
soit réinitialisée quand elle est chargée en mémoire. 

```
TBBlog class >> initialize
   self reset
```



### Tester les règles métiers


Nous allons écrire des tests pour les règles métiers et ceci en mode TDD \(Test-Driven Development\) c'est-à-dire en développant les tests en premier puis en définissant les fonctionnalités jusqu'à ce que les tests passent.

Les tests unitaires sont regroupés dans une étiquette \(tag\) `TinyBlog-Tests` qui contient la classe `TBBlogTest` \(voir menu item "Add Tag..."\). Un tag est juste une étiquette qui permet de trier et grouper les classes à l'intérieur d'un package. Nous utilisons un tag ici pour ne pas avoir à gérer deux packages différents mais dans un projet réel nous définirions un \(ou plusieurs\) package séparé pour les tests.

```
TestCase subclass: #TBBlogTest
   instanceVariableNames: 'blog post first'
   classVariableNames: ''
   package: 'TinyBlog-Tests'
```


La méthode `setUp` permet d'initialiser le contexte des tests \(aussi appelé fixture\).
Elle est donc exécutée avant chaque test unitaire.
Dans cet exemple, elle efface le contenu du blog, lui ajoute un post et en créé un autre qui n'est provisoirement pas enregistré. 
Faites attention car nous devrons changer cette logique puisque dans le futur à chaque fois que vous exécuterez des tests, vous perdrez votre domaine. C'est un exemple de la sorte d'effets pernicieux qu'un Singleton introduit dans un système.

```
TBBlogTest >> setUp
   blog := TBBlog current.
   blog removeAllPosts.

   first := TBPost title: 'A title' text: 'A text' category: 'First Category'.
   blog writeBlogPost: first.

   post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible
```


Afin de tester différentes configurations, les posts `post` et `first` n'appartiennent pas à la même catégorie, l'un est visible et l'autre pas.

Définissons également la méthode `tearDown` qui est exécutée après chaque test et remet le blog à zéro. 

```
TBBlogTest >> tearDown
   TBBlog reset
```


L'utilisation d'un Singleton montre une de ses limites puisque si vous déployez un blog puis exécutez les tests vous perdrez les posts que vous avez créés car nous les remettons à zéro.

Nous allons développer les tests d'abord puis les fonctionnalités testées.
Les fonctionnalités métiers seront regroupées dans le protocole 'action' de la classe `TBBlog`.

### Un premier test


Commençons par écrire un premier test qui ajoute un post et vérifie qu'il est effectivement ajouté au blog.

```
TBBlogTest >> testAddBlogPost
   blog writeBlogPost: post.
   self assert: blog size equals: 2
```


Ce test ne passe pas \(n'est pas vert\) car nous n'avons pas défini les méthodes: `writeBlogPost:`,  `removeAllPosts` et `size`. 
Ajoutons-les.

```
TBBlog >> removeAllPosts
   posts := OrderedCollection new
```


```
TBBlog >> writeBlogPost: aPost
   "Add the blog post to the list of posts."
   posts add: aPost
```


```
TBBlog >> size
   ^ posts size
```


Le test précédent doit maintenant passer.


### Améliorons la couverture de test


Ecrivons d'autres tests pour couvrir les fonctionnalités que nous venons de développer. 

```
TBBlogTest >> testSize
   self assert: blog size equals: 1
```


```
TBBlogTest >> testRemoveAllBlogPosts
   blog removeAllPosts.
   self assert: blog size equals: 0
```


### Autres fonctionnalités


Nous allons procéder en suivant une méthodologie dirigée par les tests \(Test Driven Development\). Nous définissons 
un test, vérifions que le test ne passe pas. Puis nous définissons la méthode qui était ainsi spécifiée et nous vérifions 
que le test passe.

#### Obtenir l'ensemble des posts \(visibles et invisibles\)


Ajoutons un nouveau test qui échoue :

```
TBBlogTest >> testAllBlogPosts
   blog writeBlogPost: post.
   self assert: blog allBlogPosts size equals: 2
```


Et le code métier qui permet de le faire passer:

```
TBBlog >> allBlogPosts
   ^ posts
```


Votre nouveau test doit passer. 
#### Obtenir tous les posts visibles


Ajoutons un nouveau test qui échoue :

```
TBBlogTest >> testAllVisibleBlogPosts
   blog writeBlogPost: post.
   self assert: blog allVisibleBlogPosts size equals: 1
```


Voici le nouveau code métier ajouté :

```
TBBlog >> allVisibleBlogPosts
   ^ posts select: [ :p | p isVisible ]
```


Votre nouveau test doit passer. 

#### Obtenir tous les posts d'une catégorie


Ajoutons un nouveau test qui échoue :

```
TBBlogTest >> testAllBlogPostsFromCategory
   self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
```


Voici le nouveau code métier ajouté :

```
TBBlog >> allBlogPostsFromCategory: aCategory
   ^ posts select: [ :p | p category = aCategory ]
```


Votre nouveau test doit passer. 

#### Obtenir tous les posts visibles d'une catégorie


Ajoutons un nouveau test qui échoue :

```
TBBlogTest >> testAllVisibleBlogPostsFromCategory
   blog writeBlogPost: post.
   self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0.
   self assert: (blog allVisibleBlogPostsFromCategory: 'Second Category') size equals: 1
```


Voici le nouveau code métier ajouté :

```
TBBlog >> allVisibleBlogPostsFromCategory: aCategory
	^ posts select: [ :p | p category = aCategory 
									and: [ p isVisible ] ]
```


Votre nouveau test doit passer. 

#### Vérifier la gestion des posts non classés


Nous ajoutons un nouveau test pour vérifier que notre fixture ne contient pas de tests non classifiés.
```
TBBlogTest >> testUnclassifiedBlogPosts
   self assert: (blog allBlogPosts select: [ :p | p isUnclassified ]) size equals: 0
```


#### Obtenir la liste des catégories


Ajoutons un nouveau test qui retourne la liste des catégories et qui échoue :
```
TBBlogTest >> testAllCategories
   blog writeBlogPost: post.
   self assert: blog allCategories size equals: 2
```


Voici le code métier :

```
TBBlog >> allCategories
   ^ (self allBlogPosts collect: [ :p | p category ]) asSet
```


Votre nouveau test doit passer.

### Données de test 


Afin de nous aider à tester l'application nous définissons une méthode qui ajoute des posts au blog courant.

```
TBBlog class >> createDemoPosts
   "TBBlog createDemoPosts"
   self current 
      writeBlogPost: ((TBPost title: 'Welcome in TinyBlog' text: 'TinyBlog is a small blog engine made with Pharo.' category: 'TinyBlog') visible: true);
      writeBlogPost: ((TBPost title: 'Report Pharo Sprint' text: 'Friday, June 12 there was a Pharo sprint / Moose dojo. It was a nice event with more than 15 motivated sprinters. With the help of candies, cakes and chocolate, huge work has been done' category: 'Pharo') visible: true);
      writeBlogPost: ((TBPost title: 'Brick on top of Bloc - Preview' text: 'We are happy to announce the first preview version of Brick, a new widget set created from scratch on top of Bloc. Brick is being developed primarily by Alex Syrel (together with Alain Plantec, Andrei Chis and myself), and the work is sponsored by ESUG. 
      Brick is part of the Glamorous Toolkit effort and will provide the basis for the new versions of the development tools.' category: 'Pharo') visible: true);
      writeBlogPost: ((TBPost title: 'The sad story of unclassified blog posts' text: 'So sad that I can read this.') visible: true);
      writeBlogPost: ((TBPost title: 'Working with Pharo on the Raspberry Pi' text: 'Hardware is getting cheaper and many new small devices like the famous Raspberry Pi provide new computation power that was one once only available on regular desktop computers.' category: 'Pharo') visible: true)
```


Vous pouvez inspecter le résultat de l'évaluation du code suivant :

```
	TBBlog createDemoPosts ; current
```


Attention, si vous exécutez plus d'une fois la méthode `createDemoPosts`, le blog contiendra plusieurs exemplaires de ces posts.

### Futures évolutions


Plusieurs évolutions peuvent être apportées telles que: obtenir uniquement la liste des catégories contenant au moins un post visible, effacer une catégorie et les posts qu'elle contient, renommer une catégorie, déplacer un post d'une catégorie à une autre, rendre visible ou invisible une catégorie et son contenu, etc. Nous vous encourageons à développer ces fonctionnalités ou de nouvelles que vous auriez imaginé.


### Conclusion


Vous devez avoir le modèle complet de TinyBlog ainsi que des tests unitaires associés. Vous êtes maintenant prêt pour des fonctionnalités plus avancées comme le stockage ou un premier serveur HTTP. C'est aussi un bon moment pour sauver votre code dans votre dépôt en ligne.


