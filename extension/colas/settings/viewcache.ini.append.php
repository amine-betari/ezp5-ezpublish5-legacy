<?php /* #?ini charset="utf-8"?

[ViewCacheSettings]
SmartCacheClear=enabled
MaxParents=3
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=parent
ClearRelationTypes[]
ClearRelationTypes[]=common
ClearRelationTypes[]=reverse_common
ClearRelationTypes[]=reverse_embedded
ClearRelationTypes[]=attribute
ClearRelationTypes[]=reverse_attribute

[ecolas_bylink_home_page]
DependentClassIdentifier[]
DependentClassIdentifier[]=folder
ClearCacheMethod[]=parent
ClearCacheMethod[]=object

[ecolas_agenda]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_mea_master_page]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_portrait]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_remontees_auto]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_texte]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_entree_agenda]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_diapo]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_remontees_auto
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_dossier]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_bylink_home_page
DependentClassIdentifier[]=ecolas_remontees_auto
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_element_liste]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_remontees_auto
DependentClassIdentifier[]=ecolas_master_container
DependentClassIdentifier[]=ecolas_bylink_home_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_galerie_vid]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_bylink_home_page
DependentClassIdentifier[]=ecolas_remontees_auto
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_liste]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_bylink_home_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=parent
ClearCacheMethod[]=relating


[ecolas_liste_thema]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_bylink_home_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=parent
ClearCacheMethod[]=relating


[ecolas_mini_site]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_bylink_home_page
DependentClassIdentifier[]=ecolas_remontees_auto
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[newsletter_issue]
DependentClassIdentifier[]
DependentClassIdentifier[]=bouygues_liste
DependentClassIdentifier[]=bouygues_liste_thema
DependentClassIdentifier[]=bouygues_master_page
DependentClassIdentifier[]=bouygues_bylink_home_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_prestataire]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_home_page
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[ecolas_video]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_bylink_home_page
DependentClassIdentifier[]=ecolas_galerie_vid
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating
ClearCacheMethod[]=parent

[ecolas_visionneuse_home]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_home_page
DependentClassIdentifier[]=folder
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=parent

[article]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_home_page
DependentClassIdentifier[]=ecolas_remontees_auto
DependentClassIdentifier[]=ecolas_visionneuse_home
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=parent
ClearCacheMethod[]=relating

[ecolas_session]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_page_sessions
DependentClassIdentifier[]=ecolas_session_element
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=parent
ClearCacheMethod[]=relating

[ecolas_session_element]
MaxParents=2
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_session
DependentClassIdentifier[]=ecolas_page_sessions
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating
ClearCacheMethod[]=parent

[user]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_session
DependentClassIdentifier[]=ecolas_page_sessions
DependentClassIdentifier[]=ecolas_session_element
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating


[file]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_master_page
DependentClassIdentifier[]=ecolas_home_page
DependentClassIdentifier[]=ecolas_remontees_auto
ClearCacheMethod[]
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_home_media]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_home_page
ClearCacheMethod[]
ClearCacheMethod[]=parent
ClearCacheMethod[]=object
ClearCacheMethod[]=relating
MaxParents=2

[ecolas_texte_footer]
DependentClassIdentifier[]
DependentClassIdentifier[]=ecolas_master_page
ClearCacheMethod[]
ClearCacheMethod[]=parent
ClearCacheMethod[]=object
ClearCacheMethod[]=relating

[ecolas_annexe]
DependentClassIdentifier[]
DependentClassIdentifier[]=article
DependentClassIdentifier[]=ecolas_diapo
DependentClassIdentifier[]=ecolas_galerie_vid
DependentClassIdentifier[]=ecolas_liste_thema
DependentClassIdentifier[]=ecolas_liste
DependentClassIdentifier[]=ecolas_mini_site
DependentClassIdentifier[]=ecolas_page_sessions
ClearCacheMethod[]=parent
ClearCacheMethod[]=object

*/ ?>