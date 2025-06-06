## Interface web d'administration et génération automatique


Nous allons maintenant développer la partie administration de TinyBlog.
Dans les chapitres précédents, nous avons défini des composants Seaside qui interagissent entre eux 
et où chaque composant est responsable de son état et de son rendu graphique.  
Dans ce chapitre, nous voulons vous montrer que l'on peut aller encore plus loin et générer des composants Seaside à partir de la description d'objets en utilisant le framework Magritte. 

La figure *@RapportNewLookActions2@* montre une partie du résultat que nous allons obtenir. L'autre partie étant l'édition de bulletins. 

![Gestion des bulletins.](figures/RapportNewLookActions.png width=75&label=RapportNewLookActions2)


La figure *@ApplicationAdmin@* montre un aperçu de l'architecture visée dans ce chapitre.

![ Composants pour l'administration.](figures/ApplicationArchitectureWithAdmin.pdf width=75&label=ApplicationAdmin)

### Décrire les données métiers avec Magritte


Magritte est une bibliothèque qui permet une fois les données décrites de générer diverses représentations ou opérations (telles des requêtes). 
Couplé avec Seaside, Magritte permet de générer des formulaires et des rapports.  
Le logiciel Quuve de la société Debris Publishing est un brillant exemple de la puissance de Magritte: tous les tableaux sont automatiquement générés (voir [http://www.pharo.org/success](http://www.pharo.org/success)). 
La validation des données est aussi définie au niveau de Magritte au lieu d'être dispersée dans le code de l'interface graphique. 
Ce chapitre ne montre pas cet aspect.

Un chapitre dans le livre sur Seaside ([http://book.seaside.st](http://book.seaside.st)) est disponible sur Magritte ainsi qu'un tutoriel en cours d'écriture sur [https://github.com/SquareBracketAssociates/Magritte](https://github.com/SquareBracketAssociates/Magritte).

Une description est un objet qui spécifie des informations sur des données de notre modèle comme son type, si une donnée est obligatoire, 
si elle doit être triée, ou quelle est sa valeur par défaut.

### Description d'un bulletin


Commençons par décrire les cinq variables d'instance de l'objet `TBPost` à l'aide de Magritte. 
Ensuite, nous en tirerons avantage pour générer automatiquement des composants Seaside.

Les cinq méthodes suivantes sont dans le protocole 'magritte-descriptions' de la classe `TBPost`.
Noter que le nom des méthodes n'est pas important mais que nous suivons une convention. 
C'est le pragma `<magritteDescription>` qui permet à Magritte d'identifier les descriptions.

Le titre d'un bulletin est une chaine de caractères devant être obligatoirement complétée.

```
TBPost >> descriptionTitle
   <magritteDescription>
   ^ MAStringDescription new
      accessor: #title;
      beRequired;
      yourself
```


Le texte d'un bulletin est une chaine de caractères multi-lignes devant être obligatoirement complété.

```
TBPost >> descriptionText
   <magritteDescription>
   ^ MAMemoDescription new
      accessor: #text;
      beRequired;
      yourself
```


La catégorie d'un bulletin est une chaîne de caractères qui peut ne pas être renseignée. 
Dans ce cas, le post sera de toute manière rangé dans la catégorie 'Unclassified'.

```
TBPost >> descriptionCategory
   <magritteDescription>
   ^ MAStringDescription new
      accessor: #category;
      yourself
```


La date de création d'un bulletin est importante car elle permet de définir l'ordre de tri pour l'affichage des posts. C'est donc une variable d'instance contenant obligatoirement une date.

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
TBPost >> descriptionVisible
   <magritteDescription>
   ^ MABooleanDescription new
      accessor: #visible;
      beRequired;
      yourself
```


Nous pourrions enrichir les descriptions pour qu'il ne soit pas possible de poster un bulletin ayant une date antérieure à celle du jour. 
Nous pourrions changer la description d'une catégorie pour que ses valeurs possibles soient définies par l'ensemble des catégories existantes. 
Tout cela permettrait de produire des interfaces plus complètes et toujours aussi simplement.

### Création automatique de composant


Une fois un bulletin décrit, nous pouvons générer un composant Seaside en envoyant le message `asComponent` à une instance.

```
	aTBPost asComponent
```


Nous allons voir comment utiliser cela dans la suite.


### Mise en place d'un rapport des bulletins


Nous allons développer un nouveau composant qui sera utilisé par le composant `TBAdminComponent`.
Le composant `TBPostReport` est un rapport qui contiendra tous les posts.
Comme nous allons le voir, le rapport est automatiquement généré. 
Le rapport étant généré par Magritte sous la forme d'un composant Seaside, nous aurions pu n'avoir qu'un seul composant. 
Toutefois, nous pensons que distinguer le composant d'administration du rapport est une bonne chose pour l'évolution de la partie administration.

#### Le composant PostsReport


La liste des posts est affichée à l'aide d'un rapport généré dynamiquement par le framework Magritte.
 Nous utilisons ce framework pour réaliser les différentes fonctionnalités de la partie administration de TinyBlog (liste des posts, création, édition et suppression d'un post).

Pour rester modulaire, nous allons créer un composant Seaside pour cette tâche. Le composant `TBPostsReport` étend la 
classe `TBSMagritteReport` qui gére les rapports avec Bootstrap.

```
TBSMagritteReport subclass: #TBPostsReport
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


Nous ajoutons une méthode de création qui prend en argument un blog et donc ses bulletins. 

```
TBPostsReport class >> from: aBlog
   | allBlogs |
   allBlogs := aBlog allBlogPosts.
   ^ self rows: allBlogs description: allBlogs anyOne magritteDescription
```


### Intégration de PostsReport dans AdminComponent


Révisons maintenant notre composant `TBAdminComponent` pour afficher ce rapport.
On ajoute une variable d'instance `report` et ses accesseurs à la classe `TBAdminComponent`.

```
TBScreenComponent subclass: #TBAdminComponent
	instanceVariableNames: 'report'
	classVariableNames: ''
	package: 'TinyBlog-Components'
```


```
TBAdminComponent >> report
   ^ report
```


```
TBAdminComponent >> report: aReport
   report := aReport
```


Comme le rapport est un composant fils du composant admin nous n'oublions pas de redéfinir la méthode `children` comme suit.
Notez que la collection contient à la fois les sous-composants définis dans la super-classe (le composant en-tête) et ceux dans la classe courante (le composant rapport).

```
TBAdminComponent >> children
   ^ super children copyWith: self report
```


Dans la méthode `initialize`, nous instancions un rapport tout en lui fournissant accès aux données du blog.

```
TBAdminComponent >> initialize
   super initialize.
   self report: (TBPostsReport from: self blog)
```


Modifions le rendu de la partie administration afin d'afficher le rapport.

```
TBAdminComponent >> renderContentOn: html
   super renderContentOn: html.
   html tbsContainer: [
      html heading: 'Blog Admin'.
      html horizontalRule.
      html render: self report ]
```


Vous pouvez déjà tester dans votre navigateur. 

### Filtrer les colonnes


Par défaut, un rapport affiche l'intégralité des données présentes dans chaque post. 
Cependant certaines colonnes ne sont pas utiles.
Il faut donc filtrer les colonnes.
Nous ne retiendrons ici que le titre, la catégorie et la date de rédaction.

Nous ajoutons une méthode de classe pour la sélection des colonnes et modifions ensuite la méthode `from:` pour en tirer parti.

```
TBPostsReport class >> filteredDescriptionsFrom: aBlogPost
	"Filter only some descriptions for the report columns."

	^ aBlogPost magritteDescription
		select: [ :each | #(title category date) includes: each accessor selector ]
```


```
TBPostsReport class >> from: aBlog
   | allBlogs |
   allBlogs := aBlog allBlogPosts.
   ^ self rows: allBlogs description: (self filteredDescriptionsFrom: allBlogs anyOne)
```



La figure *@RapportV1@* montre ce que vous devez obtenir dans votre navigateur.

![Rapport Magritte contenant les bulletins du blog.](figures/RapportMagritteV1.png width=100&label=RapportV1)


### Amélioration du rapport


Le rapport généré est brut. Il n'y a pas de titres sur les colonnes et l'ordre d'affichage des colonnes n'est pas fixé.
Celui-ci peut varier d'une instance à une autre. 
Pour gérer cela, il suffit de modifier les descriptions Magritte pour chaque variable d'instance.
Nous spécifions une priorité et un titre (message `label:`) comme suit : 

```
TBPost >> descriptionTitle
   <magritteDescription>
   ^ MAStringDescription new
      label: 'Title';
      priority: 100;
      accessor: #title;
      beRequired;
      yourself
```

```
TBPost >> descriptionText
   <magritteDescription>
   ^ MAMemoDescription new
      label: 'Text';
      priority: 200;
      accessor: #text;
      beRequired;
      yourself
```

```
TBPost >> descriptionCategory
   <magritteDescription>
   ^ MAStringDescription new
      label: 'Category';
      priority: 300;
      accessor: #category;
      yourself
```

```
TBPost >> descriptionDate
   <magritteDescription>
   ^ MADateDescription new
      label: 'Date';
      priority: 400;
      accessor: #date;
      beRequired;
      yourself
```

```
TBPost >> descriptionVisible
   <magritteDescription>
   ^ MABooleanDescription new
      label: 'Visible';
      priority: 500;
      accessor: #visible;
      beRequired;
      yourself
```



Vous devez obtenir la situation telle que représentée par la figure *@adminReportDraft@*.
![Administration avec un rapport.](figures/RapportMagritteV2.png width=85&label=adminReportDraft)


### Administration des bulletins


Nous pouvons maintenant mettre en place un CRUD (Create Read Update Delete) permettant de gérer les bulletins.
Pour cela, nous allons ajouter une colonne (instance `MACommandColumn`) au rapport qui regroupera les différentes opérations en utilisant `addCommandOn:`. 
Cette méthode permet de définir un lien qui déclenchera l'exécution d'une méthode de l'objet courant lorsqu'il sera cliqué grâce à un callback.

Ceci se fait lors de la création du rapport. 
En particulier nous donnons un accès au blog depuis le rapport.

```
TBSMagritteReport subclass: #TBPostsReport
    instanceVariableNames: 'blog'
    classVariableNames: ''
    package: 'TinyBlog-Components'
```


```
TBPostsReport >> blog
   ^ blog
```


```
TBPostsReport >> blog: aTBBlog
   blog := aTBBlog
```



La méthode `from:` ajoute une nouvelle colonne au rapport. Elle regroupe les différentes opérations en utilisant `addCommandOn:`. 

```
TBPostsReport class >> from: aBlog
    | report blogPosts |
    blogPosts := aBlog allBlogPosts.
    report := self rows: blogPosts description: (self filteredDescriptionsFrom: blogPosts anyOne).
    report blog: aBlog.
    report addColumn: (MACommandColumn new
        addCommandOn: report selector: #viewPost: text: 'View'; yourself;
        addCommandOn: report selector: #editPost: text: 'Edit'; yourself;
        addCommandOn: report selector: #deletePost: text: 'Delete'; yourself).
     ^ report
```



Nous allons devoir définir les méthodes liées à chaque opération dans une prochaine section.

Par ailleurs, cette méthode est un peu longue et elle ne permet pas de separer la définition du rapport de l'ajout d'opérations sur les éléments. Une solution est de créer une méthode d'instance `addCommands` et de l'appeller explicitement.  Faites cette transformation.



### Gérer l'ajout d'un bulletin


L'ajout (add) est dissocié des bulletins et se trouvera donc juste avant le rapport. 
Etant donné qu'il fait partie du composant `TBPostsReport`, nous devons redéfinir la méthode `renderContentOn:` du composant `TBPostsReport` pour insérer le lien `add`.


```
TBPostsReport >> renderContentOn: html
   html tbsGlyphIcon iconPencil.
   html anchor
      callback: [ self addPost ];
      with: 'Add post'.
   super renderContentOn: html
```


Identifiez-vous à nouveau et vous devez obtenir la situation telle que représentée par la figure *@RapportNewLookActions@*.
![Rapport des bulletins avec des liens d'édition.](figures/RapportNewLookActions.png width=75&label=RapportNewLookActions)


### Implémentation des actions CRUD


A chaque action (Create/Read/Update/Delete) correspond une méthode de l'objet `TBPostsReport`. 
Nous allons maintenant les implémenter. 
Un formulaire personnalisé est construit en fonction de l'opération demandée (il n'est pas utile par exemple d'avoir un bouton "Sauver" alors que l'utilisateur veut simplement lire le post).

### Ajouter un bulletin

Commençons par gérer l'ajout d'un bulletin.
La méthode `renderAddPostForm:` suivante illustre la puissance de Magritte pour générer des formulaires.

```
TBPostsReport >> renderAddPostForm: aPost
    ^ aPost asComponent
        addDecoration: (TBSMagritteFormDecoration buttons: { #save -> 'Add post' .  #cancel -> 'Cancel'});
        yourself
```


Ici, le message `asComponent`, envoyé à un objet métier instance de la classe `TBPost`, créé directement un composant Seaside. Nous ajoutons une décoration à ce composant Seaside afin de gérer ok/cancel.


La méthode `addPost` pour sa part, affiche le composant rendu par la méthode `renderAddPostForm:` et lorsque qu'un nouveau post est créé, elle l'ajoute au blog. La méthode `writeBlogPost:` sauve les changements.

```
TBPostsReport >> addPost
    | post |
    post := self call: (self renderAddPostForm: TBPost new).
    post ifNotNil: [ blog writeBlogPost: post ]
```


 On voit une fois encore l'utilisation du message `call:` pour donner la main à un composant.
Le lien pour ajouter un bulletin permet maintenant d'afficher un formulaire de création que nous rendrons plus présentable (Voir figure *@AffichePostRaw@*).


![Affichage rudimentaire d'un bulletin.](figures/AffichePostRaw.png width=75&label=AffichePostRaw)



#### Afficher un bulletin

Pour afficher un bulletin en lecture nous définissons deux méthodes similaires aux précédentes.
Notez que nous utilisons l'expression `readonly: true` pour indiquer que le formulaire n'est pas éditable.

```
TBPostsReport >> renderViewPostForm: aPost
   ^ aPost asComponent 
       addDecoration: (TBSMagritteFormDecoration buttons: { #cancel -> 'Back' });
       readonly: true;
       yourself
```


Voir un bulletin ne nécessite pas d'action supplémentaire que d'afficher le composant.
```
TBPostsReport >> viewPost: aPost
   self call: (self renderViewPostForm: aPost)
```


#### Editer un bulletin


Pour éditer un bulletin nous utilisons la même approche. 
```
TBPostsReport >> renderEditPostForm: aPost
   ^ aPost asComponent addDecoration: (
      TBSMagritteFormDecoration buttons: {
         #save -> 'Save post'.
         #cancel -> 'Cancel'});
      yourself
```


Maintenant la méthode `editPost:` récupère la valeur du message `call:` et sauve les changements apportés.
```
TBPostsReport >> editPost: aPost
   | post |
   post := self call: (self renderEditPostForm: aPost).
   post ifNotNil: [ blog save ]
```


#### Supprimer un bulletin


Il nous faut maintenant ajouter la méthode `removeBlogPost:` à la classe `TBBlog`:

```
TBBlog >> removeBlogPost: aPost
    posts remove: aPost ifAbsent: [ ].
    self save.
```


ainsi qu'un test unitaire :

```
TBBlogTest >> testRemoveBlogPost
    self assert: blog size equals: 1.
    blog removeBlogPost: blog allBlogPosts anyOne.
    self assert: blog size equals: 0
```


Pour éviter une opération accidentelle, nous utilisons une boite modale pour que l'utilisateur confirme la suppression du post. 
Une fois le post effacé, la liste des posts gérés par le composant `TBPostsReport` est actualisée et le rapport est rafraîchi.

```
TBPostsReport >> deletePost: aPost
    (self confirm: 'Do you want remove this post ?')
        ifTrue: [ blog removeBlogPost: aPost ]
```




### Gérer le rafraîchissement des données


Les méthodes `addPost:` et `deletePost:` font bien leur travail mais les données à l'écran ne sont pas mises à jour.
Il faut donc rafraichir la liste des bulletins en utilisant l'expression `self refresh`.

```
TBPostsReport >> refreshReport
    self rows: blog allBlogPosts.
    self refresh.
```


```
TBPostsReport >> addPost
	| post |
	post := self call: (self renderAddPostForm: TBPost new).
	post
		ifNotNil: [ blog writeBlogPost: post.
			self refreshReport ]
```


```
TBPostsReport >> deletePost: aPost
    (self confirm: 'Do you want remove this post ?')
        ifTrue: [ blog removeBlogPost: aPost.
                 self refreshReport ]
```


Le rapport est maintenant fonctionnel  et gère même les contraintes de saisie c'est-à-dire que le formulaire assure par exemple que les champs déclarés comme obligatoire dans les descriptions Magritte sont bien renseignés.

### Amélioration de l'apparence des formulaires


Pour tirer parti de Bootstrap, nous allons modifier les définitions Magritte. Tout d'abord, spécifions que le rendu du rapport doit se baser sur Bootstrap.

Un container en Magritte est l'élément qui va contenir les composants créer à partir des descriptions.

```
TBPost >> descriptionContainer
    <magritteContainer>
    ^ super descriptionContainer
        componentRenderer: TBSMagritteFormRenderer;
        yourself
```


Nous pouvons maintenant nous occuper des différents champs de saisie et améliorer leur apparence.

```
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
```


![Formulaire d'ajout d'un post avec Bootstrap.](figures/AddAPostBootstrap.png width=85&label=addAPostBootstrap)


```
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
```


```
TBPost >> descriptionCategory
    <magritteDescription>
    ^ MAStringDescription new
        label: 'Category';
        priority: 300;
        accessor: #category;
        comment: 'Unclassified if empty';
        componentClass: TBSMagritteTextInputComponent;
        yourself
```




```
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


Grâce à ces nouvelles descriptions Magritte, les formulaires générés sous la forme de composants Seaside utilisent Bootstrap. 
Par exemple, le formulaire d'édition d'un post doit maintenant ressembler à celui de la figure *@addAPostBootstrap@*.


### Conclusion 


Nous avons mis en place la partie administration de TinyBlog sous la forme d'un rapport des bulletins contenus dans le blog courant. 
Nous avons également ajouté des liens permettant une gestion CRUD de chaque bulletin. 
Nous avons réalisé tout cela en utilisant Magritte. 
En effet, nous avons ajouté des descriptions sur les bulletins et généré des composants Seaside (des formulaires) à partir de ces descriptions.
