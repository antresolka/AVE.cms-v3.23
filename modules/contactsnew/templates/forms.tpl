{literal}
<style>
#forms input {
	box-sizing:border-box;
}
</style>
{/literal}
<div class="title">
	<h5>{#contacts#}</h5>
</div>
<div class="widget" style="margin-top:0">
	<div class="body">
		<ul style="list-style: none; margin-left:0px;">
			<li>{#mod_info#}</li>
			<li><strong>{#cn_mod_info#}<a class="doclink" href="index.php?do=settings&amp;cp={$sess}">{#cn_mod_info_a#}</a></strong></li>
		</ul>
	</div>
</div>
<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
		<ul>
			<li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}" class="toprightDir"></a></li>
			<li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
			<li><a href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}">{#contacts#}</a></li>
			<li><strong class="code">{#forms#}</strong></li>
		</ul>
	</div>
</div>
<div class="widget first">
	<div class="head">
		<h5 class="iFrames">{#forms#}</h5>
		<div class="num">
			<a class="basicNum" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_edit&amp;cp={$sess}" target="_self">{#form_new#}</a>
		</div>
	</div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm" id="forms">
		<colgroup>
			<col width="1">
			<col>
			<col width="1">
			<col width="1">
			<col width="1">
			<col width="1">
			<col width="1">
			<col width="1">
			<col width="1">
			<col width="1">
		</colgroup>
		<thead>
			<tr>
				<td>ID</td>
				<td>{#title#}</td>
				<td colspan="4">{#cn_status#}</td>
				<td>{#tag#}</td>
				<td colspan="3">{#actions#}</td>
			</tr>
		</thead>
		<tbody>
			{foreach from=$forms item=form}
			<tr>
				<td align="center">{$form.id}</td>
				<td align="center">
					<strong><a class="toprightDir" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_edit&amp;fid={$form.id}&amp;cp={$sess}" title="{#edit#}">{$form.title|stripslashes|escape}
					</a></strong>
				</td>
				<td nowrap="nowrap">{if $form.history_new > 0}<strong><a class="topDir doclink btn redBtn" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_list&amp;fid={$form.id}&amp;cp={$sess}" title="{#look#}">{#list_new#}: {$form.history_new}</a></strong>{else}<a class="btn whiteBtn" style="cursor: default" href="javascript:void(0);">{#list_new#}: {$form.history_new}{/if}</a></td>
				<td nowrap="nowrap"><a style="cursor: default" class="btn blueBtn" href="javascript:void(0);">{#list_viewed#}: {$form.history_viewed}</a></td>
				<td nowrap="nowrap"><a style="cursor: default" class="btn greenBtn" href="javascript:void(0);">{#list_replied#}: {$form.history_replied}</a></td>
				<td nowrap="nowrap"><a title="{#cn_count_messages#}{$form.history_new+$form.history_viewed+$form.history_replied}" class="topDir btn greyishBtn" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_list&amp;fid={$form.id}&amp;cp={$sess}">{#cn_view#}</a></td>
				<td>
				    <div class="pr12" style="display: table">
					<input type="text" id="form_tag_{$form.id}" value="[mod_contactsnew:{if $form.alias}{$form.alias}{else}{$form.id}{/if}]" style="width:180px; display: table-cell" readonly class="mousetrap" />
					<a style="display: table-cell; text-align: center" class="whiteBtn copyBtn topDir" href="javascript:void(0);" data-clipboard-action="copy" data-clipboard-target="#form_tag_{$form.id}" title="{#cn_copy_to_clipboard#}">
					<img style="margin-top: -3px; position: relative; top: 4px; padding: 0 3px;" class="clippy" src="{$ABS_PATH}admin/templates/images/clippy.svg" width="13"></a>
				    </div>
				</td>
				<td align="center">
					<a class="topDir icon_sprite ico_edit" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_edit&amp;fid={$form.id}&amp;cp={$sess}" title="{#edit#}"></a>
				</td>
				<td align="center">
					<a class="topleftDir icon_sprite ico_copy" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_copy&amp;fid={$form.id}&amp;cp={$sess}" title="{#copy#}"></a>
				</td>
				<td align="center">
					<a class="topleftDir icon_sprite ico_delete ConfirmDelete" dir="{#deleting#}" name="{#form_deleting#}" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=form_del&amp;fid={$form.id}&amp;cp={$sess}" title="{#delete#}"></a>
				</td>
			</tr>
			{foreachelse}
			<tr>
				<td colspan="10">
					<ul class="messages">
						<li class="highlight yellow">{#noforms#}</li>
					</ul>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div>
{if $page_nav}
<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
</div>
{/if}
<script type="text/javascript">var clipboard = new Clipboard('.copyBtn');</script>