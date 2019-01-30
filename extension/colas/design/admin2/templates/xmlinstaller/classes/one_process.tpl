<ProccessInformation comment="Creating Colas classes" />
<CreateClass>
	<ContentClass isContainer="true" identifier="folder" remoteID="a3d405b81be900468eb153d774f4f0d2"
				  objectNamePattern="&lt;short_name|name&gt;" urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="Folder"/>
		<Groups>
			<Group id="1" name="Content"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="name" placement="1">
				<Names always-available="fre-FR" fre-FR="Name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string>Folder</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_name" placement="2">
				<Names always-available="fre-FR" fre-FR="Short name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_description" placement="3">
				<Names always-available="fre-FR" fre-FR="Short description"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="4">
				<Names always-available="fre-FR" fre-FR="Description"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>20</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="show_children" placement="5">
				<Names always-available="fre-FR" fre-FR="Show children"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="sur_titre" placement="6">
				<Names fre-FR="Sur-titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image" placement="7">
				<Names fre-FR="Image" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">1</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="article" remoteID="c15b600eb9198b1924063b5a68758232" objectNamePattern="&lt;title&gt;"
				  urlAliasPattern="&lt;title&gt;" classExistAction="">
		<Names always-available="fre-FR" fre-FR="# Article / Article 2 Colonnes"/>
		<Groups>
			<Group id="1" name="Content"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names always-available="fre-FR" fre-FR="Titre"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string>New article</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="sub_title" placement="2">
				<Names fre-FR="Sur-titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="intro" placement="3">
				<Names fre-FR="Introduction" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="4">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>1</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub_cb" placement="5">
				<Names fre-FR="Afficher la date de publication ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezauthor" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="author" placement="6">
				<Names always-available="fre-FR" fre-FR="Auteur"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="7">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="8">
				<Names fre-FR="Liste et Master Page &gt; Accroche" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="9">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 214*138px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">1</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_main" placement="10">
				<Names fre-FR="Image principale de l'article" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_legende" placement="11">
				<Names fre-FR="Légende de l'image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>150</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_copyright" placement="12">
				<Names fre-FR="Copyright de l'image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="body" placement="13">
				<Names always-available="fre-FR" fre-FR="Texte"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>20</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_encadre" placement="14">
				<Names fre-FR="Encadré &gt;Titre de l’encadré" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="contenu_encadre" placement="15">
				<Names fre-FR="Encadré &gt; Texte de l’encadré" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_colonne" placement="16">
				<Names fre-FR="2e Colonne &gt; Titre de la colonne (pour un article 2 colonnes)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="texte_colonne" placement="17">
				<Names fre-FR="2e Colonne &gt; Texte de la colonne (pour un article 2 colonnes)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_colonne" placement="18">
				<Names fre-FR="2e colonne &gt; Vignette de la colonne (pour un article 2 colonnes)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="19">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="share_yammer" placement="20">
				<Names fre-FR="Partager sur le réseau collaboratif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="send_yammer" placement="21" description="Utilisable uniquement pour les actualités">
				<Names fre-FR="Auto-publication sur Yammer" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="send_filiale" placement="22" description="Utilisable uniquement pour les actualités de Colas">
				<Names fre-FR="Partager l'actualité sur les filiales" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Toutes"/>
								<option id="aximum_folder_actualites" name="Axium"/>
								<option id="axter_folder_actualites" name="Axter"/>
								<option id="eco_centre_ouest_folder_actualites" name="Colas Centre-Ouest"/>
								<option id="eco_rhone_alpes_auvergne_folder_actualites" name="Colas Rhône-Alpes-Auvergne"/>
								<option id="eco_sud_ouest_folder_actualites" name="Colas Sud-Ouest"/>
								<option id="ecoest_folder_actualites" name="Colas Est/NP"/>
								<option id="ecoidfn_folder_actualites" name="Colas IDFN"/>
								<option id="ecomm_folder_actualites" name="Colas MM"/>
								<option id="ecorail_folder_actualites" name="Colas Rail"/>
								<option id="ecosuisse_folder_actualites" name="Colas Suisse"/>
								<option id="skydome_folder_actualites" name="Skydôme"/>
								<option id="smac_folder_actualites" name="Smac"/>
								<option id="spac_folder_actualites" name="Spac"/>
							</options>
							<is-multiselect>1</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="user_group" remoteID="25b4268cdcd01921b808a0d854b877ef"
				  objectNamePattern="&lt;name&gt;" urlAliasPattern="" classExistAction="">
		<Names always-available="fre-FR" fre-FR="User group"/>
		<Groups>
			<Group id="2" name="Users"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="name" placement="1">
				<Names always-available="fre-FR" fre-FR="Name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names always-available="fre-FR" fre-FR="Description"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="user" remoteID="40faa822edc579b02c25f6bb7beec3ad"
				  objectNamePattern="&lt;first_name&gt; &lt;last_name&gt;" urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="User"/>
		<Groups>
			<Group id="2" name="Users"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="first_name" placement="1">
				<Names always-available="fre-FR" fre-FR="First name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="last_name" placement="2">
				<Names always-available="fre-FR" fre-FR="Last name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezuser" required="true" searchable="true" informationCollector="false" translatable="false"
					   identifier="user_account" placement="3">
				<Names always-available="fre-FR" fre-FR="User account"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="eztext" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="signature" placement="4">
				<Names always-available="fre-FR" fre-FR="Signature"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image" placement="5">
				<Names always-available="fre-FR" fre-FR="Image"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">1</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="civilite" placement="6">
				<Names fre-FR="Civilité" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Choisir"/>
								<option id="1" name="Mademoiselle"/>
								<option id="2" name="Madame"/>
								<option id="3" name="Monsieur"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="langue" placement="7">
				<Names fre-FR="Langue" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Français"/>
								<option id="1" name="English"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="no_galby_sync" placement="8">
				<Names fre-FR="Ne pas synchroniser avec GALBY" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="image" remoteID="f6df12aa74e36230eb675f364fccd25a" objectNamePattern="&lt;name&gt;"
				  urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="Image"/>
		<Groups>
			<Group id="3" name="Media"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="name" placement="1">
				<Names always-available="fre-FR" fre-FR="Name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>150</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="caption" placement="2">
				<Names always-available="fre-FR" fre-FR="Caption"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image" placement="3">
				<Names always-available="fre-FR" fre-FR="Image"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezbinaryfile" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="longdesc" placement="4">
				<Names fre-FR="Description longue de l'image (pour l'accessibilité)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="link" remoteID="74ec6507063150bc813549b22534ad48" objectNamePattern="&lt;titre&gt;"
				  urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="Lien externe"/>
		<Groups>
			<Group id="1" name="Content"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names always-available="fre-FR" fre-FR="Titre du lien"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="lien" placement="2">
				<Names always-available="fre-FR" fre-FR="Lien"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="3">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="4">
				<Names always-available="fre-FR"
					   fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="5">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 214*138px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="6">
				<Names fre-FR="Afficher le lien dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="7">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="file" remoteID="637d58bfddf164627bdfd265733280a0" objectNamePattern="&lt;name&gt;"
				  urlAliasPattern="&lt;name&gt;"  classExistAction="">
		<Names always-available="fre-FR" fre-FR="# File"/>
		<Groups>
			<Group id="3" name="Media"/>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="name" placement="1">
				<Names always-available="fre-FR" fre-FR="Nom"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string>New file</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="2">
				<Names fre-FR="Surtitre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="3">
				<Names always-available="fre-FR" fre-FR="Accroche"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="4">
				<Names fre-FR="Vignette - taille souhaitée : 200x112 px" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezbinaryfile" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="file" placement="5">
				<Names always-available="fre-FR" fre-FR="Fichier"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="6">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>1</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="comment" remoteID="000c14f4f475e9f2955dedab72799941"
				  objectNamePattern="&lt;subject&gt;" urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="Comment"/>
		<Groups>
			<Group id="1" name="Content"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="subject" placement="1">
				<Names always-available="fre-FR" fre-FR="Subject"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="author" placement="2">
				<Names always-available="fre-FR" fre-FR="Author"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="eztext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="message" placement="3">
				<Names always-available="fre-FR" fre-FR="Message"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>20</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="status" placement="4">
				<Names fre-FR="Validation" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Oui"/>
								<option id="1" name="Non"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="common_ini_settings" remoteID="ffedf2e73b1ea0c3e630e42e2db9c900"
				  objectNamePattern="&lt;name&gt;" urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="Common ini settings"/>
		<Groups>
			<Group id="4" name="Setup"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="name" placement="1">
				<Names always-available="fre-FR" fre-FR="Name"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="indexpage" placement="2">
				<Names always-available="fre-FR" fre-FR="Index Page"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>SiteSettings</section>
							<parameter>IndexPage</parameter>
							<type>1</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="defaultpage" placement="3">
				<Names always-available="fre-FR" fre-FR="Default Page"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>SiteSettings</section>
							<parameter>DefaultPage</parameter>
							<type>1</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="debugoutput" placement="4">
				<Names always-available="fre-FR" fre-FR="Debug Output"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>DebugSettings</section>
							<parameter>DebugOutput</parameter>
							<type>2</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="debugbyip" placement="5">
				<Names always-available="fre-FR" fre-FR="Debug By IP"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>DebugSettings</section>
							<parameter>DebugByIP</parameter>
							<type>2</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="debugiplist" placement="6">
				<Names always-available="fre-FR" fre-FR="Debug IP List"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>DebugSettings</section>
							<parameter>DebugIPList</parameter>
							<type>6</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="debugredirection" placement="7">
				<Names always-available="fre-FR" fre-FR="Debug Redirection"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>DebugSettings</section>
							<parameter>DebugRedirection</parameter>
							<type>2</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="viewcaching" placement="8">
				<Names always-available="fre-FR" fre-FR="View Caching"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>ContentSettings</section>
							<parameter>ViewCaching</parameter>
							<type>2</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="templatecache" placement="9">
				<Names always-available="fre-FR" fre-FR="Template Cache"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>TemplateSettings</section>
							<parameter>TemplateCache</parameter>
							<type>2</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="templatecompile" placement="10">
				<Names always-available="fre-FR" fre-FR="Template Compile"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>TemplateSettings</section>
							<parameter>TemplateCompile</parameter>
							<type>2</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="imagesmall" placement="11">
				<Names always-available="fre-FR" fre-FR="Image Small Size"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>image.ini</file>
							<section>small</section>
							<parameter>Filters</parameter>
							<type>6</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="imagemedium" placement="12">
				<Names always-available="fre-FR" fre-FR="Image Medium Size"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>image.ini</file>
							<section>medium</section>
							<parameter>Filters</parameter>
							<type>6</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="imagelarge" placement="13">
				<Names always-available="fre-FR" fre-FR="Image Large Size"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>image.ini</file>
							<section>large</section>
							<parameter>Filters</parameter>
							<type>6</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="template_look" remoteID="59b43cd9feaaf0e45ac974fb4bbd3f92"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern=""  classExistAction="">
		<Names always-available="fre-FR" fre-FR="Template look"/>
		<Groups>
			<Group id="4" name="Setup"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="title" placement="1">
				<Names always-available="fre-FR" fre-FR="Title"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>SiteSettings</section>
							<parameter>SiteName</parameter>
							<type>1</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="meta_data" placement="2">
				<Names always-available="fre-FR" fre-FR="Meta data"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>SiteSettings</section>
							<parameter>MetaDataArray</parameter>
							<type>6</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image" placement="3">
				<Names always-available="fre-FR" fre-FR="Image"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezpackage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="sitestyle" placement="4">
				<Names always-available="fre-FR" fre-FR="Sitestyle"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<type>sitestyle</type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="id" placement="5">
				<Names always-available="fre-FR" fre-FR="id"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="email" placement="6">
				<Names always-available="fre-FR" fre-FR="Email"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>MailSettings</section>
							<parameter>AdminEmail</parameter>
							<type>1</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinisetting" required="false" searchable="false" informationCollector="false" translatable="false"
					   identifier="siteurl" placement="7">
				<Names always-available="fre-FR" fre-FR="Site URL"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<file>site.ini</file>
							<section>SiteSettings</section>
							<parameter>SiteURL</parameter>
							<type>1</type>
							<ini_instance/>
							<site_access_list>override;user;admin;demo</site_access_list>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_master_page" remoteID="ced7f35c67c14bc5b6ccb9b404621dd4"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# MASTER PAGE" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="description_titre" placement="2">
				<Names fre-FR="Description Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="3">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="intitule_description_filiere" placement="4">
				<Names fre-FR="Intitulé du Lien Description Filière" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_rejoindre_filiere" placement="5">
				<Names fre-FR="Rejoindre la filière" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="description_filiere" placement="6">
				<Names fre-FR="Lien Description Filière" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_titre" placement="7">
				<Names fre-FR="Actualité principale › Titre du bloc" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_principale" placement="8">
				<Names fre-FR="Actualité principale › Titre de l’information" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_date" placement="9">
				<Names fre-FR="Actualité principale › Date de l’information" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="empty"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_accroche" placement="10">
				<Names fre-FR="Actualité principale › Accroche de l’information" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_image" placement="11">
				<Names fre-FR="Actualité principale › Image de l’information (taille souhaitée : 300 * 391 px)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_intitule_url" placement="12">
				<Names fre-FR="Actualité principale &gt; intitulé du lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string>En savoir plus</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="actu_url" placement="13">
				<Names fre-FR="Actualité principale › Lien vers site externe" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="actu_contenu" placement="14">
				<Names fre-FR="Actualité principale › Lien vers un contenu eColas" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="yammer_identifiant_flux" placement="15">
				<Names fre-FR="Yammer &gt; Identifiant du flux de messages" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezemail" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="contact" placement="17">
				<Names fre-FR="Contact" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_mea_master_page" remoteID="653081ee2fa859fff8914f1d958c69b3"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# MEA master page" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="lien_eby" placement="2">
				<Names fre-FR="Lien vers un contenu eColas" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="43"/>
							<type>2</type>
							<class-constraints/>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_remontees_auto" remoteID="c30b3f56be6013c8c2a463cdeff63747"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Bloc remontées automatiques" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="colonne" placement="3">
				<Names fre-FR="Colonne" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Colonne centrale"/>
								<option id="1" name="Colonne de droite"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="remontees_select" placement="4">
				<Names fre-FR="Nombre de remontées" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="1"/>
								<option id="1" name="2"/>
								<option id="2" name="3"/>
								<option id="3" name="4"/>
								<option id="4" name="5"/>
								<option id="5" name="6"/>
								<option id="6" name="7"/>
								<option id="7" name="8"/>
								<option id="8" name="9"/>
								<option id="9" name="10"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="lien_liste_cb" placement="5">
				<Names fre-FR="Affichage du lien vers tous les éléments ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lib_ts_elem" placement="6">
				<Names fre-FR="Si oui, Intitulé du lien vers tous les éléments" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="rub_parente_breves" placement="7">
				<Names fre-FR="Rubrique parente des brèves" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="rub_children_cb" placement="8">
				<Names fre-FR="Récupérer les éléments de la sous arborescence ? " always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="tri" placement="9">
				<Names fre-FR="Trier par " always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Date de publication"/>
								<option id="1" name="Date de modification"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_agenda" remoteID="78642bb80a2540e1a6cdcc263b9d8539"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Bloc Agenda" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre du bloc Agenda" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="remontees_select" placement="2">
				<Names fre-FR="Nombre d'entrées Agenda par page" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="1" name="3"/>
								<option id="2" name="5"/>
								<option id="3" name="7"/>
								<option id="4" name="9"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_programme" placement="3">
				<Names fre-FR="Titre du programme" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_entree_agenda" remoteID="8bcf5c8c8aa65cf7d38453aa870bee96"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Entrée agenda" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_debut" placement="2">
				<Names fre-FR="Date de début" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_fin" placement="3">
				<Names fre-FR="Date de fin (facultatif)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="empty"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="4">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby" placement="5">
				<Names fre-FR="Lien vers un contenu eColas" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_ext" placement="6">
				<Names fre-FR="Lien vers site externe (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="ecolas_portrait" remoteID="1b7983b096f5a76bfe62b38965b8dedd"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Bloc Portrait" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="false" informationCollector="false"
					   translatable="true" identifier="fiches_collabor" placement="2">
				<Names fre-FR="Fiches Who's Who' du ou des collaborateurs" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="user"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="colonne" placement="3">
				<Names fre-FR="Colonne" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Colonne centrale"/>
								<option id="1" name="Colonne de droite"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="frequence" placement="4">
				<Names fre-FR="Fréquence de modification du portrait (en jours)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Aucune mise à jour automatique"/>
								<option id="1" name="1 semaine"/>
								<option id="2" name="2 semaines"/>
								<option id="3" name="1 mois"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_texte" remoteID="6202c22c4f2fb309f67e06397acbcea8"
				  objectNamePattern="&lt;titre_bloc&gt;" urlAliasPattern="&lt;titre_bloc&gt;"  classExistAction="">
		<Names fre-FR="# Bloc Texte" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_bloc" placement="1">
				<Names fre-FR="Titre du bloc" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_texte" placement="2">
				<Names fre-FR="Titre du texte" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="contenu_texte" placement="3">
				<Names fre-FR="Contenu du texte" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_texte" placement="4">
				<Names fre-FR="Image du texte (format : 106x69 px)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="colonne" placement="5">
				<Names fre-FR="Colonne" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Colonne centrale"/>
								<option id="1" name="Colonne de droite"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby" placement="6">
				<Names fre-FR="Lien vers un contenu eColas" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_ext" placement="7">
				<Names fre-FR="Lien vers site externe (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_text_link" placement="8">
				<Names fre-FR="Intitulé du lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_texte_footer" remoteID="86b7819b6d9f572d9a6d7195bc2239dc"
				  objectNamePattern="&lt;titre_bloc&gt;" urlAliasPattern="&lt;titre_bloc&gt;"  classExistAction="">
		<Names fre-FR="# Bloc Texte Footer" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_bloc" placement="1">
				<Names fre-FR="Titre du bloc" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>30</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_texte_1" placement="2">
				<Names fre-FR="Titre du texte 1" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="contenu_texte_1" placement="3">
				<Names fre-FR="Contenu du texte 1" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby_1" placement="4">
				<Names fre-FR="Lien vers un contenu eColas du texte 1" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_ext_1" placement="5">
				<Names fre-FR="Lien vers site externe du texte 1 (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_text_link_1" placement="6">
				<Names fre-FR="Intitulé du lien vers le site externe 1" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_texte_2" placement="7">
				<Names fre-FR="Titre du texte 2" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="contenu_texte_2" placement="8">
				<Names fre-FR="Contenu du texte 2" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby_2" placement="9">
				<Names fre-FR="Lien vers un contenu eColas du texte 2" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_ext_2" placement="10">
				<Names fre-FR="Lien vers site externe du texte 2 (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_text_link_2" placement="11">
				<Names fre-FR="Intitulé du lien vers le site externe 2" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_texte_3" placement="12">
				<Names fre-FR="Titre du texte 3" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby_3" placement="13">
				<Names fre-FR="Lien vers un contenu eColas du texte 3" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="contenu_texte_3" placement="14">
				<Names fre-FR="Contenu du texte 3" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_ext_3" placement="15">
				<Names fre-FR="Lien vers site externe du texte 3 (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url_text_link_3" placement="16">
				<Names fre-FR="Intitulé du lien vers le site externe 3" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_annexe" remoteID="907ccbd4fe174ada87d1ecac7b2fe39a"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Bloc Annexe" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="texte" placement="2">
				<Names fre-FR="Texte" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_diapo" remoteID="fd31e91074aa615123ce1c21d4f37227"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Diaporama" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="sous_titre" placement="2">
				<Names fre-FR="Sur-titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="3">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="4">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>1</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub_cb" placement="5">
				<Names fre-FR="Afficher la date de publication?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezauthor" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="author" placement="6">
				<Names fre-FR="Auteur" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="7">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="8">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="9">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 171x110px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="copyright" placement="10">
				<Names fre-FR="Copyright par défaut pour le diaporama" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="carroussel_vignette_cb" placement="11">
				<Names fre-FR="Afficher le carrousel de vignettes ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="transition" placement="12">
				<Names fre-FR="Temps de transition entre chaque photo du diaporama (en secondes) " always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="3"/>
								<option id="1" name="1"/>
								<option id="2" name="2"/>
								<option id="3" name="4"/>
								<option id="4" name="5"/>
								<option id="5" name="6"/>
								<option id="6" name="7"/>
								<option id="7" name="8"/>
								<option id="8" name="9"/>
								<option id="9" name="10"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="13">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="share_yammer" placement="14">
				<Names fre-FR="Partager sur le réseau collaboratif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_diapo_image" remoteID="505b65eb7afaf9807b97f8531107787c"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Diaporama › Image" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="image" placement="2">
				<Names fre-FR="Image (format : 670*385 px)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="vignette" placement="3">
				<Names fre-FR="Vignette - (la vignette est générée automatiquement sur eColas au format 110x63 px)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="legende" placement="4">
				<Names fre-FR="Légende" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="copyright" placement="5">
				<Names fre-FR="Copyright" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_galerie_vid" remoteID="a15463bdba3291b303c0e200db41617d"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Galerie Vidéo" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="sous_titre" placement="2">
				<Names fre-FR="Sur-titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="3">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="4">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>1</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub_cb" placement="5">
				<Names fre-FR="Afficher la date de publication ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezauthor" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="auteur" placement="6">
				<Names fre-FR="Auteur" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="7">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="8">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="9">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 171x110px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="10">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_se_cb" placement="11">
				<Names fre-FR="Afficher les sous-éléments dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="share_yammer" placement="12">
				<Names fre-FR="Partager sur le réseau collaboratif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_video" remoteID="3eea5d9b6fcfa428a786d9b2db07303c"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Vidéo" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="sub_title" placement="2">
				<Names fre-FR="Sur-titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="youtubechooser" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="video_youtube" placement="3">
				<Names fre-FR="Vidéo YouTube" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute unsupported="true">
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="video_youtube_url" placement="4">
				<Names fre-FR="Vidéo YouTube (URL)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="watchooser" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="video_wat" placement="5">
				<Names fre-FR="Vidéo WAT" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute unsupported="true">
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="video_vignette" placement="6">
				<Names fre-FR="Vignette - taille souhaitée : 220x124 px" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="7">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub_cb" placement="8">
				<Names fre-FR="Afficher la date de publication ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="9">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>1</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezauthor" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="auteur" placement="10">
				<Names fre-FR="Auteur" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="liste_surtitre" placement="11">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="12">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="13">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="14">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 200 * 112px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="do_not_display_in_video_homepage" placement="15">
				<Names fre-FR="Ne pas afficher dans la page Vidéothèque ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="share_yammer" placement="16">
				<Names fre-FR="Partager sur le réseau collaboratif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_dossier" remoteID="0a342b4318415838b4bad44d1bc0f44f"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Dossier / Dossier Ancre" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="chapeau" placement="2">
				<Names fre-FR="Introduction" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="tpl_select" placement="3">
				<Names fre-FR="Type de gabarit ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Dossier"/>
								<option id="1" name="Dossier ancre"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="author_name" placement="4">
				<Names fre-FR="Auteur (nom)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezemail" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="author_mail" placement="5">
				<Names fre-FR="Auteur (email)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_sommaire_ancre" placement="6">
				<Names fre-FR="Titre du sommaire à ancre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="7">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="8">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="9">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 171*110px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="10">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_se_cb" placement="11">
				<Names fre-FR="Afficher les sous-éléments dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="12">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="share_yammer" placement="13">
				<Names fre-FR="Partager sur le réseau collaboratif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_mini_site" remoteID="ae19acc1fefac9182b0b66531b0a8fc0"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Mini site" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="2">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste) " always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_header" placement="3">
				<Names fre-FR="Bandeau - taille souhaitée : 1040*235px" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="4">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="5">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 171*110 px (affichée dans une liste ou sur une Master Page"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="6">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_se_cb" placement="7">
				<Names fre-FR="Afficher les sous-éléments dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="8">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="share_yammer" placement="9">
				<Names fre-FR="Partager sur le réseau collaboratif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_liste" remoteID="5fc5800f90a01b646c9c5c91232c64f3"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Liste / Liste sous‐rubrique" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image" placement="3">
				<Names fre-FR="Image - taille souhaitée :  345 px de large (hauteur conseillée : 370 px)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="legende" placement="4">
				<Names fre-FR="Légende de l'image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>150</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="copyright" placement="5">
				<Names fre-FR="Copyright de l'image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="tpl_select" placement="6">
				<Names fre-FR="Type de gabarit ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Une colonne"/>
								<option id="1" name="Deux colonnes"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="7">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="8">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="9">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 200*112px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="lib_ts_elem" placement="10">
				<Names fre-FR="Liste thématique &gt; Intitulé du lien « Tous les éléments » (affiché dans une liste thématique pour accéder à la liste complète)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string>Tous les articles</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="sur_titre_cb" placement="11">
				<Names fre-FR="Afficher les surtitres des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="accroche_cb" placement="12">
				<Names fre-FR="Afficher les accroches des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_select" placement="13">
				<Names fre-FR="Afficher la date des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Non"/>
								<option id="1" name="Date de publication"/>
								<option id="2" name="Date de mise à jour"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="pagination" placement="14">
				<Names fre-FR="Créer une pagination ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="elem_page_select" placement="15">
				<Names fre-FR="Si oui, nombre d’éléments affichés par page ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="50"/>
								<option id="1" name="30"/>
								<option id="2" name="20"/>
								<option id="3" name="15"/>
								<option id="4" name="10"/>
								<option id="5" name="5"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="16">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_se_cb" placement="17">
				<Names fre-FR="Afficher les sous-éléments dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="18">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_liste_thema" remoteID="77fe3096a5723fdd97ee9b9567f4c8f7"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Liste thématique" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image" placement="3">
				<Names fre-FR="Image - taille souhaitée :  345 px de large (hauteur conseillée : 370 px)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="legende" placement="4">
				<Names fre-FR="Légende de l'image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>150</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="copyright" placement="5">
				<Names fre-FR="Copyright de l'image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="6">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="7">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="8">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 200*112px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="lib_ts_elem" placement="9">
				<Names fre-FR="Liste thématique &gt; Intitulé du lien « Tous les éléments » (affiché dans une liste thématique pour accéder à la liste complète)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string>Tous les articles</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="sommaire_cb" placement="10">
				<Names fre-FR="Afficher le sommaire ancre ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_sommaire" placement="11">
				<Names fre-FR="Titre du sommaire à ancre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="liste_n_2_cb" placement="12">
				<Names fre-FR="Afficher les sous thèmes des listes thématiques ? (liste jusqu’à N-2)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="sur_titre_cb" placement="13">
				<Names fre-FR="Afficher les surtitres des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="accroche_cb" placement="14">
				<Names fre-FR="Afficher les accroches des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="vignette_select" placement="15">
				<Names fre-FR="Afficher les vignettes des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Moyen"/>
								<option id="1" name="Grand"/>
								<option id="2" name="Petit"/>
								<option id="3" name="Non"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_select" placement="16">
				<Names fre-FR="Afficher une date pour les éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Non"/>
								<option id="1" name="Date de publication"/>
								<option id="2" name="Date de mise à jour"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_thema_cb" placement="17">
				<Names fre-FR="Afficher les liens « Tous les éléments » pour chaque thème ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="element_select" placement="18">
				<Names fre-FR="Si oui, nombre d’éléments affichés par thèmes ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="3"/>
								<option id="1" name="1"/>
								<option id="2" name="2"/>
								<option id="3" name="4"/>
								<option id="4" name="5"/>
								<option id="5" name="6"/>
								<option id="6" name="7"/>
								<option id="7" name="8"/>
								<option id="8" name="9"/>
								<option id="9" name="10"/>
								<option id="10" name="11"/>
								<option id="11" name="12"/>
								<option id="12" name="13"/>
								<option id="13" name="14"/>
								<option id="14" name="15"/>
								<option id="15" name="16"/>
								<option id="16" name="17"/>
								<option id="17" name="18"/>
								<option id="18" name="19"/>
								<option id="19" name="20"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="ordre_select" placement="19">
				<Names fre-FR="Ordre d’affichage des éléments listés ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Date de publication / Décroissante"/>
								<option id="1" name="Date de publication / Croissante"/>
								<option id="2" name="Date de mise à jour / Croissante"/>
								<option id="3" name="Date de mise à jour / Décroissante"/>
								<option id="4" name="Date de création / Croissante"/>
								<option id="5" name="Date de création / Décroissante"/>
								<option id="6" name="Ordre alphabétique / Croissant"/>
								<option id="7" name="Ordre alphabétique / Décroissant"/>
								<option id="8" name="Ordre backoffice / Croissant"/>
								<option id="9" name="Ordre backoffice / Décroissant"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="20">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_se_cb" placement="21">
				<Names fre-FR="Afficher les sous-éléments dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="22">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_prestataire" remoteID="71ff391115e4b400fcdbcbdaf209ca68"
				  objectNamePattern="&lt;nom&gt;" urlAliasPattern="&lt;nom&gt;"  classExistAction="">
		<Names fre-FR="# Prestataire" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="nom" placement="1">
				<Names fre-FR="Nom" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="domaine" placement="2">
				<Names fre-FR="Domaine d'activité / Sur-titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>150</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="eztext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="adresse" placement="3">
				<Names fre-FR="Adresse" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="contact" placement="4">
				<Names fre-FR="Nom du contact" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="tel" placement="5">
				<Names fre-FR="Téléphone fixe" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>50</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="mobile" placement="6">
				<Names fre-FR="Mobile" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>50</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezemail" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="email" placement="7">
				<Names fre-FR="Adresse email" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="site" placement="8">
				<Names fre-FR="Site internet" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="9">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste) " always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="10">
				<Names fre-FR="Liste &gt; Accroche (affichée dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="11">
				<Names fre-FR="Liste &gt; Vignette - taille souhaitée : 214*138px (affichée dans une liste)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="12">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_prestataire_projet" remoteID="48580f38d93bdbd320919341e84a1619"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Prestataire &gt; Projet" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre du projet" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="prestation" placement="2">
				<Names fre-FR="Description de la prestation" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_element_liste" remoteID="5370c7545787432a170f9ddd774d40fc"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Elément liste" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="2">
				<Names fre-FR="Surtitre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="3">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>1</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="4">
				<Names fre-FR="Accroche" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="5">
				<Names fre-FR="Vignette - taille souhaitée : 171*110px" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby" placement="6">
				<Names fre-FR="Lien vers un contenu eColas" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_ext" placement="7">
				<Names fre-FR="Lien vers site externe (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_categorie" remoteID="2952903c89ab9abfa6fd21e76c12ed93"
				  objectNamePattern="&lt;nom&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Catégorie" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="nom" placement="1">
				<Names fre-FR="Nom" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="menu_1se_select" placement="2">
				<Names fre-FR="Afficher la page du 1er sous-élément de la catégorie ou Ouvrir la sous-arborescence ? "
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Afficher la page du 1er sous-élément"/>
								<option id="1" name="Ouvrir la sous-arborescence uniquement"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="ecolas_rss_item" remoteID="88734c7c588dc58a34265fe00a008dc1"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# RSS item" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="eztext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="link" placement="3">
				<Names fre-FR="Url" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="rss_source" placement="4">
				<Names fre-FR="Source" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="5">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_master_container" remoteID="c2e27725b3f6b79b77b3545bd4e06d8c"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# Master Page &gt; Conteneur" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_home_page" remoteID="c518e3a83f77bb42411882ea56d3e6a3"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Home page" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="challenger_description" placement="2">
				<Names fre-FR="Bloc Challenger &gt; description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>200</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="communique_titre" placement="3">
				<Names fre-FR="Bloc communiqué de Presse &gt; Titre du communiqué" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>200</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezbinaryfile" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="communique_titre_fichier" placement="4">
				<Names fre-FR="Bloc communiqué de Presse &gt; Fichier" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">25</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="communique_date" placement="5">
				<Names fre-FR="Bloc Communiqué de presse &gt; Date" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="communique_url" placement="6">
				<Names fre-FR="Bloc Communiqué de presse &gt; Voir tous les communiqués" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="true" searchable="true" informationCollector="false"
					   translatable="true" identifier="bibliotheque_liens" placement="7">
				<Names fre-FR="Bloc Bibliothèque &gt; liens" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<type>2</type>
							<class-constraints/>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_annuaire_pda_imode" placement="8">
				<Names fre-FR="Bloc Je m'abonne &gt; Lien annuaire PDA et i-mode" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre_lien_annuaire_pda_imode" placement="9">
				<Names fre-FR="Bloc Je m'abonne &gt; Titre lien annuaire PDA et i-mode" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>15</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="evenement_titre" placement="10">
				<Names fre-FR="Bloc Evénement &gt; Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>45</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="evenement_image" placement="11">
				<Names fre-FR="Bloc Evénement &gt; Image (345*120)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">25</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="evenement_lien_externe" placement="12">
				<Names fre-FR="Bloc Evénement &gt; Lien externe" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="evenement_lien_interne" placement="13">
				<Names fre-FR="Bloc Evénement &gt; Lien interne" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="evenement_balise_alt" placement="14">
				<Names fre-FR="Bloc Evénement &gt; Balise alt" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="evenement_balise_title" placement="15">
				<Names fre-FR="Bloc Evénement &gt; Balise title" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="evenement_type_de_lien" placement="16">
				<Names fre-FR="Bloc Evénement &gt; Type de lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="Même fenêtre"/>
								<option id="1" name="Nouvelle fenêtre"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="sondage_display" placement="17">
				<Names fre-FR="Sondage : afficher le dernier sondage actif" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="challenger_last" placement="18">
				<Names fre-FR="Challenger - Dernière édition" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="challenger_derniere_edition_titre" placement="19">
				<Names fre-FR="Challenger - Dernière édition - Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="challenger_all" placement="20">
				<Names fre-FR="Challenger - Archives" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="challenger_date" placement="21">
				<Names fre-FR="Challenger - Date" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="empty"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="media_titre" placement="22">
				<Names fre-FR="Titre du bloc média" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>45</max-length>
							<default-string>Bloc média</default-string>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="small_block_description" placement="23">
				<Names fre-FR="Bypedia &gt; Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="small_block_lien" placement="24">
				<Names fre-FR="Bypedia &gt; Lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="small_block_image" placement="25">
				<Names fre-FR="Bypedia &gt; Image (100*40)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="element_group_select" placement="26">
				<Names fre-FR="Actualité(s) Groupe &gt; Nombre à afficher" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="0"/>
								<option id="1" name="1"/>
								<option id="2" name="2"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezselection" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="element_filiere_select" placement="27">
				<Names fre-FR="Actualité(s) filières &gt; Nombre à afficher" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<options>
								<option id="0" name="1"/>
								<option id="1" name="2"/>
								<option id="2" name="3"/>
								<option id="3" name="4"/>
								<option id="4" name="5"/>
								<option id="5" name="6"/>
								<option id="6" name="7"/>
								<option id="7" name="8"/>
								<option id="8" name="9"/>
							</options>
							<is-multiselect>0</is-multiselect>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="nomination_date" placement="28">
				<Names fre-FR="Nominations : Date de dernière publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="empty"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="nomination_lien_interne" placement="29">
				<Names fre-FR="Nominations : Lien interne" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="nomination_description" placement="30">
				<Names fre-FR="Nominations : Descriptions" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>75</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="ecolas_element_mea" remoteID="9fa2b2a2cce815c28af450c56d6c86f0"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Elément MEA" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="2">
				<Names fre-FR="surtitre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdate" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_pub" placement="3">
				<Names fre-FR="Date de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="empty"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="4">
				<Names fre-FR="Accroche" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="5">
				<Names fre-FR="Vignette (format : 106 x 69px)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby" placement="6">
				<Names fre-FR="Lien vers un contenu eColas" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_ext" placement="7">
				<Names fre-FR="Lien vers site externe (dans le cas où il n’y a pas de lien vers un contenu eColas)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_page_sessions" remoteID="807d9996bc3bbeca7c4931cd1a5af951"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Page Sessions" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="intro" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_main" placement="3">
				<Names fre-FR="Image principale" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="4">
				<Names fre-FR="Liste &gt; Surtitre (affiché dans une liste) " always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="accroche_liste" placement="5">
				<Names fre-FR="Liste et Master Page &gt; Accroche (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="6">
				<Names fre-FR="Liste et Master Page &gt; Vignette - taille souhaitée : 214*138px (affichée dans une liste ou sur une Master Page)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="menu_cb" placement="7">
				<Names fre-FR="Afficher dans le menu filière ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_session" remoteID="0e5c0fc8c70871bfa0a827e8e71b7d4a"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Session" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>100</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="image_vignette" placement="3">
				<Names fre-FR="Vignette" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_session_element" remoteID="1b803118679d0043f449ea052ac1c446"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# Elément de session" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>300</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="collaborator" placement="2">
				<Names fre-FR="Collaborateurs" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezemail" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="yammer_email" placement="3">
				<Names fre-FR="E-mail de l'utilisateur eColas Network (Yammer)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="yammer_profile_url" placement="4">
				<Names fre-FR="Url du profil utilisateur eColas Network (Yammer)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_static" remoteID="be201b4a0b293475a113eab7233a09ba"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# Page Statique" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="content" placement="2">
				<Names fre-FR="Texte" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>10</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="ecolas_home_media" remoteID="6c5c41e2db6a6b854bfeb3abf5ec5a16"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Home page : média" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre de la mise en avant" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>40</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="vignette_text_charte_color" placement="2">
				<Names fre-FR="Nom de la filière dans la couleur de sa charte ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="true"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelation" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="lien_eby" placement="3">
				<Names fre-FR="Lien vers un contenu eby" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<selection-type id="0"/>
							<fuzzy-match id="0"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="lien_ext" placement="4">
				<Names fre-FR="Lien vers un contenu externe" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="true" searchable="false" informationCollector="false" translatable="true"
					   identifier="vignette" placement="5">
				<Names fre-FR="Vignette de l'élément média (208x107)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">0</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="false" informationCollector="false" translatable="true"
					   identifier="type" placement="6">
				<Names fre-FR="Type de média (Vidéo OU Diaporama)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>10</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="false" identifier="ecolas_iframe" remoteID="1d89dba8c58ef75863eaf0c08ffb4480"
				  objectNamePattern="Iframe / &lt;url&gt;" urlAliasPattern=""  classExistAction="">
		<Names fre-FR="# Iframe" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="url" placement="1">
				<Names fre-FR="URL absolue vers l'élément à afficher" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>0</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinteger" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="hauteur" placement="2">
				<Names fre-FR="Hauteur de l'iframe en pixel" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value>500</default-value>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_home_page" remoteID="408b812236718ab944de890a53f83976"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# eColas Home page" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="baseline" placement="2">
				<Names fre-FR="Baseline" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="bylink_alternative_block" placement="8">
				<Names fre-FR="eColas - bloc de remplacement" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="group_images_title" placement="9">
				<Names fre-FR="Le groupe en images - Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="group_images_videos" placement="10">
				<Names fre-FR="Le groupe en images - sélection (la vidéo principale est celle en 2ème position - Nombre de vidéos conseillées pour un rendu optimal : 13)"
					   always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="43"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_video"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="videotheque_link" placement="11">
				<Names fre-FR="Vidéothèque - lien d accès" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_videotheque"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezurl" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="phototheque_link" placement="12">
				<Names fre-FR="Photothèque - lien d accès" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description_colas" placement="13">
				<Names fre-FR="Description - Texte libre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>
				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="press_releases_title" placement="13">
				<Names fre-FR="Communiqués de presse - titre du bloc" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="press_releases_contents" placement="14">
				<Names fre-FR="Communiqués de presse - sélection de contenus" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="file"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="press_releases_link_title" placement="15">
				<Names fre-FR="Communiqués de presse - titre du lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="press_releases_link" placement="16">
				<Names fre-FR="Communiqués de presse - lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_liste"/>
								<class-constraint class-identifier="ecolas_liste_thema"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="library_title" placement="17">
				<Names fre-FR="Bibiliothèque - titre du bloc" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="library_contents" placement="18">
				<Names fre-FR="Bibiliothèque - sélection de contenus" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="file"/>
								<class-constraint class-identifier="ecolas_liste"/>
								<class-constraint class-identifier="ecolas_liste_thema"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="library_link_title" placement="19">
				<Names fre-FR="Bibiliothèque - titre du lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="library_link" placement="20">
				<Names fre-FR="Bibiliothèque - lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_liste"/>
								<class-constraint class-identifier="ecolas_liste_thema"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="group_organization_title" placement="21">
				<Names fre-FR="Organisation du groupe - titre du bloc" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="group_organization_contents" placement="22">
				<Names fre-FR="Organisation du groupe - sélection de contenus" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="article"/>
								<class-constraint class-identifier="ecolas_liste"/>
								<class-constraint class-identifier="ecolas_liste_thema"/>
								<class-constraint class-identifier="ecolas_video"/>
								<class-constraint class-identifier="file"/>
								<class-constraint class-identifier="link"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="group_organization_link_title" placement="23">
				<Names fre-FR="Organisation du groupe - titre du lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="group_organization_link" placement="24">
				<Names fre-FR="Organisation du groupe - lien" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_liste"/>
								<class-constraint class-identifier="ecolas_liste_thema"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="new_this_month" placement="25">
				<Names fre-FR="A découvrir ce mois-ci - sélection (6 au maximum)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="article"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="quick_access" placement="26">
				<Names fre-FR="Accès rapide - sélection" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_liste"/>
								<class-constraint class-identifier="ecolass_liste_thema"/>
								<class-constraint class-identifier="ecolas_mini_site"/>
								<class-constraint class-identifier="folder"/>
								<class-constraint class-identifier="file"/>
								<class-constraint class-identifier="article"/>
								<class-constraint class-identifier="link"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="footer_links" placement="27">
				<Names fre-FR="Liens obligatoires sélection" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_static"/>
								<class-constraint class-identifier="link"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="subsidiary_links" placement="28">
				<Names fre-FR="Grandes marques du Groupe" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="link"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="group_sites_link" placement="29">
				<Names fre-FR="Lien Tous les sites Internet du Groupe" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_liste"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_visionneuse_home" remoteID="45249411d01e0628fbb15881c1498543"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# Visionneuse Accueil" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="true" searchable="true" informationCollector="false"
					   translatable="true" identifier="visio_slides" placement="2">
				<Names fre-FR="Contenu associé (Actualité, Article, Diaporama, Vidéo)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_element_liste"/>
								<class-constraint class-identifier="article"/>
								<class-constraint class-identifier="ecolas_diapo"/>
								<class-constraint class-identifier="ecolas_video"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="image" placement="3">
				<Names fre-FR="Surcharger la photo (526x345 px)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezinteger" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="duree" placement="4">
				<Names fre-FR="Durée d'affichage en focus (seconde)" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value>3</default-value>
							<min-value>2</min-value>
							<max-value>30</max-value>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_publish" placement="5">
				<Names fre-FR="Début de publication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="current-date"/>
							<use-seconds>0</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezdatetime" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="date_unpublish" placement="6">
				<Names fre-FR="Date de dépublication" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value type="adjustment">
								<adjustment>
									<year value=""/>
									<month value=""/>
									<day value="7"/>
									<hour value=""/>
									<minute value=""/>
									<second value=""/>
								</adjustment>
							</default-value>
							<use-seconds>0</use-seconds>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_videotheque" remoteID="7f2fc094d22d2b1a8e6a2579803bc3d2"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# Vidéothèque" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_application_configuration" remoteID="bb319d5abe246b38c3fb20598fefee3e"
				  objectNamePattern="&lt;short_title&gt;" urlAliasPattern="&lt;short_title&gt;"  classExistAction="">
		<Names fre-FR="# Application configuration" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="short_title" placement="1">
				<Names fre-FR="Titre court" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="long_title" placement="2">
				<Names fre-FR="Titre long" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="available_application_title" placement="3">
				<Names fre-FR="Applications disponibles - Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="my_applications_title" placement="4">
				<Names fre-FR="Mes applications - Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_application" remoteID="dc1cdfb64a6f6b1cddef6cb21a7bfc39"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# Application" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="url" placement="2">
				<Names fre-FR="Url de l'application" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezboolean" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="default" placement="3">
				<Names fre-FR="Application par défaut ?" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-value is-set="false"/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezimage" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="picto" placement="4">
				<Names fre-FR="Picto associé" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-size unit-size="mega">2</max-size>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_faq_question_reponse" remoteID="3b47202f1528359d2b1f9d375620cb4c"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# FAQ &gt; Question/Réponse" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre/Question" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="reponse" placement="2">
				<Names fre-FR="Réponse" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezobjectrelationlist" required="false" searchable="true" informationCollector="false"
					   translatable="true" identifier="categories" placement="3">
				<Names fre-FR="Catégories" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<default-placement node-id="2"/>
							<type>2</type>
							<class-constraints>
								<class-constraint class-identifier="ecolas_faq_categorie"/>
							</class-constraints>
							<selection-type>0</selection-type>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_faq_rubrique" remoteID="8e6375351f5f750c393dce1e5736372c"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# FAQ &gt; Rubrique" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="intro" placement="2">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_faq_categorie" remoteID="7895158b6555332b40bc1fbf83b1285d"
				  objectNamePattern="&lt;titre&gt;" urlAliasPattern="&lt;titre&gt;"  classExistAction="">
		<Names fre-FR="# FAQ &gt; Catégorie" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="titre" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_yammer_utility" remoteID="1518e40d3fa27ade0dfe3610ddb899da"
				  objectNamePattern="&lt;title&gt;" urlAliasPattern="&lt;title&gt;"  classExistAction="">
		<Names fre-FR="# Utilitaire Yammer" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
					   identifier="title" placement="1">
				<Names fre-FR="Titre" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="access_error" placement="2">
				<Names fre-FR="Texte de la popup d'erreur d'autorisation au réseau" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="access_confirm" placement="3">
				<Names fre-FR="Texte de la popup attente de non inscription au réseau" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezauthor" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="authorized_domain" placement="4">
				<Names fre-FR="Liste des domaines autorisés" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters/>
					</attribute>


				</DatatypeParameters>
			</Attribute>
			<Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="description" placement="5">
				<Names fre-FR="Description" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<text-column-count>5</text-column-count>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>

	<ContentClass isContainer="true" identifier="ecolas_yammer_authorized_domain" remoteID="a3ad117819e738cdecf167503d280956"
				  objectNamePattern="&lt;authorized_domain_name&gt;" urlAliasPattern="&lt;authorized_domain_name&gt;"
				   classExistAction="">
		<Names fre-FR="# Domaine Yammer" always-available="fre-FR"/>
		<Groups>
			<Group id="6" name="eColas"/>
		</Groups>
		<Attributes>
			<Attribute datatype="ezstring" required="false" searchable="true" informationCollector="false" translatable="true"
					   identifier="authorized_domain_name" placement="1">
				<Names fre-FR="Domaine autorisé" always-available="fre-FR"/>
				<DatatypeParameters>
					<attribute>
						<datatype-parameters>
							<max-length>255</max-length>
							<default-string/>
						</datatype-parameters>
					</attribute>


				</DatatypeParameters>
			</Attribute>
		</Attributes>
	</ContentClass>
</CreateClass>