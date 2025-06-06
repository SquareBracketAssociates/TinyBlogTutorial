## Persistance des données de TinyBlog avec Voyage et Mongo



Avoir un modèle d'objets en mémoire fonctionne bien, et sauvegarder l'image Pharo sauve aussi ces objets. 
Toutefois, il est préférable de pouvoir sauver les objets \(les posts\) dans une base de données extérieure. 
Pharo offre plusieurs sérialiseurs d'objets \(Fuel en format binaire et STON en format texte\). 
Ces sérialiseurs d'objets sont très puissants et pratiques. 
Souvent sauver un graphe complet d'objets est réalisé en une seule ligne de code comme explique dans le livre Enterprise Pharo disponible à [http://books.pharo.org](http://books.pharo.org).

Dans ce chapitre, nous voulons vous présenter une autre option : la sauvegarde dans une base de données orientée documents telle que Mongo \([https://www.mongodb.com](https://www.mongodb.com)\) en utilisant le framework Voyage. 
Voyage est un framework qui propose une API unifiée permettant d'accéder à différentes bases de données documents comme Mongo ou UnQLite afin d'y stocker des objets.

Dans ce chapitre, nous allons commencer par utiliser la capacité de Voyage à simuler une base extérieure. 
Ceci est très pratique en phase de développement. 
Dans un second temps, nous installerons une base de données Mongo et nous y accéderons à travers Voyage.

Comme pour chacun des chapitres précédents vous pouvez charger le code comme indiqué dans le dernier chapitre.


### Configurer Voyage pour sauvegarder des objets TBBlog


Grâce à la méthode de classe `isVoyageRoot`, nous déclarons que les objets de la classe `TBBlog` doivent être sauvés dans la base en tant qu'objets racines. 
Cela veut dire que nous aurons autant de documents que d'objets instance de cette classe.

```
TBBlog class >> isVoyageRoot
   "Indicates that instances of this class are top level documents in noSQL databases"
   ^ true
```


Nous devons ensuite soit créer une connexion sur une base de données réelle soit travailler en mémoire. 
C'est cette dernière option que nous choisissons pour l'instant en utilisant cette expression. 

```
VOMemoryRepository new enableSingleton.
```


Le message `enableSingleton` indique à Voyage que nous n'utilisons qu'une seule base de données.

Nous définissons une méthode `initializeVoyageOnMemoryDB` dont le rôle est d'initialiser correctement la base. 

```
TBBlog class >> initializeVoyageOnMemoryDB
   VOMemoryRepository new enableSingleton
```



Nous définissons la méthode de classe `reset` afin de réinitialiser la base de données.
Nous redéfinissons également la méthode class `initialize` pour réinitialiser la base de données lorsque l'on charge le code c'est-à-dire lorsque la classe `TBBlog` est chargée.

```
TBBlog class >> reset
      self initializeVoyageOnMemoryDB
```


```
TBBlog class >> initialize
      self reset
```


N'oubliez pas d'exécuter la méthode `initialize` une fois la méthode définie en exécutant expression `TBBlog initialize`.

Le cas de la méthode `current` est plus délicat. Avant l'utilisation de Mongo, nous avions un singleton tout simple. 
Cependant utiliser un Singleton ne fonctionne plus car imaginons que nous ayons sauvé notre blog et que le serveur s'éteigne par accident ou que nous rechargions une nouvelle version du code. 
Ceci conduirait à une réinitialisation et création d'une nouvelle instance. 
Nous pouvons donc nous retrouver avec une instance différente de celle sauvée. 

Nous redéfinissons `current` de manière à faire une requête dans la base. 
Comme pour le moment nous ne gérons qu'un blog il nous suffit de faire `self selectOne: [ :each | true ]` ou `self selectAll anyOne`. 
Nous nous assurons de créer une nouvelle instance et la sauvegarder si aucune instance n'existe dans la base. 

```
TBBlog class >> current
   ^ self selectAll 
			ifNotEmpty: [ :x | x anyOne ]
			ifEmpty: [ self new save ]
```


La variable `uniqueInstance` qui servait auparavant à stocker le singleton `TBBlog` peut être enlevée.

```
TBBlog class
	instanceVariableNames: ''
```


### Sauvegarde d'un blog


Nous devons maintenant modifier la méthode `writeBlogPost:` pour sauver le blog lors de l'ajout d'un post.

```
TBBlog >> writeBlogPost: aPost
	"Write the blog post in database"
	self allBlogPosts add: aPost.
	self save
```


Nous pouvons aussi modifier la méthode `remove` afin de sauver le nouvel état d'un blog. 

```
TBBlog >> removeAllPosts
	posts := OrderedCollection new.
	self save.
```


### Revision des tests


Maintenant que nous sauvons les blogs dans une base \(quelle soit en mémoire ou dans une base Mongo\), nous devons faire attention car si un test modifie la base, notre base courante \(hors test\) sera elle aussi modifiée : Cette situation est clairement dangereuse. 
Un test ne doit pas modifier l'état du système.

Pour résoudre ce problème, avant de lancer un test nous allons garder une référence au blog courant, créer un nouveau contexte puis nous allons utiliser cette référence pour restaurer le blog courant après l'exécution d'un test.


Nous ajoutons la variable d'instance `previousRepository` à la classe `TBBLogTest`.

```
TestCase subclass: #TBBlogTest
	instanceVariableNames: 'blog post first previousRepository'
	classVariableNames: ''
	package: 'TinyBlog-Tests'
```


Ensuite, nous modifions donc la méthode `setUp` pour sauver la base de données avant l'exécution du test. 
Nous créons un objet base de données temporaire qui sera celui qui sera modifié par le test.

```
TBBlogTest >> setUp
	previousRepository := VORepository current.
	VORepository setRepository: VOMemoryRepository new.
	blog := TBBlog current.
	first := TBPost title: 'A title' text: 'A text' category: 'First Category'.
	blog writeBlogPost: first.
	post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible
```


Dans la méthode `tearDown`, à la fin de l'exécution d'un test nous réinstallons l'objet base données que nous avons sauvé avant l'exécution.

```
TBBlogTest >> tearDown
	VORepository setRepository: previousRepository
```



Notez que les méthodes `setUp` et `tearDown` sont exécutées avant et après l'exécution de chaque test.


### Utilisation de la base


Alors même que la base est en mémoire et bien que nous pouvons accéder au blog en utilisant le singleton de la classe `TBBlog`,
nous allons montrer l'API offerte par Voyage. 
C'est la même API que nous pourrons utiliser pour accéder à une base Mongo.

Nous créons des posts ainsi :
```
TBBlog createDemoPosts.
```


Nous pouvons compter le nombre de blogs. `count` fait partie de l'API directe de Voyage. Ici nous obtenons 1 ce qui est normal puisque le blog est implémentée comme un singleton. 

```
TBBlog count
>1
```


De la même manière, nous pouvons sélectionner tous les objets sauvés. 

```
TBBlog selectAll	
```


On peut supprimer un objet racine en lui envoyant le message `remove`.

Vous pouvez voir l'API de Voyage en parcourant
- la classe `Class`, et 
- la classe `VORepository` qui est la racine d'héritage des bases de données en mémoire ou extérieure.


Ces requêtes sont plus pertinentes quand on a plus d'objets mais nous ferions exactement les mêmes. 

### Si nous devions sauvegarder les posts \[Discussion\]


Cette section n'est pas à implémenter. Elle est juste donnée à titre de discussion
\(Plus d'explications sont données dans le chapitre sur Voyage dans le livre _Enterprise Pharo: a Web Perspective_ disponible a [http://books.pharo.org](http://books.pharo.org)\). 
Nous voulons illustrer que déclarer une classe comme une racine Voyage a une influence sur comment une instance de cette classe est sauvée et rechargée. 

En particulier, déclarer un post comme une racine a comme effet que les objets posts seront des documents à part entière et ne seront plus une sous-parties d'un blog.

Lorsqu'un post n'est pas une racine, vous n'avez pas la certitude d'unicité de celui-ci lors du chargement depuis la base. 
En effet, lors du chargement \(et ce qui peut être contraire à la situation du graphe d'objet avant la sauvegarde\) un post n'est alors pas partagé entre deux instances de blogs. 
Si avant la sauvegarde en base un post était partagé entre deux blogs, après le chargement depuis la base, ce post sera dupliqué car recréé à partir de la définition du blog \(et le blog contient alors complètement le post\).

Nous pourrions définir qu'un post soit un élément qui peut être sauvegardé de manière autonome.
Cela permettrait de sauver des posts de manière indépendante d'un blog.

Cependant tous les objets n'ont pas vocation être définis comme des racines.
Si nous représentions les commentaires d'un post, nous ne les déclarerions pas comme racine car sauver ou manipuler un commentaire en dehors du contexte de son post ne fait pas beaucoup de sens. 

#### Post comme racine = Unicité

Si vous désirez qu'un bulletin soit partagé et unique entre plusieurs instances de blog, alors les objets `TBPost` doivent être déclarés comme une racine dans la base. 
Lorsque c'est le cas, les bulletins sont sauvés comme des entités autonomes et les instances de `TBBlog` feront référence à ces entités au lieu que leurs définitions soient incluses dans celle des blogs. 
Cela a pour effet qu'un post donné devient unique et partageable via une référence depuis le blog. 

Pour cela nous définirions les méthodes suivantes:

```
TBPost class >> isVoyageRoot
   "Indicates that instances of this class are top level documents in noSQL databases"
   ^ true
```


Lors de l'ajout d'un post dans un blog, il est maintenant important de sauver le blog et le nouveau post.

```
TBBlog >> writeBlogPost: aPost
   "Write the blog post in database"
   posts add: aPost.
   aPost save. 
   self save 
```



```
TBBlog >> removeAllPosts
   posts do: [ :each | each remove ].
   posts := OrderedCollection new.
   self save.
```


Ici dans la méthode `removeAllPosts`, nous enlevons chaque bulletin puis nous remettons à jour la collection.


### Déployer avec une base Mongo \[Optionnel\]


Nous allons maintenant montrer comment utiliser une base Mongo externe à Pharo. 
Dans le cadre de ce tutoriel, vous pouvez ne pas le faire et passer à la suite.

En utilisant Voyage nous pouvons rapidement sauver nos posts dans une base de données Mongo. Cette section explique rapidement la mise en oeuvre et les quelques modifications que nous devons apporter à notre projet Pharo pour y parvenir. 


#### Installation de Mongo


Quel que soit votre système d'exploitation \(Linux, Mac OSX ou Windows\), vous pouvez installer un serveur Mongo localement sur votre machine. Cela est pratique pour tester votre application sans avoir besoin d'une connexion Internet. 
Une solution consiste à installer directement un serveur Mongo sur votre système \(cf. [https://www.mongodb.com](https://www.mongodb.com)\). 
Toutefois, nous vous conseillons plutôt d'installer Docker \([https://www.docker.com](https://www.docker.com)\) sur votre machine et à lancer un conteneur  qui exécute un serveur Mongo grâce à la ligne de commande suivante:

```
	docker run --name mongo -p 27017:27017 -d mongo
```


!!note Le serveur Mongo ne doit pas utiliser d'authentification \(ce n'est pas le cas avec une installation locale par défaut\) car la nouvelle méthode de chiffrement SCRAM utilisée par MongoDB 3.0 n'est actuellement pas supportée par Voyage.

Quelques commandes utiles pour la suite :

```
	# pour stopper votre conteneur
	docker stop mongo
	
	# pour re-démarrer votre conteneur
	docker start mongo
	
	# pour détruire votre conteneur. Ce dernier doit être stoppé avant.
	docker rm mongo
```



#### Connexion à un serveur local


Nous définissons la méthode `initializeLocalhostMongoDB` pour établir la connexion vers la base de données.

```
TBBlog class >> initializeLocalhostMongoDB
   | repository |
   repository := VOMongoRepository database: 'tinyblog'.
   repository enableSingleton.
```


Il faut aussi s'assurer de la ré-initialisation de la connexion à la base lors du reset de la classe.

```
TBBlog class >> reset
   self initializeLocalhostMongoDB
```


Vous pouvez maintenant re-créer vos posts de démo, et ils seront automatiquement sauvegardés dans votre base Mongo:

```
TBBlog reset.
TBBlog createDemoPosts 
```


#### En cas de problème


Notez que si vous avez besoin de réinitialiser la base extérieure complètement, vous pouvez utiliser la méthode `dropDatabase`.

```
(VOMongoRepository
   host: 'localhost'
   database: 'tinyblog') dropDatabase
```


Si vous ne pouvez pas le faire depuis Pharo, vous pouvez le faire lorsque Mongo est en cours d'exécution avec l'expression suivante : 

```
mongo tinyblog --eval "db.dropDatabase()"
```


ou dans le conteneur docker :

```
docker exec -it mongo bash -c 'mongo tinyblog --eval "db.dropDatabase()"'
```


#### Attention : Changements de TBBlog


Si vous utilisez une base locale plutôt qu'une base en mémoire, à chaque fois que vous déclarez une nouvelle racine d'objets ou modifiez la définition d'une classe racine \(ajout, retrait, modification d'attribut\) il est capital de ré-initialiser le cache maintenu par Voyage.  La ré-initialisation se fait comme suit:

```
VORepository current reset
```



### Conclusion


Voyage propose une API sympathique pour gérer de manière transparente la sauvegarde d'objets soit en mémoire soit dans une base de données document. Votre application peut maintenant être sauvée dans la base et vous êtes donc prêt pour construire son interface web. 
