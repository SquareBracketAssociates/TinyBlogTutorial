## Charger le code des chapitres@cha:loadingCe chapitre contient les expressions permettant de charger le code décrit dans chacun des chapitres. Ces expressions peuvent être exécutées dans n'importe quelle image Pharo 8.0 \(ou supérieure\).Néanmoins, utiliser l'image Pharo du MOOC \(cf. Pharo Launcher\) est généralement plus rapide car elle contient déjà de nombreuses dépendances comme : Seaside, Voyage, ...Si vous commencez par le chapitre 4 par exemple, vous pouvez charger tout le code des chapitres précédents \(1, 2 et 3\) en suivant la procédure décrite dans la section 'Chapitre 4' ci-après.Bien évidemment, nous vous conseillons de faire votre propre code mais cela vous permettra de ne pas rester bloqué le cas échéant.### Chapitre 3 : Extension du modèle et tests unitairesVous pouvez charger la correction du chapitre 2 en exécutant le code suivant :```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter2/src';
   onConflict: [ :ex | ex useLoaded ];
   load```Après le chargement d'un package, il est recommandé d'exécuter les tests unitaires qu'il contient afin de vérifier le bon fonctionnement du code chargé.Pour cela, vous pouvez lancer l'outil TestRunner \(Tools menu > Test Runner\), chercher le package TinyBlog-Tests et lancer tous les tests unitaires de la classe `TBBlogTest` en cliquant sur le bouton "Run Selected". Tous les tests doivent être verts. Une alternative est de presser l'icone verte qui se situe à coté de la class `TBBlogTest`.### Chapitre 4 : Persistance des données de TinyBlog avec Voyage et MongoVous pouvez charger la correction du chapitre 3 en exécutant le code suivant:```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter3/src';
   onConflict: [ :ex | ex useLoaded ];
   load```Ouvrez maintenant un browser de code pour regarder le code des classes `TBBlog` et `TBBlogTest` et compléter votre propre code si nécessaire.Avant de poursuivre, n'oubliez pas de commiter une nouvelle version dans votre dépôt si vous avez modifié votre application.### Chapitre 5 : Commencer avec SeasideVous pouvez charger la correction du chapitre 4 en exécutant le code suivant:```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter4/src';
   onConflict: [ :ex | ex useLoaded ];
   load```Exécutez les tests.Pour tester l'application, vous devez lancer le serveur HTTP pour Seaside:```ZnZincServerAdaptor startOn: 8080.```Ouvrez votre browser sur `http://localhost:8080/TinyBlog`Si vous avez besoin de créer quelques posts initiaux:```TBBlog reset ; createDemoPosts```### Chapitre 6 : Des composants web pour TinyBlogVous pouvez charger la correction des chapitres précédents en exécutant le code suivant:```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter5/src';
   onConflict: [ :ex | ex useLoaded ];
   load```Pour tester le code, vous devez lancer le serveur HTTP pour Seaside:```ZnZincServerAdaptor startOn: 8080.```Ouvrez votre browser sur `http://localhost:8080/TinyBlog`Si vous avez besoin de créer quelques posts initiaux:```TBBlog reset ; createDemoPosts```### Chapitre 7 : Gestion des catégoriesVous pouvez charger la correction des chapitres précédents en exécutant le code suivant:```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter6/src';
   onConflict: [ :ex | ex useLoaded ];
   load```Même process que le précédent.### Chapitre 8 : Authentification et SessionVous pouvez charger l'application TinyBlog avec la partie publique en exécutant :```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter7/src';
   onConflict: [ :ex | ex useLoaded ];
   load```Pour tester le code, vous devez lancer le serveur HTTP pour Seaside:```ZnZincServerAdaptor startOn: 8080.```### Chapitre 9 : Interface Web d’administration et génération automatiqueVous pouvez charger l'application TinyBlog avec l'authentification en exécutant :```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog:chapter8/src';
   onConflict: [ :ex | ex useLoaded ];
   load```### La dernière version de TinyBlogLa version la plus à jour de TinyBlog peut chargée ainsi :```Metacello new
   baseline:'TinyBlog';
   repository: 'github://LucFabresse/TinyBlog/src';
   onConflict: [ :ex | ex useLoaded ];
   load.```