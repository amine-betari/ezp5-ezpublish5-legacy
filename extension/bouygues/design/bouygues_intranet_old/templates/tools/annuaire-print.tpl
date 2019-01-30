{set-block scope=global variable=cache_ttl}0{/set-block}

<script type="text/javascript">var varErrorMakeCall='{"makecall_error"|i18n("design/bouygues/annuaire")}';</script>
<div class="annuaire" style="font-size:1em">

	<div class="boxA">
		<div class="content">
			
			<div class="bloc-result">
			
				{if is_set($results)}
						
				<div class="results">
					{def $countResult=0 $paginationStart=1}{def $divClass=0}
					{foreach $results.result as $key => $value}
						{def $picEntreprise = ''}
						{if eq($key, 'BYCONST')}{set $picEntreprise = 'bouyguesC'}
						{elseif eq($key, 'COLAS')}{set $picEntreprise = 'colas'}
						{elseif eq($key, 'FINA')}{set $picEntreprise = ''}
						{elseif eq($key, 'TF1')}{set $picEntreprise = 'tf1'}
						{elseif eq($key, 'BYTEL')}{set $picEntreprise = 'bouyguesT'}
						{elseif eq($key, 'BYSA')}{set $picEntreprise = 'bouyguesSA'}
						{elseif eq($key, 'BYIMMO')}{set $picEntreprise = 'bouyguesI'}
						{elseif eq($key, 'C2S')}{set $picEntreprise = 'c2s'}{/if}

						{foreach $value.users as $result}
						{if $paginationStart|eq(1)}{set $divClass=$divClass|inc()}<div id="divPage{$divClass}" {if $nbresult|gt(20)}style="display: none"{/if}>{/if}
						<div class="item">
							<span class="icon"></span>
							<span class="collaborator">
								{$result.name} {$result.givenName}
								
								{if eq($result.photo, '')|not()}<img src="{'/annuaire/photo/?id='|ezroot(no)}{$result.id}" align="absmiddle" alt="{$result.givenName} {$result.name}" width="95" class="collaborator_pic"/>{/if}
								{if $picEntreprise|eq('')|not()}<img src="{concat('images/logos/',$picEntreprise,'.gif')|ezdesign(no)}" align="absmiddle" class="picto"/>{/if}	
							
							</span>
							<span class="function">
								<span class="big">{$result.company}<br/>
								<span class="blue">{$result.title}</span><br/></span>
								{if eq($result.organizationalUnit, '')|not()}<span class="small">{$result.organizationalUnit}&nbsp;</span>{/if}
								{if eq($result.mail, '')|not()}<p class="mail">{$result.mail}</p>{/if}
								{if eq($result.workSite, '')|not()}<span class="adresse">{$result.workSite}<br/>
								{$result.location}{if eq($result.streetAddress, '')|not()}<br/> {$result.streetAddress}<br/> {$result.city} /  {$result.country}<br/>{/if}</span>{/if}
								<span class="assistante">
									{if eq($result.secretaryName, '')|not()}{"assistante"|i18n("design/bouygues/annuaire")} {$result.secretaryName}<br/>
									{"assistante_tel"|i18n("design/bouygues/annuaire")} <span class="clicktocalllink" onclick="eby.annuaireMakeCall('{$key}', '{$result.secretaryPhone}')" style="cursor: pointer">{$result.secretaryPhone}</span>{/if}
								</span>
								
							</span>
							<span class="phone">
								{if eq($result.telephoneNumber, '')|not()}<span class="orange clicktocalllink" onclick="eby.annuaireMakeCall('{$key}', '{$result.telephoneNumber}')" style="cursor: pointer"><strong><img src="{concat('images/pictos/phone','.png')|ezdesign(no)}" align="absmiddle" />&nbsp;&nbsp; {$result.telephoneNumber}</strong></span><br/>{/if}
								{if eq($result.mobile, '')|not()}<span class="mobile clicktocalllink" onclick="eby.annuaireMakeCall('{$key}', '{$result.mobile}')" style="cursor: pointer">Mobile : {$result.mobile}</span>{/if}
								{if eq($result.facsimileTelephonenumber, '')|not()}<span class="fax">Fax : {$result.facsimileTelephonenumber}</span>{/if}
							
							</span>
							
							{if or(eq($result.mobile, '')|not(),
										eq($result.facsimileTelephonenumber, '')|not(),
										eq($result.secretaryName, '')|not(),
										eq($result.photo, '')|not(),
										eq($result.workSite, '')|not())}<a href="#" class="more" ></a>{/if}

						</div>
						{if $paginationStart|eq(20)}{set $paginationStart=1}</div>{else}{set $paginationStart=$paginationStart|inc()}{/if}
						{set $countResult=$countResult|inc()}
						{/foreach}
					{/foreach}
				</div>
								
				{/if}
			</div>
		
		</div>
		<div class="bottom">
			<div class="left"></div>
			<div class="right"></div>
			<div class="middle"></div>
		</div>
	</div>
</div>
<div id="activx"></div>
{literal}
<script type="text/javascript">
	var currentPage = 'divPage1';
	var currentPageInt = 1;
	var nextPage = 'divPage2';
	var previousPage = null;
	
	eby.loadActiveX();
	
	$().ready(function(){
		
		$('.results .item').addClass('on');
		
		eby.checkClickToCall();
				
		{/literal}{if and(eq($results.isMax, 'true')|not(), $nbresult|lt(100))}{literal}
			$('#searchNextDiv').css('display', 'block');
		{/literal}{/if}{literal}
		
		{/literal}{if and($counterPage,$nbresult|gt(20), $counterPage|gt(0))}{literal}
	
		
		$('.divPageButtonPrevious').click(function(){
			$('a.divPageButton[rel='+previousPage+']').trigger('click');
		});
		
		$('.divPageButtonNext').click(function(){
			$('a.divPageButton[rel='+nextPage+']').trigger('click');
		});
		
		eby.annuairePagination($('a.divPageButton[rel=divPage1]'), '{/literal}{$counterPage}{literal}');
		
		{/literal}{else}$('#divPage1').css('display', 'block');{/if}{literal}
		
		$("#annuaireForm").validate({
			errorContainer: $('.mandatoryfields'),
			errorLabelContainer: $("span", $('.mandatoryfields')),
			errorElement: "span",
			wrapper: '',
			rules: {
				userNom: {
					required: function(element) {
						if($("#annuaireForm input[name=userInitiales]").val() == '')
							return true;
						else
							return false;
		      		}
				}
			}
		});
		
		
	});
	
	{/literal}{if and($counterPage,$nbresult|gt(20), $counterPage|gt(0))}{/if}{literal}
</script>
{/literal}