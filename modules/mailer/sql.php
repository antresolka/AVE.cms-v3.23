<?php

/**
 * AVE.cms - Модуль Внутренней Рассылки
 *
 * @package AVE.cms
 * @subpackage module_mailer
 * @author Arcanum, val005
 * @since 2.01
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$module_sql_install = array();
$module_sql_deinstall = array();

$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_mailer_mails";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_mailer_lists";
$module_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_module_mailer_receivers";

$module_sql_install[] = "CREATE TABLE CPPREFIX_module_mailer_mails (
  id int(10) unsigned NOT NULL auto_increment,
  author_id int(10) unsigned NOT NULL,
  date int(10) unsigned default NULL,
  from_name varchar(255) NOT NULL default '',
  from_email varchar(255) NOT NULL default '',
  from_copy enum('0','1') NOT NULL default '0',
  to_groups text NOT NULL default '',
  to_lists text NOT NULL default '',
  to_add text NOT NULL default '',
  subject varchar(255) NOT NULL default '',
  type varchar(255) NOT NULL default '',
  appeal varchar(255) NOT NULL default '',
  body longtext NOT NULL default '',
  attach text NOT NULL default '',
  saveattach enum('0','1') NOT NULL default '1',
  timing varchar(255) NOT NULL default '',
  sent enum('0','1') NOT NULL default '0',
  done longtext NOT NULL default '',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$module_sql_install[] = "CREATE TABLE CPPREFIX_module_mailer_lists (
  id int(10) unsigned NOT NULL auto_increment,
  title varchar(255) NOT NULL default '',
  descr longtext NOT NULL default '',
  author_id int(10) unsigned NOT NULL,
  date int(10) unsigned default NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$module_sql_install[] = "CREATE TABLE CPPREFIX_module_mailer_receivers (
  id int(10) unsigned NOT NULL auto_increment,
  list_id int(10) unsigned NOT NULL,
  status enum('0','1','2') NOT NULL default '1',
  email varchar(255) NOT NULL default '',
  lastname varchar(255) NOT NULL default '',
  firstname varchar(255) NOT NULL default '',
  middlename varchar(255) NOT NULL default '',
  comments text NOT NULL default '',
  date int(10) unsigned default NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

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
    `CPPREFIX_modul_mailer_mails`
  TO
    `CPPREFIX_module_mailer_mails`
";

$module_sql_update[] = "
  RENAME TABLE
    `CPPREFIX_modul_mailer_lists`
  TO
    `CPPREFIX_module_mailer_lists`
";

$module_sql_update[] = "
  RENAME TABLE
    `CPPREFIX_modul_mailer_receivers`
  TO
    `CPPREFIX_module_mailer_receivers`
";
?>