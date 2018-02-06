<?php

 /**
 * AVE.cms - module Weather
 *
 * @package AVE.cms
 * @author N.Popova, npop@abv.bg
 * @subpackage mod_weather
 * @filesource
 */
class Weather
{

	var $error = '';
	
	var $config = array(
			'module_unique_id'      => 1,
			'location'              => 'Varna',    //city, region
			'country'               => 'Bulgaria', //country
			'WOEID'                 => '',
			'lat'                   => '',
			'lon'                   => '',
			'displayCityNameOnly'   => false,
			'api'                   => 'openweathermap',                       //yahoo, openweathermap   			
			'apikey'                => "",                                     //api key for openweathermar, cliend ID for yahoo
			'secret_key'            => "",                                     //secret key for yahoo YQL 
			'forecast'              => '5',                                    //number of days to forecast, max 5 
			'view'                  => "full",                                 //options: simple, today, partial, forecast, full
			'render'                => true,                                   //render: false if you to make your own markup, true plugin generates markup
            'lang'                  => 'bg',
			'cacheTime'             => 5,	
			'units'                 => 'metric',                               //  "imperial" default: "auto"		
			'useCSS'                => 1         
		);
		
	var $content = array();
		
	var $_use_filelock = true;
	
	var $apiurls  =  array(
			"openweathermap" =>  array( "http://api.openweathermap.org/data/2.5/weather", "http://api.openweathermap.org/data/2.5/forecast/daily" ),
			"yahoo" => array( "http://query.yahooapis.com/v1/public/yql" )
		);


	/**
	 * Read cache file
	 *
	 * @return boolean
	 */
	function _weatherCacheRead( $cache_filename )
	{
		if (!empty($cache_filename)
			&& is_file($cache_filename)
			&& filesize($cache_filename) > 0
			&& ((filemtime($cache_filename) + $this->config['cacheTime'] * 60) > time()))
		{
			$fp = @fopen($cache_filename, "rb");
	        if ($this->_use_filelock) @flock($fp, LOCK_SH);
			if ($fp)
			{
				$cache_file_data = @fread($fp, filesize($cache_filename));
				if ($this->_use_filelock) @flock($fp, LOCK_UN);
				@fclose($fp);

				return $cache_file_data;
			}
		}

		return "";
	}

	/**
	 * Write cache file
	 *
	 * @return boolean
	 */
	function _weatherCacheWrite( $cache_filename, $file_data )
	{
		if (! empty($cache_filename))
		{
			$fp = @fopen($cache_filename, "wb");
			if ($fp)
			{
				if ($this->_use_filelock) @flock($fp, LOCK_EX);
				@fwrite($fp, $file_data);
				if ($this->_use_filelock) @flock($fp, LOCK_UN);
				@fclose($fp);

				return true;
			}
		}
		return false;
	}
	
	
	//Takes wind speed, direction in degrees and units 
	//and returns a string ex. (8.5, 270, "metric") returns "W 8.5 km/h"
	function formatWind($speed, $degrees, $units) 
	{
		$wd = $degrees;
		if (($wd >= 0 && $wd <= 11.25) || ($wd > 348.75 && $wd <= 360))  { $wd = "N"; }
		else if ($wd > 11.25 && $wd <= 33.75){ $wd = "NNE"; }
		else if ($wd > 33.75 && $wd <= 56.25){ $wd = "NE";  }
		else if ($wd > 56.25 && $wd <= 78.75){ $wd = "ENE"; }
		else if ($wd > 78.75 && $wd <= 101.25){ $wd = "E";  }
		else if ($wd > 101.25 && $wd <= 123.75){ $wd = "ESE";}
		else if ($wd > 123.75 && $wd <= 146.25){ $wd = "SE"; }
		else if ($wd > 146.25 && $wd <= 168.75){ $wd = "SSE"; }
		else if ($wd > 168.75 && $wd <= 191.25){ $wd = "S"; }
		else if ($wd > 191.25 && $wd <= 213.75){ $wd = "SSW"; }
		else if ($wd > 213.75 && $wd <= 236.25){ $wd = "SW"; }
		else if ($wd > 236.25 && $wd <= 258.75){ $wd = "WSW"; }
		else if ($wd > 258.75 && $wd <= 281.25){ $wd = "W"; }
		else if ($wd > 281.25 && $wd <= 303.75){ $wd = "WNW"; }
		else if ($wd > 303.75 && $wd <= 326.25){ $wd = "NW"; }
		else if ($wd > 326.25 && $wd <= 348.75){ $wd = "NNW"; }
		
		$speedUnits = ($units == "metric")?"km/h":"mph";
		return $wd + " " + $speed + " " + $speedUnits;
	}
	
	
	/**
	 * Init class
	 *
	 */
	function weatherInit()
	{
		global $AVE_DB;

 		//Load settings
		$row = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_weather
			WHERE Id = '1'
			LIMIT 1
		")->FetchRow();

			$this->config['location'            ]   =  $row->location;
			$this->config['country'             ]   =  $row->country;
			$this->config['WOEID'               ]   =  $row->WOEID; 
			$this->config['lat'                 ]   =  $row->lat;
			$this->config['lon'                 ]   =  $row->lon;
			$this->config['displayCityNameOnly' ]   =  $row->displayCityNameOnly;
			$this->config['api'                 ]   =  $row->api;
			$this->config['apikey'              ]   =  $row->apikey;  
			$this->config['secret_key'          ]   =  $row->secret_key;  
			$this->config['forecast'            ]   =  $row->forecast; 
			$this->config['view'                ]   =  $row->view; 
			$this->config['render'              ]   =  $row->render;
            $this->config['lang'                ]   =  $row->lang; 
			$this->config['cacheTime'           ]   =  $row->cacheTime;	
			$this->config['units'               ]   =  $row->units; 
			$this->config['useCSS'              ]   =  $row->useCSS;

	} //  init()

 function ShowWeather($tpl_dir, $lang_file) {
    global $AVE_DB, $AVE_Template;
	
	$AVE_Template->config_load($lang_file);
	//Load settings
	$this->weatherInit();   	
	$this->weatherDataGet();
	
	if ($this->error === '')
	{
		
	   $weather = $this->datamapper($this->content);	  
	   $degrees =  $this->config['units'] == "metric"?"&#176;C":"&#176;F";	   
	   $format_wind = $this->formatWind(   $weather['today']['wind']['speed'], $weather['today']['wind']['deg'], $this->config['units']);
	   
	   $AVE_Template->assign('config', $this->config);	
	   $AVE_Template->assign('weather', $weather );	
	   $AVE_Template->assign('degrees', $degrees);
	   $AVE_Template->assign('format_wind', $format_wind);

       $AVE_Template->display($tpl_dir . 'weather.tpl');	   	
	} else {
		// открити грешки
		//reportlog('открити грешки');
	}

 }
  
 
   	/**
	 * Get weather data JSON
	 *
	 */
	 
   function weatherDataGet( )
   {
			
		if ($this->config['cacheTime'] > 0)
		{
			// using cache
			
			if ($this->config['api'] == 'openweathermap' ) 
		    {	
				$cache_weather = $this->_weatherCacheRead(BASE_DIR . '/cache/module_weather_' . md5($this->config['city'] . $this->config['language']) . '.json');
				$cache_forecast = $this->_weatherCacheRead(BASE_DIR . '/cache/module_forecast_' . md5($this->config['city'] . $this->config['language']) . '.json');
				if ( ($cache_weather !="") and ($cache_forecast !="") ) {
					$this->content = array();
					$this->content[] = json_decode( $cache_weather, true );
					$this->content[] = json_decode( $cache_forecast, true );
					return;	   
				}
			} else if ($this->config['api'] == 'yahoo') {
				$cache_weather = $this->_weatherCacheRead(BASE_DIR . '/cache/module_weather_yahoo' . md5($this->config['city'] . $this->config['language']) . '.json');
				if ($cache_weather !="") {
					$this->content = array();
					$this->content[] = json_decode( $cache_weather, true );
					return;	   
				}
			}			
		}

		if(function_exists('curl_init')) 
		{
			
		  if ($this->config['api'] == 'openweathermap' ) 
		  {			
			$this->content = array();
			$curl = curl_init(); // initializing connection
			curl_setopt($curl, CURLOPT_HEADER, 0);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // saves us before putting directly results of request
			// check the source of request	
            curl_setopt($curl, CURLOPT_URL,  $this->apiurls["openweathermap"][0]."?id=".$this->config['WOEID']."&units=".$this->config['units']."&lang=".$this->config['lang']."&APPID=".$this->config['apikey']); // url to get 		  			
			curl_setopt($curl, CURLOPT_TIMEOUT, 20); // timeout in seconds
			curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // useragent
			
			$temp_data = curl_exec($curl);			
			if ($this->config['cacheTime'] > 0) $this->_weatherCacheWrite( BASE_DIR . '/cache/module_weather_' . md5($this->config['city'] . $this->config['language']) . '.json',$temp_data); 
			
			$this->content[] = json_decode( $temp_data, true ); // reading content			
			curl_close($curl); // closing connection
			
			$curl = curl_init(); // initializing connection
			curl_setopt($curl, CURLOPT_HEADER, 0);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // saves us before putting directly results of request
            curl_setopt($curl, CURLOPT_URL,  $this->apiurls["openweathermap"][1]."?id=".$this->config['WOEID']."&units=".$this->config['units']."&lang=".$this->config['lang']."&APPID=".$this->config['apikey']); // url to get 		  			
			curl_setopt($curl, CURLOPT_TIMEOUT, 20); // timeout in seconds
			curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // useragent	
		
		    $temp_data = curl_exec($curl);			
			if ($this->config['cacheTime'] > 0) $this->_weatherCacheWrite( BASE_DIR . '/cache/module_forecast_' . md5($this->config['city'] . $this->config['language']) . '.json',$temp_data); 	
					
			$this->content[] = json_decode( $temp_data, true ); // reading content
			curl_close($curl); // closing connection
			
		  } else if ($this->config['api'] == 'yahoo') {
			  // Yahoo YQL			
			  $this->content = array();
			  $curl = curl_init(); // initializing connection
			  curl_setopt($curl, CURLOPT_HEADER, 0);
			   
			  curl_setopt($curl, CURLOPT_RETURNTRANSFER,true); // saves us before putting directly results of request
			  
			  $yunit =  ($this->config['units'] == "metric")?"c":"f";
			  $yql_query = 'select * from weather.forecast where woeid="'.$this->config['WOEID'].'" AND u="'. $yunit .'"';			  
			  
			   curl_setopt( $curl, CURLOPT_URL,  $this->apiurls["yahoo"][0]."?q=" . urlencode($yql_query).'&format=json&env="store://datatables.org/alltableswithkeys"' ) ;   // url to get 	
			  
	          curl_setopt($curl, CURLOPT_TIMEOUT, 20); // timeout in seconds
			  curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // useragent
			
			
			   $temp_data = curl_exec($curl);	

			//  if(($temp_data = curl_exec($curl)) === false){reportlog('Curl error: ' . curl_error($curl));}
			  if ($this->config['cacheTime'] > 0) $this->_weatherCacheWrite( BASE_DIR . '/cache/module_weather_yahoo' . md5($this->config['city'] . $this->config['language']) . '.json',$temp_data); 

			  $this->content[] = json_decode( $temp_data, true ); // reading content			
			  curl_close($curl); // closing connection

		  }
       
		} 
		// check file_get_contents function enable and allow external url's'
	    else if( file_get_contents(__FILE__) && ini_get('allow_url_fopen') && !function_exists('curl_init')) 
		{			
	      if ($this->config['api'] == 'openweathermap' ) 
		  {	
			  $this->content = array();
			  $temp_data = json_decode( file_get_contents( $apiurls["openweathermap"][0]."?id=".$this->config['WOEID']."&units=".$this->config['units']."&lang=".$this->config['lang']."&APPID=".$this->config['apikey']), true );
			  if ($this->config['cacheTime'] > 0) $this->_weatherCacheWrite( BASE_DIR . '/cache/module_forecast_' . md5($this->config['city'] . $this->config['language']) . '.json',$temp_data); 
			  $this->content[] = $temp_data;
			  
			  $temp_data = json_decode( file_get_contents( $apiurls["openweathermap"][1]."?id=".$this->config['WOEID']."&units=".$this->config['units']."&lang=".$this->config['lang']."&APPID=".$this->config['apikey']), true  );
			  if ($this->config['cacheTime'] > 0) $this->_weatherCacheWrite( BASE_DIR . '/cache/module_forecast_' . md5($this->config['city'] . $this->config['language']) . '.json',$temp_data); 	 
			  $this->content[] = $temp_data;
			
		  } else if ($this->config['api'] == 'yahoo') {
			  // Yahoo YQL
			  $this->content = array();
			  $yunit =  ($this->config['units'] == "metric")?"c":"f";
			  $yql_query = 'select * from weather.forecast where woeid="'.$this->config['WOEID'].'" AND u="'. $yunit .'"';
			  $temp_data = json_decode( file_get_contents( $this->apiurls["yahoo"][0]."?q=".urlencode($yql_query).'&format=json&env="store://datatables.org/alltableswithkeys"'), true  );				  
			  if ($this->config['cacheTime'] > 0) $this->_weatherCacheWrite( BASE_DIR . '/cache/module_weather_yahoo' . md5($this->config['city'] . $this->config['language']) . '.json',$temp_data); 
			  $this->content[] =  $temp_data;	  			  
		  }
		  
		} else {
			$this->error = 'cURL extension and file_get_content method is not available on your server';
			return;
		};		
		
   }
    
 	//note: input data is in an array of the returned api result request(s) in the same order as setup in the apiurls
	//All data manipulation and cleaning up happens below
	//making this was tedious.
	
	function datamapper($input) {

			
		if ($this->config['api'] == 'openweathermap' ) 
		{	
			//data[0] is current weather, data[1] is forecast
 
            $out['location'] = $this->config['location'] + ", " + $this->config['country'];
			$out['city'] = $this->config['location']; 

			$out['today'] = array();
			$out['today']['temp'] = array();
			$out['today']['temp']['now'] = round($input[0]['main']['temp']);

            $out['today']['temp']['min'] = round($input[1]['list'][0]['temp']['min']);
		 	$out['today']['temp']['max'] = round($input[1]['list'][0]['temp']['max']);
            
			$out['today']['desc'] = $input[0]['weather'][0]['description'] ;
			$out['today']['code'] = $input[0]['weather'][0]['id']; 
			
			//no weather id code remapping needed, we will use this as our default weather code system
			//and convert all other codes to the openweathermap weather code format

			$out['today']['wind']     = $input[0]['wind'];
			$out['today']['humidity'] = $input[0]['main']['humidity'];
			$out['today']['pressure'] = $input[0]['main']['pressure'];
			$out['today']['sunrise']  = Date( 'H:i', $input[0]['sys']['sunrise']);
			$out['today']['sunset']   = Date( 'H:i', $input[0]['sys']['sunset']);

			$out['today']['day'] =  $this->getDayString( Date('w') ) ;
			
			$out['forecast'] = array();
			for ($i = 0; $i < $this->config['forecast']; $i++) {
				$forecast = array();	
								
				$forecast['day'] =  $this->getDayString( Date( 'w' , $input[1]['list'][$i]['dt'] ) ); //api time is in unix epoch
				$forecast['code'] = $input[1]['list'][$i]['weather'][0]['id'];
				$forecast['desc'] = $input[1]['list'][$i]['weather'][0]['description'];
				$forecast['temp'] = array( 'max' => round($input[1]['list'][$i]['temp']['max']), 'min' => round($input[1]['list'][$i]['temp']['min']) );
				$out['forecast'][] = $forecast;
			}

		return $out;
		
	   } else if ($this->config['api'] == 'yahoo') {
		   //key = yahoo code, value = standard code (based on openweathermap codes)
		  $codes = array(
					0  => "900",	//tornado
					1  => "901",	//tropical storm
					2  => "902",	//hurricane
					3  => "212",	//severe thunderstorms
					4  => "200",	//thunderstorms
					5  => "616",	//mixed rain and snow
					6  => "612",	//mixed rain and sleet
					7  => "611",	//mixed snow and sleet
					8  => "511",	//freezing drizzle
					9  => "301",	//drizzle
					10 => "511",	//freezing rain
					11 => "521",	//showers
					12 => "521",	//showers
					13 => "600",	//snow flurries
					14 => "615",	//light snow showers
					15 => "601",	//blowing snow
					16 => "601",	//snow
					17 => "906",	//hail
					18 => "611",	//sleet
					19 => "761",	//dust
					20 => "741",	//foggy
					21 => "721",	//haze
					22 => "711",	//smoky
					23 => "956",	//blustery
					24 => "954",	//windy
					25 => "903",	//cold
					26 => "802",	//cloudy
					27 => "802",	//mostly cloudy (night)
					28 => "802",	//mostly cloudy (day)
					29 => "802",	//partly cloudy (night)
					30 => "802",	//partly cloudy (day)
					31 => "800",	//clear (night)
					32 => "800",	//sunny
					33 => "951",	//fair (night)
					34 => "951",	//fair (day)
					35 => "906",	//mixed rain and hail
					36 => "904",	//hot
					37 => "210",	//isolated thunderstorms
					38 => "210",	//scattered thunderstorms
					39 => "210",	//scattered thunderstorms
					40 => "521",	//scattered showers
					41 => "602",	//heavy snow
					42 => "621",	//scattered snow showers
					43 => "602",	//heavy snow
					44 => "802",	//partly cloudy
					45 => "201",	//thundershowers
					46 => "621",	//snow showers
					47 => "210",	//isolated thundershowers
				   3200 => "951",	//not available... alright... lets make that sunny.
				);
										            
				include(BASE_DIR . "/modules/weather/lang/" . $_SESSION['user_language'] . ".php");
								
	            $input = $input[0]['query']['results']['channel'];
				//reportlog(print_r($input));
				$out['location'] = $this->config['location'] + ", " + $this->config['country'];
			    $out['city'] = $this->config['location']; 

			    $out['today'] = array();
			    $out['today']['temp'] = array();
				$out['today']['temp']['now'] = round($input['item']['condition']['temp']); 		

				$out['today']['temp']['min'] = round($input['item']['forecast'][0]['low']);
				$out['today']['temp']['max'] = round($input['item']['forecast'][0]['high']); 
				
				$out['today']['desc'] = $conditions[$input['item']['condition']['code']];
				$out['today']['code'] = $codes[$input['item']['condition']['code']]; //map weather code
				
				$out['today']['wind']     = array();
				$out['today']['wind']['speed'] = $input['wind']['speed'];
				$out['today']['wind']['deg']   = $input['wind']['deg'];
								
			    $out['today']['humidity'] = $input['atmosphere']['humidity'];
			    $out['today']['pressure'] = $input['atmosphere']['pressure'];
			    $out['today']['sunrise']  = $input['astronomy']['sunrise'];
			    $out['today']['sunset']   = $input['astronomy']['sunset'];
				
				$out['today']['day'] =  $this->getDayString( Date('w') ) ;
				
				
				$out['forecast'] = array();
				for ($i = 0; $i < $this->config['forecast']; $i++) {
					$forecast = array();	
					// day				
					if(isset($tdays[ (string)$input['item']['forecast'][$i]['day'] ] )){
						$forecast['day'] = 	$tdays[ (string)$input['item']['forecast'][$i]['day'] ]	;		 
					} else {
						$forecast['day'] = 	(string)$input['item']['forecast'][$i]['day']	;		 
					}
					// condition code
					$forecast['code'] = $codes[$input['item']['forecast'][$i]['code']]; //map weather code   
					// condition text
					if(isset($conditions[ $input['item']['condition']['code'] ] )){					
						 $forecast['desc'] =  $conditions[ $input['item']['condition']['code'] ];
					 } else {
						$forecast['desc'] = $input['item']['forecast'][$i]['text'];
					 }
					 					
					$forecast['temp'] = array( 'max' => round($input['item']['forecast'][$i]['high']), 'min' => round($input['item']['forecast'][$i]['low']) );
					$out['forecast'][] = $forecast;
					
				}

		   return $out;
				
	   }

	}


  
   function getDayString($day) {	   
	   $days = array("Неделя", "Понеделник", "Вторник", "Сряда", "Четвъртък", "Петък" , "Събота");	   
	   include(BASE_DIR . "/modules/weather/lang/" . $_SESSION['user_language'] . ".php");
	   return  $days[$day];	   
   }

	/**
	 * Config module
	 * @param string $tpl_dir
	 * @param string $lang_file
	 */
	 
	function weatherSettingsEdit($tpl_dir, $lang_file)
	{
		global $AVE_DB, $AVE_Template;
		
		if ( isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save' )
		{			
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_module_weather
				SET
				  location             = '" . $_REQUEST['location'] . "', 
			      country              = '" . $_REQUEST['country'] . "',
			      WOEID                = '" . $_REQUEST['WOEID'] . "',
			      lat                  = '" . $_REQUEST['lat'] . "',
			      lon                  = '" . $_REQUEST['lon'] . "',
			      displayCityNameOnly  = '" . $_REQUEST['displayCityNameOnly'] . "',
			      api                  = '" . $_REQUEST['api'] . "',
			      apikey               = '" . $_REQUEST['apikey'] . "', 
				  secret_key           = '" . $_REQUEST['secret_key'] . "', 
                  forecast             = '" . $_REQUEST['forecast'] . "', 
			      view                 = '" . $_REQUEST['view'] . "',
			      render               = '" . $_REQUEST['render'] . "', 
                  lang                 = '" . $_REQUEST['lang'] . "',
			      cacheTime            = '" . $_REQUEST['cacheTime'] . "',
			      units                = '" . $_REQUEST['units'] . "',
			      useCSS               = '" . $_REQUEST['useCSS'] . "'
				WHERE id = '1'
			");

			header('Location:index.php?do=modules&action=modedit&mod=weather&moduleaction=1&cp=' . SESSION);
			exit;
		};

		$row = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_module_weather WHERE id = 1")->FetchAssocArray();

		$AVE_Template->assign('row', $row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_weather.tpl'));
	}
	
	
} // class : end

?>