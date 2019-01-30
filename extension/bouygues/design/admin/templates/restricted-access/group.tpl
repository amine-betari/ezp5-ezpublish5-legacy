{def $obj_user=''
   $group_value=''
   $sections=fetch( 'content', 'section_list' )
   $selected=''
   $arrSection = hash()
}

{if $group_data}
  {set $group_value=$group_data.nom}
{/if}
<div class="content-navigation">

  {* DESIGN: Header START *}
  <div class="context-block">
    <div class="box-header">
      <div class="box-tc">
        <div class="box-ml">
          <div class="box-mr">
            <div class="box-tl">
              <div class="box-tr">
                <h1 class="context-title">Restriction d'accès</h1>

                {* DESIGN: Mainline *}<div class="header-mainline"></div>

                {* DESIGN: Header END *}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

<form action={"restricted-access/group"|ezurl} method="post" name="children">
<!-- DEB - Formulaire groupe -->
  <div class="content-view-children">
  <!-- Children START -->

    <div class="context-block">

      <div class="box-header">
        <div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
        <h2 class="context-title">Edition d'un groupe</h2>
        <div class="header-subline"></div>
        </div></div></div></div></div>
      </div>

      <div class="box-ml">
        <div class="box-mr"><div class="box-content">

          <div class="context-toolbar">
          <div class="block">

          <div class="break"></div>
    {if $group_id}
          <input type="hidden" name="Id" value="{$group_id}" />
          <table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
            <tr>
              <td>Nom du groupe</td>
              <td>&nbsp;</td>
              <td>Section</td>
              <td>&nbsp;</td>
              <td>Sélectionner les utilisateurs autorisés</td>
            </tr>

            <tr>
              <td valign="top"><input type="text" name="Group" value="{$group_value|wash}" /></td>
              <td>&nbsp;</td>
              <td><select name="SectionId">
                {foreach $sections as $section}
                  {if and(gt( $section.id, 5),$arr_section|contains( $section.id ))}
                      <option {$selected} value="{$section.id}" {if $section.id|eq($section_id)}selected{/if}>{$section.name} </option>
                    {/if}
                {/foreach}
                </select>
              </td>
              <td>&nbsp;</td>
              <td><input type="submit" value="Ajouter des utilisateurs au groupe" name="BrowseForUsers" class="button"/></td>
            </tr>
          </table>
    {else}
            <table style="width:100%;margin-left:10px;margin-bottom:10px;margin-top:10px">
            <tr>
              <td>Nom du groupe</td>
              <td>&nbsp;</td>
              <td>Section</td>
            </tr>

            <tr>
              <td valign="top"><input type="text" name="Group" value="" /></td>
              <td>&nbsp;</td>
              <td><select name="SectionId">
                {foreach $sections as $section}
                  {if and(gt( $section.id, 5),$arr_section|contains( $section.id ))}
                      <option value="{$section.id}">{$section.name} </option>
                    {/if}
                {/foreach}
                </select>
              </td>

            </tr>
          </table>

    {/if}
        </div>
          </div>


        </div></div>

      </div>

      <!-- DEB CONTROLBAR-->
      <div class="controlbar">

        <div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

        <div class="block">

          <div class="left">

          </div>

            <div class="break"></div>
        </div>

        </div></div></div></div></div></div>

      </div>
      <!-- FIN CONTROLBAR-->


    </div>

  <!-- Children END -->
  </div>
<!-- FIN - Formulaire groupe -->



{if $user_list}
<!-- DEB - Liste des utilisateurs associés au groupe -->
  <div class="content-view-children">
  <!-- Children START -->

    <div class="context-block">

      <div class="box-header">
        <div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
        <h2 class="context-title">Liste des utilisateurs ({count($user_list)})</h2>
        <div class="header-subline"></div>
        </div></div></div></div></div>
      </div>

      <div class="box-ml"><div class="box-mr"><div class="box-content">

           <div class="context-toolbar"><div class="block">
          <div class="left">
{include name=navigator uri='design:navigator/google.tpl' page_uri='/restricted-access/edit' item_count=$item_count view_parameters=$view_parameters item_limit=$item_limit}
          </div>

          <div class="break"></div>

              <div class="content-navigation-childlist">

              <div class="block">
              <div class="right">
              	Trier par nom :
              		<small><a style="selected" href={concat("restricted-access/group/", $group_id, "/(sort_by)/name_asc" )|ezurl()} > A->Z </a> / </small>
              		<small><a href={concat("restricted-access/group/", $group_id, "/(sort_by)/name_desc" )|ezurl()} >Z->A </a></small>
              	Trier par pr&eacute;nom :
              		<small><a href={concat("restricted-access/group/", $group_id, "/(sort_by)/first_name_asc" )|ezurl()} > A->Z </a> / </small>
              		<small><a href={concat("restricted-access/group/", $group_id, "/(sort_by)/first_name_desc" )|ezurl()} >Z->A </a></small>
              	Trier par email :
              		<small><a href={concat("restricted-access/group/", $group_id, "/(sort_by)/email_asc" )|ezurl()} > A->Z </a> / </small>
              		<small><a href={concat("restricted-access/group/", $group_id, "/(sort_by)/email_desc" )|ezurl()} >Z->A </a></small>
              </div>
              </div>

              <table cellspacing="0" class="list">
              <tbody>
              <tr>
                <th class="remove">&nbsp;</th>
                <th style="width:30%">Nom</th>
                <th style="width:30%">Pr&eacute;nom</a></th>
                <th style="width:30%">Email</a></th>
              </tr>

              {set $class='bglight'}
                 {foreach $user_list as $obj_id sequence array('bgdark', 'bglight') as $seq}
                   {set $obj_user = fetch( 'content', 'object', hash( 'object_id', $obj_id) )}
                  <tr class="{$seq}">
                    <td><input type="checkbox" value="{$obj_id}" name="ActionIDArray[]"/></td>
                    <td>{$obj_user.data_map.last_name.content|wash}</td>
                    <td>{$obj_user.data_map.first_name.content|wash}</td>
                    <td>{$obj_user.data_map.user_account.content.email|wash}</td>
                  </tr>
              {/foreach}


              </tbody>
              </table>
            </div>

          </div>
          </div>
           

        </div></div>

      </div>

      <!-- DEB CONTROLBAR-->
      <div class="controlbar">

        <div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

        <div class="block">
            <div class="left">
            <input type="submit" title="" value="Retirer les utilisateurs séléctionnés" name="RemoveUserButton" class="button"/>
          </div>
            <div class="break"></div>
        </div>

        </div></div></div></div></div></div>

      </div>
      <!-- FIN CONTROLBAR-->


    </div>

  <!-- Children END -->
  </div>
<!-- FIN - Liste des utilisateurs associés au groupe -->
{/if}


<!-- DEB CONTROLBAR-->
      <div class="controlbar">

        <div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

        <div class="block">
            <div class="left">
            <input type="submit"  value="Valider le formulaire" name="ValiderButton" class="button"/>
          </div>

            <div class="break"></div>
        </div>

        </div></div></div></div></div></div>

      </div>
      <!-- FIN CONTROLBAR-->
</form>
            <div class="right">
          <form action={concat("restricted-access/group/",$group_id)|ezurl()} method="get">

          </form>
          </div>
</div>



