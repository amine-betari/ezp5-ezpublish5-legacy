<div class="content-navigation">

  <div class="context-block">
    <div class="box-header">
      <div class="box-tc">
        <div class="box-ml">
          <div class="box-mr">
            <div class="box-tl">
              <div class="box-tr">
                <h1 class="context-title">Vérification des utilisateurs</h1>
                <div class="header-mainline"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- DEB - Recherche utilisateur --> 
  <div class="content-view-children">
    <form action={"whoswho/usercheck"|ezurl} method="post" id="mainform">
    <div class="context-block">
      <div class="box-header">
        <div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
        
        
        <h2 class="context-title">Rechercher les informations</h2>
        
        
        <div class="header-subline"></div>
        </div></div></div></div></div>
      </div>
      <div class="box-ml">
        <div class="box-mr"><div class="box-content">
          <div class="context-toolbar">
          <div class="block">
          <div class="break"></div>
          
          
          
          <table>
            <tr>
              <td>Nom</td>
            </tr>
            <tr>
              <td><input type="text" name="lastname" value="{$lastname}" />&nbsp;<span class="checkError">{$lastnameerror}</span></td>
            </tr>
            <tr>
              <td>Prénom</td>
            </tr>
            <tr>
              <td><input type="text" name="firstname" value="{$firstname}" />&nbsp;<span class="checkError">{$firstnameerror}</span></td>
            </tr>
            <tr>
              <td>Email</td>
            </tr>
            <tr>
              <td><input type="text" name="email" value="{$email}" />&nbsp;<span class="checkError">{$mailerror}</span></td>
            </tr>
          </table>
          
          
          
          
          <div class="break"></div>
          </div>
          </div>
        </div></div>
      </div>

      <!-- DEB CONTROLBAR-->    
      <div class="controlbar">
        <div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
        <div class="block">
          <div class="left">
          
          
            <input type="submit" title="Rechercher la personne" value="Rechercher l'utilisateur" name="SearchButton" class="button"/>
            <input type="submit" title="Vérifier l'email sur Galby" value="Vérifier l'email sur Galby" name="GalbyButton" class="button"/>
            
            
          </div>
          <div class="break"></div>
        </div>
        </div></div></div></div></div></div>
      </div>
      <!-- FIN CONTROLBAR-->      

    </div>
  </form>
  <!-- Children END -->
  </div>
  <!-- FIN - Recherche utilisateur -->
  
  <!-- DEB - Réponse Galby -->
  {if is_set($galby_r1) }
  <div class="content-view-children" id="response-galby">
    <form action={"whoswho/usercheck"|ezurl} method="post">
    <div class="context-block">
      <div class="box-header">
        <div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
        
        
        <h2 class="context-title">Retour de Galby</h2>
        
        
        <div class="header-subline"></div>
        </div></div></div></div></div>
      </div>
      <div class="box-ml">
        <div class="box-mr"><div class="box-content">
          <div class="context-toolbar">
          <div class="block">
          <div class="break"></div>
          
          {if $galby_r1 }
          
             <span class="checkSuccess">Galby indique l'adresse mail existe.</span><br />
             
            {if $galby_r2 }
              <span class="checkSuccess">Le nom et prénom pour cette adresse mail sont : {$galby_r2.first_name} {$galby_r2.last_name}.</span>   
            {else}
              <span class="checkError">Galby ne retourne aucun nom et prénom pour cette adresse mail.</span>
            {/if}
             
          {else}
             <span class="checkError">Galby indique que l'adresse mail n'existe pas dans sa base de données.</span>
          {/if}
          
          <div class="break"></div>
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
    </div>
  </div>
  {/if}
  <!-- FIN - Réponse Galby -->

  <!-- DEB - Réponse recherche utilisateurs -->
  {if is_set($rows) }
  <div class="content-view-children" id="response-utilisateur">
    <div class="context-block">
      <div class="box-header">
        <div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
        
        
        <h2 class="context-title">Résultats de la recherche</h2>
        
        
        <div class="header-subline"></div>
        </div></div></div></div></div>
      </div>
      <div class="box-ml">
        <div class="box-mr"><div class="box-content">
          <div class="context-toolbar">
          <div class="block">
          <div class="break"></div>
          
          
          {if eq($count, 0) }
            <p>Aucun utilisateur trouvé pour les critères donnés.</p>
          {else}
            {if gt($count, 50) }
              <p>Plus de 50 utilisateurs correspondent aux critères, vous devez affiner la recherche.</p>
            {else}
              <div id="response-utilisateur-main" class="content-navigation-childlist">
                <table class="list">
                  <tr>
                    <th>Login</th>
                    <th>Email</th>
                    <th>Nom du compte</th>
                    <th>Date de création</th>
                    <th>Date de dernière modification</th>
                    <th>Vérifier le compte</th>
                  </tr>
                  {foreach $rows as $row sequence array('bgdark', 'bglight') as $color}
                    <tr class="{$color}">
                      <td>{$row.login}</td>
                      <td>{$row.email}</td>
                      <td>{$row.name}</td>
                      <td>{$row.published|l10n( 'datetime' )}</td>
                      <td>{$row.modified|l10n( 'datetime' )}</td>
                      <td>
                        <a href={concat('whoswho/usercheck?lastname=', $lastname, '&firstname=', $firstname, '&email=', $email, '&id=', $row.id)|ezurl}><img title="Vérifier l'utilisateur" alt="Vérifier utilisateur" src={'/design/standard/images/edit.gif'|ezurl}></a>
                      </td>
                    </tr>
                  {/foreach}
                </table>
              </div>
            {/if}
          {/if}
          
          
          
          <div class="break"></div>
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
    </div>
  </div>
  <!-- FIN - Recherche utilisateur -->
  {/if}
  
  <!-- DEB - Check utilisateur -->
  {if is_set($data) }
  <div class="content-view-children" id="response-check">
    <div class="context-block">
      <div class="box-header">
        <div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
        
        
        <h2 class="context-title">Vérifications sur le compte utilisateur</h2>
        
        
        <div class="header-subline"></div>
        </div></div></div></div></div>
      </div>
      <div class="box-ml">
        <div class="box-mr"><div class="box-content">
          <div class="context-toolbar">
          <div class="block">
          <div class="break"></div>
          
          
          
          <div id="response-utilisateur-check">
          
            {if is_set($message) }
              <div class="checkSuccess">{$message}</div><br /><br />
            {/if}
            
            <h1>Détails</h1>
          
            <table class="list">
              <tr class="bgdark">
                <td style="width: 25%;">Login</td>
                <td>{$data.login}</td>
              </tr>
              <tr class="bglight">
                <td>Email</td>
                <td class="{if eq($data.login, $data.email) }checkSuccess{else}checkFailed{/if}">{$data.email}</td>
              </tr>
              <tr class="bgdark">
                <td>Existe sur GALBY ?</td>
                <td class="{if $datagalbyr1 }checkSuccess{else}checkFailed{/if}">{if $datagalbyr1 }oui{else}non{/if}</td>
              </tr>
              <tr class="bglight">
                <td>Synchronisé avec GALBY ?</td>
                <td>{if eq($data.no_galby_sync, 1) }non{else}oui{/if}</td>
              </tr>
              <tr class="bglight">
                <td>Existait lors de la synchronisation GALBY de la nuit ?</td>
                <td class="{if $galbystatus}checkSuccess{else}checkFailed{/if}">{if $galbystatus}oui{else}non - l'utilisateur n'est plus dans Galby depuis {$galbydaysfrom} jours et sera désactivé dans {$galbydaysleft} jours si sa situation n'évolue pas.{/if}</td>
              </tr>
              <tr class="bgdark">
                <td>Activé sur eby ?</td>
                <td class="{if eq($data.is_enabled, 1) }checkSuccess{else}checkFailed{/if}">{if eq($data.is_enabled, 1) }oui{else}non{/if}</td>
              </tr>
              {if $datagalbyr2}
              <tr class="bglight">
                <td>Nom GALBY / Nom eby</td>
                <td class="{if eq($data.last_name, $datagalbyr2.last_name) }checkSuccess{else}checkFailed{/if}">{$datagalbyr2.last_name} / {$data.last_name}</td>
              </tr>
              <tr class="bgdark">
                <td>Prénom GALBY / Prénom eby</td>
                <td class="{if eq($data.first_name, $datagalbyr2.first_name) }checkSuccess{else}checkFailed{/if}">{$datagalbyr2.first_name} / {$data.first_name}</td>
              </tr>
              {/if}
              <tr class="bglight">
                <td>Version courante du compte / Version max</td>
                <td class="{if eq($data.version, $versions.0.version) }checkSuccess{else}checkFailed{/if}">{$data.version} / {$versions.0.version}</td>
              </tr>
            </table>
          </div>
          
          <br />
          
          <h1>Actions sur le compte</h1>
          
          <table class="list">
            <tr class="bgdark">
              <td>Lors de la connexion, si l'utilisateur voit la popin "Votre email n'existe pas dans le groupe" alors que dans le tableau ci-dessus "Existe sur GALBY" est à "oui" OU "Synchronisé avec GALBY ?" est à "non" et que "Existait lors de la synchronisation GALBY de la nuit ?" est à "non"</td>
              <td style="width: 25%; text-align: center;"><input type="submit" data-url={concat('whoswho/usercheck?lastname=', $lastname, '&firstname=', $firstname, '&email=', $email, '&id=', $data.user_id, '&update=syncgalby')|ezurl} title="Mettre à jour la synchro Galby" value="Mettre à jour sa synchro Galby" name="syncgalby" class="button checkDo" /></td>
            </tr>
            <tr class="bglight">
              <td>Lors de la connexion, si l'utilisateur arrive sur la page "eby perso" mais qu'il ne voit que le début de la page et pas la fin, puis que quand il change de page, il est déconnecté, ses informations eby perso (Widgets, préférences des Widgets et préférences d'affichages dans eby) sont corrompues et sont a remettre à zéro.</td>
              <td style="text-align: center;"><input type="submit" data-url={concat('whoswho/usercheck?lastname=', $lastname, '&firstname=', $firstname, '&email=', $email, '&id=', $data.user_id, '&del=perso')|ezurl} title="Supprimer ses données ebyperso" value="Supprimer ses données ebyperso" name="ebyperso" class="button checkConfirm" /></td>
            </tr>
            <tr class="bgdark">
              <td>Si le(s) profil(s) Who's Who ne sont plus éditables ou corrompus, il faut les remettre à zéro.</td>
              <td style="text-align: center;"><input type="submit" data-url={concat('whoswho/usercheck?lastname=', $lastname, '&firstname=', $firstname, '&email=', $email, '&id=', $data.user_id, '&del=whoswho')|ezurl} title="Supprimer ses comptes WhosWho" value="Supprimer ses comptes WhosWho" name="whoswho" class="button checkConfirm" /></td>
            </tr>
          </table>
          
          <div class="break"></div>
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
    </div>
  </div>
  <!-- FIN - Check utilisateur -->
  {/if}
  
  
</div>