<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<colgroup>
		<col width="1">
		<col width="1">
		<col>
		<col width="160">
		<col width="1">
		<col width="1">
		<col>
		<col width="1">
		<col width="1">
	</colgroup>
	<thead>
		<tr>
			<td align="center"><a href="javascript:void(0);" class="toprightDir icon_sprite ico_ok{if $ave15}_green{/if}" style="cursor:help;display:inline-block" title="{#active_i#}"></a></td>
			<td>ID</td>
			<td>{#title#}</td>
			<td>{#type#}</td>
			<td>{#sets#}</td>
			<td align="center"><div class="topDir" style="cursor:pointer" title="{#required#}">!</div></td>
			<td>{#defaultval#}</td>
			<td></td>
			<td></td>
		</tr>
	</thead>
	<tbody>
		{foreach from=$fields item=field key=field_id}
		<tr>
			<td align="center">
				<input type="checkbox" class="toprightDir" name="fields[{$field.id}][active]" value="1" {if $field.active}checked="checked"{/if} title="{#active_i#}" />
			</td>
			<td>
				<div class="nowrap">
					<a class="toprightDir icon_sprite ico_info inline" title="{#fld_i#}"></a>
					{if $field.main}
					<a href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:fld:{$field.title}]','');"><strong>[tag:fld:{$field.title}]</strong></a>
					{else}
					<a href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:fld:{$field.id}]','');"><strong>[tag:fld:{$field.id}]</strong></a>
					{/if}
				</div>
			</td>
			<td>
				{if $field.main}
				<div class="nowrap">
					{$field.title_lang|escape}
					<input type="hidden" name="fields[{$field.id}][title]" value="{$field.title|escape}"/>
					{if $field.title=='copy'}<a class="topDir icon_sprite ico_info inline" title="{#copy_fld_i#}"></a>{/if}
				</div>
				{else}
				<input type="text" name="fields[{$field.id}][title]" placeholder="{#title#}" class="mousetrap" value="{$field.title|escape}" />
				{/if}
			</td>
			{if $field.main && $field.title != 'subject' && $field.title != 'email'}
			<td colspan="2">
				<input type="hidden" name="fields[{$field.id}][type]" value="{$field.type|escape}"/>
				{if $field.main && $field.title=='receivers'}
					{foreach from=$field.setting item=receiver name=receivers}
					<div class="add_wrap">
						<input type="text" name="fields[{$field.id}][setting][{$smarty.foreach.receivers.index}][email]" value="{$receiver.email|escape}" placeholder="Email" size="20" class="mousetrap email form_field_switch" />
						<input type="text" name="fields[{$field.id}][setting][{$smarty.foreach.receivers.index}][name]" value="{$receiver.name|escape}" placeholder="{#name#}" size="20" class="mousetrap form_field_switch" />
						{if $smarty.foreach.receivers.index == 0}
						<input type="button" value="+" class="btn basicBtn smallBtn addParentBtn mousetrap form_field_switch" data-content='<div class="add_wrap"><input type="text" class="mousetrap email form_field_switch" name="fields[{$field.id}][setting][%count%][email]" placeholder="Email" size="20"/> <input class="mousetrap form_field_switch" type="text" name="fields[{$field.id}][setting][%count%][name]" placeholder="{#name#}" size="20"/> <input type="button" value="&times;" class="btn redBtn smallBtn delParentBtn form_field_switch" data-target="div"></div>' data-target="td" data-count="{$field.setting|@count}">
						{else}
						<input type="button" value="&times;" class="btn redBtn smallBtn delParentBtn form_field_switch" data-target="div">
						{/if}
					</div>
					{/foreach}
				{else}
				<input type="hidden" name="fields[{$field.id}][setting]" value="{$field.setting|escape}" />
				{/if}
			</td>
			{else}
			<td>
				{if $field.main}
				<input type="hidden" name="fields[{$field.id}][type]" value="{$field.type|escape}"/>
				{else}
				<div class="nowrap">
					<select style="width:300px" name="fields[{$field.id}][type]" class="mousetrap form_field_type_change">
						<option value="input" {if $field.type=='input'}selected="selected"{/if}>input</option>
						<option value="textarea" {if $field.type=='textarea'}selected="selected"{/if}>textarea</option>
						<option value="select" {if $field.type=='select'}selected="selected"{/if}>select</option>
						<option value="multiselect" {if $field.type=='multiselect'}selected="selected"{/if}>multiselect</option>
						<option value="checkbox" {if $field.type=='checkbox'}selected="selected"{/if}>checkbox</option>
						<option value="file" {if $field.type=='file'}selected="selected"{/if}>file</option>
						<option value="doc" {if $field.type=='doc'}selected="selected"{/if}>{#doc#}</option>
						<option value="multidoc" {if $field.type=='multidoc'}selected="selected"{/if}>{#multidoc#}</option>
					</select>
					<a class="toprightDir icon_sprite ico_info inline" title="{#type_i#}"></a>
				</div>
				{/if}
			</td>
			<td>
				{if $field.type=='input' || $field.type=='textarea'}
					<div class="nowrap">
						<input type="text" name="fields[{$field.id}][setting]" value="{$field.setting|escape}" placeholder="{#pattern#}" class="mousetrap" style="width:142px" />
						<a class="toprightDir icon_sprite ico_info inline" title="{#pattern_i#}"></a>
					</div>
				{elseif $field.type=='select' || $field.type=='multiselect'}
					{foreach from=$field.setting item=title name=select}
						<div class="add_wrap">
							<input type="text" name="fields[{$field.id}][setting][]" value="{$title|escape}" placeholder="option" size="20" class="mousetrap form_field_switch" />
							{if $smarty.foreach.select.index == 0}
							<input type="button" value="+" class="btn basicBtn smallBtn addParentBtn mousetrap form_field_switch" data-content='<div class="add_wrap"><input type="text" name="fields[{$field.id}][setting][]" placeholder="option" size="20" class="mousetrap form_field_switch" /> <input type="button" value="&times;" class="btn redBtn smallBtn form_field_switch del" data-target="div"></div>' data-target="td">
							{else}
							<input type="button" value="&times;" class="btn redBtn smallBtn form_field_switch del" data-target="div">
							{/if}
						</div>
					{/foreach}
				{elseif $field.type=='doc' || $field.type=='multidoc'}
					<select class="mousetrap" name="fields[{$field.id}][setting][]" multiple="multiple" size="4" style="width:100%">
						{foreach from=$rubrics item=rtitle key=rid}
						<option value="{$rid}" {if $rid|in_array:$field.setting}selected="selected"{/if}>{$rtitle|escape}</option>
						{/foreach}
					</select>
				{elseif $field.type == 'file'}
					<input type="text" name="fields[{$field.id}][setting]" value="{$field.setting|escape}" title="{#file_size2#}" placeholder="{#file_size#}" class="mousetrap botDir" />
				{/if}
			</td>
			{/if}
			<td align="center">
				{if !($field.type == 'doc' || $field.type == 'multidoc' || ($field.main && ($field.title == 'copy' || $field.title == 'receivers')))}
					<input type="checkbox" class="topDir" name="fields[{$field.id}][required]" value="1" {if $field.required}checked="checked"{/if} title="{#required#}" {if $field.main && $field.title=='captcha'}disabled="disabled"{/if} />
					{if $field.main && $field.title=='captcha'}
					<input type="hidden" name="fields[{$field.id}][required]" value="1" />
					{/if}
				{/if}
				{if !$field.main && $field.type == 'select'}
					<a style="margin-top:5px;" class="botDir icon_sprite ico_info inline" style="display:block;" title="{#select_req_i#}"></a>
				{/if}
			</td>
			<td class="defaultval">
				{if $field.main && $field.title=='captcha'}
				{elseif $field.type=='input' || $field.type=='textarea'}
					<textarea name="fields[{$field.id}][defaultval]" placeholder="{#defaultval#}" class="mousetrap" id="field_defaultval[{$field.id}]" rows="1">{$field.defaultval|escape}</textarea>
					<div> |
						php |
						<a class="docname botDir" title="{#tag_title#}" href="javascript:void(0);" onClick="textSelection_field_defaultval_{$field.id}('[tag:title]','')"><strong>[tag:title]</strong></a> |
						<a class="docname botDir" title="{#tag_uemail#}" href="javascript:void(0);" onClick="textSelection_field_defaultval_{$field.id}('[tag:uemail]','');"><strong>[tag:uemail]</strong></a> |
						<a class="docname botDir" title="{#tag_uname#}" href="javascript:void(0);" onClick="textSelection_field_defaultval_{$field.id}('[tag:uname]','');"><strong>[tag:uname]</strong></a> |
						<a class="docname botDir" title="{#tag_ufname#}" href="javascript:void(0);" onClick="textSelection_field_defaultval_{$field.id}('[tag:ufname]','');"><strong>[tag:ufname]</strong></a> |
						<a class="docname botDir" title="{#tag_ulname#}" href="javascript:void(0);" onClick="textSelection_field_defaultval_{$field.id}('[tag:ulname]','');"><strong>[tag:ulname]</strong></a> |
					</div>
					<!-- Оформляем поле в CodeMirror -->
					{if $ave15}
						{include file="$codemirror_editor" ctrls='form_save();' conn_id="_field_defaultval_$field_id" textarea_id="field_defaultval[$field_id]" height=60}
					{else}
						<script>
						var editor_field_defaultval_{$field_id} = CodeMirror.fromTextArea(document.getElementById('field_defaultval[{$field_id}]'), {ldelim}
							extraKeys: {ldelim}
								'Ctrl-S': function(cm) {ldelim}
									form_save();
								{rdelim}
							{rdelim},
							lineNumbers: true,
							lineWrapping: true,
							matchBrackets: true,
							mode: 'application/x-httpd-php',
							indentUnit: 4,
							indentWithTabs: true,
							enterMode: 'keep',
							tabMode: 'shift',
							onChange: function() {ldelim}
								editor_field_defaultval_{$field_id}.save();
							{rdelim},
							onCursorActivity: function() {ldelim}
								editor_field_defaultval_{$field_id}.setLineClass(hlLine, null, null);
								hlLine = editor_field_defaultval_{$field_id}.setLineClass(editor_field_defaultval_{$field_id}.getCursor().line, null, 'activeline');
							{rdelim}
						{rdelim});
						
						editor_field_defaultval_{$field_id}.setSize('100%',60);
						
						function getSelectedRange_field_defaultval_{$field_id}() {ldelim}
							return {ldelim}
								from: editor_field_defaultval_{$field_id}.getCursor(true),
								to: editor_field_defaultval_{$field_id}.getCursor(false)
							{rdelim};
						{rdelim}
						
						function textSelection_field_defaultval_{$field_id}(startTag,endTag) {ldelim}
							var range = getSelectedRange_field_defaultval_{$field_id}();
							editor_field_defaultval_{$field_id}.replaceRange(startTag + editor_field_defaultval_{$field_id}.getRange(range.from, range.to) + endTag, range.from, range.to)
							editor_field_defaultval_{$field_id}.setCursor(range.from.line, range.from.ch + startTag.length);
						{rdelim}
						</script>
					{/if}
				{elseif ($field.type=='select' || $field.type=='multiselect')}
					{if !$field.setting_empty}
					<select style="width:300px" name="fields[{$field.id}][defaultval]{if $field.type=='multiselect'}[]{/if}" {if $field.type=='multiselect'}multiple="multiple" size="{$field.setting|@count}" style="width:100%"{/if} class="mousetrap">
						{foreach from=$field.setting item=item name=select}
							{if $field.main && $field.title=='receivers'}
							<option value="{$smarty.foreach.select.index}" {if $smarty.foreach.select.index==$field.defaultval}selected="selected"{/if}>{$item.name|escape}</option>
							{else}
							<option value="{$smarty.foreach.select.index}" {if ($field.type=='select' && $smarty.foreach.select.index==$field.defaultval) || ($field.type=='multiselect' && $smarty.foreach.select.index|in_array:$field.defaultval)}selected="selected"{/if}>{$item|escape}</option>
							{/if}
						{/foreach}
					</select>
					{else}
					{#setting_empty#}
					{/if}
				{elseif $field.type=='checkbox'}
					<input type="hidden" name="fields[{$field.id}][defaultval]" value="0">
					<input type="checkbox" name="fields[{$field.id}][defaultval]" value="1" {if $field.defaultval}checked="checked"{/if}>
				{/if}
			</td>
			<td align="center">
				<a class="topleftDir icon_sprite ico_template form_field_tpl_btn" href="javascript:void(0);" title="{#fld_tpl_toggle#}"></a>
				<input type="hidden" class="form_field_tpl_input" name="field_tpl_open[{$field.id}]" value="{if $field_tpl_open[$field_id]}1{else}0{/if}">
			</td>
			<td align="center">
				{if !$field.main}
				<a class="topleftDir icon_sprite ico_delete form_field_del" data-confirm="{#fld_del#}" data-confirm-title="{#fld_deleting#}" href="javascript:void(0)" data-field="{$field.id}"></a>
				{/if}
			</td>
		</tr>
		<tr class="form_field_tpl_tr {if !$field_tpl_open[$field_id]}hide{/if}">
			<td colspan="8">
				<div class="col-half">
					<h6>{#attributes#}</h6>
					<textarea name="fields[{$field.id}][attributes]" id="field_attr[{$field.id}]" placeholder="{#attributes#}" class="mousetrap" rows="8">{$field.attributes|escape}</textarea>
					<div> |
						php |
						<a class="icon_sprite ico_start botDir inline" title="{#tag_attr#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('id=&quot;fld[[tag:id]]&quot; class=&quot;&quot; placeholder=&quot;[tag:title]&quot;','')"></a> |
						<a class="docname botDir" title="{#tag_id#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:id]','')"><strong>[tag:id]</strong></a> |
						<a class="docname botDir" title="{#tag_title#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:title]','')"><strong>[tag:title]</strong></a> |
						<a class="docname botDir" title="{#tag_nempty#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:if_notempty]','[/tag:if_notempty]')"><strong>[tag:if_notempty][/tag:if_notempty]</strong></a> |
						<a class="docname botDir" title="{#tag_empty#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:if_empty]','[/tag:if_empty]')"><strong>[tag:if_empty][/tag:if_empty]</strong></a> |
						<br> |
						<a class="docname botDir" title="{#tag_uemail#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:uemail]','');"><strong>[tag:uemail]</strong></a> |
						<a class="docname botDir" title="{#tag_uname#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:uname]','');"><strong>[tag:uname]</strong></a> |
						<a class="docname botDir" title="{#tag_ufname#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:ufname]','');"><strong>[tag:ufname]</strong></a> |
						<a class="docname botDir" title="{#tag_ulname#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:ulname]','');"><strong>[tag:ulname]</strong></a> |
						{if $field.type=='input' || $field.type=='textarea' || $field.type=='file'}
						<br> |
						<a class="docname botDir" title="{#tag_valid#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:if_valid]','[/tag:if_valid]')"><strong>[tag:if_valid][/tag:if_valid]</strong></a> |
						<a class="docname botDir" title="{#tag_invalid#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:if_invalid]','[/tag:if_invalid]')"><strong>[tag:if_invalid][/tag:if_invalid]</strong></a> |
						{/if}
						{if $field.main && $field.title == 'captcha'}
						<br> |
						<a class="docname botDir" title="{#tag_captcha#}" href="javascript:void(0);" onClick="textSelection_field_attr_{$field.id}('[tag:captcha]','')"><strong>[tag:captcha]</strong></a> |
						{/if}
					</div>
				</div>
				<div class="col-half">
					<h6>{#field_tpl#}</h6>
					<textarea name="fields[{$field.id}][tpl]" id="field_tpl[{$field.id}]" placeholder="{#field_tpl#}" class="mousetrap" rows="8">{$field.tpl|escape}</textarea>
					<div> |
						php |
						<a class="docname botDir" title="{#tag_fld_tpl#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:fld]','')"><strong>[tag:fld]</strong></a> |
						<a class="docname botDir" title="{#tag_id#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:id]','')"><strong>[tag:id]</strong></a> |
						<a class="docname botDir" title="{#tag_title#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:title]','')"><strong>[tag:title]</strong></a> |
						<a class="docname botDir" title="{#tag_nempty#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:if_notempty]','[/tag:if_notempty]')"><strong>[tag:if_notempty][/tag:if_notempty]</strong></a> |
						<a class="docname botDir" title="{#tag_empty#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:if_empty]','[/tag:if_empty]')"><strong>[tag:if_empty][/tag:if_empty]</strong></a> |
						<br> |
						<a class="docname botDir" title="{#tag_uemail#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:uemail]','');"><strong>[tag:uemail]</strong></a> |
						<a class="docname botDir" title="{#tag_uname#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:uname]','');"><strong>[tag:uname]</strong></a> |
						<a class="docname botDir" title="{#tag_ufname#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:ufname]','');"><strong>[tag:ufname]</strong></a> |
						<a class="docname botDir" title="{#tag_ulname#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:ulname]','');"><strong>[tag:ulname]</strong></a> |
						{if $field.type=='input' || $field.type=='textarea' || $field.type=='file'}
						<br> |
						<a class="docname botDir" title="{#tag_valid#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:if_valid]','[/tag:if_valid]')"><strong>[tag:if_valid][/tag:if_valid]</strong></a> |
						<a class="docname botDir" title="{#tag_invalid#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:if_invalid]','[/tag:if_invalid]')"><strong>[tag:if_invalid][/tag:if_invalid]</strong></a> |
						{/if}
						{if $field.main && $field.title == 'captcha'}
						<br> |
						<a class="docname botDir" title="{#tag_captcha#}" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('[tag:captcha]','')"><strong>[tag:captcha]</strong></a> |
						<a class="docname" href="javascript:void(0);" onClick="textSelection_field_tpl_{$field.id}('&lt;img src=&quot;[tag:path][tag:captcha]&quot; alt=&quot;Капча&quot;&gt;','')"><strong>captcha_img</strong></a> |
						{/if}
					</div>
				</div>
			</td>
		</tr>
		{/foreach}
		<tr>
			<td colspan="9"><h6>{#field_add#}</h6></td>
		</tr>
		<tr>
			<td align="center">
				<input type="checkbox" class="toprightDir" name="fields[0][active]" value="1" checked="checked" title="{#active_i#}" />
			</td>
			<td></td>
			<td>
				<input type="text" name="fields[0][title]" placeholder="{#title#}" class="mousetrap form_fields_new_title" />
			</td>
			<td>
				<select style="width:300px" name="fields[0][type]" class="mousetrap">
					<option value="input">input</option>
					<option value="textarea">textarea</option>
					<option value="select">select</option>
					<option value="multiselect">multiselect</option>
					<option value="checkbox">checkbox</option>
					<option value="file">file</option>
					<option value="doc">{#doc#}</option>
					<option value="multidoc">{#multidoc#}</option>
				</select>
			</td>
			<td colspan="5" align="right">
				<input type="hidden" name="fields[0][new]" value="1" />
				<input type="button" class="btn greenBtn mousetrap" value="{#add_refresh#} (Ctrl+S)" onClick="if(!$('.form_fields_new_title').val()) jAlert('{#field_new_error#}','{#field_creating#}'); else form_save(true); return false;" />
			</td>
		</tr>
	</tbody>
</table>

<!-- Оформляем поля в CodeMirror -->
{foreach from=$fields item=field key=field_id}
	{if $ave15}
		{include file="$codemirror_editor" ctrls='form_save();' conn_id="_field_attr_$field_id" textarea_id="field_attr[$field_id]" height=176}
		{include file="$codemirror_editor" ctrls='form_save();' conn_id="_field_tpl_$field_id" textarea_id="field_tpl[$field_id]" height=176}
	{else}
		<script>
		// аттрибуты поля
		var editor_field_attr_{$field_id} = CodeMirror.fromTextArea(document.getElementById('field_attr[{$field_id}]'), {ldelim}
			extraKeys: {ldelim}
				'Ctrl-S': function(cm) {ldelim}
					form_save();
				{rdelim}
			{rdelim},
			lineNumbers: true,
			lineWrapping: true,
			matchBrackets: true,
			mode: 'application/x-httpd-php',
			indentUnit: 4,
			indentWithTabs: true,
			enterMode: 'keep',
			tabMode: 'shift',
			onChange: function() {ldelim}
				editor_field_attr_{$field_id}.save();
			{rdelim},
			onCursorActivity: function() {ldelim}
				editor_field_attr_{$field_id}.setLineClass(hlLine, null, null);
				hlLine = editor_field_attr_{$field_id}.setLineClass(editor_field_attr_{$field_id}.getCursor().line, null, 'activeline');
			{rdelim}
		{rdelim});
		
		editor_field_attr_{$field_id}.setSize('100%',176);
		
		function getSelectedRange_field_attr_{$field_id}() {ldelim}
			return {ldelim}
				from: editor_field_attr_{$field_id}.getCursor(true),
				to: editor_field_attr_{$field_id}.getCursor(false)
			{rdelim};
		{rdelim}
		
		function textSelection_field_attr_{$field_id}(startTag,endTag) {ldelim}
			var range = getSelectedRange_field_attr_{$field_id}();
			editor_field_attr_{$field_id}.replaceRange(startTag + editor_field_attr_{$field_id}.getRange(range.from, range.to) + endTag, range.from, range.to)
			editor_field_attr_{$field_id}.setCursor(range.from.line, range.from.ch + startTag.length);
		{rdelim}
	
		// шаблон поля
		var editor_field_tpl_{$field_id} = CodeMirror.fromTextArea(document.getElementById('field_tpl[{$field_id}]'), {ldelim}
			extraKeys: {ldelim}
				'Ctrl-S': function(cm) {ldelim}
					form_save();
				{rdelim}
			{rdelim},
			lineNumbers: true,
			lineWrapping: true,
			matchBrackets: true,
			mode: 'application/x-httpd-php',
			indentUnit: 4,
			indentWithTabs: true,
			enterMode: 'keep',
			tabMode: 'shift',
			onChange: function() {ldelim}
				editor_field_tpl_{$field_id}.save();
			{rdelim},
			onCursorActivity: function() {ldelim}
				editor_field_tpl_{$field_id}.setLineClass(hlLine, null, null);
				hlLine = editor_field_tpl_{$field_id}.setLineClass(editor_field_tpl_{$field_id}.getCursor().line, null, 'activeline');
			{rdelim}
		{rdelim});
		
		editor_field_tpl_{$field_id}.setSize('100%',176);
		
		function getSelectedRange_field_tpl_{$field_id}() {ldelim}
			return {ldelim}
				from: editor_field_tpl_{$field_id}.getCursor(true),
				to: editor_field_tpl_{$field_id}.getCursor(false)
			{rdelim};
		{rdelim}
		
		function textSelection_field_tpl_{$field_id}(startTag,endTag) {ldelim}
			var range = getSelectedRange_field_tpl_{$field_id}();
			editor_field_tpl_{$field_id}.replaceRange(startTag + editor_field_tpl_{$field_id}.getRange(range.from, range.to) + endTag, range.from, range.to)
			editor_field_tpl_{$field_id}.setCursor(range.from.line, range.from.ch + startTag.length);
		{rdelim}
		</script>
	{/if}
{/foreach}
<!-- /Оформляем поля в CodeMirror -->

<!-- Скрываем поля -->
<script>
$('.form_field_tpl_tr.hide').hide();
</script>
<!-- /Скрываем поля -->