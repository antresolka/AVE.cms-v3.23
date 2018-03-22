<?php
 /**
 * AVE.cms - module Weather
 *
 * @package AVE.cms
 * @author N.Popova, npop@abv.bg
 * @subpackage mod_weather
 * @filesource
 */

if (!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
	
	$modul['ModuleName'] = 'Weather widget';
    $modul['ModuleSysName'] = 'weather';
    $modul['ModuleVersion'] = '1.01';
    $modul['ModuleDescription'] = 'Weather is weather module which utilizes the Openweather/Yahoo API allowing you to display weather data and related information from regions from all over the world very easily.<br />You can enrich your website with your own weather channel, were all weather conditions from any place of the world will look as you want to be, using the most reliable weather forecast source and combining with the most professional style.<br />System tag <strong>[mod_weather]</strong>.';
    $modul['ModuleAutor'] = "N. Popova, npop@abv.bg"; // Автор
    $modul['ModuleCopyright'] = '&copy; 2016  npop@abv.bg'; //
    $modul['ModuleIsFunction'] = 1;
    $modul['ModuleAdminEdit'] = 1;
    $modul['ModuleFunction'] = 'mod_weather';
    $modul['ModuleTag'] = '[mod_weather]';
    $modul['ModuleTagLink'] = null;
    $modul['ModuleAveTag'] = "#\\\[mod_weather]#";
    $modul['ModulePHPTag'] = "<?php mod_weather(); ?>";

}

function mod_weather()
{
	
	require_once(BASE_DIR . "/modules/weather/class.weather.php");
	
    $weather = new Weather();
	
	$tpl_dir   = BASE_DIR . '/modules/weather/templates/';
	$lang_file = BASE_DIR . "/modules/weather/lang/" . $_SESSION['user_language'] . ".txt";

	if (! is_file(BASE_DIR . '/cache/')) {@mkdir(BASE_DIR . '/cache/', 0777);}
	
	$weather->ShowWeather($tpl_dir, $lang_file);
}


if (defined('ACP') && ! empty($_REQUEST['moduleaction']))
{
	
	require_once(BASE_DIR . "/modules/weather/class.weather.php");

	$tpl_dir   = BASE_DIR . '/modules/weather/templates/';
	$lang_file = BASE_DIR . "/modules/weather/lang/" . $_SESSION['user_language'] . ".txt";

	$weather = new Weather();
	$AVE_Template->config_load($lang_file, "admin");
		
	switch($_REQUEST['moduleaction'])
	{
		case '1':
			$weather->weatherSettingsEdit($tpl_dir, $lang_file);
			break;
	}
}

?>