## Une interface REST pour TinyBlog


Ce chapitre décrit comment doter notre application TinyBlog d'une interface REST (REpresentational State Transfer).
Le code est placé dans un package `'TinyBlog-Rest'` car l'utilisation de REST est optionnelle.
Les tests seront dans le package `'TinyBlog-Rest-Tests'`.

### Notions de base sur REST

REST se base sur les verbes HTTP pour décrire l'accès aux ressources HTTP [REST](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html). Les principaux verbes ont la signification suivante:

- GET pour lire une ressource,
- POST pour créer une nouvelle ressource,
- PUT pour modifier une ressource existante,
- DELETE pour effacer une ressource,


Les ressources sont définies à l'aide des URL qui pointent sur une entité. Le chemin précisé dans l'URL permet de donner une signification plus précise à l'action devant être réalisée. Par exemple, un `GET /files/file.txt` signifie que le client veut accéder au contenu de l'entité nommée `file.txt`. Par contre, un `GET /files/` précise que le client veut obtenir la liste des entités contenues dans l'entité `files`.

Une autre notion importante est le respect des formats de données acceptés par le client et par le serveur. Lorsqu'un client REST émet une requête vers un serveur REST, il précise dans l'en-tête de la requête HTTP la liste des types de données qu'il est capable de gérer. Le serveur REST se doit de répondre dans un format compréhensible par le client et si cela n'est pas possible, de préciser au client qu'il n'est pas capable de lui répondre.

La réussite ou l'échec d'une opération est basée sur les codes de statut du protocole HTTP [REST](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html). Par exemple, si une opération réussit, le serveur doit répondre un code 200 (OK). De même, si une ressource demandée par le client n'existe pas, il doit retourner un code 404 (Not Found). Il est très important de respecter la signification de ces codes de statut afin de mettre en place un dialogue compréhensible et normalisé entre le client et le serveur.

### Définir un filtre REST


Pour regrouper les différents services REST de TinyBlog, il est préférable de créer un paquet dédié, nommé TinyBlog-REST. L'installation de ces services REST sera ainsi optionnelle. Si le paquet TinyBlog-REST est présent, le serveur TinyBlog autorisera:
- l'obtention de l'ensemble des posts existants,
- l'ajout d'un nouveau post,
- la recherche parmi les posts en fonction du titre,
- la recherche parmi les posts en fonction d'une période.


L'élément central de REST est un objet destiné à filtrer les requêtes HTTP reçues par le serveur et à déclencher les différents traitements. C'est en quelque sorte une gare de triage permettant d'aiguiller la requête du client vers le code apte à le gérer. Cet objet, nommé `TBRestfulFilter`, hérite de la classe WARestfulFilter.

```
WARestfulFilter subclass: #TBRestfulFilter
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'TinyBlog-REST'
```


Pour l'utiliser, il nous faut le déclarer au sein de l'application TinyBlog. Pour cela, éditez la méthode de classe `initialize` de la classe `TBApplicationRootComponent` pour ajouter une instance de `TBRestfulFilter`.

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
	      addLibrary: TBSDeploymentLibrary.
		
		app addFilter: TBRestfulFilter new.
```


N'oublier pas d'initialiser à nouveau la classe `TBApplicationRootComponent` en exécutant la méthode `initialize` dans le Playground. Sans cela, Seaside ne prendra pas en compte le filtre ajouté.

```
TBApplicationRootComponent initialize
```


A partir de maintenant, nous pouvons commencer à implémenter les différents services REST.

### Obtenir la liste des posts


Le premier service proposé sera destiné à récupérer la liste des posts. Il s'agit d'une opération de lecture et elle utilisera donc le verbe GET du protocole HTTP. La réponse sera produite au format JSON. La méthode `listAll` est marquée comme étant un point d'entrée REST à l'aide des annotations `<get>` et `<produces:>`.

Si le client interroge le serveur à l'aide de l'URL `http://localhost:8080/TinyBlog/listAll`, la méthode `listAll` est appelée. Celle-ci retourne les données selon le type MIME (Multipurpose Internet Mail Extensions) spécifié par l'annotation `<produces:>`.

```
TBRestfulFilter >> listAll
	<get>
	<produces: 'application/json'>
```


Afin de faciliter l'utilisation d'un service REST, il est préférable de préciser finement la ou les ressources manipulées. Dans le cas présent, le nom de la méthode `listAll` ne précise pas au client quelles sont les ressources qui seront retournées. Certes, nous savons que ce sont les posts mais après tout, cela pourrait également être des rubriques. Il faut donc être plus explicite dans la formalisation de l'URL afin de lui donner une réelle signification sémantique. C'est d'ailleurs la principale difficulté dans la mise en place des services REST. La meilleure méthode est de faire simple et de s'efforcer d'être cohérent dans la désignation des chemins d'accès aux ressources. Si nous voulons la liste des posts, il nous suffit de demander la liste des posts. L'URL doit donc avoir la forme suivante:

```
http://localhost:8080/TinyBlog/Posts
```


Pour obtenir cela, nous pouvons renommer la méthode `listAll` ou préciser le chemin d'accès qui appellera cette méthode. Cette seconde approche est plus souple puisqu'elle permet de réorganiser les appels aux services REST sans nécessiter de refactoriser le code.

```
TBRestfulFilter >> listAll
	<get>
	<path: '/posts'>
	<produces: 'application/json'>
```


Maintenant que nous avons défini le point d'entrée, nous pouvons implémenter la partie métier du service `listAll`. C'est à dire le code chargé de construire la liste des posts contenus dans la base. Une représentation astucieuse d'un service peut être réalisée à l'aide des objets. Chaque service REST sera contenu dans un object distinct. Ceci facilitera grandement la maintenance et la compréhension du code.

La méthode `listAll` ci-dessous fait maintenant appel au service adéquat, nommé TBRestServiceListAll. Il est nécessaire de transmettre le contexte d'exécution de Seaside à l'instance de cet objet. Ce contexte est l'ensemble des informations transmises par le client REST (variables d'environnement HTTP ainsi que les flux d'entrée/sortie de Seaside).

```
TBRestfulFilter >> listAll
	<get>
	<path: '/posts'>
	<produces: 'application/json'>

	TBRestServiceListAll new applyServiceWithContext: self requestContext
```


### Créer des Services


Ce contexte d'exécution sera utile pour l'ensemble de services REST de TinyBlog. Cela signifie donc que nous devons trouver une solution pour éviter la copie de sections de code identiques au sein des différents services. Pour cela, la solution évidente en programmation objet consiste à mettre en oeuvre un mécanisme d'héritage. Chaque service REST héritera d'un service commun nommé ici TBRestService. Ce service dispose de deux variables d'instance. `context` contiendra le contexte d'exécution et `result` recevra les éléments de réponse devant être transmis au client.

```
Object subclass: #TBRestService
	instanceVariableNames: 'result context'
	classVariableNames: ''
	category: 'TinyBlog-Rest'	
```

```
TBRestService >> context
	^ context
```

```
TBRestService >> context: anObject
	context := anObject
```


La méthode `initialize` assigne un conteneur de réponses à la variable d'instance `result`. Ce conteneur est l'objet `TBRestResponse`. Nous décrirons son implémentation un peu plus tard.

```
TBRestService >> initialize
	super initialize.
	result := TBRestResponseContent new.	
```


Le contexte d'éxecution est transmis au service REST à l'aide de la méthode `applyServiceWithContext:`. Une fois reçu, le traitement spécifique au service est déclenché à l'aide de la méthode `execute`. Au sein de l'objet TBRestService, la méthode `execute` doit être déclarée comme abstraite puisqu'elle n'a aucun travail à faire. Cette méthode devra être implémentée de manière spécifique dans les différents services REST de TinyBlog.

```
TBRestService >> applyServiceWithContext: aRequestContext
	self context: aRequestContext.
	self execute.
```

```
TBRestService >> execute
	self subclassResponsibility
```


Tous les services REST de TinyBlog doivent être capables de retourner une réponse au client et de lui préciser le format des données utilisé. Vous devez donc ajouter une méthode pour faire cela. Il s'agit de la méthode `dataType:with:`. Le premier paramètre sera le type MIME utilisé et le second, contiendra les données transmises au client. 
La méthode insère ces informations dans le flux de réponses fournit par Seaside. 
La méthode `greaseString` appliquée sur le type de données permet d'obtenir une représentation du type MIME sous la forme d'une chaine de caractères (par exemple: "application/json").

```
TBRestService >> dataType: aDataType with: aResultSet
	self context response contentType: aDataType greaseString.
	self context respond: [ :response | response nextPutAll: aResultSet ]
```


Avant de terminer l'implémentation de `TBRestServiceListAll`, il nous faut définir l'objet contenant les données devant être transmises au client. Il s'agit de `TBRestResponseContent`.

### Construire une réponse


Un service REST doit pouvoir fournir sa réponse au client selon différents formats en fonction de la capacité du client à les comprendre. Un bon service REST doit être capable de s'adapter pour être compris par le client qui l'interroge. C'est pourquoi, il est courant qu'un même service puisse répondre dans les formats les plus courants tels que JSON, XML ou encore CSV. Cette contrainte doit être gérée dans notre application par l'utilisation d'un objet destiné à contenir les données. Au terme de l'exécution du service REST, c'est son contenu qui sera transformé dans le format adapté pour être ensuite transmis au client.

Dans TinyBlog, c'est l'objet `TBRestResponseContent` qui a la responsabilité de contenir les données à l'aide de la méthode d'instance `data`.

```
Object subclass: #TBRestResponseContent
	instanceVariableNames: 'data'
	classVariableNames: ''
	category: 'TinyBlog-Rest'
```


Les données sont stockées au sein d'une collection ordonnée, initialisée à l'instanciation de l'objet. La méthode `add:` permet d'ajouter un nouvel élément à cette collection.

```
TBRestResponseContent >> initialize
	super initialize.
	data := OrderedCollection new.
```

```
TBRestResponseContent >> add: aValue
	data add: aValue	
```


Nous avons également besoin de traducteurs pour convertir les données de la collection vers le format attendu par le client. Pour le format JSON, c'est la méthode `toJson` qui effectue le travail.

```
TBRestResponseContent >> toJson
	^String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
		for: Date
		customDo: [ :mapping | mapping encoder: [ :value | value asDateAndTime printString ] ];
		nextPut: data ]	
```


Pourquoi ne pas ajouter d'autres traducteurs ? Pharo supporte parfaitement XML ou encore CSV comme nous l'avons vu dans le chapitre précédent. Nous vous laissons le soin d'ajouter ces formats aux services REST de TinyBlog.

### Implémenter le code métier du service listAll


A ce stade, nous avons mis en place toute l'infrastructure qui permettra le bon fonctionnement des différents services REST de TinyBlog. L'implémentation de `listAll` va maintenant être rapide et extrêmement simple. En fait, nous n'avons besoin qu'une seule et unique méthode. Souvenez vous, c'est la méthode `execute` qui doit être ici implémentée.

```
TBRestService >> execute
	TBBlog current allBlogPosts do: [ :each | result add: (each asDictionary) ].
	self dataType: (WAMimeType applicationJson) with: (result toJson)	
```


Cette méthode va collecter les posts présents dans la base de données de TinyBlog et les ajouter à l'instance de TBRestResponseContent. Une fois l'opération terminée, la réponse est convertie au format JSON puis retournée au client. 

### Utiliser un service REST


Il existe plusieurs façons d'utiliser ce service REST.

#### En ligne de commande


Tout d'abord, si vous êtes un adepte du shell et des commandes Unix, il vous suffit d'utiliser les commandes `wget` ou `curl`. Celles-ci permettent d'envoyer une requête HTTP à un serveur.

Par exemple, la commande wget suivante interroge une instance locale de TinyBlog.

```
wget http://localhost:8080/TinyBlog/posts
```


Les posts sont enregistrés dans un fichier nommé `posts` qui contient les données au format JSON.

```
[{"title":"A title","date":"2017-02-02T00:00:00+01:00","text":"A text","category":"Test"},{"title":"un test de TinyBlog","date":"2017-02-03T00:00:00+01:00","text":"Incroyable, il n'a jamais été plus facile de faire un blog !","category":"Vos avis"}]
```


#### Avec un client graphique


Une autre approche, plus confortable et adaptée à la mise au point de vos services REST, consiste à utiliser un client graphique. 
Il en existe un grand nombre sur tout système d'exploitation. 
Certains proposent des fonctionnalités avancées telles qu'un éditeur de requêtes HTTP ou HTTPS, la gestion de bibliothèques de requêtes ou encore la mise en place de tests unitaires. Nous vous recommandons de vous intéresser plus particulièrement à des produits fonctionnant directement avec des technologies web, sous la forme d'applications ou d'extensions intégrées à votre navigateur web. 

@todo IMAGE GRAPHIQUE D'UN CLIENT

#### Avec Zinc


Bien évidemment, il vous est possible d'interroger vos services REST directement avec Pharo. Le framework Zinc permet de le faire en une seule ligne de code. 

```
(ZnEasy get: 'http://localhost:8080/TinyBlog/posts') contents
```


Il vous est donc aisé de construire des services REST et d'écrire en Pharo des applications qui les consomment.

### Recherche d'un Post


Maintenant nous allons proposer d'autres fonctionnalités comme la recherche d'un post.
Nous définissons donc cette fonctionnalité dans la classe `TBlog`. La méthode `postWithTitle:` reçoit une chaine de caractères comme unique argument et recherche un post ayant un titre identique à la chaine de caractères. Si plusieurs posts sont trouvés, la méthode retourne le premier sélectionné.

```
TBBlog >> postWithTitle: aString
	| result |
	result := self allVisibleBlogPosts select: [ :post | post title = aTitle ].
	result ifNotEmpty: [ ^result first ] ifEmpty: [ ^nil ]
```


Il faut déclarer la route HTTP permettant de lancer la recherche. L'emplacement du titre recherché au sein de l'URL est entouré à l'aide d'accolades et le nom de l'argument doit être identique à celui du paramètre reçu par la méthode.

```
search: aTitle
	<get>
	<path: '/posts/search?title={aTitle}'>
	<produces: 'application/json'>
```


La partie métier du service est implémentée dans l'objet `TBRestServiceSearch` qui hérite de `TBRestService`. Cet objet a besoin de connaître le titre du post recherché et fait appel à la méthode TBBlog >> postWithTitle: définie précedemment.

```
TBRestService subclass: #TBRestServiceSearch
	instanceVariableNames: 'title'
	classVariableNames: ''
	category: 'TinyBlog-Rest'
```

```
TBRestServiceSearch >> title
	^ title
```

```
TBRestServiceSearch >> title: anObject
	title := anObject
```


```
TBRestServiceSearch >> execute
	| post |

	post := TBBlog current postWithTitle: title urlDecoded.
	
	post 
		ifNotNil: [ result add: (post asDictionary) ] 
		ifNil: [ self context response notFound ].
	self dataType: (WAMimeType applicationJson) with: result toJson
```


Deux choses sont intéressantes dans cette méthode.
Il y a tout d'abord l'utilisation de la méthode `urlDecoded` qui est appliquée à la chaine de caractères contenant le titre recherché.
Cette méthode permet la gestion des caractères spéciaux tels que l'espace ou les caractères accentués.
Si vous cherchez un post ayant pour titre "La reproduction des hippocampes", le service REST recevra en fait la chaîne de caractères "La%20reproduction%20des%20hippocampes" et une recherche avec celle ci ne fonctionnera pas car aucun titre de post ne coïncidera. 
Il faut donc nettoyer la chaîne de caractères en remplaçant les caractères spéciaux avant de lancer la recherche.

Un autre point important est la gestion des codes d'erreur HTTP. Lorsqu'un serveur HTTP répond à son client, il glisse dans l'en-tête de la réponse une valeur numérique qui fournit au client de précieuses informations sur le résultat attendu. Si la réponse contient le code 200, c'est que tout s'est correctement passé et qu'un résultat est fourni au client (c'est d'ailleurs la valeur par défaut dans Seaside/Rest). Mais parfois, un problème survient. Par exemple, la requête demande à accéder à une ressource qui n'existe pas. Dans ce cas, il est nécessaire de retourner un code 404 (Not Found) pour l'indiquer au client. Un code 500 va indiquer qu'une erreur d'exécution a été rencontrée par le service. Vous trouverez la liste exhaustive des codes d'erreur sur la page décrivant le protocole HTTP. Il est très important de les gérer correctement tant au niveau de votre service REST qu'au sein de votre client REST car c'est ce qui va permettre à la couche cliente de réagir à bon escient en fonction du résultat du traitement exécuté par le serveur.

Notre serveur web de recherche par titre est pratiquement terminé. Il nous reste maintenant à modifier le point d'entrée du service pour qu'il soit capable d'appeler le code métier associé.

```
TBRestfulFilter >> search: aTitle
	<get>
	<path: '/posts/search?title={aTitle}'>
	<produces: 'application/json'>

	TBRestServiceSearch new
		title: aTitle;
		applyServiceWithContext: self requestContext	
```


### Chercher selon une période


Une autre méthode intéressante pour lancer une recherche consiste à extraire l'ensemble des posts créés entre deux dates qui définissent ainsi une période. Pour cette raison, la méthode `searchDateFrom:to:` reçoit deux arguments qui sont également définis dans la syntaxe de l'URL.

```
TBRestfulFilter >> searchDateFrom: beginString to: endString
	<get>
	<path: '/posts/search?begin={beginString}&end={endString}'>
	<produces: 'application/json'>
```


La partie métier est implémentée au sein de l'objet `TBRestServiceSearchDate` héritant de TBRestService. Deux variables d'instance permettent de définir la date de début et la date de fin de la période de recherche. 

```
TBRestService subclass: #TBRestServiceSearchDate
	instanceVariableNames: 'from to'
	classVariableNames: ''
	package: 'TinyBlog-Rest'
```

```
TBRestServiceSearchDate >> from
	^from
```

```
TBRestServiceSearchDate >> from: anObject
	from := anObject
```

```
TBRestServiceSearchDate >> to
	^to
```

```
TBRestServiceSearchDate >> to: anObject
	to := anObject	
```


La méthode `execute` convertie les deux chaines de caractères en instances de l'objet `Date` à l'aide de la méthode `fromString`. 
Elle lit l'ensemble des posts à l'aide de la méthode `allBlogPosts`, filtre les posts créés dans période indiquée et retourne le résultat au format JSON.

```
TBRestServiceSearchDate >> execute
	| posts dateFrom dateTo |
		
	dateFrom := Date fromString: self from.
	dateTo := Date fromString: self to.

	posts := TBBlog current allBlogPosts
		select: [  :each | each date between: dateFrom and: dateTo ].
	
	posts do: [ :each | result add: (each asDictionary) ].
	self dataType: (WAMimeType applicationJson) with: result toJson	
```


Il serait judicieux ici d'ajouter certaines vérifications. 
Les deux dates sont-elles dans un format correct ? 
La date de fin est-elle postérieure à celle de début ?
Nous vous laissons implémenter ces améliorations et gérer correctement les codes d'erreur HTTP.

La dernière étape consiste à compléter la méthode `searchDateFrom:to:` afin d'instancier l'objet `TBRestServiceSearchDate` lorsque le service `searchDateFrom:to:` est invoqué.

```
TBRestfulFilter >> searchDateFrom: beginString to: endString
	<get>
	<path: '/posts/search?begin={beginString}&end={endString}'>
	<produces: 'application/json'>
	
	TBRestServiceSearchDate new
		from: beginString;
		to: endString;
		applyServiceWithContext: self requestContext
```


A l'aide d'une URL telle que http://localhost:8080/TinyBlog/posts/search?begin=2017/1/1&end=2017/3/30, vous pouvez tester votre nouveau service REST (bien évidemment, les dates doivent être adaptées en fonction du contenu de votre base de test).

### Ajouter un post


Voyons maintenant comment ajouter un nouveau post à notre blog à l'aide de REST. Etant donné qu'il s'agit ici de la création d'une nouvelle ressource, nous devons utiliser le verbe POST pour décrire l'action. Le chemin sera la ressource désignant la liste des posts.

```
TBRestfulFilter >> addPost
	<post>
	<consumes: '*/json'>
	<path: '/posts'>
```


La description du servie REST comporte la directive <consumes:> qui précise à Seaside qu'il doit accepter uniquement des requêtes clientes contenant des données au format JSON. Le client doit donc obligatoirement utiliser le paramètre `Content-Type: application/json` au sein de l'en-tête HTTP.

La couche métier est constituée par l'objet TBRestServiceAddPost qui hérite de la classe TBRestService.

```
TBRestService subclass: #TBRestServiceAddPost
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Rest'
```


Seule la méthode `execute` doit être implémentée. Elle lit le flux de données et le parse à l'aide de la méthode de classe `fromString:` de l'objet `NeoJSONReader`. Les données sont stockées dans un dictionnaire contenu dans la variable local `post`. Il suffit ensuite d'instancier un `TBPost` et de le sauver dans la base de données. Par sécurité, l'ensemble de ce processus est réalisé au sein d'une exception afin d'intercepter un problème d'exécution qui pourrait rendre instable le serveur. La dernière opération consiste à renvoyer au client un résultat vide mais aussi et surtout un code HTTP 200 (OK) signalant que le post a bien été créé. En cas d'erreur, c'est le message d'erreur 400 (BAD REQUEST) qui est retourné.

```
TBRestServiceAddPost >> execute
	| post |

	[ 
		post := NeoJSONReader fromString: (self context request rawBody).
		TBBlog current writeBlogPost: (TBPost title: (post at: #title) text: (post at: #text) category: (post at: #category)). 
	] on: Error do: [ self context request badRequest ].

	self dataType: (WAMimeType textPlain) with: ''	
```


Il ne vous reste plus qu'à ajouter l'instanciation de TBRestServiceAddPost au sein de la déclaration du point d'entrée REST.

```
TBRestfulFilter >> addPost
	<post>
	<consumes: '*/json'>
	<path: '/posts'>
	
	TBRestServiceAddPost new
		applyServiceWithContext: self requestContext	
```


En guise de travaux pratiques, il vous est possible d'améliorer la gestion d'erreur de la méthode execute afin de différencier une erreur au sein de la structure des données transmises au serveur, du format utilisé ou encore lors de l'étape d'ajout du post à la base de données. Un service REST complet se doit de fournir une information pertinente au client afin d'expliciter la cause du problème.

### Améliorations possibles


Au fil de ce chapitre, vous avez implémenté les principales briques d'une API REST permettant de consulter et d'alimenter le contenu d'un moteur de blog. Il reste bien sur des évolutions possibles et nous vous encourageons à les implémenter. Voici quelques propositions qui constituent des améliorations pertinentes.

#### Modifier un post existant


La modification d'un post existant peut facilement être réalisée. Il vous suffit d'implémenter un service REST utilisant le verbe HTTP `PUT` et d'encoder votre post avec la même structure que celle utilisée pour la création d'un post (service `addPost`). L'exercice consiste ici à implémenter correctement la gestion des codes d'erreurs HTTP. De nombreux cas sont possibles.

- 200 (OK) ou 201 (CREATED) si l'opération a réussi,
- 204 (NO CONTENT) si la requête ne contient pas de données,
- 304 (NOT MODIFIED) si aucun changement ne doit être appliqué (le contenu du post est identique),
- 400 (BAD REQUEST) si les données transmises par le client sont incorrectes,
- 404 (NOT FOUND) si le post devant être modifié n'existe pas,
- 500 (INTERNAL SERVER ERROR) si un problème survient lors de la création du post dans la base de données.


#### Supprimer un post


La suppression d'un post sera le résultat d'une requête DELETE transmise au serveur. Ici aussi, il vous est conseillé d'implémenter une gestion la plus complète possible des codes d'erreurs HTTP qui devrait être assez proche de celle utilisée dans le service de modification d'un post.











