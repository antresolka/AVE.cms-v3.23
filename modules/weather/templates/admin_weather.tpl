<div class="title"><h5>{#WEATHER_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#WEATHER_MODULE_INFO#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#WEATHER_MODULE_NAME#}</li>
	    </ul>
	</div>
</div>


<form method="post" action="index.php?do=modules&action=modedit&mod=weather&moduleaction=1&sub=save&cp={$sess}" class="mainForm">
  <fieldset>
  <div class="widget first">
  <div class="head"><h5 class="iFrames">{#WEATHER_MODULE_EDIT#}</h5></div>

        <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
           <colgroup>
             <col width="30">
             <col width="250px;">
             <col>
           </colgroup>
           <tbody>
            <tr>
                <td><a title="{#WEATHER_SOURCE_DESC#}" href="javascript:void(0);" style="cursor:help;"  class="rightDir icon_sprite ico_info"></a></td>
                <td>{#WEATHER_SOURCE#}</td>
                <td>
                    <select name="api" >
                        <option value="openweathermap"{if $row.api=="openweathermap"} selected="selected"{/if}>Openweathermap Api</option>
                        <option value="yahoo"{if $row.api=="yahoo"} selected="selected"{/if}>Yahoo weather Api</option>
                    </select>
                </td>
            </tr> 
            <tr>
                <td><a title="API key" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td>API key (Openweathermap)</td>
                <td><input type="text" name="apikey" value="{$row.apikey}"/></td>
            </tr>
            <tr>
                <td ><a title="{#WEATHER_WOEID_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td >{#WEATHER_WOEID#}</td>
                <td><div class="pr12"><input type="text" name="WOEID" value="{$row.WOEID}"/></div></td>
            </tr>  
            <tr>
                <td><a title="{#WEATHER_TEMPLATE_DESC#}" href="javascript:void(0);" style="cursor:help;"  class="rightDir icon_sprite ico_info"></a></td>
                <td>{#WEATHER_TEMPLATE#}</td>
                <td>
                    <select name="view" >
                        <option value="simple"{if $row.view=="simple"} selected="selected"{/if}>simple</option>
                        <option value="today"{if $row.view=="today"} selected="selected"{/if}>today</option>
                        <option value="partial"{if $row.view=="partial"} selected="selected"{/if}>partial</option>
                        <option value="forecast"{if $row.view=="forecast"} selected="selected"{/if}>forecast</option>
                        <option value="full"{if $row.view=="full"} selected="selected"{/if}>full</option>
                    </select>
                </td>
           </tr>  
            <tr>
                <td><a title="{#WEATHER_AMOUNT_DAYS_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td>{#WEATHER_AMOUNT_DAYS#}</td>
                <td>
                    <select name="forecast" id="forecast">
                        <option value="1"{if $row.forecast=="1"} selected="selected"{/if}>1</option>
                        <option value="2"{if $row.forecast=="2"} selected="selected"{/if}>2</option>
                        <option value="3"{if $row.forecast=="3"} selected="selected"{/if}>3</option>
                        <option value="4"{if $row.forecast=="4"} selected="selected"{/if}>4</option>
                        <option value="5"{if $row.forecast=="5"} selected="selected"{/if}>5</option>
                    </select>
                </td>
            </tr>                   
            <tr>
                <td><a title="{#WEATHER_FCITY_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td>{#WEATHER_FCITY#}</td>
                <td ><div class="pr12"><input type="text" name="location" value="{$row.location}"  /></div></td>
            </tr>
            <tr>
                <td><a title="{#WEATHER_FCITY_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td>{#WEATHER_FCOUNTRY#}</td>
                <td ><div class="pr12"><input type="text" name="country" value="{$row.country}"  /></div></td>
            </tr>        
             <tr>
                <td ><a title="{#WEATHER_SHOWCITY_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td >{#WEATHER_SHOWCITY#}</td>
                <td>
                    <select name="displayCityNameOnly" id="displayCityNameOnly">
                        <option value="1"{if $row.showCity=="1"} selected="selected"{/if}>{#WEATHER_ENABLE#}</option>
                        <option value="0"{if $row.showCity=="0"} selected="selected"{/if}>{#WEATHER_DISABLE#}</option>
                    </select>
                </td>
            </tr>
           
            {*
            <tr>
                <td><a title="API key" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td>Secret key (Yahoo YQL)</td>
                <td><input type="text" name="secret_key" value="{$row.secret_key}"/></td>
            </tr>
            *}
            
           
            <tr>
                <td ><a title="{#WEATHER_LANG_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></td>
                <td >{#WEATHER_LANG#}</td>
                <td><input type="text" name="lang" value="{$row.lang}" style="width: 200px;"/></td>
            </tr>
            <tr>
                <td ><a title="{#WEATHER_LATITUDE_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td >{#WEATHER_LATITUDE#}</td>
                <td><input type="text" name="lat" value="{$row.lat}" style="width: 300px;"/></td>
            </tr>
    
            <tr>
                <td ><a title="{#WEATHER_LONGITUDE_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td >{#WEATHER_LONGITUDE#}</td>
                <td><input type="text" name="lon" value="{$row.lon}" style="width: 300px;"/></td>
            </tr>            
           
            <tr>
                <td><a title="{#WEATHER_UNIT_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></td>
                <td>{#WEATHER_UNIT#}</td>
                <td>
                    <select name="units" id="units">
                        <option value="metric" {if $row.tempUnit=="metric"} selected="selected"{/if}>Metric (C)</option>
                        <option value="imperial" {if $row.tempUnit=="imperial"} selected="selected"{/if}>Imperial (F)</option>
                    </select>
                </td>
            </tr>   
    
            <tr>
                <td ><a title="{#WEATHER_CACHETIME_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td >{#WEATHER_CACHETIME#}</td>
                <td><input type="text" name="cacheTime" value="{$row.cacheTime}" style="width: 300px;"/></td>
            </tr>
    
            <tr>
                <td ><a title="{#WEATHER_USECSS_DESC#}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a></td>
                <td >{#WEATHER_USECSS#}</td>
                <td>
                    <select name="useCSS" id="useCSS">
                        <option value="1"{if $row.useCSS=="1"} selected="selected"{/if}>{#WEATHER_ENABLE#}</option>
                        <option value="0"{if $row.useCSS=="0"} selected="selected"{/if}>{#WEATHER_DISABLE#}</option>
                    </select>
                </td>
            </tr>

          </tbody>
        </table>	
        <div class="rowElem">
          <input type="submit" class="basicBtn" value="{#WEATHER_BUTTON_SAVE#}" />
        </div>	
     </div>
   </fieldset>
</form>

</div>
</div>