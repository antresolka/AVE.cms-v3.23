<div id="myMap{$gmap.id}" style="height:{$gmap.gmap_height};{if $gmap.gmap_width}width:{$gmap.gmap_width};{/if}"></div>
<script>
    function loadMapsAPI() {ldelim}
        if( window.google && google.maps )
            return;
       document.write(
          '<script src="',
          'https://maps.googleapis.com/maps/api/js?key=',
          '{$api_key}',
          '&amp;=initMap',
               
            '">',
           '<\/script>'
        );
    {rdelim}

     window.initMap = function(){ldelim}
     //фикс ошибки "initMap is not a function"
    {rdelim}

   loadMapsAPI();
</script>
<script language="Javascript" type="text/javascript">
$(document).ready(function(){ldelim}
		loadMap{$gmap.id}();
{rdelim});
</script>
<script language="Javascript" type="text/javascript"> 
    
            
    // zoom level of the map		
    var defaultZoom{$gmap.id} ={$gmap.gmap_zoom};
            
    // variable for map
    var map{$gmap.id};
            
    // variable for marker info window
    var infowindow{$gmap.id};
         
    // List with all marker to check if exist
    var markerList{$gmap.id} = [];
         
    
        
    /** Load Map */
    function loadMap{$gmap.id}(){ldelim}
        
    console.log('loadMap');
	// set default map properties
    var defaultLatlng{$gmap.id} = new google.maps.LatLng({$gmap.latitude},{$gmap.longitude});
	// option for google map object
    var myOptions{$gmap.id} = {ldelim}
        zoom: defaultZoom{$gmap.id},
        center: defaultLatlng{$gmap.id},
        mapTypeId: google.maps.MapTypeId.ROADMAP
   {rdelim};
	// create new map make sure a DIV with id myMap exist on page
    map{$gmap.id} = new google.maps.Map(document.getElementById("myMap{$gmap.id}"), myOptions{$gmap.id});
        
    // create new info window for marker detail pop-up
    infowindow{$gmap.id} = new google.maps.InfoWindow(
    {ldelim}
    maxWidth: 700
    {rdelim}

    );
                
    // load markers
    loadMarkers{$gmap.id}();
	{rdelim}			
	
	/**
    * Load markers via ajax request from server
    */
	
	function loadMarkers{$gmap.id}(){ldelim}
		var lmarkers{$gmap.id} = {$markers};	
        // load marker jSon data		
                
        // loop all the markers
        $.each(lmarkers{$gmap.id}, function(i,item){ldelim}
			// add marker to map
            loadMarker{$gmap.id}(item);	
        
        {rdelim});
    {rdelim}
			
			
	/**
    * Load marker to map
    */
    function loadMarker{$gmap.id}(markerData){ldelim}
            
		// create new marker location
            var myLatlng = new google.maps.LatLng(markerData['latitude'],markerData['longitude']);
        
        // create new marker				
            var image = '/modules/gmap/images/'+markerData['image']+'.png';

        if (markerData['img_title'] != '/modules/gmap/img/no_image.png')
        {ldelim}
            var a_stimg = "<img style=\"margin: 0px 10px 0px 0px;\" src=\"/index.php?thumb="+markerData['img_title']+"&height=64&width=64&mode=f\">";
        {rdelim} else {ldelim}
            var a_stimg = "<img style=\"margin: 0px 10px 10px 0px;\" src=\"/modules/gmap/img/no_image.png\">";
        {rdelim};

        if (markerData['marker_cat_title'] != '')
        {ldelim}
            if (markerData['marker_cat_link'] == '/' || markerData['marker_cat_link'] == 'javascript:void(0);'){ldelim}
            var a_categ = "<li><a style=\"color:#828282; font-size:11px; text-decoration:none;\" onmouseover=\"this.style.color='#181818';\" onmouseout=\"this.style.color='#828282';\" href=\""+markerData['marker_cat_link']+"\">"+markerData['marker_cat_title']+"</a></li>";
            {rdelim}
            else {ldelim}
            var a_categ = "<li><a style=\"color:#828282; font-size:11px; text-decoration:none;\" onmouseover=\"this.style.color='#181818';\" onmouseout=\"this.style.color='#828282';\" href=\"/"+markerData['marker_cat_link']+"\">"+markerData['marker_cat_title']+"</a></li>";            
            {rdelim}
        {rdelim}
                else
        {ldelim}
            var a_categ='';
        {rdelim};        


        if (markerData['title'] != '')
        {ldelim}
            if (markerData['title_link'] == '/' || markerData['title_link'] == 'javascript:void(0);'){ldelim}    
            var a_title = "<li><a style=\"color:#181818; font-size:18px; text-decoration:none; border-bottom:2px solid;\" onmouseover=\"this.style.color='#FF6600';\" onmouseout=\"this.style.color='#181818';\" href=\""+markerData['title_link']+"\"><strong>"+markerData['title']+"</strong></a></li>";
            {rdelim}
            else {ldelim}
            var a_title = "<li><a style=\"color:#181818; font-size:18px; text-decoration:none; border-bottom:2px solid;\" onmouseover=\"this.style.color='#FF6600';\" onmouseout=\"this.style.color='#181818';\" href=\"/"+markerData['title_link']+"\"><strong>"+markerData['title']+"</strong></a></li>";
           {rdelim}
        {rdelim}
                else
        {ldelim}
            var a_title='';
        {rdelim};        

        
        if (markerData['marker_street'] != '')
        {ldelim}
            var a_city = "<li><span style=\"font-size:12px; color:#68809B;\">"+markerData['marker_city']+", "+markerData['marker_street']+", "+markerData['marker_building']+"</span></li>";
        {rdelim}
                else
        {ldelim}
            var a_city='';
        {rdelim};

        if (markerData['marker_dopfield'] != '')
        {ldelim}
            var a_dopfield = "<li><div style=\"max-width:280px; white-space: normal !important; color:#828282;\">"+markerData['marker_dopfield']+"</div></li>";
        {rdelim}
                else
        {ldelim}
            var a_dopfield='';
        {rdelim};


        if (markerData['marker_phone'] != '')
        {ldelim}
            var a_phone = "<li><img src=\"{$ABS_PATH}modules/gmap/img/phone.png\">"+markerData['marker_phone']+"</li>";
        {rdelim}
                else
        {ldelim}
            var a_phone='';
        {rdelim};        

        if (markerData['marker_www'] != '')
        {ldelim}
            var a_placeholders = new Array('http://www.', 'https://www.', 'http://', 'https://');
            var a_www = "<li><a style=\"font-size:12px; color:#828282; text-decoration:none;\" onmouseover=\"this.style.color='#181818';\" onmouseout=\"this.style.color='#828282';\" href=\""+markerData['marker_www']+"\"><img src=\"{$ABS_PATH}modules/gmap/img/url.png\">"+str_replace(a_placeholders, 'www.', markerData['marker_www'])+"</a></li>";
        {rdelim}
                else
        {ldelim}
            var a_www='';
        {rdelim};

            // ПОЗИЦИОНИРУЕМ ЭЛЕМЕНТЫ МАРКЕРА

            // div контейнер
            var a_divs = "<div style=\"white-space: nowrap; overflow:hidden; min-height: 64px; \">";
            var a_dive = "</div>";
            // список включающий категорию, ссылку на документ и адрес
            var a_uls = "<ul style=\"list-style:none; margin-top:-68px; margin-left: 30px;\">";
            // список включающий телефон и вебсайт
            var a_ultws = "<ul style=\"margin-top:-8px; list-style:none; text-align: center;\">";
            // закрывающий тег </ul>
            var a_ule = "</ul>";
                                  
            // ФОРМИРУЕМ КОНТЕНТ МАРКЕРА
     		var content = a_divs+a_stimg+a_uls+a_categ+a_title+a_city+a_dopfield+a_ule+a_ultws+a_phone+a_www+a_ule+a_dive;
        
	    	var marker = new google.maps.Marker({ldelim}
                    id: markerData['id'],
                    map: map{$gmap.id}, 
                    content: content,
					icon:image,
                    position: myLatlng
        {rdelim});
        
        // add marker to list used later to get content and additional marker information
        markerList{$gmap.id}[marker.id] = marker;
        
        // add event listener when marker is clicked
        // currently the marker data contain a dataurl field this can of course be done different
        google.maps.event.addListener(marker, 'click', function() {ldelim}
                    
			// show marker when clicked
            showMarker{$gmap.id}(marker.id);
        {rdelim});
    {rdelim}
    
	/**
    * Show marker info window
    */
    function showMarker{$gmap.id}(markerId){ldelim}
                
                // get marker information from marker list
                var marker = markerList{$gmap.id}[markerId];
                
                // check if marker was found
                if( marker ){ldelim}
					infowindow{$gmap.id}.setContent(marker.content);
                    infowindow{$gmap.id}.open(map{$gmap.id},marker);
                {rdelim}else{ldelim}
                    alert('Error marker not found: ' + markerId);
                {rdelim}
    {rdelim}

    function str_replace ( search, replace, subject ) {ldelim} 
    if(!(replace instanceof Array)){ldelim}
        replace=new Array(replace);
        if(search instanceof Array){ldelim}
            while(search.length>replace.length){ldelim}
                replace[replace.length]=replace[0];
            {rdelim}
        {rdelim}
    {rdelim}
    if(!(search instanceof Array))search=new Array(search);
    while(search.length>replace.length){ldelim}
        replace[replace.length]='';
    {rdelim}
    if(subject instanceof Array){ldelim}
        for(k in subject){ldelim}
            subject[k]=str_replace(search,replace,subject[k]);
        {rdelim}
        return subject;
    {rdelim}
    for(var k=0; k<search.length; k++){ldelim}
        var i = subject.indexOf(search[k]);
        while(i>-1){ldelim}
            subject = subject.replace(search[k], replace[k]);
            i = subject.indexOf(search[k],i);
        {rdelim}
    {rdelim}
    return subject;
{rdelim}

</script>

