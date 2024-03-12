## Commencer avec Seaside
   instanceVariableNames: ''
   classVariableNames: ''
   package: 'TinyBlog-Components'
   "self initialize"
   | app |
   app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
   app
      addLibrary: JQDeploymentLibrary;
      addLibrary: JQUiDeploymentLibrary;
      addLibrary: TBSDeploymentLibrary
   ^ true
   html text: 'TinyBlog'
   super updateRoot: anHtmlRoot.
   anHtmlRoot beHtml5.
   anHtmlRoot title: 'TinyBlog'