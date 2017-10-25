MAIN = book
CHAPTERS = \
        Chapters/Chap00-TinyBlog-Introduction-FR \
	Chapters/Chap01-TinyBlog-Model-FR \
	Chapters/Chap02-TinyBlog-ModelExtensionTests-FR \
	Chapters/Chap03-TinyBlog-Teapot-FR \
	Chapters/Chap04-TinyBlog-VoyageMongo-FR \
	Chapters/Chap05-TinyBlog-Seaside-FR \
	Chapters/Chap06-TinyBlog-SeasideAdmin-FR \
	Chapters/Chap09-SeasideREST \
	Chapters/Chap10-TinyBlog-RenoirST-FR \
	Chapters/Chap11-TinyBlog-Mustache-FR \
	Chapters/Chap12-TinyBlog-Export \
	Chapters/Chap13-TinyBlog-Deployment-FR \
	Chapters/Chap14-TinyBlog-Loading-FR

OUTPUTDIRECTORY = build
LATEXTEMPLATE = support/templates/main.latex.mustache
LATEXCHAPTERTEMPLATE = support/templates/chapter.latex.mustache
HTMLTEMPLATE = support/templates/html.mustache
HTMLCHAPTERTEMPLATE = $(HTMLTEMPLATE)

.DEFAULT_GOAL = help
.phony: all book chapters

all: pdf html ## Build everything in all formats
book: pdfbook htmlbook ## Full book only, all formats
chapters: pdfchapters htmlchapters ## Separate chapters, all formats

include support/makefiles/help.mk
include support/makefiles/prepare.mk

include support/makefiles/pdf.mk
include support/makefiles/html.mk
include support/makefiles/epub.mk
