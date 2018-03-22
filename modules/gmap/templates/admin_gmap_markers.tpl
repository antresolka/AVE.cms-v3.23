			{if check_permission('adminpanel')}
			<link rel="stylesheet" href="{$ABS_PATH}lib/redactor/elfinder/css/elfinder.full.css" type="text/css" media="screen" charset="utf-8" />
			<link rel="stylesheet" href="{$ABS_PATH}lib/redactor/elfinder/css/theme.css" type="text/css" media="screen" charset="utf-8" />
			<script src="{$ABS_PATH}lib/redactor/elfinder/js/elfinder.full.js" type="text/javascript" charset="utf-8"></script>
			<script src="{$ABS_PATH}lib/redactor/elfinder/js/i18n/elfinder.ru.js" type="text/javascript" charset="utf-8"></script>
			<script type="text/javascript" src="{$ABS_PATH}modules/gmap/js/filemanager_gmap.js"></script>
			{/if}

<style type="text/css"> 
            
            #myMap{ldelim}width: 650px; height: 400px;margin:20px;{rdelim}
			.deleteButton input{ldelim}line-height:normal;{rdelim}
			.pagination {ldelim}margin-left:20px;margin-bottom:30px;{rdelim}
            #myMapList{ldelim}float: left; text-align:left; width: 250px;  height:400px; overflow-x:hidden; overflow-y:scroll; {rdelim}
            .clear {ldelim}float: none; clear:both;{rdelim}
        </style>
<div class="title"><h5>{#ModName#} - {#MarkerAddmap#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#AddMarkers#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#MarkerView#}</li>
	        <li><strong class="code">{$gmap_title}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget first" style="margin-bottom: 20px;">
<div class="head closed">
<h5 class="iFrames">{#Gmap_fm#}</h5>
</div>
    <div class="body">
		<ul>
			<li>{if UGROUP == 1}<h5 class="iFrames">{#Gmap_fm_inf#}&nbsp;&nbsp;<a id="dir_upl" class="button blueBtn" href="javascript:void(0);">{#Gmap_fm_inf1#}</a>&nbsp;&nbsp;{#Gmap_fm_inf2#}&nbsp;&nbsp;<a id="dir_uplgmi" class="button greenBtn" href="javascript:void(0);">{#Gmap_fm_inf3#}</a></h5>{/if}</li>
			<li>&nbsp;</li>
			<li class="link"></li>
			<li>&nbsp;</li>
		</ul>
		<div id='gm_wrfm'></div>
		<div id="finder">finder</div>
		<div class="clear"></div>
    </div>
</div>


<div class="widget first">
<div class="head">
<h5 class="iFrames">{#Gmap_edi_mark#} {$gmap_title}</h5>
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
			<td><span style="float: left; margin-right: 5px;">{#MarkerAdress#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_cat_inf_tt#}">&nbsp;</span></td>
			<td nowrap="nowrap">
				<input class="mousetrap" name="address" type="text" id="marker_address" value="" size="40" style="width:500px" />&nbsp;&nbsp;
				<input name="latitude" type="hidden" id="lat" value=""/>
				<input name="longitude" type="hidden" id="long" value=""/>
			</td>
		</tr>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#MarkerDesc#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_link_category#}">&nbsp;</span></td>
			<td nowrap="nowrap">
                <input readonly class="mousetrap" name="marker_cat_title" type="text" id="marker_cat_title" placeholder="{#Markercat_h#}" value="" style="width:500px" />
                <input type="hidden" name="marker_cat_link" id="marker_cat_link" value="" />
                <input type="hidden" name="marker_cat_id" id="marker_cat_id" value="" />&nbsp;
     		    <select name="category" id="category" style="width: 300px;">
				<option value="">{#Gmap_cat_sel#}</option>
				{foreach from=$gcats item=gcat}
			    <option value="{$gcat.id}" data-link="{$gcat.gcat_link}">{$gcat.gcat_title|escape}</option>
			    {/foreach}
			    </select>&nbsp;&nbsp;
			    <a class="button redBtn" href="javascript:void(0);" onclick="GetCategory()">{#Gmap_cat_cnf#}</a>&nbsp;
			    {if $gcat.id !=''}<a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=showcategory&id={$gmap.id}&cp={$sess}" class="btn greyishBtn">{#Gmap_cat_edit#}</a>{else}<a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=showcategory&id={$gmap.id}&cp={$sess}" class="btn redBtn">{#Gmap_cat_create#}</a>{/if}
     		</td>
		</tr>		
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_doc_title#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_link_single_marker#}">&nbsp;</span></td>
			<td>
     			<input class="mousetrap" name="marker_title" type="text" id="marker_title" placeholder="{#Gmap_doc_title#}" value="" style="width:500px" />&nbsp;
     			<input type="hidden" name="title_link" id="title_link" value="" />
				<input onclick="openLinkWindowSelect('');" type="button" class="basicBtn greenBtn" value="{#Gmap_btn_doc_title#}" />
			</td>
		</tr>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_img_title#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_link_single_image#}">&nbsp;</span></td>
			<td>
               <div style="" id="feld__i">
               <img style="" id="_img_feld__i" src="{$field_value}" alt="" border="0" width="64" height="64" />
               </div>
               <div style="" id="span_feld__i"></div>
               <input class="mousetrap" type="text" style="width: 500px;" placeholder="{#Markerimg_t#}" name="img_feld__i" value="{$field_value|escape}" id="img_feld__i" />&nbsp;
               <input value="{#Gmap_load_img_title#}"" class="basicBtn" type="button" onclick="browse_uploads('img_feld__i', '', '', '0');" />&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2"><h5 class="iFrames">{#Gmap_cat_inf_dop#}</h5></td>
		</tr>		
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_t#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_cat_inf_tt#}">&nbsp;</span></td>
			<td>
				<input class="mousetrap" name="marker_city" type="text" id="marker_city" value="" placeholder="{#Gmap_cat_inf_tp#}" style="width:250px" />
			</td>
		</tr>
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_st#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_mar_key_street#}">&nbsp;</span></td>
			<td>
				<input class="mousetrap" name="marker_street" type="text" id="marker_street" value="" placeholder="{#Gmap_cat_inf_stp#}" style="width:250px" />
			</td>
		</tr>
		<tr>
			<td>{#Gmap_cat_inf_bi#}</td>
			<td>
				<input class="mousetrap" name="marker_building" type="text" id="marker_building" value="" placeholder="{#Gmap_cat_inf_blp#}" style="width:250px" />
			</td>
		</tr>
		<tr>
			<td>{#Gmap_cat_inf_ap#}</td>
			<td>
				<textarea cols="20" wrap="hard" class="mousetrap" name="marker_dopfield" type="text" id="marker_dopfield" value="" placeholder="{#Gmap_cat_inf_dopfi#}" style="width:250px"></textarea>
			</td>
		</tr>
		<tr>
			<td>{#Gmap_cat_inf_phone#}</td>
			<td>
				<input class="mousetrap" name="marker_phone" type="text" id="marker_phone" value="" placeholder="{#Gmap_cat_inf_telp#}" style="width:250px" />
			</td>
		</tr>	
		<tr>
			<td><span style="float: left; margin-right: 5px;">{#Gmap_cat_inf_www#}</span><span style="cursor: help; float: left;" class="toprightDir icon_sprite ico_info" title="{#Gmap_cat_inf_wwwi#}">&nbsp;</span></td>
			<td>
				<input class="mousetrap" name="marker_www" type="text" id="marker_www" value="" placeholder="{#Gmap_cat_inf_wwwf#}" style="width:250px" />
			</td>
		</tr>			
												
		<tr>
			<td>{#MarkerImage#}</td>
			<td>
			<a id="btn_pin_green"  href="javascript:void(0);"><img src='/modules/gmap/images/pin-green.png'></a>
			<a id="btn_pin-krayola" href="javascript:void(0);"><img src='/modules/gmap/images/pin-krayola1.png'></a>
			<a id="btn_pin-persian-red" href="javascript:void(0);"><img src='/modules/gmap/images/pin-persian-red74.png'></a>
			<a id="btn_pin-yellow" href="javascript:void(0);"><img src='/modules/gmap/images/pin-yellow110.png'></a>
			<a id="btn_pin-red" href="javascript:void(0);"><img src='/modules/gmap/images/pin-red17.png'></a>
			<a id="btn_pin-dark-blue" href="javascript:void(0);"><img src='/modules/gmap/images/pin-dark-blue28.png'></a>
			<a id="btn_pin-gray" href="javascript:void(0);"><img src='/modules/gmap/images/pin-gray210.png'></a>
			<a id="btn_pin-blue" href="javascript:void(0);"><img src='/modules/gmap/images/pin-blue49.png'></a>
			<a id="btn_pin-purple" href="javascript:void(0);"><img src='/modules/gmap/images/pin-purple283.png'></a>
			<a id="btn_pin-orange" href="javascript:void(0);"><img src='/modules/gmap/images/pin-orange339.png'></a>
			<a id="btn_pin-brown" href="javascript:void(0);"><img src='/modules/gmap/images/pin-brown500.png'></a>
			<a id="btn_pin-user" href="javascript:void(0);"><img src='/modules/gmap/images/pin-user.png'></a>
			<div id="res"></div>

	<script type="text/javascript" language="javascript">
	        var pin_request = '';

            $('#btn_pin_green').on('click', function(){ldelim}
            pin_request = 'green';
            pgCall();
            {rdelim});
            $('#btn_pin-krayola').on('click', function(){ldelim}
            pin_request = 'krayola';
            pgCall();
            {rdelim});
            $('#btn_pin-persian-red').on('click', function(){ldelim}
            pin_request = 'persian_red';
            pgCall();
            {rdelim});
            $('#btn_pin-yellow').on('click', function(){ldelim}
            pin_request = 'yellow';
            pgCall();
            {rdelim});
            $('#btn_pin-red').on('click', function(){ldelim}
            pin_request = 'red';
            pgCall();
            {rdelim});
            $('#btn_pin-dark-blue').on('click', function(){ldelim}
            pin_request = 'dark_blue';
            pgCall();
            {rdelim});
            $('#btn_pin-gray').on('click', function(){ldelim}
            pin_request = 'gray';
            pgCall();
            {rdelim});
            $('#btn_pin-blue').on('click', function(){ldelim}
            pin_request = 'blue';
            pgCall();
            {rdelim});
            $('#btn_pin-purple').on('click', function(){ldelim}
            pin_request = 'purple';
            pgCall();
            {rdelim});
            $('#btn_pin-orange').on('click', function(){ldelim}
            pin_request = 'orange';
            pgCall();
            {rdelim});
            $('#btn_pin-brown').on('click', function(){ldelim}
            pin_request = 'brown';
            pgCall();
            {rdelim});
            $('#btn_pin-user').on('click', function(){ldelim}
            pin_request = 'user';
            pgCall();
            {rdelim});                                                                                                                          

            function pgCall() {ldelim}
            //var pin_request = 'green';
            $.ajax({ldelim}
            type: 'POST',
            url: '{$ABS_PATH}modules/gmap/pin.gmap.php',
            async: true,
            data: pin_request,
            success: function(data) {ldelim}
    		$("#res").html(data);
    		pin_request = ''; 
            {rdelim},
            error:  function(xhr, str){ldelim}
            $.jGrowl("{#SaveError#}", {ldelim}
			header: '{#SentData#}',
			theme: 'error'
		    {rdelim}); 
            {rdelim}
            {rdelim});
            {rdelim};
    </script>
				
			</td>
		</tr>
		<tr>
    		<td colspan="2">
    			<input type="button" onclick="newMarker();" value="{#AddMarkerButton#}" class="btn redBtn" />&nbsp;&nbsp;
			    {if $gcat.id !=''}<a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=showcategory&id={$gmap.id}&cp={$sess}" class="btn greyishBtn">{#Gmap_cat_edit#}</a>{else}<a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=showcategory&id={$gmap.id}&cp={$sess}" class="btn redBtn">{#Gmap_cat_create#}</a>{/if}&nbsp;&nbsp;
    			<a href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&cp={$sess}" class="btn greenBtn" >{#Gmap_return#}</a>
    		</td>
    	</tr>
</table>
<div class="rowElem">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<col width="240">
		<col>
		<tr>
			<td><h5 class="iFrames" style="float: left;">{#SetMarkerOnClick#}</h5><div style="float: left; margin-top: 1px; margin-left: 15px;"><input type="checkbox" name="put" value="1" id="put"></div></td>
			<td>&nbsp;&nbsp;</td>
		</tr>	
	</table>
	<div id="myMap"></div>
</div>


</div>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key={$api_key}&amp;libraries=places"></script> 
<script language="Javascript" type="text/javascript">
function searchAdress() {ldelim}
		var input = document.getElementById('marker_address');
		var autocomplete = new google.maps.places.Autocomplete(input);
		google.maps.event.addListener(autocomplete, 'place_changed', function () {ldelim}
			var place = autocomplete.getPlace();

			var lat = place.geometry.location.lat();
			var lon = place.geometry.location.lng();

			document.getElementById('lat').value = lat;
			document.getElementById('long').value = lon;
		{rdelim});
	{rdelim}
google.maps.event.addDomListener(window, 'load', searchAdress);	

$(document).ready(function(){ldelim}
	loadMap();
{rdelim});
</script>
<script language="Javascript" type="text/javascript"> 
        
            
            // set default map properties
            var defaultLatlng = new google.maps.LatLng({$gmap.latitude},{$gmap.longitude});
            
            // zoom level of the map		
            var defaultZoom ={$gmap.gmap_zoom};
            
            // variable for map
            var map;
            
            // variable for marker info window
            var infowindow;
         
            // List with all marker to check if exist
            var markerList = [];
         
            // set error handler for jQuery AJAX requests
            $.ajaxSetup({ldelim}"error":function(XMLHttpRequest,textStatus, errorThrown) {ldelim}  
                alert(textStatus + ' / ' + errorThrown + ' / ' + XMLHttpRequest.responseText);
            {rdelim}{rdelim});
        
            // option for google map object
            var myOptions = {ldelim}
                zoom: defaultZoom,
                center: defaultLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            {rdelim};
        
        
            /**
             * Load Map
             */
            function loadMap(){ldelim}
        
                console.log('loadMap');

                // create new map make sure a DIV with id myMap exist on page
                map = new google.maps.Map(document.getElementById("myMap"), myOptions);
        
                // create new info window for marker detail pop-up
                infowindow = new google.maps.InfoWindow();
                
                // load markers
                loadMarkers();
				
				google.maps.event.addListener(map, 'click', function (e) {ldelim}

				//Determine the location where the user has clicked.
				var location = e.latLng;
				var clLatitude = e.latLng.lat();
				var clLongitude = e.latLng.lng();
				var climg_feld__i = '/modules/gmap/img/no_image.png';
				var clmarker_city = '';
				
				if($('input[name=image]').is(':checked')) {ldelim}
					climage = $('input[name=image]:checked').val();
				{rdelim} else {ldelim}
					climage = 'pin-green';
					
				{rdelim}
				
				$('#put').change(function() {ldelim}
					if (this.checked){ldelim}
						add_marker = true;
			{rdelim} else {ldelim}
						add_marker = false;

					{rdelim}
				// do stuff here. It will fire on any checkbox change

				{rdelim}); 
				
				if (add_marker) {ldelim}
				var markerData = {ldelim}
                            'latitude': clLatitude,
                            'gmap_id': {$gmap_id},
                            'longitude': clLongitude,
                            'image': climage,
                            'img_title': climg_feld__i,
                            'marker_city': clmarker_city,
                            'title': '',
                        {rdelim};
         
                        // save new marker request to server
                        $.ajax({ldelim}
                            type: 'POST',			
                            url: 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=addmarker&id={$gmap_id}&cp={$sess}',
                            data: {ldelim}
                                marker: markerData
                            {rdelim},
                            dataType: 'json',
                            async: false,
                            success: function(result){ldelim}
                            $.jGrowl("{#Gmap_sv_mark1#}", {ldelim}
			                header: '{#Gmap_sv_mark#}',
			                theme: 'accept'
			                {rdelim});                            
                                var marker_id =result['id'];
								AddTr(marker_id, climage,'');
								// add marker to map
                                loadMarker(result);
                                                        
                                // show marker detail
                                showMarker(marker_id);

                                $('#newMarker').removeClass('error');

                                
                            {rdelim}
                        {rdelim});
						{rdelim}
			{rdelim}); 
            {rdelim}
			
			/**
             * Adds new marker to list
             */
			 
			
			
            function newMarker(){ldelim}
         
                // get new city name
                var markerAddress = $('#newMarker').val();
                
                if( markerAddress == "" ){ldelim}
                    $('#newMarker').addClass('error');
                    $('#newMarker').attr('placeholder','missing location');
                    return false;
                {rdelim}
				
				if($('input[name=image]').is(':checked')) {ldelim}
					image = $('input[name=image]:checked').val();
				{rdelim} else {ldelim}
					$('#newMarker').addClass('error');
                    $('#newMarker').attr('placeholder','not selected marker image');
                    alert('{#Gmap_not_mark_a#}');
					return false;
				{rdelim}
				var latitude = $('#lat').val();
				var longitude = $('#long').val();
				var marker_title = $('#marker_title').val();
			    if ($('#title_link').val() =='')
			    	{ldelim} var title_link = 'javascript:void(0);'; {rdelim}
                else 
                	{ldelim} var title_link = $('#title_link').val(); {rdelim};
				var marker_cat_title = $('#marker_cat_title').val();
				if ($('#marker_cat_link').val() =='')
					{ldelim} var marker_cat_link = 'javascript:void(0);'; {rdelim}
				else
				    {ldelim} var marker_cat_link = $('#marker_cat_link').val(); {rdelim}; 
				var marker_cat_id = $('#marker_cat_id').val();
				if ($('#img_feld__i').val() !='')
                {ldelim} var img_feld__i = $('#img_feld__i').val(); {rdelim}
                else
                {ldelim} var img_feld__i = '/modules/gmap/img/no_image.png'; {rdelim};	
                var marker_city = $('#marker_city').val();
                var marker_street = $('#marker_street').val();
                var marker_building = $('#marker_building').val();
                var marker_dopfield = $('#marker_dopfield').val();
                var marker_phone = $('#marker_phone').val();
                var marker_www = $('#marker_www').val();
                // check response status
                if (latitude !='' && longitude !='' && marker_city !='') {ldelim}			
						var markerData = {ldelim}
                            'latitude': latitude,
                            'gmap_id': {$gmap_id},
                            'longitude': longitude,
                            'image': image,
                            'title': marker_title,
                            'title_link': title_link,
                            'marker_cat_title': marker_cat_title,
                            'marker_cat_link': marker_cat_link,
                            'marker_cat_id': marker_cat_id,
                            'img_title': img_feld__i,
                            'marker_city': marker_city,
                            'marker_street': marker_street,
                            'marker_building': marker_building,
                            'marker_dopfield': marker_dopfield,
                            'marker_phone': marker_phone,
                            'marker_www': marker_www,
                        {rdelim};
         
                        // save new marker request to server
                        $.ajax({ldelim}
                            type: 'POST',			
                            url: 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=addmarker&id={$gmap_id}&cp={$sess}',
                            data: {ldelim}
                                marker: markerData
                            {rdelim},
                            dataType: 'json',
                            async: false,
                            success: function(result){ldelim}
                            $.jGrowl("{#Gmap_sv_mark1#}", {ldelim}
			                header: '{#Gmap_sv_mark#}',
			                theme: 'accept'
			                {rdelim});
                                var marker_id =result['id'];
								AddTr(marker_id, image, marker_title);
								// add marker to map
                                loadMarker(result);
                                                        
                                // show marker detail
                                showMarker(marker_id);

                                $('#newMarker').removeClass('error');

                                
                            {rdelim}
                        {rdelim});
                    //add marker to list
						    
                    {rdelim}else {ldelim}
                        alert("{#Gmap_not_mark_all#}");
                    {rdelim};
                $('#marker_title').val('');
                $('#marker_address').val('');
				$('#title_link').val('');
				$('#marker_cat_title').val('');
				$('#marker_cat_link').val('');
				$('#marker_cat_id').val('');
                $('#img_feld__i').val('');
                $('#_img_feld__i').attr('src','');
                $('#marker_city').val('');
                $('#marker_street').val('');
                $('#marker_building').val('');
                $('#marker_dopfield').val('');
                $('#marker_phone').val('');
                $('#marker_www').val('');                
            {rdelim}
			
			function SaveMarker(id){ldelim}
				var title = $('#marker_title-'+id).val();
				$.ajax({ldelim}
                            type: 'POST',			
                            url: 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=savemarker&id='+id+'&cp={$sess}',
                            data: {ldelim}
                                marker_title: title
                            {rdelim},
                            dataType: 'json',
                            async: false,
                            success: function(){ldelim}
                             $.jGrowl("{#Gmap_sv_mark2#}", {ldelim}
			                header: '{#Gmap_sv_mark#}',
			                theme: 'accept'
			                {rdelim});                           
                                showMarker(id);
                            {rdelim}
                        {rdelim});
			{rdelim}
         
			function AddTr(marker_id, image,marker_title){ldelim}
					html = '<tr id="marker-'+marker_id+'">';
					html += '<td valign="top"><input class="btn redBtn" type="button" onclick="DeleteMarker('+marker_id+');" value="{#Delete#}" /></td>';
					html += '<td valign="top">'+marker_id+'</td>';
					html += '<td valign="top"><div class="pr12"><a onclick="showMarker('+marker_id+');"><img src="/modules/gmap/images/'+image+'.png" /></a></div></td>';
					html += '<td valign="top"><div class="pr12"><input placeholder="{#MarkerDesc#}" name="marker_title['+marker_id+']" type="text" id="marker_title-'+marker_id+'" value="'+marker_title+'"></div></td>';
					html += '<td valign="top"><input class="btn basicBtn" type="button" onclick="SaveMarker('+marker_id+');" value="{#Save#}" /></td>';
					html += '</tr>';
						
					$('#mlist tbody').prepend(html);  
			
			{rdelim}
			/**
             * Load markers via ajax request from server
             */
			function loadMarkers(){ldelim}
				var lmarkers = {$load_markers};	
                // load marker jSon data		
                
                    
                // loop all the markers
                $.each(lmarkers, function(i,item){ldelim}
                        
                    // add marker to map
                    loadMarker(item);	
        
                {rdelim});
                
            {rdelim}
			
			
			/**
             * Load marker to map
             */
            function loadMarker(markerData){ldelim}
            
                // create new marker location
                var myLatlng = new google.maps.LatLng(markerData['latitude'],markerData['longitude']);
        
                // create new marker				
                var image = '/modules/gmap/images/'+markerData['image']+'.png';
				
				var content = markerData['title'];
                content += "<p class='deleteButton'><input class='btn redBtn' type = 'button' value = '{#Delete#}' onclick = 'DeleteMarker(" + markerData['id'] + ");' /></p>";
				
				var marker = new google.maps.Marker({ldelim}
                    id: markerData['id'],
                    map: map, 
                    content: content,
					icon:image,
                    position: myLatlng
                {rdelim});
        
                // add marker to list used later to get content and additional marker information
                markerList[marker.id] = marker;
        
                // add event listener when marker is clicked
                // currently the marker data contain a dataurl field this can of course be done different
                google.maps.event.addListener(marker, 'click', function() {ldelim}
                    
                    // show marker when clicked
                    showMarker(marker.id);
        
                {rdelim});
        
				              
            {rdelim}
        
           
            /**
             * Show marker info window
             */
            function showMarker(markerId){ldelim}
                
                // get marker information from marker list
                var marker = markerList[markerId];
                
                // check if marker was found
                if( marker ){ldelim}
					marker_url = 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=getmarker&id='+markerId+'&cp={$sess}';
                    // get marker detail information from server
                    $.get(marker_url, function(data) {ldelim}
                        // show marker window
						content = "<p>ID:" +markerId+ "</p>"+data+"<p class='deleteButton'><input class='btn redBtn' type = 'button' value = '{#Delete#}' onclick = 'DeleteMarker(" +markerId+ ");' value = 'Delete' />&nbsp;&nbsp;<a class='btn blueBtn' href=\"index.php?do=modules&action=modedit&mod=gmap&moduleaction=editmarker&id=" +markerId+ "&cp={$sess}\">{#Gmap_narker_edit#}</a></p><br>";
                        infowindow.setContent(content);
                        infowindow.open(map,marker);
                    {rdelim});	
					
                {rdelim}else{ldelim}
                    alert('Error marker not found: ' + markerId);
                {rdelim}
            {rdelim}
			function editMarker() {ldelim}
            edit_url = "index.php?do=modules&action=modedit&mod=gmap&moduleaction=editmarker&id=" +markerId+ "&cp={$sess}";
            $.get(edit_url);
            //alert('DDD'+id);
            //return;
			{rdelim};

			function DeleteMarker(id) {ldelim}
                             $.jGrowl("{#Gmap_sv_mark3#}", {ldelim}
			                header: '{#Gmap_sv_mark#}',
			                //theme: 'error'
			                {rdelim});			
				//Find and remove the marker from the Array
				markerList[id].setMap(null);
				//Remove the marker from array.
				delete markerList[id];
				
				del_url = 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=delmarker&id='+id+'&cp={$sess}';
                // get marker detail information from server
                $('#marker-' + id).remove();
				$.get(del_url);	
				return;
			{rdelim};
            
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
$('#marker_title').val(data.document_title);
$('#title_link').val(data.document_alias);
{rdelim}
{rdelim});
	{rdelim};
</script>
			    <script type="text/javascript">
				// Обнуляем значения полей категорий при вводе с клавиатуры
		        $('#marker_cat_title').focus(function(){ldelim}
		        $('#marker_cat_title').val('');
		        $('#marker_cat_link').val('');
		        $('#marker_cat_id').val('');		
		        {rdelim});
		        // Обнуляем значения полей Связать с документом при вводе с клавиатуры
		        $('#marker_title').focus(function(){ldelim}
                $('#marker_title').val('');
		        $('#title_link').val('');		
		        {rdelim});
			    // Функция выбора категории выпадающим списком
			   	function GetCategory()
                {ldelim}
		        $('#marker_cat_title').val('');
		        $('#marker_cat_link').val('');
		        $('#marker_cat_id').val('');                
                // получаем индекс выбранного элемента
  	            var selind = document.getElementById("category").options.selectedIndex;
                var txt= document.getElementById("category").options[selind].text;
                var val= document.getElementById("category").options[selind].value;
		        var link= $(':selected', document.getElementById("category")).data('link');
                if (link == undefined) {ldelim}
                //alert('{#Gmap_cat_cs#}');	
                $('#marker_cat_title').val('');
                $('#marker_cat_link').val('');
                $('#marker_cat_id').val(val);
                {rdelim} else {ldelim}
                $('#marker_cat_title').val(txt);
                $('#marker_cat_link').val(link);
                $('#marker_cat_id').val(val);
                {rdelim}
                {rdelim}
			    </script>



<script type="text/javascript">
   $("#dir_upl").on('click', function () {ldelim}

        var fmgmap = 'dir_upl';
        $("#finder").remove();
        $('#gm_wrfm').append('<div id="finder">finder</div>');
        $.ajax({ldelim}
          type: 'POST',
          url: '{$ABS_PATH}modules/gmap/fm.gmap.php',
          cache: false,
          data: {ldelim}fmgmap:fmgmap{rdelim},
          success: function(data) {ldelim}
          $.ajax({ldelim}
          async: false,
          url: '{$ABS_PATH}lib/redactor/elfinder/js/elfinder.full.js',
          dataType: "script"
          {rdelim});
          $.ajax({ldelim}
          async: false,
          url: '{$ABS_PATH}lib/redactor/elfinder/js/i18n/elfinder.ru.js',
          dataType: "script"
          {rdelim});
          $.ajax({ldelim}
          async: false,
          url: '{$ABS_PATH}modules/gmap/js/filemanager_gmap.js',
          dataType: "script"
          {rdelim});
          {rdelim},
          error:  function(xhr, str){ldelim}
      alert('Возникла ошибка: ' + xhr.responseCode);
          {rdelim}
{rdelim});
 {rdelim});

    $("#dir_uplgmi").on('click', function () {ldelim}

        var fmgmap = 'dir_uplgmi';
        $("#finder").remove();
        $('#gm_wrfm').append('<div id="finder">finder</div>');
        $.ajax({ldelim}
          type: 'POST',
          url: '{$ABS_PATH}modules/gmap/fm.gmap.php',
          cache: false,
          data: {ldelim}fmgmap:fmgmap{rdelim},
          success: function(data) {ldelim}
          $.ajax({ldelim}
          async: false,
          url: '{$ABS_PATH}lib/redactor/elfinder/js/elfinder.full.js',
          dataType: "script"
          {rdelim});
          $.ajax({ldelim}
          async: false,
          url: '{$ABS_PATH}lib/redactor/elfinder/js/i18n/elfinder.ru.js',
          dataType: "script"
          {rdelim});
          $.ajax({ldelim}
          async: false,
          url: '{$ABS_PATH}modules/gmap/js/filemanager_gmap.js',
          dataType: "script"
          {rdelim});
          {rdelim},
          error:  function(xhr, str){ldelim}
      alert('Возникла ошибка: ' + xhr.responseCode);
          {rdelim}
{rdelim});
 {rdelim});    
</script>

