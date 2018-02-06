<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}
	$(".AddGmap").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#NewGmap#}';
			var text = '{#EmptyGmapTitle#}';
			$.alerts._overlay('show');
			$("#add_gmap").submit();
		{rdelim});

{rdelim});
</script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key={$api_key}&amp;libraries=places"></script> 
<script language="Javascript" type="text/javascript">
function searchAdress() {ldelim}
		var input = document.getElementById('gmap_address');
		var autocomplete = new google.maps.places.Autocomplete(input);
		google.maps.event.addListener(autocomplete, 'place_changed', function () {ldelim}
			var place = autocomplete.getPlace();

			var lat = place.geometry.location.lat();
			var lon = place.geometry.location.lng();

			document.getElementById('latitude').value = lat;
			document.getElementById('longitude').value = lon;
		{rdelim});
	{rdelim}
google.maps.event.addDomListener(window, 'load', searchAdress);	
</script>
<div class="title"><h5>{#ModName#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
    <ul>
		<li>{#ModTitle#}</li>
		<li style="margin-top: 10px;">{if $api_key !=''}<a style="cursor: default;" class="btn greenBtn" href="javascript:void(0);">{#Gmap_api_key#} <i style="text-transform: none;">{$api_key}</i></a>{else}<a class="topDir btn redBtn" title="{#Gmap_link_set_api_key#}" href="index.php?do=settings&sub=case&cp={$sess}">{#Gmap_api_key_no#}</a>&nbsp;&nbsp; <a class="topDir btn blueBtn" title="{#Gmap_link_get_api_info#}" href="https://developers.google.com/maps/documentation/javascript/get-api-key#key" target="_blank">{#Gmap_link_get_api_key#}</a>{/if}</li>
	</ul>	
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#ModName#}</li>
	    </ul>
	</div>
</div>
{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}

<div class="widget first">
	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">{#GmapList#}</a></li>
	    <li class=""><a href="#tab2">{#NewGmap#}</a></li>
	</ul>

		<div class="tab_container">
			<div id="tab1" class="tab_content" style="display: block;">
<form action="" method="post" class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings">

			<colgroup>
			    <col width="*">
				<col width="200">
				<col width="200">
				<col width="210">
				<col width="200">
				<col width="1">
			</colgroup>
			<thead>
	
  <tr class="noborder">
    	<td>{#GmapTitle#}</td>
    	<td>{#CpTag#}</td>
    	<td colspan="4">{#Actions#}</td>
    </tr>
   
		   </thead>
		 <tbody>    
			<form action="" method="post" class="mainForm">
            {foreach from=$gmaps item=gmap}
                <tr>
					<td align="center">
						{if $gmap.markers_count > 0}
							<strong class="docname"><a class="topDir" title="{#MarkerView#}" href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=showmarkers&id={$gmap.id}&cp={$sess}&compile=1">{$gmap.gmap_title|escape}</a></strong>
						{else}
							<strong>{$gmap.gmap_title|escape}</strong>
						{/if}
					</td>
					<td align="center">
						<div class="pr12" style="display: table; position: relative; text-align: right;">
						<input style="width: 130px;" id="tgmap_{$gmap.id}" name="textfield" type="text" readonly value="[mod_gmap:{$gmap.id}]" size="17" />
						<a style="text-align: center; padding: 5px 3px 4px 3px;" class="whiteBtn copyBtn topDir" href="javascript:void(0);" data-clipboard-action="copy" data-clipboard-target="#tgmap_{$gmap.id}" title="{#Gmap_copy_buf#}">
					    <img style="margin-top: -3px; position: relative; top: 4px; padding: 0 3px;" class="clippy" src="{$ABS_PATH}admin/templates/images/clippy.svg" width="13"></a>
					    </div>
					</td>
					<td align="center">
						<div align="center">
							{if $gmap.marker_count > 0}
								<a style="cursor: default;" class="btn greenBtn" href="javascript:void(0);">{#Gmap_marcount_yes#}{$gmap.marker_count}</a>
							{else}<a style="cursor: default;" class="btn redBtn" href="javascript:void(0);">{#Gmap_marcount_no#}</a>{/if}
						</div>
					</td>
					<td align="center">
						<a class="btn blueBtn" href="index.php?do=modules&amp;action=modedit&amp;mod=gmap&amp;moduleaction=show&amp;id={$gmap.id}&amp;cp={$sess}">{#Gmap_maredit#}</a>
					</td>
					<td align="center">
						<a class="btn greyishBtn" href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=editgmap&id={$gmap.id}&cp={$sess}">{#Gmap_mapedit#}</a>
					</td>
					<td align="right">
						<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#DeleteGmap#}" dir="{#DeleteGmap#}" name="{#DeleteGmapC#}" href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=delgmap&id={$gmap.id}&cp={$sess}"></a>
					</td>
				</tr>
            {/foreach}
				{if !$gmaps}
				<tr>
					<td colspan="6">
					<ul class="messages">
						<li class="highlight yellow">{#GmapNoItems#}</li>
					</ul>
					</td>
				</tr>
				{/if}
			</form>
    </tbody>
</table>
</form>

            </div>

            <div id="tab2" class="tab_content" style="display: none;">
			    <form id="add_gmap" name="add_gmap" class="mainForm">
                	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr class="noborder">
                			<td width="180">{#GmapTitle#}</td>
                			<td>
                				<input placeholder="{#GmapTitle#}" name="gmap_title" type="text" id="gmap_title" value="" style="width:300px" />
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapHeight#}</td>
                			<td>
                				<input placeholder="{#GmapHeight#}" name="gmap_height" type="text" id="gmap_height" value="400px" style="width:300px" />
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapWidth#}</td>
                			<td>
                				<input placeholder="{#GmapWidth#}" name="gmap_width" type="text" id="gmap_width" value="100%" style="width:300px" />
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapMainAddress#}</td>
                			<td>
                				<input placeholder="{#GmapMainAddress#}" name="gmap_address" type="text" id="gmap_address" value="" style="width:300px" />
								<input name="latitude" type="hidden" id="latitude" value=""/>
								<input name="longitude" type="hidden" id="longitude" value=""/>
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapZoom#}</td>
                			<td>
                				<input placeholder="{#GmapZoom#}" name="gmap_zoom" type="text" id="zoom" value="10" style="width:300px" />
                			</td>
                		</tr>
						<tr>
                			<td colspan="2">
                				<div class="pr12" style="display: table; padding: 5px 0px 5px 0px;">
                				<a id="btn_agsub" class="btn blueBtn" href="javascript:void(0);">{#ButtonAdd#}</a>
                                </div>
                			</td>
                		</tr>
                	</table>
			    </form>
			</div>

        </div>
<div class="fix"></div>
</div>
{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}
<script type="text/javascript">var clipboard = new Clipboard('.copyBtn');</script>

    <script type="text/javascript" language="javascript">
     	$("#btn_agsub").on('click', function agcall() {ldelim}
     	  var msg   = $('#add_gmap').serialize();
            $.ajax({ldelim}
              type: 'POST',
              url: '{$formaction}',
              data: msg,
              success: function(data) {ldelim}
              $.jGrowl("{#SaveSuccess#}", {ldelim}
			  header: '{#SentData#}',
			  theme: 'accept'
			  {rdelim});
              document.location.href = "index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}";
              {rdelim},
              error:  function(xhr, str){ldelim}
              $.jGrowl("{#SaveError#}", {ldelim}
			  header: '{#SentData#}',
			  theme: 'error'
		      {rdelim}); 
              {rdelim}
            {rdelim});
     
        {rdelim});
    </script>