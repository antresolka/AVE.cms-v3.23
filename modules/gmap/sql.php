<?php

/**
 * AVE.cms - Модуль GoogleMaps.
 *
 * @package AVE.cms
 * @subpackage module_gmap
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$module_sql_install = array();
$module_sql_deinstall = array();
$module_sql_update = array();

//Удаление модуля
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_gmap;";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_gmap_category;";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_gmap_markers;";

//Установка модуля
$module_sql_install[] = "CREATE TABLE `CPPREFIX_module_gmap` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `gmap_title` varchar(255) NOT NULL,
  `gmap_width` varchar(10) NOT NULL,
  `gmap_height` varchar(10) NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `gmap_zoom` tinyint(2) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;";

$module_sql_install[] = "CREATE TABLE `CPPREFIX_module_gmap_category` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `gcat_title` varchar(255) NOT NULL default '',
  `gcat_link` varchar(255) NOT NULL default '',  
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;";

$module_sql_install[] = "CREATE TABLE `CPPREFIX_module_gmap_markers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `gmap_id` int(10) unsigned NOT NULL default '0',
  `marker_cat_id` int(10) unsigned NOT NULL default '0',
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `img_title` varchar(255) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `title_link` varchar(255) NOT NULL default '',
  `marker_cat_title` varchar(255) NOT NULL default '',
  `marker_cat_link` varchar(255) NOT NULL default '',
  `marker_city` varchar(255) NOT NULL,
  `marker_street` varchar(255) NOT NULL default '',
  `marker_building` varchar(255) NOT NULL default '',
  `marker_dopfield` varchar(255) NOT NULL default '',
  `marker_phone` varchar(255) NOT NULL default '',
  `marker_www` varchar(255) NOT NULL default '',
  `image` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `gmap_id` (`gmap_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;";

$module_sql_update[] = "
  UPDATE `CPPREFIX_module`
  SET
    ModuleAveTag = '" . $modul['ModuleAveTag'] . "',
    ModulePHPTag = '" . $modul['ModulePHPTag'] . "',
    ModuleVersion = '" . $modul['ModuleVersion'] . "'
  WHERE
    ModuleSysName = '" . $modul['ModuleSysName'] . "'
  LIMIT 1;
";
?>