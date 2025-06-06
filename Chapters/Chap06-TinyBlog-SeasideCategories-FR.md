## Gestion des catégories


Dans ce chapitre, nous allons ajouter la gestion des catégories des bulletins. 
Si vous avez le sentiment d'être un peu perdu, la figure *@AssociationArchitectureUser@* vous montre les composants sur lesquels nous allons travailler dans ce chapitre. 

![L'architecture des composants de la partie publique avec catégories.](figures/ApplicationArchitectureUser.pdf width=75&label=AssociationArchitectureUser)

Les instructions pour charger le code des chapitres précédents sont disponibles dans le chapitre *@cha:loading@*.

### Affichage des bulletins par catégorie


Les bulletins sont classés par catégorie. Par défaut, si aucune catégorie n'a été précisée, ils sont rangés dans une catégorie spéciale dénommée "Unclassified".
Nous allons créer un composant nommé `TBCategoriesComponent` pour gérer une liste de catégories.

#### Pour afficher les catégories


Nous avons besoin d'un composant qui affiche la liste des catégories présentes dans le blog et permet d'en sélectionner une. 
Ce composant devra donc avoir la possibilité de communiquer avec le composant `TBPostsListComponent` afin de lui communiquer la catégorie courante. La situation est décrite par la figure *@AssociationArchitectureUser@*.

Rappelez-vous qu'une catégorie est simplement exprimée comme une chaîne de caractères dans le modèle défini dans le Chapitre *@cha:model@* et comme l'illustre le test suivant.

```
testAllBlogPostsFromCategory
	self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
```



% +Ajout du composant Categories.>file://figures/ComponentRelationship4.pdf|width=75|label=compt4+

#### Definition du composant


Nous définissons un nouveau composant nommé `TBCategoriesComponent`. 
Ce composant va garder une collection triée par ordre alphabétique de chaines de caractères pour chacune des catégories ainsi qu'un pointeur sur le composant postsList associé. 

```
WAComponent subclass: #TBCategoriesComponent
   instanceVariableNames: 'categories postsList'
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


Nous définissons les accesseurs associés.

```
TBCategoriesComponent >> categories
   ^ categories
```


```
TBCategoriesComponent >> categories: aCollection
   categories := aCollection asSortedCollection
```


```
TBCategoriesComponent >> postsList: aComponent
      postsList := aComponent
```


```
TBCategoriesComponent >> postsList
   ^ postsList
```


Nous définissons aussi une méthode de création au niveau classe.

```
TBCategoriesComponent class >> categories: categories postsList: aTBScreen
   ^ self new categories: categories; postsList: aTBScreen 
```



#### Liaison depuis la liste de bulletins

Nous avons donc besoin d'ajouter une variable d'instance pour stocker la catégorie courante dans la classe `TBPostsListComponent`.

```
TBScreenComponent subclass: #TBPostsListComponent
   instanceVariableNames: 'currentCategory'
   classVariableNames: ''
   package: 'TinyBlog-Components'
```


Nous définissons les accesseurs associés.
```
TBPostsListComponent >> currentCategory
   ^ currentCategory
```


```
TBPostsListComponent >> currentCategory: anObject
   currentCategory := anObject
```



#### La méthode selectCategory:


La méthode `selectCategory:` \(protocole 'actions'\) communique au composant `TBPostsListComponent` la nouvelle catégorie courante.

```
TBCategoriesComponent >> selectCategory: aCategory
   postsList currentCategory: aCategory
```


%  Notez que si nous voulions avoir un effet visuel plus avancé le composant catégories devrait peut être lui aussi garder trace de la catégorie couramment sélectionnée.


### Rendu des catégories

Nous ajoutons la méthode `renderCategoryLinkOn:with:` \(protocole 'rendering'\) pour afficher les catégories sur la page. En particulier, pour chaque catégorie nous définissons le fait que cliquer sur la catégorie la sélectionne comme la catégorie courante.
Nous utilisons un callback \(message `callback:`\). L'argument de ce message est un bloc qui peut contenir n'importe quelle expression Pharo. Cela illustre la puissance de Seaside.

```
TBCategoriesComponent >> renderCategoryLinkOn: html with: aCategory
   html tbsLinkifyListGroupItem
      callback: [ self selectCategory: aCategory ];
      with: aCategory
```


La méthode de rendu `renderContentOn:` du composant `TBCategoriesComponent` est simple : on itère sur toutes les catégories et on les affiche en utilisant Bootstrap.

```
TBCategoriesComponent >> renderContentOn: html
   html tbsListGroup: [
      html tbsListGroupItem
         with: [  html strong: 'Categories' ].
      categories do: [ :cat | 
         self renderCategoryLinkOn: html with: cat ] ]
```


Nous avons presque fini mais il faut encore afficher la liste des catégories et mettre à jour la liste des bulletins en fonction de la catégorie courante. 

### Mise à jour de la liste des bulletins


Nous devons mettre à jour les bulletins.
Pour cela, modifions la méthode de rendu du composant `TBPostsListComponent`.

La méthode `readSelectedPosts` récupère les bulletins à afficher depuis la base et les filtre en fonction de la catégorie courante. Si la catégorie courante est `nil`, cela signifie que l'utilisateur n'a pas encore sélectionné de catégorie et l'ensemble des bulletins visibles de la base est affiché. 
Si elle contient une valeur autre que `nil`, l'utilisateur a sélectionné une catégorie et l'application affiche alors la liste des bulletins attachés à cette catégorie.

```
TBPostsListComponent >> readSelectedPosts
   ^ self currentCategory
      ifNil: [ self blog allVisibleBlogPosts ]
      ifNotNil: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]
```


Nous pouvons maintenant modifier la méthode chargée du rendu de la liste des posts :

```
TBPostsListComponent >> renderContentOn: html
   super renderContentOn: html.
   html render: (TBCategoriesComponent
               categories: (self blog allCategories)
               postsList: self).
   html tbsContainer: [ 
      self readSelectedPosts do: [ :p |
         html render: (TBPostComponent new post: p) ] ]
```


Une instance du composant `TBCategoriesComponent` est ajoutée sur la page et permet de sélectionner la catégorie courante \(voir la figure *@ugly@*\). 
De même qu'expliqué précédemment, une nouvelle instance de `TBCategoriesComponent` est créé à chaque rendu du composant `TBPostsListComponent`, donc il n'est pas nécessaire de l'ajouter dans la liste des sous-composants retourné par `children:`.

![Catégories afin de sélectionner les posts.](figures/categoriesUgly.png width=75&label=ugly)

#### Améliorations possibles


Mettre en dur le nom des classes et la logique de création des catégories et des bulletins n'est pas optimale. Proposer quelques méthodes pour résoudre cela.

### Look et agencement


Nous allons maintenant agencer le composant `TBPostsListComponent` en utilisant un 'responsive design' pour la liste des bulletins \(voir la figure  *@nicer5@*\). Cela veut dire que le style CSS va adapter les composants à l'espace disponible.

Les composants sont placés dans un container Bootstrap puis agencés sur une ligne avec deux colonnes. La dimension des colonnes est déterminée en fonction de la résolution \(viewport\) du terminal utilisé. Les 12 colonnes de Bootstrap sont réparties entre la liste des catégories et la liste des posts. Dans le cas d'une résolution faible, la liste des catégories est placée au dessus de la liste des posts \(chaque élément occupant 100% de la largeur du container\).


```
TBPostsListComponent >> renderContentOn: html
   super renderContentOn: html.
   html tbsContainer: [
      html tbsRow showGrid;
         with: [
            html tbsColumn
               extraSmallSize: 12;
               smallSize: 2;
               mediumSize:  4;
               with: [
                  html render: (TBCategoriesComponent
                    categories: (self blog allCategories)
                    postsList: self) ].
      html tbsColumn
               extraSmallSize: 12;
               smallSize: 10;
               mediumSize: 8;
               with: [
         self readSelectedPosts do: [ :p |
             html render: (TBPostComponent new post: p) ] ] ] ]
```


Vous devez obtenir une application proche de celle représentée par la figure *@nicer5@*.

![Liste des catégories avec un meilleur agencement.](figures/NicerCategories.png width=75&label=nicer5)

Lorsqu'on sélectionne une catégorie, la liste des posts est bien mise à jour.
Toutefois, l'entrée courante dans la liste des catégories n'est pas sélectionnée.
Pour cela, on modifie la méthode suivante :

```
TBCategoriesComponent >> renderCategoryLinkOn: html with: aCategory
   html tbsLinkifyListGroupItem
      class: 'active' if: aCategory = self postsList currentCategory;
      callback: [ self selectCategory: aCategory ]; 
      with: aCategory
```


Bien que le code fonctionne, on ne doit pas laisser la méthode `renderContentOn:` de la classe `TBPostsListComponent` dans un tel état. Elle est bien trop longue et difficilement réutilisable. Proposer une solution. 


### Modulariser son code avec des petites méthodes


Voici notre solution au problème précédent. Pour permettre une meilleure lecture et réutilisation future, nous commençons par définir les méthodes de création des composants 

```
TBPostsListComponent >> categoriesComponent
	^ TBCategoriesComponent 
			categories: self blog allCategories 
			postsList: self
```


```
TBPostsListComponent >> postComponentFor: aPost
	^ TBPostComponent new post: aPost
```


```
TBPostsListComponent >> renderContentOn: html
	super renderContentOn: html.
	html
		tbsContainer: [ html tbsRow
				showGrid;
				with: [ 
					html tbsColumn
						extraSmallSize: 12;
						smallSize: 2;
						mediumSize: 4;
						with: [ html render: self categoriesComponent ].
					html tbsColumn
						extraSmallSize: 12;
						smallSize: 10;
						mediumSize: 8;
						with: [ self readSelectedPosts
								do: [ :p | html render: (self postComponentFor: p) ] ] ] ]
```


#### Autre passe de découpage


Continuons à découper cette méthode en plusieurs petites méthodes.  Pour cela, créons des méthodes pour les traitements élémentaires. 

```
TBPostsListComponent >> basicRenderCategoriesOn: html
	html render: self categoriesComponent 
```


```
TBPostsListComponent >> basicRenderPostsOn: html
	self readSelectedPosts do: [ :p | 
		html render: (self postComponentFor: p) ]
```


Puis nous utilisons ces traitements pour simplifier la méthode `renderContentOn:`.

```
TBPostsListComponent >> renderContentOn: html
   super renderContentOn: html.
   html
      tbsContainer: [ 
         html tbsRow
            showGrid;
            with: [ self renderCategoryColumnOn: html.
                  self renderPostColumnOn: html ] ]
```



```
TBPostsListComponent >> renderCategoryColumnOn: html
   html tbsColumn
      extraSmallSize: 12;
      smallSize: 2;
      mediumSize: 4;
      with: [ self basicRenderCategoriesOn: html ]
```



```
TBPostsListComponent >> renderPostColumnOn: html
   html tbsColumn
         extraSmallSize: 12;
         smallSize: 10;
         mediumSize: 8;
         with: [ self basicRenderPostsOn: html ] 
```



L'application finale est affichée dans la figure *@final@*.

![TinyBlog UI version finale.](figures/finalPublicWebPage.png width=85&label=final)

### Conclusion

Nous avons défini une interface pour notre blog en utilisant un ensemble de composants définissant chacun
leur propre état et leurs responsabilités. Maintenant il faut remarquer que de très nombreuses applications se construisent de la même manière. Donc vous avez les bases pour définir de nombreuses applications web. 

Dans le prochain chapitre, nous allons voir comment gérer l'identification permettant d'accéder à la partie administration des bulletins.

#### Améliorations possibles


A titre d'exercice, vous pouvez :
- trier les catégories par ordre alphabétique ou
- ajouter un lien nommé 'All' dans la liste des catégories permettant d'afficher tous les bulletins visibles quelque que soit leur catégorie.






