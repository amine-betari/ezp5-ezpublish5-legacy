
{default attribute_base=ContentObjectAttribute}
<div class="block">
<div class="date">

<div class="element">
<label>{'Year'|i18n( 'design/standard/content/datatype' )}:</label>
<input type="text" name="{$attribute.contentclass_attribute_identifier}_date_year" size="5" value="{section show=$attribute.content.is_valid}{$attribute.content.year}{/section}" />
</div>

<div class="element">
<label>{'Month'|i18n( 'design/standard/content/datatype' )}:</label>
<input type="text" name="{$attribute.contentclass_attribute_identifier}_date_month" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.month}{/section}" />
</div>

<div class="element">
<label>{'Day'|i18n( 'design/standard/content/datatype' )}:</label>
<input  type="text" name="{$attribute.contentclass_attribute_identifier}_date_day" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.day}{/section}" />
</div>

<div class="break"></div>
</div>
</div>
{/default}