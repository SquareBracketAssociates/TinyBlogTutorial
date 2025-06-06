## Utiliser des modèles de mise en page avec Mustache


Poursuivons l'amélioration de TinyBlog en nous intéressant à l'utilisation de modèles pour l'affichage des données de TinyBlog. Les modèles sont particulièrement utiles pour le développement web car ils permettent de mixer aisément des chaînes de caractères avec des balises HTML et ceci, sans avoir recours à de toujours pénibles manipulations des chaînes de caractères. Ils facilitent également la lecture et la maintenance du code. Ils sont très utiles pour la localisation des applications. Si votre logiciel doit être traduit en plusieurs langues, vous apprécierez forcément les modèles.

Parmi les technologies web, il existe de nombreux moteurs de gestion des modèles. Avec Pharo, vous disposez de l'adaptation de Mustache ([https://mustache.github.io/](https://mustache.github.io/)) qui est un produit reconnu. L'installation est rapide puisque le framework Mustache est disponible dans le catalogue Pharo.

### Ajouter un bas de page


L'objectif est d'ajouter un bas de page à l'écran principal de TinyBlog. Cette zone est généralement destinée à recevoir les mentions légales d'un site, des liens, les noms des auteurs et de nombreuses autres informations.

Pour mettre en place le bas de page, il nous faut tout d'abord ajouter la méthode `renderFooterOn:` chargée de l'affichage du bas de page. Vous devez bien évidemment modifier la méthode `renderContentOn:` de la classe `TBPostListComponent` en ajoutant l'appel à la méthode `renderFooterOn:`.

```
TBPostListComponent >> renderFooterOn: html
 	html div class: 'footer'; with: [
		html text: 'I''am the footer!'
	]

TBPostListComponent >> renderContentOn: html
	super renderContentOn: html.
	html render: (TBAuthentificationComponent from: self).
	html
		tbsContainer: [ 
			html tbsRow
				showGrid;
				with: [ 
					self renderCategoryColumnOn: html.
					self renderPostColumnOn: html
			]. 
			self renderFooterOn: html 		
		]
```


Le style de la `div` contenant le bas de page est modifié à l'aide d'une classe CSS nommée `footer`. Celle ci nous permet de spécifier le style d'affichage du bas de page. Pour cela, ajoutez un appel à la méthode `applyFooterStyleOn:` à la déclaration de la feuille de styles.

```
TBApplicationRootComponent >> styleSheet
	| styles |
	styles := CascadingStyleSheetBuilder new.
	self 
		applyTitleStyleOn: styles;
		applyParagraphSubtitleStyleOn: styles;
		applyParagraphContentStyleOn: styles;
		applyFooterStyleOn: styles.
	^styles build asString
```


Cette nouvelle méthode sélectionne les éléments de la classe `footer` et applique sur eux le style défini par une autre méthode nommée `footerStyleOn:`. 

```
TBApplicationRootComponent >> applyFooterStyleOn: aSheet
	^aSheet declareRuleSetFor: [ :selector | selector div class: 'footer' ]
			with: [ :style | self footerStyleOn: style ]
```


La méthode `footerStyleOn:` fixe les attributs CSS afin de placer la `div` en bas de la page. Un fond gris est appliqué et le texte est centré.

```
TBApplicationRootComponent >> footerStyleOn: aStyle
	aStyle
		position: CssConstants absolute;
		bottom: 0 pixels;
		paddingTop: 25 pixels;
		height: 150 pixels;
		width: 100 percent;
		backgroundColor: (CssRGBColor red: 239 green: 239 blue: 239);	
		textAlign: CssConstants center;
		yourself
```


![Le bas de page](figures/emptyfooter.png width=75&label=nicer11)

Vous pouvez maintenant ajouter du contenu et pour cela, vous allez utiliser Mustache.

### Ajouter du contenu dans le bas de page


Pour ajouter des élément dans le bas de page, vous allez utiliser certaines fonctionnalités de Mustache qui facilitent grandement la substitution d'éléments au sein de modèles. Avec Mustache, il est aîsé de manipuler des éléments textuels statiques mais également des textes générés dynamiquement.

### Utiliser de texte statique


Le premier modèle doit afficher les principales technologies utilisées dans TinyBlog. Pour cela, définissez une méthode `renderPoweredByOn:` dans la classe `TBPostListComponent`. Un dictionaire contient les données qui sont insérées au sein du modèle. Celui-ci est défini par une chaîne de caractères dans laquelle les éléments devant être substitués sont encadrés par les caractères "\{{" et "\}}". 

Par défaut, Mustache utilise les caractères spéciaux d'HTML pour assurer un rendu web optimal (par exemple `<b>Pharo</b>` est transformé en `&lt;b&gt;Pharo&lt;/b&gt;`. Si vous ne voulez pas les utiliser, vous devez encadrer les éléments par les caractères `{{{` et `}}}`.

```
TBPostListComponent >> renderPoweredByOn: html
	html text: ('Powered by {{language}}, {{framework}} and {{tool}}.' asMustacheTemplate value: { 
		'language' -> 'Pharo'. 
		'framework' -> 'Seaside'.
		'tool' -> 'Bootstrap'
	} asDictionary)
```


Vous pouvez maintenant modifier la méthode `renderFooterOn:` afin d'afficher le texte sur la page.

```
TBPostListComponent >> renderFooterOn: html
 	html div class: 'footer'; with: [
		self renderPoweredByOn: html.
	]
```


### Utiliser du texte généré dynamiquement


Avec Mustache, il est également possible de remplacer des éléments au sein d'un modèle à l'aide d'un texte généré dynamiquement. Ici par exemple, la méthode `renderDateTodayOn:` permet à TinyBlog de construire un texte contenant la date du jour. Le code exécuté doit être placé entre crochets au sein du dictionnaire définissant les données à insérer.

```
TBPostListComponent >> renderDateTodayOn: html
	html text: ('The date today is {{today}}.' asMustacheTemplate value: { 'today' -> [ Date today ] } asDictionary)
```


Pour que la date apparaisse sur la page, il vous faut ajouter l'appel à la méthode `renderFooterOn:`.

```
TBPostListComponent >> renderFooterOn: html
 	html div class: 'footer'; with: [
		self renderDateTodayOn: html.
		html break.
		self renderPoweredByOn: html.
	]
```


![Le bas de page](figures/footer.png width=75&label=nicer112)

### Conclusion


Nous n'avons ici qu'effleurer le potentiel de Mustache. Il simplifie réellement la construction d'éléments au sein d'une application web. Ce framework propose de nombreuses autres fonctionnalités. Pour en savoir plus et explorer toutes ses possibilités, nous vous invitons à consulter le chapitre qui lui est consacré au sein du livre "Enterprise Pharo".

