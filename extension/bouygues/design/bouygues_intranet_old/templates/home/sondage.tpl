{set-block scope=global variable=cache_ttl}0{/set-block}
{def $sondage = fetch('sondage', 'fetchlast')}
{def $hasResponded = fetch('sondage', 'fetchresponse', hash('sondage_id', $sondage.id))}
{$site.http_equiv.Content-language}
{if $current_language|eq('fre-FR')}
	{def $question = $sondage.question}
	{def $reponse1 = $sondage.reponse1}
	{def $reponse2 = $sondage.reponse2}
	{def $reponse3 = $sondage.reponse3} 
{elseif $current_language|eq('eng-US')}
	{def $question = $sondage.question_eng}
	{def $reponse1 = $sondage.reponse1_eng}
	{def $reponse2 = $sondage.reponse2_eng}
	{def $reponse3 = $sondage.reponse3_eng}           
{/if}

{if or($hasResponded|gt(0),$userHasResponded|eq('true'))}
<strong class="title">{"quizz"|i18n("design/bouygues/home")}</strong>
<p class="color-blue">{$question}</p>
<div class="sondage"><span class="sondage-reponse">1. {$reponse1}</span><span class="sondage-rate">{$sondage.reponse1_rate}%</span></div>
<div class="sondage"><span class="sondage-reponse">2. {$reponse2}</span><span class="sondage-rate">{$sondage.reponse2_rate}%</span></div>
{if $reponse3|eq('')|not()}<div class="sondage"><span class="sondage-reponse">3. {$reponse3}</span><span class="sondage-rate">{$sondage.reponse3_rate}%</span></div>{/if}
<div class="sondage-total"><span class="sondage-reponse">{"quizz_nbvote"|i18n("design/bouygues/home")} {$sondage.nbTotal}</span></div>
{else}
<strong class="title">{"quizz"|i18n("design/bouygues/home")}</strong>
<p class="color-blue">{$question}</p>
<form id="sondage-form" action="/sondage/reponse" method="post">
<fieldset>
<legend>{"quizz"|i18n("design/bouygues/home")} - {$question}</legend>
<input type="hidden" name="id" value="{$sondage.id}"/>
<input type="hidden" name="current_language" value="{$current_language}"/>
<input type="radio" name="reponse" id="reponse1" value="1" class="required" title="{'quizz_error_content'|i18n('design/bouygues/home')}"/> <label for="reponse1">{$reponse1}</label><br />
<input type="radio" name="reponse" id="reponse2" value="2" class="required"/> <label for="reponse2">{$reponse2}</label><br />
{if $reponse3|eq('')|not()}<input type="radio" name="reponse" id="reponse3" value="3"/> <label for="reponse3">{$reponse3}</label>{/if}
<span id="sondageError"><span></span></span>
<p>
{include uri="design:blocs/btn.tpl" label="quizz_validate"|i18n("design/bouygues/home") url='/sondage' submit='sondage-form'}
</p>
</fieldset>
</form>
{literal}
<script type="text/javascript">
	$().ready(function(){
		var options = {
			url :currentLang+'/layout/set/ajax2/sondage/reponse',
			success : function(msg) {
				$("#sondage-ajax-content").fadeOut( function() {
					$("#sondage-ajax-content").html(msg).fadeIn();
				});
			}
		}
		$("#sondage-form").validate( {
			errorContainer: $('#sondageError'),
			errorLabelContainer: $("span", $('#sondageError')),
			submitHandler : function(error) {
				$("#sondage-form").ajaxSubmit(options);
			}
		});
	});
</script>
{/literal}
{/if}

{undef $question $reponse1 $reponse2 $reponse3 $sondage $current_language}