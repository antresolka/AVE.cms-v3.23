{foreach from=$gmarkers item=gmarker}
<div class="title"><h5>{#ModName#} - {#MarkerAdress_e_brc#}{$gmarker.id}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		<span style=" position: relative; top: -10px;">{#MarkerAdress_m_e#}</span> <img src='/modules/gmap/images/{$gmarker.image}.png'>
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#MarkerView#}</li>
	        <li><strong class="code">{#MarkerAdress_e_brc#}{$gmarker.id}</strong></li>
	    </ul>
	</div>
</div>


<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<col width="250">
		<col>
        <thead>
		<tr>
			<td><h5 class="iFrames">{#MarkerParam#}</h5></td>
			<td><h5 class="iFrames">{#MarkerSetVal#}</h5></td>
		</tr>
        </thead>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#MarkerAdress_not#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_narker_edit_not#}">&nbsp;</span></td>
			<td nowrap="nowrap">
				<input disabled class="mousetrap" name="address_e" type="text" id="marker_address_e" value="" size="40" style="width:500px" />&nbsp;&nbsp;
				<input name="latitude_e" type="hidden" id="lat_e" value="{$gmarker.latitude}"/>
				<input name="longitude_e" type="hidden" id="long_e" value="{$gmarker.longitude}"/>
			</td>
		</tr>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#MarkerDesc#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_link_category#}">&nbsp;</span></td>
			<td nowrap="nowrap">
                <input readonly class="mousetrap" name="marker_cat_title_e" type="text" id="marker_cat_title_e" placeholder="{#Markercat_h#}" value="{$gmarker.marker_cat_title}" style="width:500px" />
                <input type="hidden" name="marker_cat_link_e" id="marker_cat_link_e" value="{$gmarker.marker_cat_link}" />
                <input type="hidden" name="marker_cat_id_e" id="marker_cat_id_e" value="{$gmarker.marker_cat_id}" />&nbsp;
                <select name="category_e" id="category_e" style="width: 300px;">
				<option value="">{#Gmap_cat_sel#}</option>
				{foreach from=$gcats item=gcat}
			    <option value="{$gcat.id}" data-link="{$gcat.gcat_link}">{$gcat.gcat_title|escape}</option>
			    {/foreach}
			    </select>&nbsp;&nbsp;
			    <a class="button redBtn" href="javascript:void(0);" onclick="GetCategoryE()">{#Gmap_cat_cnf#}</a>&nbsp;
			</td>
		</tr>		
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_doc_title#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_link_single_marker#}">&nbsp;</span></td>
			<td>
     			<input class="mousetrap" name="marker_title_e" type="text" id="marker_title_e" placeholder="{#Gmap_doc_title#}" value="{$gmarker.title}" style="width:500px" />&nbsp;
     			<input type="hidden" name="title_link_e" id="title_link_e" value="{$gmarker.title_link}" />
				<input onclick="openLinkWindowSelectE('');" type="button" class="basicBtn greenBtn" value="{#Gmap_btn_doc_title#}" />
			</td>
		</tr>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_img_title#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_link_single_image#}">&nbsp;</span></td>
			<td>
               <div style="" id="feld__i_e">
               <img style="" id="_img_feld__i_e" src="{$gmarker.img_title}" alt="" border="0" width="64" height="64" />
               </div>
               <div style="" id="span_feld__i_e"></div>
               <input class="mousetrap" type="text" style="width: 500px;" placeholder="{#Markerimg_t#}" name="img_feld__i_e" value="{$gmarker.img_title}" id="img_feld__i_e" />&nbsp;
               <input value="{#Gmap_load_img_title#}"" class="basicBtn" type="button" onclick="browse_uploads('img_feld__i_e', '', '', '0');" />&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2"><h5 class="iFrames">{#Gmap_cat_inf_dop#}</h5></td>
		</tr>		
		<tr id="tr_city_e">
		    {if $gmarker.marker_city !=''}
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_tn#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_narker_edit_not#}">&nbsp;</span></td>
			<td>
				<input disabled="disabled" class="mousetrap" name="marker_city_e" type="text" id="marker_city_e" value="{$gmarker.marker_city}" placeholder="{#Gmap_cat_inf_tp#}" style="width:250px" />
			</td>
			{else}
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_t#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_cat_inf_tt#}">&nbsp;</span></td>
			<td>
				<input class="mousetrap" name="marker_city_e" type="text" id="marker_city_e" value="{$gmarker.marker_city}" placeholder="{#Gmap_cat_inf_tp#}" style="width:250px" />
			</td>
			{/if}
		</tr>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_st#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_mar_key_street#}">&nbsp;</span></td>
			<td>
				<input class="mousetrap" name="marker_street_e" type="text" id="marker_street_e" value="{$gmarker.marker_street}" placeholder="{#Gmap_cat_inf_stp#}" style="width:250px" />
			</td>
		</tr>
		<tr>
			<td>{#Gmap_cat_inf_bi#}</td>
			<td>
				<input class="mousetrap" name="marker_building_e" type="text" id="marker_building_e" value="{$gmarker.marker_building}" placeholder="{#Gmap_cat_inf_blp#}" style="width:250px" />
			</td>
		</tr>
		<tr>
			<td>{#Gmap_cat_inf_ap#}</td>
			<td>
				<textarea cols="20" wrap="hard" class="mousetrap" name="marker_dopfield_e" type="text" id="marker_dopfield_e" value="{$gmarker.marker_dopfield}" placeholder="{#Gmap_cat_inf_dopfi#}" style="width:250px; word-wrap: inherit;">{$gmarker.marker_dopfield}</textarea>
			</td>
		</tr>
		<tr>
			<td>{#Gmap_cat_inf_phone#}</td>
			<td>
				<input class="mousetrap" name="marker_phone_e" type="text" id="marker_phone_e" value="{$gmarker.marker_phone}" placeholder="{#Gmap_cat_inf_telp#}" style="width:250px" />
			</td>
		</tr>	
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_www#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_cat_inf_wwwi#}">&nbsp;</span></td>
			<td>
				<input class="mousetrap" name="marker_www_e" type="text" id="marker_www_e" value="{$gmarker.marker_www}" placeholder="{#Gmap_cat_inf_wwwf#}" style="width:250px" />
			</td>
		</tr>			
												
		<tr>
    		<td colspan="2">
    			<input type="button" onclick="editSaveMarker();" value="{#Gmap_mar_editsave#}" class="basicBtn" />&nbsp;&nbsp;
    			<a href="javascript:void(0);" onclick="ClearAllField();" class="btn redBtn">{#Gmap_field_reset#}</a>&nbsp;&nbsp;
    			<a href="index.php?do=modules&amp;action=modedit&amp;mod=gmap&amp;moduleaction=show&amp;id={$gmarker.gmap_id}&amp;cp={$sess}" class="btn greenBtn" >{#Gmap_mar_map_ret#}</a>
    		</td>
    	</tr>
</table>

{/foreach}

		<script type="text/javascript">
		// Функция обнуления значений всех доступных полей
		function ClearAllField()
        {ldelim}
        $('#marker_title_e').val('');
		$('#title_link_e').val('');
		$('#marker_cat_title_e').val('');
		$('#marker_cat_link_e').val('');
		$('#marker_cat_id_e').val('');
        $('#img_feld__i_e').val('');
        $('#_img_feld__i_e').attr('src','');
        $('#marker_street_e').val('');
        $('#marker_building_e').val('');
        $('#marker_dopfield_e').val('');
        $('#marker_phone_e').val('');
        $('#marker_www_e').val('');
		{rdelim};
		// Обнуляем значения полей категорий при вводе с клавиатуры
		$('#marker_cat_title_e').focus(function(){ldelim}
		$('#marker_cat_title_e').val('');
		$('#marker_cat_link_e').val('');
		$('#marker_cat_id_e').val('');		
		{rdelim});
		// Обнуляем значения полей Связать с документом при вводе с клавиатуры
		$('#marker_title_e').focus(function(){ldelim}
        $('#marker_title_e').val('');
		$('#title_link_e').val('');		
		{rdelim});	
		// Функция выбора категории выпадающим списком
		function GetCategoryE()
        {ldelim}
		$('#marker_cat_title_e').val('');
		$('#marker_cat_link_e').val('');
		$('#marker_cat_id_e').val('');        
        // получаем индекс выбранного элемента
  	    var selind_e = document.getElementById("category_e").options.selectedIndex;
        var txt_e= document.getElementById("category_e").options[selind_e].text;
        var val_e= document.getElementById("category_e").options[selind_e].value;
		var link_e= $(':selected', document.getElementById("category_e")).data('link');
        if (link_e == undefined) {ldelim}
        //alert('{#Gmap_cat_cs#}');	
        $('#marker_cat_title_e').val('');
        $('#marker_cat_link_e').val('');
        $('#marker_cat_id_e').val(val_e);
        {rdelim} else {ldelim}
        $('#marker_cat_title_e').val(txt_e);
        $('#marker_cat_link_e').val(link_e);
        $('#marker_cat_id_e').val(val_e);
        {rdelim}
        {rdelim}
		</script>
<script>
            function editSaveMarker(){ldelim}

				var latitude_e = $('#lat_e').val();
				var longitude_e = $('#long_e').val();
				var marker_title_e = $('#marker_title_e').val();
			    if ($('#title_link_e').val() =='')
			    	{ldelim} var title_link_e = 'javascript:void(0);'; {rdelim}
                else 
                	{ldelim} var title_link_e = $('#title_link_e').val(); {rdelim};
				var marker_cat_title_e = $('#marker_cat_title_e').val();
				if ($('#marker_cat_link_e').val() =='')
					{ldelim} var marker_cat_link_e = 'javascript:void(0);'; {rdelim}
				else
				    {ldelim} var marker_cat_link_e = $('#marker_cat_link_e').val(); {rdelim}; 
				var marker_cat_id_e = $('#marker_cat_id_e').val();
				if ($('#img_feld__i_e').val() !='')
                {ldelim} var img_feld__i_e = $('#img_feld__i_e').val(); {rdelim}
                else
                {ldelim} var img_feld__i_e = '/modules/gmap/img/no_image.png'; {rdelim};	
                var marker_city_e = $('#marker_city_e').val();
                var marker_street_e = $('#marker_street_e').val();
                var marker_building_e = $('#marker_building_e').val();
                var marker_dopfield_e = $('#marker_dopfield_e').val();
                var marker_phone_e = $('#marker_phone_e').val();
                var marker_www_e = $('#marker_www_e').val();
                var image = '{$gmarker.image}';
                if (marker_city_e !='') {ldelim}			
						var markerDataE = {ldelim}
					        'id': {$gmarker.id},
                            'latitude': latitude_e,
                            'gmap_id': {$gmarker.gmap_id},
                            'longitude': longitude_e,
                            'image': image,
                            'title': marker_title_e,
                            'title_link': title_link_e,
                            'marker_cat_title': marker_cat_title_e,
                            'marker_cat_link': marker_cat_link_e,
                            'marker_cat_id': marker_cat_id_e,
                            'img_title': img_feld__i_e,
                            'marker_city': marker_city_e,
                            'marker_street': marker_street_e,
                            'marker_building': marker_building_e,
                            'marker_dopfield': marker_dopfield_e,
                            'marker_phone': marker_phone_e,
                            'marker_www': marker_www_e,
                        {rdelim};
         
                        
                        $.ajax({ldelim}
                            type: 'POST',			
                            url: 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=saveeditmarker&id={$gmarker.id}&cp={$sess}',
                            data: {ldelim}
                                e_marker: markerDataE
                            {rdelim},
                            dataType: 'json',
                            async: false,
                            success: function(result){ldelim}
                            $.jGrowl("{#Gmap_sv_mark1#}", {ldelim}
			                header: '{#Gmap_sv_mark#}',
			                theme: 'accept'
			                {rdelim});
			                
                            $('#tr_city_e').html("<td><span style=\"float: left; margin-right: 5px;\">{#Gmap_cat_inf_tn#}</span><span style=\"cursor: help; float: left;\" class=\"toprightDir icon_sprite ico_info\" title=\"{#Gmap_narker_edit_not#}\">&nbsp;</span></td><td><input disabled=\"disabled\" class=\"mousetrap\" name=\"marker_city_e\" type=\"text\" id=\"marker_city_e\" value=\"{$gmarker.marker_city}\" placeholder=\"{#Gmap_cat_inf_tp#}\" style=\"width:250px\" /></td>");
                           var marker_ci =result['marker_city'];
                           $('#marker_city_e').val(marker_ci);
                            {rdelim}
                        {rdelim});
                  						    
                    {rdelim}else {ldelim}
                        alert("{#Gmap_not_mark_t#}");
                    {rdelim};
            
            {rdelim}	
</script>

<script>
	function openLinkWindowSelectE(target, doc) {ldelim}
	$('#marker_title_e').val('');
	$('#title_link_e').val('');
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

	$.fn.fromDocList = function set_value(target_id, doc_id, id) {ldelim}
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
$('#marker_title_e').val(data.document_title);
$('#title_link_e').val(data.document_alias);
{rdelim}
{rdelim});
	{rdelim};
</script>
