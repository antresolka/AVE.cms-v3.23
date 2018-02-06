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
<style type="text/css">
#form_edit td > input, #form_edit td > textarea {
	box-sizing: border-box;
}
#form_edit .settings input, #form_edit .settings textarea, .add_wrap input, .add_wrap textarea {
	width: auto !important;
}
#form_edit input+input {
	margin-left: 4px;
}
#form_edit a.ico_info {
	cursor: pointer;
}
.add_wrap {
	white-space: nowrap;
	float: none;
	display:block;
	width:100%;
}
.add_wrap + .add_wrap {
	margin-top: 4px;
}
.icon_sprite.inline {
	display: inline-block;
	vertical-align: middle;
	margin: 0;
	padding: 0;
}
.jqTransformSelectWrapper + .icon_sprite.inline {
	margin: 4px 0 0 8px;
	float: left;
}
.nowrap {
	white-space: nowrap;
}
.col-half {
	width: 50%;
	box-sizing: border-box;
	float: left;
	padding-right: 8px;
}
.col-half+.col-half {
	padding: 0 0 0 8px;
}
.col-half h6 {
	margin-bottom: 6px;
}
.col-half .CodeMirror-wrap {
	border: 1px solid #B9CFDF;
	box-sizing: border-box;
}
.col-half textarea {
	box-sizing: border-box;
	box-shadow: none !important;
	-webkit-box-shadow: none !important;
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
$smarty['_email_accept'] = '{#email_accept#}';
$smarty['_email_error'] = '{#email_error#}';
$smarty['tpl_dir'] = '{$tpl_dir}';
$smarty['_refresh']	= '{#refresh#}';
</script>

<div class="title">
	<h5>{#contacts#}</h5>
</div>
<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
		<ul>
			<li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}" class="toprightDir"></a></li>
			<li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
			<li><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}">{#contacts#}</a></li>
			{if $fid}
				<li><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}">{#forms#}</a></li>
				<li><strong class="code">{$form.title|escape}</strong></li>
			{/if}
			<li>{if $fid}{#form_editing#}{else}{#form_creating#}{/if}</strong></li>
		</ul>
	</div>
</div>
<form method="post" class="mainForm" id="form_edit" action="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_save&amp;fid={$fid}&amp;cp={$sess}" data-accept="{#saved#}" data-error="{#notsaved#}">
	<div class="widget first">
		<div class="head">
			<h5 class="iFrames">{#main_sets#}</h5>
			<div class="num">
				<a class="basicNum" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_list&amp;fid={$fid}&amp;cp={$sess}">{#history#}</a>
			</div>
		</div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings">
			<colgroup>
				<col width="200">
				<col>
			</colgroup>
			<tbody>
				<tr class="noborder">
					<td>{#title#}:</td>
					<td>
						<input type="text" name="title" id="form_title" value="{$form.title|escape}" class="mousetrap" placeholder="{#title#}" size="40" {if !$fid}autofocus{/if} />
					</td>
				</tr>
				<tr>
					<td>
						<div class="nowrap">
							{#alias#}
							<a class="toprightDir icon_sprite ico_info inline" title="{#alias_i#}"></a>:
						</div>
					</td>
					<td>
						<div class="pr12" style="display: table;">
						<input type="text" name="alias" id="form_alias" value="{$form.alias|escape}" class="mousetrap" data-accept="{#alias_accept#}" data-error-syn="{#alias_er_syn#}" data-error-exists="{#alias_er_exists#}" placeholder="{#alias#}" maxlength="20" size="40" />
						<input type="text" id="form_tag_{$fid}" value="[mod_contactsnew:{if $fid && $form.alias}{$form.alias}{elseif $fid}{$fid}{/if}]" readonly size="40" class="mousetrap" />
                        <a style="text-align: center; padding: 5px 3px 4px 3px;" class="whiteBtn copyBtn topDir" href="javascript:void(0);" data-clipboard-action="copy" data-clipboard-target="#form_tag_{$form.id}" title="{#cn_copy_to_clipboard#}">
					    <img style="margin-top: -3px; position: relative; top: 4px; padding: 0 3px;" class="clippy" src="{$ABS_PATH}admin/templates/images/clippy.svg" width="13"></a>
				        </div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="nowrap">
							{#protection#}
							<a class="toprightDir icon_sprite ico_info inline" title="{#protect_i#}"></a>:
						</div>
					</td>
					<td>
						<input type="checkbox" name="protection" value="1" {if $form.protection!=='0'}checked="checked"{/if} class="mousetrap"/>
					</td>
				</tr>
				{if !$fid}
				<tr>
					<td>{#demo#}:</td>
					<td>
						<select style="width:300px" name="demo">
							<option value="">{#no#}</option>
							<option value="noajax">{#demo_noajax#}</option>
							<option value="ajax">{#demo_ajax#}</option>
							<option value="ajax_o">{#demo_ajax_o#}</option>
						</select>
					</td>
				</tr>
				{/if}
			</tbody>
		</table>
		{if !$fid}
	    <div class="rowElem">
			<input type="submit" class="btn basicBtn mousetrap" value="{#create#} (Ctrl+S)" />
		</div>
		{/if}
	</div>

	{if $fid}
	<div class="widget first">
		<div class="head closed">
			<h5 class="iFrames">{#rubheader#}</h5>
		</div>
		<div>
			<div class="body">{#rubheader_info#}</div>
			<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
				<colgroup>
					<col width="200">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td><a class="toprightDir" title="{#tag_path#}" href="javascript:void(0);" onClick="textSelection_rubheader('[tag:path]','');"><strong>[tag:path]</strong></a></td>
						<td rowspan="3">
							<textarea wrap="off" name="rubheader" id="rubheader">{$form.rubheader|escape}</textarea>
						</td>
					</tr>
					<tr>
						<td><a class="toprightDir" title="{#tag_media#}" href="javascript:void(0);" onClick="textSelection_rubheader('[tag:mediapath]','');"><strong>[tag:mediapath]</strong></a></td>
					</tr>
					<tr>
						<td><a class="toprightDir" title="{#tag_css#}" href="javascript:void(0);" onClick="textSelection_rubheader('[tag:css:]','');"><strong>[tag:css:FFF:P]</strong></a>, <a class="toprightDir" title="{#tag_js#}" href="javascript:void(0);" onClick="textSelection_rubheader('[tag:js:]','');"><strong>[tag:js:FFF:P]</strong></a></td>
					</tr>
					<tr>
						<td>HTML tags</td>
						<td> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<ol>', '</ol>');"><strong>OL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<ul>', '</ul>');"><strong>UL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<li>', '</li>');"><strong>LI</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<strong>', '</strong>');"><strong>B</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<em>', '</em>');"><strong>I</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<h1>', '</h1>');"><strong>H1</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<h2>', '</h2>');"><strong>H2</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<h3>', '</h3>');"><strong>H3</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<h4>', '</h4>');"><strong>H4</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<h5>', '</h5>');"><strong>H5</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<span>', '</span>');"><strong>SPAN</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<pre>', '</pre>');"><strong>PRE</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('<br />', '');"><strong>BR</strong></a> | <a href="javascript:void(0);" onClick="textSelection_rubheader('\t', '');"><strong>TAB</strong></a> | </td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="widget first">
		<div class="head">
			<h5 class="iFrames">{#fields_sets#}</h5>
		</div>
		<div id="form_fields_appendto">
			{include file=$form_fields_tpl fields=$form.fields}
		</div>
	</div>

	<div class="widget first">
		<div class="head">
			<h5 class="iFrames">{#form_tpl#}</h5>
		</div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<colgroup>
				<col width="200">
				<col>
			</colgroup>
			<tbody>
				<tr class="noborder">
					<td>{#conditions#}</td>
					<td> |
						<a title="{#tag_if_fld#}" href="javascript:void(0);" class="topDir" onClick="textSelection_form_tpl('[tag:if_fld:]', '[/tag:if_fld]');"><strong>[tag:if_fld:XXX == '123'][/tag:if_fld]</strong></a> |
						<a title="{#tag_if_fld#}" href="javascript:void(0);" class="topDir" onClick="textSelection_form_tpl('[tag:elseif_fld:]', '');"><strong>[tag:elseif_fld:XXX > 2]</strong></a> |
						<a title="{#tag_if_fld#}" href="javascript:void(0);" class="topDir" onClick="textSelection_form_tpl('[tag:else_fld]', '');"><strong>[tag:else_fld]</strong></a> |
						<br/> |
						<a title="{#tag_f_valid#}" href="javascript:void(0);" class="topDir" onClick="textSelection_form_tpl('[tag:if_form_valid]', '[/tag:if_form_valid]');"><strong>[tag:if_form_valid][/tag:if_form_valid]</strong></a> |
						<a title="{#tag_f_invalid#}" href="javascript:void(0);" class="topDir" onClick="textSelection_form_tpl('[tag:if_form_invalid]', '[/tag:if_form_invalid]');"><strong>[tag:if_form_invalid][/tag:if_form_invalid]</strong></a> |
					</td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_fld#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:fld:]', '');">[tag:fld:XXX]</a></strong></td>
					<td rowspan="16"><textarea name="form_tpl" id="form_tpl" wrap="off">{$form.form_tpl|escape}</textarea></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_title#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:title:]', '');">[tag:title:XXX]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_docid#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:docid]', '');">[tag:docid]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_url#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:document]', '');">[tag:document]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_formalias#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:formalias]', '');">[tag:formalias]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_formtitle#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:formtitle]', '');">[tag:formtitle]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_path#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:path]', '');">[tag:path]</a></strong></td>
				</tr>
				<tr>
					<td><a class="toprightDir" title="{#tag_media#}" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:mediapath]','');"><strong>[tag:mediapath]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:hide:]','[/tag:hide]');" title="{#tag_hide#}"><strong>[tag:hide:X,X:TEXT][/tag:hide]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:uemail]','');" title="{#tag_uemail#}"><strong>[tag:uemail]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:ulogin]','');" title="{#tag_ulogin#}"><strong>[tag:ulogin]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:uname]','');" title="{#tag_uname#}"><strong>[tag:uname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:ufname]','');" title="{#tag_ufname#}"><strong>[tag:ufname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:ulname]','');" title="{#tag_ulname#}"><strong>[tag:ulname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:sitename]','');" title="{#tag_sitename#}"><strong>[tag:sitename]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_form_tpl('[tag:sitehost]','');" title="{#tag_sitehost#}"><strong>[tag:sitehost]</strong></a></td>
				</tr>
				<tr>
					<td>HTML Tags</td>
					<td> | <a href="javascript:void(0);" onClick='textSelection_form_tpl("<form action=\"\" method=\"post\" id=\"[tag:formalias]\" enctype=\"multipart/form-data\" role=\"form\">", "\n</form>\n");'><strong>FORM</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<ol>', '</ol>');"><strong>OL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<ul>', '</ul>');"><strong>UL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<li>', '</li>');"><strong>LI</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<strong>', '</strong>');"><strong>B</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<em>', '</em>');"><strong>I</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<h1>', '</h1>');"><strong>H1</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<h2>', '</h2>');"><strong>H2</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<h3>', '</h3>');"><strong>H3</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<h4>', '</h4>');"><strong>H4</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<h5>', '</h5>');"><strong>H5</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<span>', '</span>');"><strong>SPAN</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<pre>', '</pre>');"><strong>PRE</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('<br />', '');"><strong>BR</strong></a> | <a href="javascript:void(0);" onClick="textSelection_form_tpl('\t', '');"><strong>TAB</strong></a> | </td>
				</tr>
			</tbody>
		</table>
	    <div class="rowElem">
			<input type="submit" class="btn basicBtn mousetrap" value="{#save#} (Ctrl+S)" />&nbsp;
			<a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}" class="btn greenBtn">{#return_to_forms#}</a>
		</div>
	</div>

	<div class="widget first">
		<div class="head">
			<h5 class="iFrames">{#mail_set#}</h5>
		</div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<colgroup>
				<col width="200">
				<col>
			</colgroup>
			<tbody>
				<tr class="noborder">
					<td>{#from_name#}:</td>
					<td>
						<textarea id="from_name" name="mail_set[from_name]" placeholder="{#from_name#}" rows="2" class="mousetrap">{$form.mail_set.from_name|escape}</textarea>
						<div>|
							php |
							<a class="docname botDir" title="{#tag_fld_mail#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:fld:]','');"><strong>[tag:fld:XXX]</strong></a> |
							<a class="docname botDir" title="{#tag_uemail#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:uemail]','');"><strong>[tag:uemail]</strong></a> |
							<a class="docname botDir" title="{#tag_login#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:login]','');"><strong>[tag:ulogin]</strong></a> |
							<a class="docname botDir" title="{#tag_uname#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:uname]','');"><strong>[tag:uname]</strong></a> |
							<a class="docname botDir" title="{#tag_ufname#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:ufname]','');"><strong>[tag:ufname]</strong></a> |
							<a class="docname botDir" title="{#tag_ulname#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:ulname]','');"><strong>[tag:ulname]</strong></a> |
							<a class="docname botDir" title="{#tag_formtitle#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:formtitle]','');"><strong>[tag:formtitle]</strong></a> |
							<a class="docname botDir" title="{#tag_formalias#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:formalias]','');"><strong>[tag:formalias]</strong></a> |
							<a class="docname botDir" title="{#tag_sitename#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:sitename]','');"><strong>[tag:sitename]</strong></a> |
							<a class="docname botDir" title="{#tag_sitehost#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:sitehost]','');"><strong>[tag:sitehost]</strong></a> |
							<br> |
							<a class="docname botDir" title="{#tag_if_user#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:if_user]','[/tag:if_user]');"><strong>[tag:if_user][/tag:if_user]</strong></a> |
							<a class="docname botDir" title="{#tag_if_admin#}" href="javascript:void(0);" onClick="textSelection_from_name('[tag:if_admin]','[/tag:if_admin]');"><strong>[tag:if_admin][/tag:if_admin]</strong></a> |
						</div>
					</td>
				</tr>
				<tr>
					<td>{#from_email#}:</td>
					<td>
						<textarea id="from_email" name="mail_set[from_email]" placeholder="{#from_email#}" rows="2" class="mousetrap">{$form.mail_set.from_email|escape}</textarea>
						<div>|
							php |
							<a class="docname botDir" title="{#tag_fld_email#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:fld:email]','');"><strong>[tag:fld:email]</strong></a> |
							<a class="docname botDir" title="{#tag_fld_mail#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:fld:]','');"><strong>[tag:fld:XXX]</strong></a> |
							<a class="docname botDir" title="{#tag_uemail#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:uemail]','');"><strong>[tag:uemail]</strong></a> |
							<a class="docname botDir" title="{#tag_login#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:login]','');"><strong>[tag:ulogin]</strong></a> |
							<a class="docname botDir" title="{#tag_uname#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:uname]','');"><strong>[tag:uname]</strong></a> |
							<a class="docname botDir" title="{#tag_ufname#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:ufname]','');"><strong>[tag:ufname]</strong></a> |
							<a class="docname botDir" title="{#tag_ulname#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:ulname]','');"><strong>[tag:ulname]</strong></a> |
							<a class="docname botDir" title="{#tag_formtitle#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:formtitle]','');"><strong>[tag:formtitle]</strong></a> |
							<a class="docname botDir" title="{#tag_formalias#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:formalias]','');"><strong>[tag:formalias]</strong></a> |
							<a class="docname botDir" title="{#tag_sitename#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:sitename]','');"><strong>[tag:sitename]</strong></a> |
							<a class="docname botDir" title="{#tag_sitehost#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:sitehost]','');"><strong>[tag:sitehost]</strong></a> |
							<br> |
							<a class="docname botDir" title="{#tag_if_user#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:if_user]','[/tag:if_user]');"><strong>[tag:if_user][/tag:if_user]</strong></a> |
							<a class="docname botDir" title="{#tag_if_admin#}" href="javascript:void(0);" onClick="textSelection_from_email('[tag:if_admin]','[/tag:if_admin]');"><strong>[tag:if_admin][/tag:if_admin]</strong></a> |
						</div>
					</td>
				</tr>
				<tr>
					<td>{#subject_tpl#}:</td>
					<td>
						<textarea id="subject_tpl" name="mail_set[subject_tpl]" placeholder="{#subject_tpl#}" rows="2" class="mousetrap">{$form.mail_set.subject_tpl|escape}</textarea>
						<div>|
							php |
							<a class="docname botDir" title="{#tag_fld_subject#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:fld:subject]','');"><strong>[tag:fld:subject]</strong></a> |
							<a class="docname botDir" title="{#tag_fld_mail#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:fld:]','');"><strong>[tag:fld:XXX]</strong></a> |
							<a class="docname botDir" title="{#tag_uemail#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:uemail]','');"><strong>[tag:uemail]</strong></a> |
							<a class="docname botDir" title="{#tag_login#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:login]','');"><strong>[tag:ulogin]</strong></a> |
							<a class="docname botDir" title="{#tag_uname#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:uname]','');"><strong>[tag:uname]</strong></a> |
							<a class="docname botDir" title="{#tag_ufname#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:ufname]','');"><strong>[tag:ufname]</strong></a> |
							<a class="docname botDir" title="{#tag_ulname#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:ulname]','');"><strong>[tag:ulname]</strong></a> |
							<a class="docname botDir" title="{#tag_formtitle#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:formtitle]','');"><strong>[tag:formtitle]</strong></a> |
							<a class="docname botDir" title="{#tag_formalias#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:formalias]','');"><strong>[tag:formalias]</strong></a> |
							<a class="docname botDir" title="{#tag_sitename#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:sitename]','');"><strong>[tag:sitename]</strong></a> |
							<a class="docname botDir" title="{#tag_sitehost#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:sitehost]','');"><strong>[tag:sitehost]</strong></a> |
							<br> |
							<a class="docname botDir" title="{#tag_if_user#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:if_user]','[/tag:if_user]');"><strong>[tag:if_user][/tag:if_user]</strong></a> |
							<a class="docname botDir" title="{#tag_if_admin#}" href="javascript:void(0);" onClick="textSelection_subject_tpl('[tag:if_admin]','[/tag:if_admin]');"><strong>[tag:if_admin][/tag:if_admin]</strong></a> |
						</div>
					</td>
				</tr>
				<tr>
					<td>{#recs_main#} <a class="toprightDir icon_sprite ico_info inline" title="{#recs_main_i#}"></a>:</td>
					<td>
						{foreach from=$form.mail_set.receivers item=receiver name=receivers}
						<div class="add_wrap">
							<input type="text" name="mail_set[receivers][{$smarty.foreach.receivers.index}][email]" value="{$receiver.email|escape}" placeholder="Email" size="40" class="mousetrap email" />
							<input type="text" name="mail_set[receivers][{$smarty.foreach.receivers.index}][name]" value="{$receiver.name|escape}" placeholder="{#name#}" size="40" class="mousetrap" />
							{if $smarty.foreach.receivers.index == 0}
							<input type="button" value="+" class="btn basicBtn smallBtn addParentBtn mousetrap" data-content='<div class="add_wrap"><input type="text" name="mail_set[receivers][%count%][email]" placeholder="Email" class="mousetrap email" size="40"/> <input class="mousetrap" type="text" name="mail_set[receivers][%count%][name]" placeholder="{#name#}" size="40"/> <input type="button" value="&times;" class="btn redBtn smallBtn delParentBtn" data-target="div"></div>' data-target="td" data-count="{$form.mail_set.receivers|@count}">
							{else}
							<input type="button" value="&times;" class="btn redBtn smallBtn delParentBtn" data-target="div">
							{/if}
						</div>
						{/foreach}
					</td>
				</tr>
				<tr>
					<td>{#format#}:</td>
					<td>
						<input class="mousetrap" type="radio" name="mail_set[format]" value="text" {if $form.mail_set.format!='html'}checked="checked"{/if}/>
						<label>{#text#}</label>
						<input class="mousetrap" type="radio" name="mail_set[format]" value="html" {if $form.mail_set.format=='html'}checked="checked"{/if}/>
						<label>HTML</label>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<h6>{#mail_tpl#}</h6>
					</td>
				</tr>
				<tr>
					<td>{#conditions#}</td>
					<td> |
						<a title="{#tag_if_fld#}" href="javascript:void(0);" class="topDir" onClick="textSelection_mail_tpl('[tag:if_fld:]', '[/tag:if_fld]');"><strong>[tag:if_fld:XXX == '123'][/tag:if_fld]</strong></a> |
						<a title="{#tag_if_fld#}" href="javascript:void(0);" class="topDir" onClick="textSelection_mail_tpl('[tag:elseif_fld:]', '');"><strong>[tag:elseif_fld:XXX > 2]</strong></a> |
						<a title="{#tag_if_fld#}" href="javascript:void(0);" class="topDir" onClick="textSelection_mail_tpl('[tag:else_fld]', '');"><strong>[tag:else_fld]</strong></a> |
						<br>|
						<a title="{#tag_if_user#}" href="javascript:void(0);" class="topDir" onClick="textSelection_mail_tpl('[tag:if_user]', '[/tag:if_user]');"><strong>[tag:if_user][/tag:if_user]</strong></a> |
						<a title="{#tag_if_admin#}" href="javascript:void(0);" class="topDir" onClick="textSelection_mail_tpl('[tag:if_admin]', '[/tag:if_admin]');"><strong>[tag:if_admin][/tag:if_admin]</strong></a> |
					</td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_fld_mail#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:fld:]', '');">[tag:fld:XXX]</a></strong></td>
					<td rowspan="15"><textarea name="mail_tpl" id="mail_tpl" wrap="off">{$form.mail_tpl|escape}</textarea></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_title#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:title:]', '');">[tag:title:XXX]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_docid#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:docid]', '');">[tag:docid]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_url#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:document]', '');">[tag:document]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_formtitle#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:formtitle]', '');">[tag:formtitle]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_formalias#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:formalias]', '');">[tag:formalias]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_path#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:path]', '');">[tag:path]</a></strong></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:easymail]','');" title="{#tag_easymail#}"><strong>[tag:easymail]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:uemail]','');" title="{#tag_uemail#}"><strong>[tag:uemail]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:ulogin]','');" title="{#tag_ulogin#}"><strong>[tag:ulogin]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:uname]','');" title="{#tag_uname#}"><strong>[tag:uname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:ufname]','');" title="{#tag_ufname#}"><strong>[tag:ufname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:ulname]','');" title="{#tag_ulname#}"><strong>[tag:ulname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:sitename]','');" title="{#tag_sitename#}"><strong>[tag:sitename]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_mail_tpl('[tag:sitehost]','');" title="{#tag_sitehost#}"><strong>[tag:sitehost]</strong></a></td>
				</tr>
				<tr>
					<td>HTML Tags</td>
					<td> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<ol>', '</ol>');"><strong>OL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<ul>', '</ul>');"><strong>UL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<li>', '</li>');"><strong>LI</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<strong>', '</strong>');"><strong>B</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<em>', '</em>');"><strong>I</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<h1>', '</h1>');"><strong>H1</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<h2>', '</h2>');"><strong>H2</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<h3>', '</h3>');"><strong>H3</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<h4>', '</h4>');"><strong>H4</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<h5>', '</h5>');"><strong>H5</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<span>', '</span>');"><strong>SPAN</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<pre>', '</pre>');"><strong>PRE</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('<br />', '');"><strong>BR</strong></a> | <a href="javascript:void(0);" onClick="textSelection_mail_tpl('\t', '');"><strong>TAB</strong></a> | </td>
				</tr>
			</tbody>
		</table>
	    <div class="rowElem">
			<input type="submit" class="btn basicBtn mousetrap" value="{#save#} (Ctrl+S)" />&nbsp;
			<a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}" class="btn greenBtn">{#return_to_forms#}</a>
		</div>
	</div>

	<div class="widget first">
		<div class="head closed">
			<h5 class="iFrames">{#finish_tpl#}</h5>
		</div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<colgroup>
				<col width="200">
				<col>
			</colgroup>
			<tbody>
				<tr class="noborder">
					<td><strong><a title="{#tag_docid#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:docid]', '');">[tag:docid]</a></strong></td>
					<td rowspan="11"><textarea name="finish_tpl" id="finish_tpl" wrap="off">{$form.finish_tpl|escape}</textarea></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_url#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:document]', '');">[tag:document]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_formalias#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:formalias]', '');">[tag:formalias]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_formtitle#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:formtitle]', '');">[tag:formtitle]</a></strong></td>
				</tr>
				<tr>
					<td><strong><a title="{#tag_path#}" class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:path]', '');">[tag:path]</a></strong></td>
				<tr>
					<td><a class="toprightDir" title="{#tag_media#}" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:mediapath]','');"><strong>[tag:mediapath]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:uemail]','');" title="{#tag_uemail#}"><strong>[tag:uemail]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:ulogin]','');" title="{#tag_ulogin#}"><strong>[tag:ulogin]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:uname]','');" title="{#tag_uname#}"><strong>[tag:uname]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:sitename]','');" title="{#tag_sitename#}"><strong>[tag:sitename]</strong></a></td>
				</tr>
				<tr>
					<td><a class="toprightDir" href="javascript:void(0);" onClick="textSelection_finish_tpl('[tag:sitehost]','');" title="{#tag_sitehost#}"><strong>[tag:sitehost]</strong></a></td>
				</tr>
				<tr>
					<td>HTML Tags</td>
					<td> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<ol>', '</ol>');"><strong>OL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<ul>', '</ul>');"><strong>UL</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<li>', '</li>');"><strong>LI</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<strong>', '</strong>');"><strong>B</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<em>', '</em>');"><strong>I</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<h1>', '</h1>');"><strong>H1</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<h2>', '</h2>');"><strong>H2</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<h3>', '</h3>');"><strong>H3</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<h4>', '</h4>');"><strong>H4</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<h5>', '</h5>');"><strong>H5</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<span>', '</span>');"><strong>SPAN</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<pre>', '</pre>');"><strong>PRE</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('<br />', '');"><strong>BR</strong></a> | <a href="javascript:void(0);" onClick="textSelection_finish_tpl('\t', '');"><strong>TAB</strong></a> | </td>
				</tr>
			</tbody>
		</table>
	    <div class="rowElem">
			<input type="submit" class="btn basicBtn mousetrap" value="{#save#} (Ctrl+S)" />&nbsp;
			<a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}" class="btn greenBtn">{#return_to_forms#}</a>
		</div>
	</div>

	<div class="widget first">
		<div class="head closed">
			<h5 class="iFrames">{#code#}</h5>
		</div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<tbody>
				<tr class="noborder">
					<td>{#code_info#}</td>
				</tr>
				<tr>
					<td><h6>{#code_onsubmit#}</h6></td>
				</tr>
				<tr>
					<td><textarea name="code_onsubmit" id="code_onsubmit" wrap="off">{$form.code_onsubmit|escape}</textarea></td>
				</tr>
				<tr>
					<td><h6>{#code_onvalidate#}</h6></td>
				</tr>
				<tr>
					<td><textarea name="code_onvalidate" id="code_onvalidate" wrap="off">{$form.code_onvalidate|escape}</textarea></td>
				</tr>
				<tr>
					<td><h6>{#code_onsend#}</h6></td>
				</tr>
				<tr>
					<td><textarea name="code_onsend" id="code_onsend" wrap="off">{$form.code_onsend|escape}</textarea></td>
				</tr>
			</tbody>
		</table>
	    <div class="rowElem">
			<input type="submit" class="btn basicBtn mousetrap" value="{#save#} (Ctrl+S)" />&nbsp;
			<a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}" class="btn greenBtn">{#return_to_forms#}</a>
		</div>
	</div>
	{/if}
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
		form_save ();
	});
});

// функция сохранения формы
function form_save (fields_reload, data) {
	if (data == undefined) var data = new Object();
	var form = $('#form_edit');
	data.ajax = 1;
	data.fields_reload = (fields_reload == true || $('.form_fields_new_title').val() > '') ? 1 : 0;
	var fields_appendto = $('#form_fields_appendto');
	form.ajaxSubmit({
		data: data,
		beforeSubmit: function () {
			$.alerts._overlay('show');
			if (data.fields_reload == 1) fields_appendto.css('opacity',0.3);
		},
		success: function (response) {
			if ($fid) {
				$.alerts._overlay('hide');
				$.jGrowl(form.attr('data-accept'), {theme: 'accept'});
				if (data.fields_reload == 1) fields_appendto.height(fields_appendto.height()).empty().append(response).height('auto').updateContent().css('opacity',1);
			}
			else {
				document.location.href = 'index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=form_edit&fid='+parseInt(response)+'&cp='+$sess;
			}
		},
		error: function () {
			$.jGrowl(form.attr('data-error'), {theme: 'error'});
		}
	});
}

// навешиваем функционал на пришедший аяксом контент
(function($) 
{
	$.fn.updateContent = function()
	{
		this.jqTransform({imgPath:$smarty.tpl_dir+'/images'})
		$('.topleftDir',this).tipsy({fade: false, gravity: 'se', opacity: 0.9});
		$('.toprightDir',this).tipsy({fade: false, gravity: 'sw', opacity: 0.9});
		$('.leftDir',this).tipsy({fade: false, gravity: 'e', opacity: 0.9});
		$('.rightDir',this).tipsy({fade: false, gravity: 'w', opacity: 0.9});
		$('.topDir',this).tipsy({fade: false, gravity: 's', opacity: 0.9});
		$('.botDir',this).tipsy({fade: false, gravity: 'n', opacity: 0.9});
		return this;
	}
})(jQuery);

// обработчики
$(document)
	// валидация алиаса формы
	.on('change', '#form_alias', function (e) {
		var input = $(this);
		var alias = input.val();
		if (alias > '') {
			$.ajax({
				url: 'index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=alias_validate&cp='+$sess,
				data: {
					alias: alias,
					ajax: 1,
					fid: $fid
				},
				success: function (data) {
					if (data === '1') {
						$.jGrowl(input.attr('data-accept'), {theme: 'accept'});
					}
					else if (data === 'syn') {
						$.jGrowl(input.attr('data-error-syn'), {theme: 'error'});
						alias = $fid ? $fid : '';
					}
					else {
						$.jGrowl(input.attr('data-error-exists'), {theme: 'error'});
						alias = $fid ? $fid : '';
					}
					$('#form_tag_'+$fid).val('[mod_contactsnew:'+alias+']');
				}
			});
		}
		else {
			alias = $fid ? $fid : '';
			$('#form_tag_'+$fid).val('[mod_contactsnew:'+alias+']');
		}
	})
	// кнопки добавления
	.on('click', '.addParentBtn', function (e) {
		e.preventDefault();
		var btn = $(this);
		var count = parseInt(btn.attr('data-count')) + 1;
		var content = btn.attr('data-content').replace(/%count%/g, count);
		$(this).parents(btn.attr('data-target')).eq(0).append(content);
		btn.attr('data-count',count);
	})
	// кнопки удаления
	.on('click', '.delParentBtn', function (e) {
		e.preventDefault();
		$(this).parents($(this).attr('data-target')).eq(0).remove();
	})
	// сохранение формы
	.on('submit', '#form_edit', function (e) {
		e.preventDefault();
		form_save();
	})
	// проверка email-а на валидность
	.on('change', '.email', function (e) {
		e.preventDefault();
		var email = $(this).val();
		$.ajax({
			url: 'index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=email_validate&cp='+$sess,
			data: {
				email: email,
				ajax: 1
			},
			success: function (data) {
				if (data == '1')
					$.jGrowl($smarty._email_accept, {theme: 'accept'});
				else
					$.jGrowl($smarty._email_error, {theme: 'error'});
			}
		});
	})
	// удаление поля
	.on('click', '.form_field_del', function (e) {
		e.preventDefault();
		var btn = $(this);
		jConfirm(btn.attr('data-confirm'),btn.attr('data-confirm-title'), function(b) {
			if (b) {
				var field_id = btn.attr('data-field');
				var data = new Object();
				data.field_del = new Object();
				data.field_del[field_id] = 1;
				form_save(true, data);
			}
		});
	})
	// изменение типа поля
	.on('change', '.form_field_type_change', function (e) {
		form_save(true);
	})
	// изменение настроек поля
	.on('click', ':button.form_field_switch', function (e) {
		$(this).parents('tr').eq(0).find('.defaultval').removeClass('defaultval').empty().html('<input type="button" value="'+$smarty._refresh+'" class="btn greenBtn mousetrap" onClick="form_save(true);return false;" />');
		if ($(this).hasClass('del')) {
			$(this).parents($(this).attr('data-target')).eq(0).remove();
			return false;
		}
	})
	// изменение настроек поля
	.on('change', '.form_field_switch', function (e) {
		$(this).parents('tr').eq(0).find('.defaultval').removeClass('defaultval').empty().html('<input type="button" value="'+$smarty._refresh+'" class="btn greenBtn mousetrap" onClick="form_save(true);return false;" />');
	})
	// скрыть/показать шаблон поля
	.on('click', '.form_field_tpl_btn', function (e) {
		e.preventDefault();
		var tr = $(this).parents('tr').eq(0).next('.form_field_tpl_tr');
		var input = $(this).next('.form_field_tpl_input');
		if (tr.is(':visible')) {
			tr.hide();
			input.val(0);
		}
		else {
			tr.show();
			input.val(1);
		}
	})
</script>
{/literal}

<!-- Оформляем поля в CodeMirror -->
{foreach from=$codemirror key='cdmr_id' item='cdmr_h'}
	{if $ave15}
		{include file="$codemirror_editor" ctrls='form_save();' conn_id="_$cdmr_id" textarea_id=$cdmr_id height=$cdmr_h}
	{else}
		<script>
		var editor_{$cdmr_id} = CodeMirror.fromTextArea(document.getElementById('{$cdmr_id}'), {ldelim}
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
{/foreach}
<!-- /Оформляем поля в CodeMirror -->
<script type="text/javascript">var clipboard = new Clipboard('.copyBtn');</script>