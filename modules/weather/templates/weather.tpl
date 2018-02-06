{if $config.useCSS == 1 }<link href="{$ABS_PATH}modules/weather/templates/css/weatherplugin.css" rel="stylesheet" type="text/css"/>{/if}
<div class="side-widget mweather c-margin-t-30">
    <div class="WeatherPlugin {$config.view}">
       <h2>{$weather.city}</h2>
      {if $config.view != "forecast" }
        <div class="wiToday">
          <div class="wiIconGroup">
            <div class="wi wi{$weather.today.code}"></div>
             <p class="wiText">{$weather.today.desc}</p>
          </div>
          <p class="wiTemperature">{$weather.today.temp.now}<sup>{$degrees}</sup></p>     
          {if $config.view != "simple" }      
              <div class="wiDetail">
                {if $config.view == "partial" } 
                  <p class="wiDay">{$weather.today.day}</p>
                {/if}           
                {if $config.view != "partial" } 
                  {if $config.view != "today"}<p class="wiDay">{$weather.today.day}</p>{/if}
                  <ul class="astronomy">
                    <li class="wi sunrise">{$weather.today.sunrise}</li>
                    <li class="wi sunset">{$weather.today.sunset}</li>
                  </ul>
                  <ul class="temp">
                    <li>Max: {$weather.today.temp.max}<sup>{$degrees}</sup></li>
                    <li>Min: {$weather.today.temp.min}<sup>{$degrees}</sup></li>
                  </ul>
                  <ul class="atmosphere">
                    <li class="wi humidity">{$weather.today.humidity}</li>
                    <li class="wi pressure">{$weather.today.pressure}</li>
                    <li class="wi wind">{$format_wind}</li>
                  </ul>
                {/if}            
              </div>          
           {/if}     
         </div>
       {/if}
       {if $config.view != "simple" } 
       {if ($config.view != "today" ) ||($config.view == "forecast") }
          <ul class="wiForecasts">  
          
          {if $config.view == "forecast" }{assign var=startingIndex value=0}{else}{assign var=startingIndex value=1}{/if}
          {section name=i start=$startingIndex loop=$weather.forecast step=1} 
            <li class="wiDay"><span>{$weather.forecast[i].day}</span>
              <ul class="wiForecast">
                <li class="wi wi{$weather.forecast[i].code}"></li>
                <li class="wiMax">{$weather.forecast[i].temp.max}<sup>{$degrees}</sup></li>
                <li class="wiMin">{$weather.forecast[i].temp.min}<sup>{$degrees}</sup></li>
              </ul>
            </li>       
           {/section}  
          </ul>
        {/if}
       {/if} 
    </div>
</div>
