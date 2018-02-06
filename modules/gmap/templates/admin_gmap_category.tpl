{literal}
<style type="text/css">
.gmnone {
	display: none;
}
</style>
{/literal}
<div class="title"><h5>{#ModName#}</h5></div>
<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#Gmap_warndelcat1#}
    </div>
</div>
<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
		<ul>
			<li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
			<li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
			<li><a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
			<li><strong class="code">{#Gmap_cat_edit#}</strong></li>
		</ul>
	</div>
</div>
<div class="widget first">
<div class="head"><h5 class="iFrames">{#Gmap_cat_list#}</h5></div>




<table width='100%' border='1' cellspacing='0' cellpadding='0' class="tableStatic mainForm"><tr>
{foreach from=$gcats item=gcat key=k}
<td  width="25%" id="gcatst_{$gcat.id}">{$gcat.gcat_title}<a id="gcatsa_{$gcat.id}" style="float: right;" class="gcatclick topleftDir icon_sprite ico_delete" href="javascript:void(0);" data-id="{$gcat.id}" title="{#Gmap_cat_del#}"></a></td>            
{if $k%4 == 3}</tr><tr>{/if}
{/foreach}
</tr></table>
</div>
<div style="text-align: center; padding-top: 10px; padding-bottom: 0px;" id="results"></div>
<div class="widget first">
<table cellspacing="0" width="100%" class="tableStatic mainForm">
	<tbody>
		<tr>
		 <td width="110">{#Gmap_cat_add#}</td>
			<td>
				<div class="pr12">
					<input class="mousetrap" name="gcatnewadd" type="text" id="gcatnewadd" placeholder="{#Gmap_cat_name#}" value="" size="40" style="width: 300px;" />
					<input type="hidden" name="gct_link" id="gct_link" value="" />&nbsp;&nbsp;
					<input id ="gdc" onclick="openLinkWindowSelect('');" type="button" class="basicBtn greenBtn" value="{#Gmap_btn_doc_title#}" />&nbsp;&nbsp;
					<a class="button redBtn" href="javascript:void(0);" onclick="newCategory();">{#Gmap_cat_save#}</a>&nbsp;&nbsp;
					<a class="btn blueBtn" href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=show&id={$smarty.request.id}&cp={$sess}">{#Gmap_mar_map_retry#}</a>
					<a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}" class="btn greyishBtn"/>{#Gmap_return#}</a>
					
				</div>
			</td>
			</tr>
		</tbody>
	</table>
</div>


<script type="text/javascript">

		// Обнуляем значения полей категорий при вводе с клавиатуры
		$('#gcatnewadd').focus(function(){ldelim}
		$('#gcatnewadd').val('');
		$('#gct_link').val('');
		{rdelim});

	//Создание новой категории
        function newCategory(){ldelim}
				
		var gcatnewadd = $('#gcatnewadd').val();
		var gct_link = $('#gct_link').val();
        // check response status
        if (gcatnewadd !='') {ldelim}			
		var categoryData = {ldelim}
        'gcatnewadd': gcatnewadd,
        'gct_link': gct_link,
        {rdelim};

        $.ajax({ldelim}
        type: 'POST',			
        url: 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=addnewcategory&cp={$sess}',
        data: {ldelim}
        category: categoryData
        {rdelim},
        dataType: 'json',
        async: false,
        success: function(result){ldelim}
        $.jGrowl("{#Gmap_cat_in#}", {ldelim}
		header: '{#Gmap_cat_i#}',
		theme: 'accept'
		{rdelim});
        var gcat_id = result['id'];
        var gcat_title = "<span style='font-size:12px; padding:5px;' class="+"'link highlight green'><strong style='font-size:16px; position:relative; top:2px; color:orange;'>+</strong> <strong>{#Gmap_cat_nca#}</strong> <strong><i class='link'>"+result['gcat_title']+"</i></strong></span>"+"<br><br>";
        $('#results').prepend(gcat_title);
                                
        {rdelim}
        {rdelim});
        //add marker to list
					    
        {rdelim}else {ldelim}
        alert("Заполните поле название категории");
        {rdelim};
        $('#gcatnewadd').val('');
        $('#gct_link').val('');

        {rdelim}

       // УДАЛЯЕМ КАТЕГОРИИ

  $('.gcatclick').on('click', function() {ldelim}
  	    var sess = '{$sess}';
  	    var sid = $(this).attr('data-id');
  	   // alert(sid);
        var url = "index.php?do=modules&action=modedit&mod=gmap&moduleaction=gcatdel&id=" + sid + "&cp=" + sess;
        //alert(url);
        if (confirm('{#Gmap_cat_delconf#}')) {ldelim}
        $.ajax({ldelim}
        url:     url + '?ajax=1',
        success: function(data){ldelim}
        $("#gcatst_"+data).addClass('gmnone');
        $.jGrowl("{#Gmap_cat_ind#}", {ldelim}
		header: '{#Gmap_cat_i#}',
		theme: 'accept'
		{rdelim});
        {rdelim}
        {rdelim});
        // Предотвращаем дефолтное поведение
        return false;
        {rdelim} else {ldelim}
        //alert("Вы нажали кнопку отмена")
        {rdelim}
        {rdelim});    
</script>

<script>
	function openLinkWindowSelect(target, doc) {ldelim}
	if (typeof width == 'undefined' || width == '') var width = screen.width * 0.8;
	if (typeof height == 'undefined' || height == '') var height = screen.height * 0.6;
	if (typeof doc == 'undefined') var doc = 'title';
	if (typeof scrollbar == 'undefined') var scrollbar = 1;
	var sess = '{$sess}';
	var abs_path = '{$ABS_PATH}';
	var left = ( screen.width - width ) / 2;
	var top = ( screen.height - height ) / 2;
	window.open('index.php?doc=' + doc + '&target=' + target + '&do=docs&action=showsimple&function=1&pop=1&cp=' + sess, 'pop', 'left=' + left + ', top=' + top + ', width=' + width + ', height=' + height + ', scrollbars=' + scrollbar + ', resizable=1');
{rdelim}
	$.fn.fromDocList = function set_value(target_id, doc_id) {ldelim}
    var sess = '{$sess}';
	var abs_path = '{$ABS_PATH}';
    		$.ajax ({ldelim}
			url: 'index.php?do=navigation&cp=' + sess,
			type: 'POST',
			dataType: 'JSON',
			data: {ldelim}
				'action':'itemeditid',
				'doc_id': doc_id
			{rdelim},

	success: function(data){ldelim}
$('#gcatnewadd').val(data.document_title);
$('#gct_link').val(data.document_alias);
{rdelim}
{rdelim});
	{rdelim};
</script>




