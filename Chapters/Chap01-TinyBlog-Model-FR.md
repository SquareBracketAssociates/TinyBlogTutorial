## Modèle de l'application TinyBlog

@cha:model

Dans ce chapitre, nous développons une partie du modèle de l'application Tinyblog.
Le modèle est particulièrement simple : il définit un bulletin. Dans le chapitre suivant
nous définissons un blog qui contient une liste de bulletins.

### La classe TBPost


![TBPost une classe très simple gérant principalement des données.](figures/postUML.pdf width=20&label=postUml)

Nous commençons ici par la représentation d'un bulletin \(post\) avec la classe `TBPost`. Elle est très simple \(comme le montre la figure *@postUml@*\) et elle définie ainsi:

```
Object subclass: #TBPost
   instanceVariableNames: 'title text date category visible'
   classVariableNames: ''
   package: 'TinyBlog'
```


Nous utilisons cinq variables d'instance pour décrire un bulletin sur le blog.


| Variable | Signification |  |
| --- | --- | --- |
| title | Titre du bulletin |  |
| text | Texte du bulletin |  |
| date | Date de redaction |  |
| category | Rubrique contenant le bulletin |  |
| visible | Post visible ou pas ? |  |


Cette classe est également dotée de méthodes d'accès \(aussi appelées accesseurs\) à ces variables d'instances dans le protocole 'accessing'. Vous pouvez utiliser un refactoring pour créer automatiquement toutes les méthodes suivantes:

```
TBPost >> title
   ^ title
```

```
TBPost >> title: aString
   title := aString
```

```
TBPost >> text
   ^ text
```

```
TBPost >> text: aString
   text := aString
```

```
TBPost >> date
   ^ date
```

```
TBPost >> date: aDate
   date := aDate
```

```
TBPost >> visible
   ^ visible
```

```
TBPost >> visible: aBoolean
   visible := aBoolean
```

```
TBPost >> category
   ^ category
```

```
TBPost >> category: anObject
   category := anObject
```




### Gérer la visibilité d'un post


Ajoutons dans le protocole 'action' des méthodes pour indiquer qu'un post est visible ou pas.

```
TBPost >> beVisible
   self visible: true
```

```
TBPost >> notVisible
   self visible: false
```



### Initialisation


La méthode `initialize` \(protocole 'initialization'\) fixe la date à celle du jour et la visibilité à faux. L'utilisateur devra par la suite activer la visibilité.
Cela permet de rédiger des brouillons et de ne publier un bulletin que lorsque celui-ci est terminé.
Un bulletin est également rangé par défaut dans la catégorie 'Unclassified' que l'on définit au niveau classe.
La méthode `unclassifiedTag` renvoie une valeur indiquant que le post n'est pas rangé dans une catégorie.

```
TBPost class >> unclassifiedTag
   ^ 'Unclassified'
```


Attention la méthode `unclassifiedTag` est définie au niveau de la classe \(cliquer le bouton 'Class' pour la définir\). Les autres méthodes sont des méthodes d'instances c'est-à-dire qu'elles seront exécutées sur des instances de la classe `TBPost`.

```
TBPost >> initialize
	super initialize.
	self category: TBPost unclassifiedTag.
	self date: Date today.
	self notVisible
```


Dans la solution proposée ci-dessus pour la méthode `initialize`, il serait préférable de ne pas faire une référence en dur à la classe `TBPost`. Proposer une solution. La séquence 3 de la semaine 6 du MOOC peut vous aider à mieux comprendre pourquoi \([http://rmod-pharo-mooc.lille.inria.fr/MOOC/WebPortal/co/content\_67.html](http://rmod-pharo-mooc.lille.inria.fr/MOOC/WebPortal/co/content_67.html)\) il faut éviter de référencer des classes directement et comment faire.

### Méthodes de création


Coté classe, on définit des méthodes de classe \(i.e., exécuter sur des classes\) pour faciliter la création de post appartenant ou pas à une catégorie - de telles méthodes sont souvent groupées dans le protocole 'instance creation'.

Nous définissons deux méthodes.
```
TBPost class >> title: aTitle text: aText
   ^ self new
        title: aTitle;
        text: aText;
        yourself
```


```
TBPost class >> title: aTitle text: aText category: aCategory
   ^ (self title: aTitle text: aText)
            category: aCategory;
            yourself
```


### Création de posts


Créons des posts pour s'assurer que tout fonctionne. Ouvrez l'outil Playground et executez l'expression suivante :

```
TBPost
	title: 'Welcome in TinyBlog'
	text: 'TinyBlog is a small blog engine made with Pharo.'
	category: 'TinyBlog'
```


Si vous inspectez le code ci-dessus \(clic droit sur l'expression et "Inspect it"\), vous allez obtenir un inspecteur sur l'objet post nouvellement créé comme représenté sur la figure *@inspectorOnTBPost@*.

![Inspecteur sur une instance de TBPost.](figures/inspectorOnTBPost.png width=100&label=inspectorOnTBPost)

### Ajout de quelques tests unitaires


Inspecter manuellemment des objets n'est pas une manière systématique de vérifier que ces objets ont les propriétes attendues.
Bien que le modèle soit simple nous pouvons définir quelques tests.
En mode Test Driven Developpement nous écrivons les tests en premier.
Ici nous avons préféré vous laissez définir une petite classe pour vous familiariser avec l'IDE.
Mais maintenant nous réparons ce manque.

Nous définissons la classe `TBPostTest` \(comme sous-classe de `TestCase`\).

```
TestCase subclass: #TBPostTest
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'TinyBlog-Tests'
```


Nous définissons deux tests.

```
TBPostTest >> testWithoutCategoryIsUnclassified

	| post |
	post := TBPost
		title: 'Welcome to TinyBlog'
		text: 'TinyBlog is a small blog engine made with Pharo.'.
	self assert: post title equals: 'Welcome to TinyBlog' .
	self assert: post category = TBPost unclassifiedTag.
```



```
TBPostTest >> testPostIsCreatedCorrectly

		| post |
		post := TBPost
			title: 'Welcome to TinyBlog'
			text: 'TinyBlog is a small blog engine made with Pharo.'
			category: 'TinyBlog'.
		self assert: post title equals: 'Welcome to TinyBlog' .
		self assert: post text equals: 'TinyBlog is a small blog engine made with Pharo.' .
```


Vos tests doivent passer.



### Interrogation d'un post


Dans le protocole 'testing', définissez les deux méthodes suivantes qui permettent respectivement, de demander à un post s'il est visible, et s'il est classé dans une catégorie.

```
TBPost >> isVisible
   ^ self visible
```

```
TBPost >> isUnclassified
   ^ self category = TBPost unclassifiedTag
```


De même il serait préférable de ne pas faire une référence en dur à la classe `TBPost` dans le corps d'une méthode.
Proposer une solution!


De plus, prenons le temps de mettre à jour notre test pour couvrir ce nouvel aspect.
Nous simplifions de cette manière la logique de notre test.

```
TBPostTest >> testWithoutCategoryIsUnclassified

	| post |
	post := TBPost
		title: 'Welcome to TinyBlog'
		text: 'TinyBlog is a small blog engine made with Pharo.'.
	self assert: post title equals: 'Welcome to TinyBlog' .
	self assert: post isUnclassified.
	self deny: post isVisible
```



### Conclusion


Nous avons développé une première partie du modèle \(la classe `TBPost`\) et défini quelques tests. Nous vous suggérons fortement
d'écrire d'autres tests unitaires pour vérifier que ce modèle fonctionne correctement même s'il est simple.
