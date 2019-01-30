{def $all_classes = array("article", "folder", "file", "image", "ecolas_application", "ecolas_application_configuration", "ecolas_agenda", "ecolas_annexe", "ecolas_portrait", "ecolas_remontees_auto", "ecolas_texte", "ecolas_texte_footer", "ecolas_categorie", "ecolas_diapo", "ecolas_diapo_image", "ecolas_yammer_authorized_domain", "ecolas_dossier", "ecolas_home_page", "ecolas_session_element", "ecolas_element_liste", "ecolas_element_mea", "ecolas_entree_agenda", "ecolas_faq_categorie", "ecolas_faq_question_reponse", "ecolas_faq_rubrique", "ecolas_galerie_vid", "ecolas_home_media", "ecolas_iframe", "ecolas_liste", "ecolas_liste_thema", "ecolas_master_page", "ecolas_master_container" "ecolas_mea_master_page", "ecolas_mini_site", "ecolas_page_sessions", "ecolas_static", "ecolas_prestataire", "ecolas_prestataire_projet", "ecolas_rss_item", "ecolas_session", "ecolas_yammer_utility", "ecolas_video", "ecolas_videotheque", "ecolas_visionneuse_home")}
{def $all_classes_without_visio = array("article", "folder", "file", "image", "ecolas_application", "ecolas_application_configuration", "ecolas_agenda", "ecolas_annexe", "ecolas_portrait", "ecolas_remontees_auto", "ecolas_texte", "ecolas_texte_footer", "ecolas_categorie", "ecolas_diapo", "ecolas_diapo_image", "ecolas_yammer_authorized_domain", "ecolas_dossier", "ecolas_home_page", "ecolas_session_element", "ecolas_element_liste", "ecolas_element_mea", "ecolas_entree_agenda", "ecolas_faq_categorie", "ecolas_faq_question_reponse", "ecolas_faq_rubrique", "ecolas_galerie_vid", "ecolas_home_media", "ecolas_iframe", "ecolas_liste", "ecolas_liste_thema", "ecolas_master_page", "ecolas_master_container" "ecolas_mea_master_page", "ecolas_mini_site", "ecolas_page_sessions", "ecolas_static", "ecolas_prestataire", "ecolas_prestataire_projet", "ecolas_rss_item", "ecolas_session", "ecolas_yammer_utility", "ecolas_video", "ecolas_videotheque")}


<ProccessInformation comment="Creating roles" />
<CreateRole>
    {include uri="design:xmlinstaller/roles/super_editor_role.tpl"}
    {include uri="design:xmlinstaller/roles/editor_role.tpl"}
    {include uri="design:xmlinstaller/roles/editor_media_role.tpl"}
    {include uri="design:xmlinstaller/roles/read_role.tpl"}
    {include uri="design:xmlinstaller/roles/front_authenticated_user_role.tpl"}
</CreateRole>

<ProccessInformation comment="Assigning common roles to user groups" />
<AssignRoles>
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_SUPER_EDITOR_OBJECT_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_SUPER_EDITOR_OBJECT_ID" />
    <RoleAssignment roleID="internal:SUPER_EDITOR_ROLE" assignTo="internal:USERS_SUPER_EDITOR_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_OBJECT_ID" subtreeLimitation="internal:ECOLAS_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECOLAS_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOLAS_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOEST_OBJECT_ID" subtreeLimitation="internal:ECOEST_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECOEST_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOEST_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECORAIL_OBJECT_ID" subtreeLimitation="internal:ECORAIL_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECORAIL_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECORAIL_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOIDFN_OBJECT_ID" subtreeLimitation="internal:ECOIDFN_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECOIDFN_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOIDFN_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECO_RHONE_ALPE_SAUVERGNE_OBJECT_ID" subtreeLimitation="internal:ECO_RHONE_ALPES_AUVERGNE_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECO_RHONE_ALPE_SAUVERGNE_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECO_RHONE_ALPE_SAUVERGNE_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECO_CENTRE_OUEST_OBJECT_ID" subtreeLimitation="internal:ECO_CENTRE_OUEST_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECO_CENTRE_OUEST_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECO_CENTRE_OUEST_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOMM_OBJECT_ID" subtreeLimitation="internal:ECOMM_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECOMM_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOMM_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECO_SUD_OUEST_OBJECT_ID" subtreeLimitation="internal:ECO_SUD_OUEST_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECO_SUD_OUEST_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECO_SUD_OUEST_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOAXTER_OBJECT_ID" subtreeLimitation="internal:AXTER_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECOAXTER_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOAXTER_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_SMAC_OBJECT_ID" subtreeLimitation="internal:SMAC_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_SMAC_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_SMAC_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_SKYDOME_OBJECT_ID" subtreeLimitation="internal:SKYDOME_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_SKYDOME_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_SKYDOME_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_AXINUM_OBJECT_ID" subtreeLimitation="internal:AXIMUM_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_AXINUM_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_AXINUM_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_SPAC_OBJECT_ID" subtreeLimitation="internal:SPAC_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_SPAC_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_SPAC_OBJECT_ID" />

    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOSUISSE_OBJECT_ID" subtreeLimitation="internal:ECOSUISSE_FILIALE_NODE_ID" />
    <RoleAssignment roleID="internal:EDITOR_MEDIA_ROLE" assignTo="internal:USERS_ECOSUISSE_OBJECT_ID" subtreeLimitation="43" />
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOSUISSE_OBJECT_ID" />

    <RoleAssignment roleID="internal:AUTHENTICATED_USER_ROLE" assignTo="internal:FRONT_AUTHENTIFICATED_USER_OBJECT_ID" />

    <!-- Filières eColas roles -->
    <RoleAssignment roleID="internal:READ_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_OBJECT_ID" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_ACHAT_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Achats_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_AUDIT_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Audit_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_BUSINESS_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Business_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_COMMUNICATION_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Communication_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_COMPTA_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Comptabilite_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_CONFORMITE_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Conformite_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_ENVIRONNEMENT_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Environnement_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_FINANCE_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Finance_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_INFORMATIQUE_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Informatique_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_INNOVATION_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Innovation_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_JURIDIQUE_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Juridique_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_MATERIEL_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Materiel_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_RH_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Ressources-Humaines_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_PREVENTION_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Prevention-_-Securite_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_FORMATION_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Formation_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_RA_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Risques-_-Assurances_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_TECHNIQUE-RECHERCHE_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Technique-_-Recherche_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_OUTILS_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Les-outils_MasterPage" />
    <RoleAssignment roleID="internal:EDITOR_ROLE" assignTo="internal:USERS_ECOLAS_FILIERES_MANAGEMENT_OBJECT_ID" subtreeLimitation="remote_id_node_id:ecolas_Management_MasterPage" />

</AssignRoles>