<?php

/**
 * Модуль "Контакты New"
 *
 * @package AVE.cms
 * @subpackage module: ContactsNew
 * @since 1.4 - 1.5
 * @author vudaltsov UPD Repellent
 * @filesource
 */

$module_sql_install = array();
$module_sql_deinstall = array();
$module_sql_update = array();

// Удаление
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_contactsnew_forms;";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_contactsnew_fields;";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_contactsnew_history;";

// Установка
$module_sql_install[] = "
CREATE TABLE IF NOT EXISTS `CPPREFIX_module_contactsnew_forms` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`alias` varchar(20) NOT NULL,
	`title` varchar(255) NOT NULL,
	`protection` enum('0','1') NOT NULL DEFAULT '1',
	`rubheader` text NOT NULL,
	`form_tpl` text NOT NULL,
	`mail_set` text NOT NULL,
	`mail_tpl` text NOT NULL,
	`finish_tpl` text NOT NULL,
	`code_onsubmit` text NOT NULL,
	`code_onvalidate` text NOT NULL,
	`code_onsend` text NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 AUTO_INCREMENT=1;
";

$module_sql_install[] = "
CREATE TABLE IF NOT EXISTS `CPPREFIX_module_contactsnew_fields` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`form_id` int(10) NOT NULL,
	`active` enum('0','1') NOT NULL DEFAULT '1',
	`title` varchar(255) NOT NULL,
	`type` varchar(255) NOT NULL,
	`main` enum('0','1') NOT NULL DEFAULT '0',
	`setting` text NOT NULL,
	`required` enum('0','1') NOT NULL DEFAULT '0',
	`defaultval` varchar(255) NOT NULL,
	`attributes` text NOT NULL,
	`tpl` text NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 AUTO_INCREMENT=1;
";

$module_sql_install[] = "
CREATE TABLE IF NOT EXISTS `CPPREFIX_module_contactsnew_history` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`form_id` int(10) NOT NULL,
	`email` varchar(255) NOT NULL,
	`subject` varchar(255) NOT NULL,
	`status` enum('new','viewed','replied') NOT NULL DEFAULT 'new',
	`date` int(10) NOT NULL,
	`dialog` longtext NOT NULL,
	`postdata` text NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 AUTO_INCREMENT=1;
";

// Обновление
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

// beta 3
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_forms`
	ADD IF NOT EXISTS `code_onsubmit` text NOT NULL
	AFTER `finish_tpl`";
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_forms`
	ADD IF NOT EXISTS `code_onvalidate` text NOT NULL
	AFTER `code_onsubmit`";
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_forms`
	ADD IF NOT EXISTS `code_onsend` text NOT NULL
	AFTER `code_onvalidate`";
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_forms`
	DROP INDEX IF EXISTS `alias`";

// beta 8
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_fields`
	ADD IF NOT EXISTS `active` enum('0','1') NOT NULL DEFAULT '1'
	AFTER `form_id`";
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_fields`
	DROP IF EXISTS `position`";

// v1.1 beta 1
$module_sql_update[] = "
CREATE TABLE IF NOT EXISTS `CPPREFIX_module_contactsnew_history` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`form_id` int(10) NOT NULL,
	`email` varchar(255) NOT NULL,
	`subject` varchar(255) NOT NULL,
	`status` enum('new','viewed','replied') NOT NULL DEFAULT 'new',
	`date` int(10) NOT NULL,
	`dialog` longtext NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 AUTO_INCREMENT=1;
";
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_forms`
	ADD IF NOT EXISTS `protection` enum('0','1') NOT NULL DEFAULT '1'
	AFTER `title`";

// v1.1 beta 2
$module_sql_update[] = "
	ALTER TABLE `CPPREFIX_module_contactsnew_history`
	ADD IF NOT EXISTS`postdata` text NOT NULL
	AFTER `dialog`";
?>