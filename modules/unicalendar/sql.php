<?php
/**
 * AVE.cms - Универсальный календарь событий.
 *
 * @autor Repellent
 * @package AVE.cms
 * @subpackage module_unicalendar
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */
$module_sql_install = array();
$module_sql_deinstall = array();
$module_sql_update = array();

//Удаление модуля
$module_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_module_unicalendar`";

//Установка модуля
$module_sql_install[] = "CREATE TABLE `CPPREFIX_module_unicalendar` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `uca_title` varchar(255) NOT NULL,
  `uca_date_format` varchar(255) NOT NULL,
  `uca_events` varchar(10) NOT NULL,
  `uca_rubric_id` varchar(10) NOT NULL,
  `uca_rubric_title` varchar(255) NOT NULL,
  `uca_doc_id` varchar(1024) NOT NULL,
  `uca_link` varchar(10) NOT NULL,
  `uca_day` varchar(10) NOT NULL,
  `uca_scroll` varchar(10) NOT NULL,
  `uca_descript` varchar(10) NOT NULL,
  `uca_events_limit` int(10) unsigned NOT NULL,
  `uca_img_field` int(10) unsigned NOT NULL,
  `uca_dsc_field` int(10) unsigned NOT NULL,
  `uca_place_field` int(10) unsigned NOT NULL,    
  PRIMARY KEY  (`id`)
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
// Обновление таблицы в версии модуля v1.1.3
$module_sql_update[] = "
  ALTER TABLE `CPPREFIX_module_unicalendar`
  ADD IF NOT EXISTS `uca_rubric_title` varchar(500) NOT NULL
  AFTER `uca_rubric_id`";

$module_sql_update[] = "
  ALTER TABLE `CPPREFIX_module_unicalendar`
  DROP IF EXISTS `uca_user_title`,
  DROP IF EXISTS `uca_user_descript`,
  DROP IF EXISTS `uca_user_link`,
  DROP IF EXISTS `uca_user_time`
  "; 
 // Обновление таблицы в версии модуля v1.2.3  
$module_sql_update[] = "
  ALTER TABLE `CPPREFIX_module_unicalendar`
  DROP IF EXISTS `uca_rub_doc_count`
  ";
  // Обновление таблицы в версии модуля v1.2.5
$module_sql_update[] = "
  ALTER TABLE `CPPREFIX_module_unicalendar`
  ADD IF NOT EXISTS `uca_date_format` varchar(255) NOT NULL
  AFTER `uca_title`";
  // Обновление таблицы в версии модуля v1.2.6
$module_sql_update[] = "
  ALTER TABLE `CPPREFIX_module_unicalendar`
  ADD IF NOT EXISTS `uca_events_limit` int(10) unsigned NOT NULL
  AFTER `uca_descript`";
  // Обновление таблицы в версии модуля v1.2.7
$module_sql_update[] = "
  ALTER TABLE `CPPREFIX_module_unicalendar`
  ADD IF NOT EXISTS `uca_img_field` int(10) unsigned NOT NULL
  AFTER `uca_events_limit`,
  ADD IF NOT EXISTS `uca_dsc_field` int(10) unsigned NOT NULL,
  AFTER `uca_img_field`,
  ADD IF NOT EXISTS `uca_place_field` int(10) unsigned NOT NULL,
  AFTER `uca_dsc_field`  
  ";  

?>