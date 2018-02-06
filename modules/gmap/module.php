<?php

/**
 * AVE.cms - Модуль Gmap
 *
 * @package AVE.cms
 * @subpackage module_gmap
 * @filesource
 */

if(!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
    $modul['ModuleName'] = 'GMap';
    $modul['ModuleSysName'] = 'gmap';
    $modul['ModuleVersion'] = '1.1.0b';
    $modul['ModuleDescription'] = 'Gmap<br/>Для того, чтобы осуществить просмотр карты, необходимо разместить системный тег <strong>[mod_gmap:XXX]</strong> в теле какого-либо документа';
    $modul['ModuleAutor'] = 'OcPh | Project Manager Duncan | Upgrade module 2016-2017 Repellent';
    $modul['ModuleCopyright'] = '&copy; 2016-2017 AVE.cms Team';
    $modul['ModuleIsFunction'] = 1;
    $modul['ModuleAdminEdit'] = 1;
    $modul['ModuleFunction'] = 'mod_gmap';
    $modul['ModuleTag'] = '[mod_gmap:XXX]';
    $modul['ModuleTagLink'] = null;
    $modul['ModuleAveTag'] = '#\\\[mod_gmap:([\\\d-]+)]#';
    $modul['ModulePHPTag'] = "<?php mod_gmap(''$1''); ?>";
}

/**
 * Функция вывода карты
 *
 * @param string $gmap_id идентификатор карты
  */
function mod_gmap($gmap_id)
{
	global $AVE_Template;

	require_once(BASE_DIR . '/modules/gmap/class.gmap.php');
	$gmap = new Gmap;

	$tpl_dir = BASE_DIR . '/modules/gmap/templates/';
	$lang_file = BASE_DIR . '/modules/gmap/lang/' . $_SESSION['user_language'] . '.txt';

	$AVE_Template->config_load($lang_file);

	$gmap->gmapShow($tpl_dir, $gmap_id);
}

//=======================================================
// Действия в админ-панели
//=======================================================
if (defined('ACP') && !empty($_REQUEST['moduleaction']))
{
	require_once(BASE_DIR . '/modules/gmap/class.gmap.php');
	$gmap = new Gmap;

	$tpl_dir = BASE_DIR . '/modules/gmap/templates/';
	$lang_file = BASE_DIR . '/modules/gmap/lang/' . $_SESSION['admin_language'] . '.txt';

	$AVE_Template->config_load($lang_file, 'admin');

	switch($_REQUEST['moduleaction'])
	{
		case '1': // Просмотр списка карт
			$gmap->gmapListShow($tpl_dir);
			break;

		case 'show': // Просмотр маркеров карты
		    $_SESSION['use_editor'] = get_settings('use_editor');
			$gmap->gmapMarkersShow($tpl_dir, intval($_REQUEST['id']));
			break;

		case 'showcategory': // Просмотр категорий
			$gmap->gmapCategoryShow($tpl_dir);
			break;
		case 'editmarker': // Редактирование маркера
			$gmap->gmapMarkerEdit($tpl_dir, intval($_REQUEST['id']));
			break;

			case 'saveeditmarker': // Сохранение отредактированного маркера
			$gmap->gmapMarkerEditSave(intval($_REQUEST['id']));
			break;	

		case 'addnewcategory': // Добавление новой категории
			$gmap->gmapCategoryNewAdd(intval($_REQUEST['id']));
			break;

		case 'gcatdel': // Удаление категории
			$gmap->gmapCategoryDel(intval($_REQUEST['id']));
			break;		

		case 'addmarker': // Добавление маркера
			$gmap->gmapMarkersAdd(intval($_REQUEST['id']));
			break;
		case 'savemarker': // Сохранение маркера
			$gmap->gmapMarkerSave(intval($_REQUEST['id']));
			break;
		case 'getmarker': // Получение описания маркера
			$gmap->gmapMarkersGet(intval($_REQUEST['id']));
			break;
		case 'delmarker': // Удаление маркера
			$gmap->gmapMarkersDel(intval($_REQUEST['id']));
			break;

		case 'new': // Создать новую карту
			$gmap->gmapNew();
			break;

		case 'delgmap': // Удаление карты
			$gmap->gmapDelete(intval($_REQUEST['id']));
			break;

		case 'editgmap': // Редактирование карты
			$gmap->gmapEdit($tpl_dir, intval($_REQUEST['id']));
			break;

	}

}
// подключаем файловый менеджер проверяем , если файла нет - создаем, если есть ничего не делаем
$filename = BASE_DIR . '/lib/redactor/elfinder/php/connector_module_gmap.php';
if (!file_exists($filename)) {
$gmfmen = '<?php
error_reporting(0);
define("BASE_DIR", str_replace("\\\", "/", dirname(dirname(dirname(dirname(dirname(__FILE__)))))));
include_once "../../../../inc/init.php";
if (! check_permission("mediapool_finder"))
{
	header("Location:/index.php");
	exit;
}
require "./autoload.php";
elFinder::$netDrivers["ftp"] = "FTP";
function access($attr, $path, $data, $volume) {
	return strpos(basename($path), ".") === 0 
		? !($attr == "read" || $attr == "write")
		:  null;
}
$opts = array(
	"roots" => array(
		array(
			"driver"          => "LocalFileSystem",
			"path"            => "../../../../" . UPLOAD_DIR,
			"URL"             => "/".UPLOAD_DIR."/",
			"uploadOrder"     => array("deny", "allow"),
			"acceptedName"    => "validName",
			"uploadAllow"     => array("all"),
			"uploadDeny"      => array("all"),
			"uploadOverwrite" => false,
			"uploadMaxSize"   => "256m",
			"accessControl"   => "access",
			"attributes"      => array(
				array(
					"pattern" => "/^\/\./",
					"read" => false,
					"write" => false,
					"hidden" => true,
					"locked" => true
				),
				 array(
					 "pattern" => "/.tmb/",
					 "read" => false,
					 "write" => false,
					 "hidden" => true,
					 "locked" => false
				 ),
				 array(
					 "pattern" => "/\.php$/",
					 "read" => false,
					 "write" => false,
					 "hidden" => true,
					 "locked" => false
				 ),
				array(
					 "pattern" => "/.quarantine/",
					 "read" => false,
					 "write" => false,
					 "hidden" => true,
					 "locked" => false
				 ),
				 array(
					 "pattern" => "/\.htaccess$/",
					 "write" => false,
					 "locked" => false,
					 "hidden" => true
				 )
			)
		)
	)
);
$connector = new elFinderConnector(new elFinder($opts));
$connector->run();
?>';
    $gfo = fopen(BASE_DIR . "/lib/redactor/elfinder/php/connector_module_gmap.php", "w");
    flock($gfo,2);
    fwrite($gfo, $gmfmen);
    flock($gfo,3);
    fclose($gfo);
    chmod(BASE_DIR . "/lib/redactor/elfinder/php/connector_module_gmap.php", 0755);
}
?>