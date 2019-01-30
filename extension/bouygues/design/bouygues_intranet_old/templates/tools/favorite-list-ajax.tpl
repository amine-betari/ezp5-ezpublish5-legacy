{def $picEntreprise = ''}
{foreach $userFavorites as $key => $userFavorite}

{if eq($userFavorite.entreprise_search , 'BYCONST')}{set $picEntreprise = 'bouyguesC'}
{elseif eq($userFavorite.entreprise_search, 'COLAS')}{set $picEntreprise = 'colas'}
{elseif eq($userFavorite.entreprise_search, 'FINA')}{set $picEntreprise = ''}
{elseif eq($userFavorite.entreprise_search, 'TF1')}{set $picEntreprise = 'tf1'}
{elseif eq($userFavorite.entreprise_search, 'BYTEL')}{set $picEntreprise = 'bouyguesT'}
{elseif eq($userFavorite.entreprise_search, 'BYSA')}{set $picEntreprise = 'bouyguesSA'}
{elseif eq($userFavorite.entreprise_search, 'BYIMMO')}{set $picEntreprise = 'bouyguesI'}
{elseif eq($userFavorite.entreprise_search, 'C2S')}{set $picEntreprise = 'c2s'}{/if}

<div class="person">
	<a href="#" class="btn-person-details" onclick="return false;"></a>
	<div class="person-general">
		<div class="first-informations">
			<span class="name">{$userFavorite.name} {$userFavorite.givenName}</span>
			{if $userFavorite.title|eq('')|not()}<span class="blue">{$userFavorite.title}</span>{/if}
		</div>
		{if $picEntreprise|eq('')|not()}<div class="person-logo">{if $picEntreprise|eq('')|not}<img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" alt="{$userFavorite.entreprise_search}"/>{/if}</div>{/if}
		{if $userFavorite.organizationalUnit|eq('')|not()}<span class="job">{$userFavorite.organizationalUnit}</span>{/if}
	</div>
	
	<div class="person-phone">
		{if $userFavorite.telephoneNumber|eq('')|not()}<span class="number clicktocalllink" onclick="eby.annuaireMakeCall('{$userFavorite.entreprise_search}', '{$userFavorite.telephoneNumber}')" style="cursor: pointer"><img src={"pictos/ebyperso_contact.gif"|ezimage} width="5px" alt="" /> {$userFavorite.telephoneNumber}</span>{/if}
		{if $userFavorite.mobile|eq('')|not()}<br /><span class="mobile clicktocalllink" onclick="eby.annuaireMakeCall('{$userFavorite.entreprise_search}', '{$userFavorite.mobile}')" style="cursor: pointer">{'widget_contact_mobile'|i18n('design/bouygues/ebyperso')} {$userFavorite.mobile}</span> <br/>{/if}
		{if $userFavorite.facsimileTelephonenumber|eq('')|not()}<span class="fax">{'widget_contact_fax'|i18n('design/bouygues/ebyperso')} {$userFavorite.facsimileTelephonenumber}</span>{/if}<br />
		{if $userFavorite.mail|eq('')|not()}<a href="mailto:{$userFavorite.mail}" class="blue mail">{$userFavorite.mail}</a> {/if}
	</div>
	
	<div class="person-address">
		{if $userFavorite.workSite|eq('')|not()}<span class="first-line">{$userFavorite.workSite}</span>{/if}
		{if $userFavorite.location|eq('')|not()}<span class="second-line">{$userFavorite.location}</span>{/if}
	</div>
	
	{if $userFavorite.secretaryName|eq('')|not()}<div class="person-assistant">
		<span class="title">{'widget_contact_assistante'|i18n('design/bouygues/ebyperso')}</span> 
		<span class="informations">{$userFavorite.secretaryName}{if and($userFavorite.secretaryName|eq('')|not(), $userFavorite.secretaryPhone|eq('')|not())}, {/if}{if $userFavorite.secretaryPhone|eq('')|not()}{$userFavorite.secretaryPhone}{/if}</span>
	</div>{/if}

</div>
{/foreach}

{literal}
<script type="text/javascript">
	$().ready(function(){
		eby.checkClickToCall();
		
		$(".columns .column .contact .widget-content .widget-overview .person .btn-person-details").unbind('click').click(function(){
			if($(this).parent().hasClass('plusfavorite'))
				$(this).parent().removeClass('plusfavorite');
			else
				$(this).parent().addClass('plusfavorite');
		});
	});
</script>
{/literal}