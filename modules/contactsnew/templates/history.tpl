{literal}
<style>
#forms input {
	box-sizing:border-box;
}
</style>
{/literal}

<script type="text/javascript">
// назначаем языковые переменные (так удобнее работать со smarty)
$smarty = new Array;
$smarty['stat_replied'] = '{#stat_replied#}';
$smarty['stat_viewed'] = '{#stat_viewed#}';
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
			<li>{#history#}</li>
		</ul>
	</div>
</div>
<div class="widget first">
	<div class="head">
		<h5 class="iFrames">{#history#}</h5>
		<div class="num">
		<a class="basicNum" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;cp={$sess}" target="_self">{#cn_return_list_form#}</a>
		</div>	
	</div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm" id="forms">
		<colgroup>
			<col width="100"/>
			<col/>
			<col width="1"/>
			<col width="1"/>
			<col width="60"/>
		</colgroup>
		<thead>
			<tr>
				<td>{#date#}</td>
				<td>{#mfld_subject#}</td>
				<td>{#author#}</td>
				<td>{#status#}</td>
				<td>{#cn_actions#}</td>
			</tr>
		</thead>
		<tbody>
			{foreach from=$dialogs item=dialog}
			<tr class="{if $dialog.status==='new'}green{elseif $dialog.status==='viewed'}yellow{/if}">
				<td align="right" nowrap="nowrap">
					<span class="date_text dgrey">{$dialog.date|date_format:$TIME_FORMAT|pretty_date}</span>
				</td>
				<td>
					<strong><a class="toprightDir" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_dialog&amp;hid={$dialog.id}&amp;cp={$sess}" title="{#look#}">{$dialog.subject|stripslashes|escape}</a></strong>
				</td>
				<td>
					<a href="mailto:{$dialog.email}" title="{#write_email#}" class="topDir">{$dialog.email}</a>
				</td>
				<td nowrap="nowrap">
					{if $dialog.status!='replied'}
						<select style="width:300px" class="dialog_status" data-hid="{$dialog.id}" onChange="status_change($(this));">
							{if $dialog.status=='new'}<option value="">{#stat_new#}</option>{/if}
							<option value="viewed">{#stat_viewed#}</option>
							<option value="replied">{#stat_replied#}</option>
						</select>
					{else}{#stat_replied#}
					{/if}
				</td>
				<td align="center">
					<a class="topleftDir icon_sprite ico_delete ConfirmDelete" dir="{#deleting#}" name="{#cn_del_mail#}" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=email_del&amp;hid={$dialog.id}&amp;fid={$fid}&amp;cp={$sess}" title="{#delete#}"></a>
				</td>	
			</tr>
			{foreachelse}
			<tr>
				<td colspan="5">
					<ul class="messages">
						<li class="highlight yellow">{#cn_not_mail#}</li>
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

{literal}
<script type="text/javascript">
function status_change (sel) {
	var status = sel.val();
	var td = sel.parents('td');
	var hid = sel.attr('data-hid');
	$.ajax({
		url: 'index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=dialog_status',
		type: 'POST',
		data: {
			hid: hid,
			status: status,
			ajax: 1
		},
		beforeSend: function() {
			$.alerts._overlay('show');
		},
		success: function(e) {
			$.alerts._overlay('hide');
			td.empty();
			if (status === 'replied') {
				td.text($smarty['stat_replied']);
				td.parent().removeClass('yellow');
			}
			else if (status === 'viewed') {
				td.parent().removeClass('green').addClass('yellow');
				$('<select class="dialog_status" data-hid="'+hid+'" onChange="status_change($(this));"><option value="viewed">'+$smarty['stat_viewed']+'</option><option value="replied">'+$smarty['stat_replied']+'</option></select>').appendTo(td).jqTransform({imgPath: "../images"}).styler({selectVisibleOptions: 5,selectSearch: false});
			}
		}
	});
};
</script>
{/literal}