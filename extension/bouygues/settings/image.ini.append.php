<?php /* #?ini charset="utf-8"?

[ImageMagick]
PreParameters=-strip

[AliasSettings]
AliasList[]=rss_small
AliasList[]=thumbdiaporama
AliasList[]=thumbvideo
AliasList[]=largediaporama
AliasList[]=zoomdiaporama
AliasList[]=includediaporama
AliasList[]=thumblistheader
AliasList[]=thumblist
AliasList[]=mediumlist
AliasList[]=largelist
AliasList[]=mediummaster
AliasList[]=mediummea
AliasList[]=thumbmea
AliasList[]=mediumtexte
AliasList[]=thumbtexte
AliasList[]=minisiteheader
AliasList[]=articlesummary
AliasList[]=home_pageactu
AliasList[]=home_pageactu_one
AliasList[]=home_pageactu_two
AliasList[]=home_blocmedia
AliasList[]=whoswho_user
AliasList[]=home_blocevenement
AliasList[]=articlewidth
AliasList[]=newslettermain
AliasList[]=newsletterother
AliasList[]=masterportrait
AliasList[]=articlewidthsummary
AliasList[]=ebyperso_pageactu
AliasList[]=video_image
AliasList[]=home_small_block


[MIMETypeSettings]
Quality[]
Quality[]=image/jpeg;90
Quality[]=image/gif;90
Quality[]=image/png;90

[rss_small]
Reference=
Filters[]
Filters[]=geometry/scaledownonly=83;53

[reference]
Filters[]
Filters[]=geometry/scaledownonly=1000;1000

[small]
Reference=reference
Filters[]=geometry/scaledownonly=100;100

[tiny]
Reference=reference
Filters[]=geometry/scaledownonly=30;30

[medium]
Reference=reference
Filters[]=geometry/scaledownonly=200;200

[large]
Reference=reference
Filters[]=geometry/scaledownonly=300;300

[thumbdiaporama]
Reference=reference
GUIName=Diaporama - petite
Filters[]=geometry/scaleheight=62
Filters[]=geometry/crop=80;62;0;0

[thumbvideo]
Reference=reference
GUIName=Video - petite
Filters[]=geometry/scaleheight=98
Filters[]=geometry/crop=127;98;0;0

[largediaporama]
Reference=reference
GUIName=Diaporama - grande
Filters[]=geometry/scaledownonly=676;514

[zoomdiaporama]
Reference=reference
GUIName=Diaporama - zoom
Filters[]=geometry/scaledownonly=800;608

[includediaporama]
Reference=reference
GUIName=Diaporama - Milieu de page - grande
Filters[]=geometry/scaledownonly=596;453

[thumblistheader]
Reference=reference
GUIName=Liste - header - petite
Filters[]=geometry/scale=160;103

[thumblist]
Reference=reference
GUIName=Liste - petite
Filters[]=geometry/scale=70;45

[mediumlist]
Reference=reference
GUIName=Liste - moyenne
Filters[]=geometry/scaledownonly=115;74

[largelist]
Reference=reference
GUIName=Liste - grande
Filters[]=geometry/scaledownonly=132;85

[mediummaster]
Reference=reference
GUIName=Master page - moyenne
Filters[]=geometry/scaledownonly=214;138

[thumbmea]
Reference=reference
GUIName=Bloc mise en avant - petite
Filters[]=geometry/scaledownonly=70;45

[mediummea]
Reference=reference
GUIName=Bloc mise en avant - moyenne
Filters[]=geometry/scaledownonly=130;84

[thumbtexte]
Reference=reference
GUIName=Bloc texte - petite
Filters[]=geometry/scaledownonly=70;45

[mediumtexte]
Reference=reference
GUIName=Bloc texte - moyenne
Filters[]=geometry/scaledownonly=130;84

[minisiteheader]
Reference=reference
GUIName=Mini site - colonne de droite
Filters[]=geometry/scaledownonly=690;130

[articlesummary]
Reference=reference
GUIName=Article - colonne de droite (283 x ...)
Filters[]=geometry/scalewidthdownonly=283

[articlewidthsummary]
Reference=reference
GUIName=Article - image + colonne de droite (360 x ...)
Filters[]=geometry/scalewidthdownonly=360

[articlewidth]
Reference=reference
GUIName= Article - Largeur de page (680 x ...)
Filters[]=geometry/scalewidthdownonly=680

[home_pageactu]
Reference=reference
GUIName=Accueil - actualité
Filters[]=geometry/scalewidthdownonly=140;90
Filters[]=background=white

[home_pageactu_one]
Reference=reference
GUIName=Accueil - actualité - groupe - une seule actualité
Filters[]=geometry/scaledownonly=195;126

[home_pageactu_two]
Reference=reference
GUIName=Accueil - ctualité - groupe - deux actualités
Filters[]=geometry/scaledownonly=130;84

[home_blocmedia]
Reference=reference
GUIName=Accueil - média
Filters[]=geometry/scaledownonly=208;107

[home_blocevenement]
Reference=reference
GUIName=Accueil - événement
Filters[]=geometry/scaledownonly=345;120

[home_small_block]
Reference=reference
GUIName=Accueil - bloc
Filters[]=geometry/scaledownonly=100;40

[whoswho_user]
Reference=reference
GUIName=Who's who - utilisateur
Filters[]=geometry/scaledownonly=136;122

[newslettermain]
Reference=reference
GUIName=Newsletter - Actualité principale
Filters[]=geometry/scaledownonly=214;138

[newsletterother]
Reference=reference
GUIName=Newsletter - Dernières principale
Filters[]=geometry/scaledownonly=132;84

[masterportrait]
Reference=reference
GUIName=Master Page - Portrait
Filters[]=geometry/scaledownonly=72;

[ebyperso_pageactu]
Reference=reference
GUIName=Eby Perso - Actualité groupe
Filters[]=geometry/scaledownonly=155;

[video_image]
Reference=reference
GUIName=Vidéo - première image
Filters[]=geometry/scaledownonly=422;320


*/ ?>