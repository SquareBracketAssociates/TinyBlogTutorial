## Exportation de données


Tout bon logiciel se doit de disposer de fonctionnalités permettant l'exportation des données qu'il manipule. Dans le cadre de TinyBlog, il est ainsi intéressant de proposer à l'utilisateur d'exporter en PDF un post afin d'en conserver la trace. Il pourra également l'imprimer aisément avec une mise en page adaptée. 
Pour l'administrateur du blog, il est utile de proposer des fonctionnalités d'exportation en CSV et en XML afin de faciliter la sauvegarde du contenu du blog. En cas d'altération de la base de données, l'administrateur dispose alors d'une solution de secours pour remettre en ordre son instance de l'application dans les plus brefs délais. Proposer des fonctionnalités d'exportation permet également d'assouplir l'utilisation d'un logiciel en favorisant l'interopérabilité, c'est à dire l'échange des données avec d'autres logiciels. Il n'y a rien de pire qu'un logiciel fermé ne sachant communiquer avec personne.
 
### Exporter un article en PDF


Le format PDF (Portable Document Format) a été créé par la société Adobe en 1992. C'est un langage de description de pages permettant de spécifier la mise en forme d'un document ainsi que son contenu. Il est particulièrement utile pour concevoir des documents électroniques, des eBooks et dans le cadre de l'impression puisqu'un document PDF conserve sa mise en forme lorsqu'il est imprimé. Vous allez justement mettre à profit cette propriété en ajoutant à TinyBlog la possibilité d'exporter un post sous la forme d'un fichier PDF.

#### Artefact


La construction d'un document PDF avec Pharo est grandement simplifiée à l'aide d'un framework nommé Artefact ([https://sites.google.com/site/artefactpdf/](https://sites.google.com/site/artefactpdf/)). Pour l'installer, il vous suffit de le sélectionner dans le catalogue Pharo. 

#### Intégrer l'exportation dans la liste des posts


Pour pouvoir exporter un post en PDF, l'utilisateur doit disposer d'un lien sur chaque post. Pour cela, vous devez modifier la méthode `TBPostComponent >> renderContentOn:`. 

```
TBPostComponent >> renderContentOn: html
   html paragraph class: 'title'; with: self title.
   html paragraph class: 'subtitle'; with: self date.
   html paragraph class: 'content'; with: self text.
   html div 
      with: [ 
         html anchor
         callback: [ self exportPostAsPdf ];
         with: [
			   html tbsGlyphIcon iconSave.
			   html text: 'pdf' ] ].
```


La figure *@pdfLink@* montre le lien d'export en PDF ajouté pour chacun des posts.

![Chaque post peut être exporté en PDF](figures/posttopdf.png width=100&label=pdfLink)

Ajoutons maintenant la méthode de callback:

```
TBPostComponent >> exportPostAsPdf
   | pdfStream |
   pdfStream := TBPostPDFExport post: post.
   self requestContext respond: [:response | 
      response 
   	   contentType: 'application/pdf; charset=UTF-8';
   	   attachmentWithFileName: post title, '.pdf';
   	   binary;
   	   nextPutAll: pdfStream contents ]
```



Lorsque l'utilisateur clique sur le lien, une instance de la classe `TBPostPDFExport` est créée. 
Cette classe aura la responsabilité de construire le document PDF à partir du bulletin courant.
Ce document est ensuite envoyé à l'utilisateur grâce au contexte HTTP.

#### Construction du document PDF


Vous allez maintenant implémenter la classe `TBPostPDFExport`. Celle ci nécessite deux variables d'instance qui sont `post` contenant le post sélectionné et `pdfdoc` pour stocker le document PDF généré.

```
Object subclass: #TBPostPDFExport
	instanceVariableNames: 'post pdfdoc'
	classVariableNames: ''
	category: 'TinyBlog-Export'

TBPostPDFExport >> post
	^ post

TBPostPDFExport >> post: aPost
    post := aPost       
```


Vous avez besoin de la méthode de classe `context:post:` qui est le point d'entrée pour utiliser la classe. 
Les méthodes `exportPdf` et `renderPostAsPdfInto:` produisent ensuite le document PDF .

```
TBPostPDFExport class >> post: aPost
	^ self new
		post: aPost;
		exportPdf   
```


```
TBPostPDFExport >> exportPdf
	| pdfStream |
	pdfStream := MultiByteBinaryOrTextStream on: String new.
	self renderPostAsPdfInto: pdfStream.
	^ pdfStream reset
```


	
```
TBPostPDFExport >> renderPostAsPdfInto: aStream
   | aPage titleFont titleColor layout pharoLogo metaDataColor defaultFont | 
   pharoLogo := Morph new 
      extent: PolymorphSystemSettings pharoLogo extent;
      color: Color white;
      addMorph: PolymorphSystemSettings pharoLogo.
   
   pdfdoc := PDFDocument new.
   
   titleColor := PDFColor r: 13 g: 100 b: 175.
   titleFont := PDFHelveticaFont new
      fontSize: 22 pt;
      bold: true.
   
   metaDataColor := PDFColor greyLevel: 0.3.
   
   defaultFont := PDFHelveticaFont new
      fontSize: 12 pt ; yourself.
   
   aPage := PDFPage new.
   aPage add: ((PDFPngElement fromMorph: pharoLogo)
      from: 10 mm @ 20 mm;
      dimension: 80mm @ 27mm).
   
   layout := PDFVerticalLayout on: {
      (PDFFormattedTextElement new
         font: titleFont;
         textColor: titleColor;
         text: post title).
      
      (PDFFormattedTextElement new
         textColor: metaDataColor;
         text: post date asString).
      
      (PDFParagraphElement new
         dimension: 150 mm @ 35 mm;
         font: defaultFont;
         text: post text ) }.
      		
   layout from: 25 mm @ 80 mm.
   layout spacing: 1 cm.
   aPage add: layout.
   pdfdoc add: aPage.
   pdfdoc exportTo: aStream
```



La figure *@pdfResult@* montre le résultat d'un export en PDF d'un bulletin.

![Résultat du rendu PDF d'un bulletin](figures/postInPdf.png width=100&label=pdfResult)

### Exportation des posts au format CSV


Vous allez poursuivre l'amélioration de TinyBlog en ajoutant une option dans la partie "Administration" de l'application. Celle ci doit permettre l'exportation de l'ensemble des billets du blog dans un fichier CSV. Ce format (Comma-separated values) est un format bien connu des utilisateurs de tableurs qui l'exploitent souvent pour importer ou exporter des données. Il s'agit d'un fichier texte dans lequel les données sont formatés et distinctes les unes des autres à l'aide d'un caractère séparateur qui est le plus souvent une virgule. Le fichier est donc composé de lignes et chacune d'entre elles contient un nombre identique de colonnes. Une ligne se termine par un caractère de fin de ligne (CRLF).

Pour gérer le format CSV dans Pharo, vous disposez du framework NeoCSV installable à l'aide du catalogue.

### Ajouter l'option d'exportation


L'utilisateur doit disposer d'un lien pour déclencher l'exportation des billets au format CSV. Ce lien est ajouté sur la page d'administration, juste en dessous du tableau référençant les billets publiés. Vous devez donc éditer la méthode `TBPostsReport>>renderContentOn:` afin d'ajouter une ancre et un callback.

```
TBPostsReport>>renderContentOn: html
	html tbsGlyphIcon perform: #iconPencil.
   	html anchor
   		callback: [ self addPost ];
      	with: 'Add post'.
	
	super renderContentOn: html.
	
	html tbsGlyphIcon perform: #iconCloudDownload.
   	html anchor
   		callback: [ self exportToCSV ];
      	with: 'Export to CSV'. 	
```


Cette méthode devient un peu trop longue. Il est temps de la fragmenter et d'isoler les différents éléments composant l'interface utilisateur.

```
TBPostsReport>>renderAddPostAnchor: html
	html tbsGlyphIcon perform: #iconPencil.
	html anchor
		callback: [ self addPost ];
		with: 'Add post'

TBPostsReport>>renderExportToCSVAnchor: html
	html tbsGlyphIcon perform: #iconCloudDownload.
	html anchor
		callback: [ self exportToCSV ];
		with: 'Export to CSV'

TBPostsReport>>renderContentOn: html
	self renderAddPostAnchor: html.
	super renderContentOn: html.
	self renderExportToCSVAnchor: html		
```


Il vous faut maintenant implémenter la méthode `TBPostsReport>>exportToCSV`. Celle ci génère une instance de la classe `TBPostsCSVExport`. Cette classe doit transmettre au client un fichier CSV et doit donc connaître le contexte HTTP afin de pouvoir répondre. Il faut également lui transmettre le blog à exporter. 

```
TBPostsReportexportToCSV
	TBPostsCSVExport context: self requestContext blog: self blog	
```


### Implémentation de la classe TBPostsCSVExport


La méthode de classe `context:blog:` initialize une instance de `TBPostsCSVExport` et appelle la méthode `TBPostsCSVExport>>sendPostsToCSVFrom:to:`.

```
Object subclass: #TBPostsCSVExport
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Export'

TBPostsCSVExport class >> context: anHTTPContext blog: aBlog
	^ self new
		sendPostsToCSVFrom: aBlog to: anHTTPContext 
		yourself	
```


Cette méthode lit le contenu de la base et génère grâce à NeoCSV le document CSV. La première étape consiste à déclarer un flux binaire qui sera par la suite transmis au client.

```
TBPostsCSVExport >> sendPostsToCSVFrom: aBlog to: anHTTPContext	
	| outputStream |
	
	outputStream := (MultiByteBinaryOrTextStream on: (OrderedCollection new)) binary.
```


La partie importante de la méthode utilise NeoCSV pour insérer dans le flux de sortie chaque billet converti au format CSV. Le titre, la date de publication et le contenu du billet sont séparés par une virgule. Lorsque cela est necessaire (titre et contenu), NeoCSV utilise des guillemets pour indiquer que la donnée est une chaine de caractères. La méthode `nextPut:` permet d'insérer au début du fichier les noms des colonnes. La méthode `addObjectFields:` sélectionne les données ajoutées au fichier et récoltées à l'aide de la méthode `allBlogPosts`.

```
	outputStream nextPutAll: (String streamContents: [ :stream | 
		(NeoCSVWriter on: stream)
			nextPut: #('Title' 'Date' 'Content');
			addObjectFields: { 
				[ :post | post title ].
				[ :post | post date ].
				[ :post | post text ] }; 
			nextPutAll: (aBlog allBlogPosts)
	]).
```


Il ne vous reste plus qu'à transmettre les données au navigateur du poste client. Pour cela, il vous faut produire une réponse dans le contexte HTTP de la requête. Le type MIME (text/csv) et l'encodage (UTF-8) sont déclarés au navigateur. La méthode `attachmentWithFileName:` permet de spécifier un nom de fichier au navigateur.

```
	anHTTPContext respond: [:response | 
		response 
			contentType: 'text/csv; charset=UTF-8';
			attachmentWithFileName: 'posts.xml';
			binary;
			nextPutAll: (outputStream reset contents)
	]
```


### Exportation des posts au format XML


XML est un autre format populaire pour exporter des informations. Ajouter cette fonctionnalité à TinyBlog ne sera pas difficile car Pharo dispose d'un excellent support du format XML. Pour installer le framework permettant de générer du XML, sélectionnez `XMLWriter` dans le catalogue Pharo. Les classes sont regroupées dans le paquet `XML-Writer-Core`.

#### Mise à jour de l'interface utilisateur


Vous allez ajouter une fonctionnalité afin d'exporter dans un fichier XML l'ensemble des billets contenus dans la base. Il faut donc ajouter un lien sur la page d'administration.

```
TBPostsReport >> renderExportToXMLAnchor: html
	html tbsGlyphIcon perform: #iconCloudDownload.
	html anchor
		callback: [ self exportToXML ];
		with: 'Export to XML'

TBPostsReport >> renderContentOn: html
	self renderAddPostAnchor: html.
	super renderContentOn: html.
	self renderExportToCSVAnchor: html.
	self renderExportToXMLAnchor: html
```


Factorisons le code pour regrouper les deux fonctionnalités d'exportation au sein d'un seule méthode. Un caractère séparateur sera également judicieux pour améliorer l'affichage en évitant que les deux liens ne soient collés l'un à l'autre.

```
TBPostsReport >> renderExportOptionsOn: html
	self renderExportToCSVAnchor: html.
	html text: ' '.
	self renderExportToXMLAnchor: html

TBPostsReport >> renderContentOn: html
	self renderAddPostAnchor: html.
	super renderContentOn: html.
	self renderExportOptionsOn: html	
```


### Génération des données XML


La nouvelle méthode `exportToXML` instancie l'objet `TBPostsXMLExport` qui a la responsabilité de générer le document XML.

```
TBPostsReport >> exportToXML
	TBPostsXMLExport context: self requestContext blog: self blog
```


Il vous faut maintenant implémenter la classe `TBPostsXMLExport`. Celle ci contient une méthode de classe `context:blog:` qui reçoit le contexte de la requête HTTP et la liste des billets.

```
Object subclass: #TBPostsXMLExport
	instanceVariableNames: ''
	classVariableNames: ''
	category: 'TinyBlog-Export'

TBPostsXMLExport class >> context: anHTTPContext blog: aBlog
	^ self new
		sendPostsToXMLFrom: aBlog to: anHTTPContext 
		yourself	
```


La méthode d'instance `sendPostsToXMLFrom:to:` prend en charge la conversion des données contenues dans les instances de `TBPost` vers le format XML. Pour cela, vous avez besoin d'instancier la classe `XMLWriter` et de sauvegarder l'instance dans la variable locale `xml`. Celle ci contiendra le fichier XML produit.

```
TBPostsXMLExport >> sendPostsToXMLFrom: aBlog to: anHTTPContext	
	| xml |

	xml := XMLWriter new enablePrettyPrinting.
```


La message `enabledPrettyPrinting` modifie le comportement du générateur XML en forçant l'insertion de retour à la ligne entre les différentes balises. 
Ceci facilite la lecture d'un fichier XML par un être humain. 
Si le document généré est volumineux, ne pas utiliser cette option permet de réduire la taille des données.

Vous pouvez maintenant formater les données en XML. La message `xml` permet d'insérer une en-tête au tout début des données. Chaque billet est placé au sein d'une balise `post` et l'ensemble des billets est stocké au sein de la balise `posts`. Pour celle ci, un espace de nommage `TinyBlog` est défini et pointe sur le domaine `pharo.org`. Chaque balise `post` est définie au sein du parcours de la collection retournée par la méthode `allBlogPosts`. Le titre est conservé tel quel, par contre la date est convertie au format anglosaxon (year-month-day). Notez le traitement particulier appliqué sur le texte du billet. Celui ci est encadré par une section `CDATA` afin de gérer correctement les caractères spéciaux pouvant s'y trouver (retour à la ligne, lettres accentuées, etc.).

```
xml writeWith: [ :writer | 
		writer xml.
		writer tag 
			name: 'posts';
			xmlnsAt: 'TinyBlog' put: 'www.pharo.org/tinyblog';
			with: [  
				aBlog allBlogPosts do: [ :post | 
					writer tag: 'post' with: [
						writer tag: 'title' with: post title.
						writer tag: 'date' with: (post date yyyymmdd).
						writer tag: 'text' with: [ writer cdata: post text ].
					] 
				]
			]
	].
```


La dernière étape consiste à retourner le document XML au client. Le type MIME utilisé ici est `text/xml`. Le fichier généré porte le nom de `posts.xml`.

```
anHTTPContext respond: [:response | 
	response 
		contentType: 'application/xml; charset=UTF-8';
		attachmentWithFileName: 'posts.xml';
		nextPutAll: (xml contents)
	]	
```


Quelques dizaines de lignes de code ont permis d'implémenter l'exportation en XML des billets. Votre moteur de blog dispose maintenant de fonctionnalités d'exportation et d'archivage des données.

### Amélioration possibles


Il existe de nombreux autres formats utiles pour l'exportation des données. Nous vous proposons d'ajouter le format JSON à la boîte à outils de TinyBlog. Pour cela, nous vous recommandons d'utiliser le framework NeoJSON disponible dans le catalogue Pharo. 

Une autre amélioration consiste à écrire un outil d'importation permettant de charger le contenu d'un fichier CSV ou XML dans la base de données de TinyBlog. Cette fonctionnalité vous permettra de restaurer le contenu de la base de données si un problème technique survient.
