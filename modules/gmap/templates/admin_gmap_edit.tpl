{literal}
<style type="text/css">
.not-vis {display: none;}
</style>
{/literal}

<div class="title"><h5>{#ModName#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#ModSettingGalT#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#GmapEdit#}</li>
	        <li><strong class="code">{$gmap.gmap_title|escape}</strong></li>
	    </ul>
	</div>
</div>



<form class="mainForm"  name="gmap_form" id="gmap_form" >
<div class="widget first">
<div class="head">
<h5 class="iFrames">{#GmapEdit#}</h5>
</div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr class="noborder">
                			<td width="180">{#GmapTitle#}</td>
                			<td>
                				<input placeholder="{#GmapTitle#}" name="gmap_title" type="text" id="gmap_title" value="{$gmap.gmap_title|escape}" style="width:300px" />
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapWidth#}</td>
                			<td>
                				<input placeholder="{#GmapWidth#}" name="gmap_width" type="text" id="gmap_width" value="{$gmap.gmap_width}" style="width:300px" />
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapHeight#}</td>
                			<td>
                				<input placeholder="{#GmapHeight#}" name="gmap_height" type="text" id="gmap_height" value="{$gmap.gmap_height}" style="width:300px" />
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapMainAddress#}</td>
                			<td>
                				<input placeholder="{#GmapMainAddress#}" name="gmap_address" type="text" id="gmap_address" value="" style="width:300px" />
								<input name="latitude" type="hidden" id="latitude" value="{$gmap.latitude}" style="width:100px"/>
								<input name="longitude" type="hidden" id="longitude" value="{$gmap.longitude}" style="width:100px"/>
                			</td>
                		</tr>
						<tr class="noborder">
                			<td width="180">{#GmapZoom#}</td>
                			<td>
                				<input placeholder="{#GmapZoom#}" name="gmap_zoom" type="text" id="zoom" value="{$gmap.gmap_zoom}" style="width:300px" />
                			</td>
                		</tr>
						<tr>
                			<td colspan="2">
                				<div class="pr12" style="display: table; padding: 5px 0px 5px 0px;">
                				<a id="btn_gsub" class="btn blueBtn" href="javascript:void(0);">{#Gmap_esave#}</a>
                				<span id="results" class="">
                				<a id="btn_lngsub" class="btn greenBtn" href="index.php?do=modules&amp;action=modedit&amp;mod=gmap&amp;moduleaction=show&amp;id={$gmap.id}&amp;cp={$sess}">{#Gmap_edit#}</a>
                				<a id="btn_lrgsub" class="btn greyishBtn" href="index.php?do=modules&amp;action=modedit&amp;mod=gmap&amp;moduleaction=1&amp;cp={$sess}">{#Gmap_return#}</a>
                		        </span>
                				</div>
                				
                			</td>
                		</tr>
                	</table>
</div>
</form>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key={$api_key}&amp;libraries=places"></script> 
<script language="Javascript" type="text/javascript">
function searchByLng() {ldelim}
		geocoder = new google.maps.Geocoder();
		var latitude = $('#latitude').val();
		var longitude = $('#longitude').val();
		var latlng = new google.maps.LatLng(latitude, longitude);
		geocoder.geocode({ldelim}
			'latLng': latlng
			{rdelim}, function (results, status) {ldelim}
			if (status === google.maps.GeocoderStatus.OK) {ldelim}
			  if (results[1]) {ldelim}
				document.getElementById('gmap_address').value = results[1].formatted_address;
			  {rdelim} else {ldelim}
				document.getElementById('gmap_address').value = '';
			  {rdelim}
			{rdelim} else {ldelim}
			  alert('Geocoder failed due to: ' + status);
			{rdelim}
		  {rdelim});
		
		
		
{rdelim}
google.maps.event.addDomListener(window, 'load', searchByLng);	
</script>
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

    <script type="text/javascript" language="javascript">
     	$("#btn_gsub").on('click', function gcall() {ldelim}
     	  var msg   = $('#gmap_form').serialize();
            $.ajax({ldelim}
              type: 'POST',
              url: 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=editgmap&id={$smarty.request.id|escape}&cp={$sess}&sub=save',
              data: msg,
              success: function(data) {ldelim}
              $.jGrowl("{#SaveSuccess#}", {ldelim}
			  header: '{#SentData#}',
			  theme: 'accept'
			  {rdelim});
			  $(".not-vis").removeClass("not-vis");
              //$("#btn_gsub").addClass("not-vis"); 
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