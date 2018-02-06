<?php
 /**
 * AVE.cms - module Weather
 *
 * @package AVE.cms
 * @author N.Popova, npop@abv.bg
 * @subpackage mod_weather
 * @filesource
 */

/**
 * mySQL-query install, update and delete module
 */

$module_sql_install = array();
$module_sql_deinstall = array();
$module_sql_update = array();

$module_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_module_weather`;";

$module_sql_install[] = "CREATE TABLE `CPPREFIX_module_weather` (
  `id`                   tinyint(1) unsigned NOT NULL auto_increment,
  `location`             char(100) default 'Varna',
  `country`              char(100) default 'Bulgaria',
  `WOEID`                varchar(20) default '726050',
  `lat`                  decimal(10,8) default '43.216671',
  `lon`                  decimal(10,8) default '27.91667',
  `displayCityNameOnly`  enum('0','1') NOT NULL default '0',           
  `api`                  enum('openweathermap','yahoo') NOT NULL default 'openweathermap',  
  `apikey`               char(255) default '',  
  `secret_key`           char(255) default '',  
  `forecast`             enum('1','2','3','4','5') NOT NULL default '3',                               
  `view`                 enum('simple','today','partial','forecast', 'full') NOT NULL default 'full',                                  
  `render`               enum('0','1') NOT NULL default '1',                                
  `loadingAnimation`     enum('0','1') NOT NULL default '1',                                
  `lang`                 char(2) NOT NULL default 'bg',
  `cacheTime`            int(3) unsigned NOT NULL default '5',
  `units`                enum('metric','imperial') NOT NULL default 'metric',     
  `useCSS`               enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;" ;

$module_sql_install[] = "INSERT INTO `CPPREFIX_module_weather` VALUES (1, 'Varna','Bulgaria', '726050', '43.216671', '27.91667', '0', 'openweathermap','','','3','full','1', '1','bg','10','metric','1');";

$module_sql_update[] = "
          UPDATE 
		     CPPREFIX_module 
		  SET 
		    CpEngineTag = '" . $modul['CpEngineTag'] . "', 
			CpPHPTag = '" . $modul['CpPHPTag'] . "', 
			Version = '" . $modul['ModulVersion'] . "' 
		  WHERE 
		    ModulPfad = '" . $modul['ModulPfad'] . "' 
		  LIMIT 1;";

$module_sql_update[] = "
	ALTER TABLE
		`CPPREFIX_module_weather`
	ADD
		`secret_key` CHAR(255) NOT NULL
	AFTER
		`apikey`;
";
?>