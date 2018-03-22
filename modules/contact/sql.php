<?php

/**
 * AVE.cms - Модуль Контакты
 *
 * Данный файл является частью модуля "Контакты" и содержит mySQL-запросы
 * к базе данных при операцих установки, обновления и удаления модуля через Панель управления.
 *
 * @package AVE.cms
 * @subpackage module_Contact
 * @since 1.4
 * @filesource
 */

$module_sql_install = array();
$module_sql_deinstall = array();
$module_sql_update = array();

$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_contacts;";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_contact_fields;";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_contact_info;";

$module_sql_install[] = "CREATE TABLE CPPREFIX_module_contacts (
  `Id` mediumint(5) unsigned NOT NULL auto_increment,
  `contact_form_title` varchar(100) NOT NULL,
  `contact_form_mail_max_chars` smallint(3) unsigned NOT NULL default '20000',
  `contact_form_reciever` varchar(100) NOT NULL,
  `contact_form_reciever_multi` varchar(255) NOT NULL,
  `contact_form_antispam` enum('1','0') NOT NULL default '1',
  `contact_form_max_upload` mediumint(5) unsigned NOT NULL default '500',
  `contact_form_subject_show` enum('1','0') NOT NULL default '1',
  `contact_form_subject_default` varchar(255) NOT NULL default 'Сообщение',
  `contact_form_allow_group` varchar(255) NOT NULL default '1,2,3,4',
  `contact_form_send_copy` enum('1','0') NOT NULL default '1',
  `contact_form_message_noaccess` text NOT NULL,
  `contact_form_message_scripts` text NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM PACK_KEYS=0 DEFAULT CHARSET=utf8;";

$module_sql_install[] = "CREATE TABLE CPPREFIX_module_contact_fields (
  `Id` int(10) unsigned NOT NULL auto_increment,
  `contact_form_id` mediumint(5) unsigned NOT NULL default '0',
  `contact_field_type` varchar(25) NOT NULL default 'text',
  `contact_field_position` smallint(3) unsigned NOT NULL default '100',
  `contact_field_title` tinytext NOT NULL,
  `contact_field_required` enum('0','1') NOT NULL default '0',
  `contact_field_default` longtext NOT NULL,
  `contact_field_status` enum('1','0') NOT NULL default '1',
  `contact_field_size` smallint(3) unsigned NOT NULL default '300',
  `contact_field_newline` enum('1','0') NOT NULL default '1',
  `contact_field_datatype` enum('anysymbol','onlydecimal','onlychars') NOT NULL default 'anysymbol',
  `contact_field_max_chars` varchar(20) NOT NULL,
  `contact_field_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$module_sql_install[] = "CREATE TABLE CPPREFIX_module_contact_info (
  `Id` int(10) unsigned NOT NULL auto_increment,
  `contact_form_id` mediumint(5) unsigned NOT NULL default '0',
  `contact_form_number` varchar(20) NOT NULL,
  `contact_form_in_date` int(10) unsigned NOT NULL default '0',
  `contact_form_in_email` varchar(255) NOT NULL,
  `contact_form_in_subject` varchar(255) NOT NULL,
  `contact_form_in_message` longtext NOT NULL,
  `contact_form_in_attachment` tinytext NOT NULL,
  `contact_form_out_date` int(10) unsigned NOT NULL default '0',
  `contact_form_out_email` varchar(255) NOT NULL,
  `contact_form_out_sender` varchar(255) NOT NULL,
  `contact_form_out_message` longtext NOT NULL,
  `contact_form_out_attachment` tinytext NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$module_sql_install[] = "INSERT INTO `CPPREFIX_module_contacts` VALUES (1, 'Обратная Связь', 5000, 'youremail@yourdomain.ru', '', '1', 120, '0', '', '1,2,3,4', '0', 'У Вас недостаточно прав для использования этой формы', '<script src=\"/modules/contact/templates/js/jquery.uniform.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\r\n<script type=\"text/javascript\" charset=\"utf-8\">\r\n	$(function(){\r\n		$(\"input, textarea, select, button\").uniform();\r\n	});\r\n</script>\r\n<link rel=\"stylesheet\" href=\"/modules/contact/templates/css/uniform.default.css\" type=\"text/css\" media=\"screen\">\r\n<link rel=\"stylesheet\" href=\"/modules/contact/templates/css/uniform.aristo.css\" type=\"text/css\" media=\"screen\">\r\n<link rel=\"stylesheet\" href=\"/modules/contact/templates/css/module.contact.css\" type=\"text/css\" media=\"screen\">');";

$module_sql_install[] = "INSERT INTO `CPPREFIX_module_contact_fields` VALUES (1, 1, 'textfield', 1, 'Сообщение', '1', '', '1', '', '1', 'anysymbol', '', 'Вы забыли написать сообщение');";
$module_sql_install[] = "INSERT INTO `CPPREFIX_module_contact_fields` VALUES (2, 1, 'dropdown', 2, 'Как Вы оцените наш сайт?', '0', 'Плохо,Средне,Нормально,Отлично', '1', '', '1', 'anysymbol', '', '');";
$module_sql_install[] = "INSERT INTO `CPPREFIX_module_contact_fields` VALUES (3, 1, 'fileupload', 3, 'Прикрепить файл', '0', '', '1', '', '1', 'anysymbol', '', '');";
$module_sql_install[] = "INSERT INTO `CPPREFIX_module_contact_fields` VALUES (4, 1, 'checkbox', 4, 'Чекбокс', '1', 'Поставьте галочку', '1', '', '1', 'anysymbol', '', 'Вы не поставили галочку');";


// Обновление модуля
$module_sql_update[] = "
  UPDATE
    `CPPREFIX_module`
  SET
    ModuleAveTag = '" . $modul['ModuleAveTag'] . "',
    ModulePHPTag = '" . $modul['ModulePHPTag'] . "',
    ModuleVersion = '" . $modul['ModuleVersion'] . "'
  WHERE
    ModuleSysName = '" . $modul['ModuleSysName'] . "'
  LIMIT 1;
";

$module_sql_update[] = "
  RENAME TABLE
    `CPPREFIX_modul_contacts`
  TO
    `CPPREFIX_module_contacts`
";

$module_sql_update[] = "
  RENAME TABLE
    `CPPREFIX_modul_contact_fields`
  TO
    `CPPREFIX_module_contact_fields`
";

$module_sql_update[] = "
  RENAME TABLE
    `CPPREFIX_modul_contact_info`
  TO
    `CPPREFIX_module_contact_info`
";

$module_sql_update[] = "
  ALTER TABLE `".PREFIX."_module_contacts`
  ADD
    `contact_form_message_scripts`
  text NOT NULL default '' AFTER
    `contact_form_message_noaccess`
";

$module_sql_update[] = "ALTER TABLE `CPPREFIX_module_contacts` CHANGE `contact_form_receiver` `contact_form_reciever` VARCHAR(100), CHANGE `contact_form_receiver_multi` `contact_form_reciever_multi` VARCHAR(255);";
?>