<!-- Включаем CodeMirror разными способами в зависимости от версии движка -->
{if $ave15}
{include file="$codemirror_connect"}
{else}
<link rel="stylesheet" href="{$ABS_PATH}admin/codemirror/lib/codemirror.css">
{literal}
<style type="text/css">
.activeline {
	background: #e8f2ff !important;
}
.CodeMirror-scroll {
	height: 450px;
}
.smallBtn {
	padding: 4px 7px !important;
}
</style>
{/literal}
<script src="{$ABS_PATH}admin/codemirror/lib/codemirror.js" type="text/javascript"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/xml/xml.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/javascript/javascript.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/css/css.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/clike/clike.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/php/php.js"></script>
{/if}
<!-- /Включаем CodeMirror -->
{literal}
<style>
#forms input {
	box-sizing:border-box;
}
</style>
{/literal}

<script type="text/javascript">
// назначаем языковые переменные (так удобнее работать со smarty)
$fid = parseInt('{$fid}');
$sess = '{$sess}';
$smarty = new Array;
$smarty['start_alert'] = '{$alert.text}';
$smarty['start_alert_theme'] = '{$alert.theme}';
</script>

<div class="title">
	<h5>{#contacts#}</h5>
</div>
<div class="widget" style="margin-top:0">
	<div class="body">{#mod_info#}</div>
</div>
<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
		<ul>
			<li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}" class="toprightDir"></a></li>
			<li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
			<li><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}">{#contacts#}</a></li>
			<li><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}">{#forms#}</a></li>
			<li><strong class="code"><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_edit&amp;fid={$fid}&amp;cp={$sess}" {if $ave14}style="float:none; display:inline;"{/if}>{$form.title|escape}</a></strong></li>
			<li><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_list&amp;fid={$fid}&amp;cp={$sess}">{#history#}</a></li>
			<li><strong class="code"><em style="font-weight:lighter;">{$date|date_format:$TIME_FORMAT|pretty_date}</em> | {$subject|escape}</strong></li>
		</ul>
	</div>
</div>

<div class="widget first">
	<div class="head">
		<h5 class="iFrames">{#history#}: {$subject}</h5>
	</div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm" id="forms">
		<colgroup>
			<col width="250">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<td colspan="2"><h6>{#request#}</h6></td>
			</tr>
			<tr>
				{assign var=item value=$dialog.request}
				<td valign="middle">
					{if $item.user_name}
						[<a target="_blank" href="index.php?do=user&amp;action=edit&Id={$item.user_id}&cp={$sess}" class="toprightDir" title="{#profile_look#}">{$item.user_name}</a>] {if $item.firstname || $item.lastname}{$item.firstname} {$item.lastname}{/if}<br/>
					{/if}
					<a href="mailto:{$email}" title="{#write_email#}" class="toprightDir">{$email}</a><br/>
					<span class="date_text dgrey">{$date|date_format:$TIME_FORMAT|pretty_date}</span>
				</td>
				<td>
					{if $item.format=='text'}
						<div style="white-space:pre">{$item.body}</div>
					{else}
						{$item.body}
					{/if}
				</td>
			</tr>
			{if $dialog.response}
			<tr>
				<td colspan="2"><h5>{if $dialog.response|@count == 1}{#response#}{else}{#responses#}{/if}</h5></td>
			</tr>
			{foreach from=$dialog.response item=item}
			<tr>
				<td valign="middle">
					{if $item.user_name}
						[<a target="_blank" href="index.php?do=user&amp;action=edit&Id={$item.user_id}&cp={$sess}" class="toprightDir" title="{#profile_look#}">{$item.user_name}</a>] {if $item.firstname || $item.lastname}{$item.firstname} {$item.lastname}{/if}<br/>
					{/if}
					{#from#} <a href="mailto:{$item.from_email}" title="{#write_email#}" class="toprightDir">{$item.from_email}</a> &lt;{$item.from_name|escape}&gt;<br/>
					<span class="date_text dgrey">{$item.date|date_format:$TIME_FORMAT|pretty_date}</span>
				</td>
				<td>
					{if $item.format=='text'}
						<div style="white-space:pre">{$item.body}</div>
					{else}
						{$item.body}
					{/if}
				</td>
			</tr>
			{/foreach}
			{else}
			<tr class="{if $status==='replied'}yellow{/if}">
				<td colspan="2" style="padding:15px 10px;">
					{if $status!=='replied'}<a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=dialog_status&amp;hid={$hid}&amp;status=replied&amp;fid={$fid}&amp;cp={$sess}" class="btn redBtn">{#set_replied#}</a>
					{else}
					<strong>{#marked_replied#}</strong>
					{/if}
				</td>
			</tr>
			{/if}
		</tbody>
	</table>
</div>

<form method="post" class="mainForm" id="response_form" action="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_dialog_submit&amp;hid={$hid}&amp;cp={$sess}" data-accept="{#saved#}" data-error="{#notsaved#}">
	<div class="widget first">
		<div class="head">
			<h5 class="iFrames">{#write_response#}</h5>
		</div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<colgroup>
				<col width="200">
				<col>
			</colgroup>
			<tbody>
				<tr class="noborder">
					<td>{#from_name#}:</td>
					<td><input type="text" name="from_name" placeholder="{#from_name#}" class="mousetrap" value="{$dialog.response_draft.from_name|escape}"/></td>
				</tr>
				<tr>
					<td>{#from_email#}:</td>
					<td><input type="text" name="from_email" placeholder="{#from_email#}" class="mousetrap" value="{$dialog.response_draft.from_email|escape}"/></td>
				</tr>
				<tr>
					<td>{#mfld_subject#}:</td>
					<td><input type="text" name="subject" placeholder="{#mfld_subject#}" class="mousetrap" value="{$dialog.response_draft.subject|escape|default:"RE: $subject"}"/></td>
				</tr>
				<tr>
					<td>{#format#}:</td>
					<td>
						<input class="mousetrap" type="radio" name="format" value="text" {if $dialog.response_draft.format!='html'}checked="checked"{/if}/>
						<label>{#text#}</label>
						<input class="mousetrap" type="radio" name="format" value="html" {if $dialog.response_draft.format=='html'}checked="checked"{/if}/>
						<label>HTML</label>
					</td>
				</tr>
				<tr>
					<td>{#body#}</td>
					<td>
						<textarea name="body" id="response_body" wrap="off">{$dialog.response_draft.body|escape}</textarea>
						<div style="margin-top:5px;">
						 | <a href="javascript:void(0);" onClick="textSelection_response_body('<ol>', '</ol>');"><strong>OL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<ul>', '</ul>');"><strong>UL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<li>', '</li>');"><strong>LI</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<strong>', '</strong>');"><strong>B</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<em>', '</em>');"><strong>I</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<h1>', '</h1>');"><strong>H1</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<h2>', '</h2>');"><strong>H2</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<h3>', '</h3>');"><strong>H3</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<h4>', '</h4>');"><strong>H4</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<h5>', '</h5>');"><strong>H5</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<span>', '</span>');"><strong>SPAN</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<pre>', '</pre>');"><strong>PRE</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('<br />', '');"><strong>BR</strong></a> | <a href="javascript:void(0);" onClick="textSelection_response_body('\t', '');"><strong>TAB</strong></a> | 
						</div>
					</td>
				</tr>
				{*<tr>
					<td>{#attach#}</td>
					<td><input type="file"></td>
				</tr>*}
			</tbody>
		</table>
	    <div class="rowElem">
			<input type="submit" class="btn basicBtn mousetrap" value="{#save_draft#} (Ctrl+S)" onClick="response_save();return false;" />&nbsp;
			<button type="submit" class="btn redBtn mousetrap" value="1" name="send">{#send#}</button>&nbsp;
			<a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_list&amp;fid={$fid}&amp;cp={$sess}" class="btn greenBtn">{#return_dialogs#}</a>
		</div>
	</div>
</form>

{literal}
<script type="text/javascript">
// на старте документа
$(function() {
	// показываем стартовый алерт
	if ($smarty.start_alert > '') $.jGrowl($smarty.start_alert, {theme: $smarty.start_alert_theme});

	// сохранение по Ctrl+S
	Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {
		e.preventDefault();
		response_save ();
	});
});

// функция сохранения формы
function response_save () {
	var form = $('#response_form');
	form.ajaxSubmit({
		data: {
			ajax: 1
		},
		beforeSubmit: function () {
			$.alerts._overlay('show');
		},
		success: function () {
			$.alerts._overlay('hide');
			$.jGrowl(form.attr('data-accept'), {theme: 'accept'});
		},
		error: function () {
			$.jGrowl(form.attr('data-error'), {theme: 'error'});
		}
	});
}
</script>
{/literal}

{assign var=cdmr_id value=response_body}
{assign var=cdmr_h value=300}
{if $ave15}
	{include file="$codemirror_editor" ctrls='response_save();' conn_id="_$cdmr_id" textarea_id=$cdmr_id height=$cdmr_h}
{else}
	<script>
	var editor_{$cdmr_id} = CodeMirror.fromTextArea(document.getElementById('{$cdmr_id}'), {ldelim}
		extraKeys: {ldelim}
			'Ctrl-S': function(cm) {ldelim}
				response_save();
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
			editor_{$cdmr_id}.save();
		{rdelim},
		onCursorActivity: function() {ldelim}
			editor_{$cdmr_id}.setLineClass(hlLine, null, null);
			hlLine = editor_{$cdmr_id}.setLineClass(editor_{$cdmr_id}.getCursor().line, null, 'activeline');
		{rdelim}
	{rdelim});

	editor_{$cdmr_id}.setSize('100%',{$cdmr_h});

	function getSelectedRange_{$cdmr_id}() {ldelim}
		return {ldelim}
			from: editor_{$cdmr_id}.getCursor(true),
			to: editor_{$cdmr_id}.getCursor(false)
		{rdelim};
	{rdelim}

	function textSelection_{$cdmr_id}(startTag,endTag) {ldelim}
		var range = getSelectedRange_{$cdmr_id}();
		editor_{$cdmr_id}.replaceRange(startTag + editor_{$cdmr_id}.getRange(range.from, range.to) + endTag, range.from, range.to)
		editor_{$cdmr_id}.setCursor(range.from.line, range.from.ch + startTag.length);
	{rdelim}
	</script>
{/if}