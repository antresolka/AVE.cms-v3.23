<?php
ob_start();
ob_implicit_flush(0);
define('BASE_DIR', str_replace("\\", "/", dirname(dirname(dirname(__FILE__)))));
require_once(BASE_DIR . '/inc/init.php');
if (! check_permission('adminpanel'))
{
	header('Location:/index.php');
	exit;
}

$fmgmap = $_POST['fmgmap'];

if ($fmgmap == 'dir_upl')
{

$gmfmen = '
<?php
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
			"driver"        => "LocalFileSystem",
			"path"          => "../../../../" . UPLOAD_DIR,
			"URL"           => "/".UPLOAD_DIR."/",
			"uploadOrder"   => array("deny", "allow"),
			"acceptedName" => "validName",
			"uploadAllow" => array("all"),
			"uploadDeny"  => array("all"),
			"uploadOverwrite" => false,
			"uploadMaxSize" => "256m",
			"accessControl" => "access",
			"attributes" => array(
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

if ($fmgmap == 'dir_uplgmi')
{
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
			"driver"        => "LocalFileSystem",
			"path"          => "../../../../" . UPLOAD_DIR,
			"URL"           => "/".UPLOAD_DIR."/",
			"uploadOrder"   => array("deny", "allow"),
			"acceptedName" => "validName",
			"uploadAllow" => array("all"),
			"uploadDeny"  => array("all"),
			"uploadOverwrite" => false,
			"uploadMaxSize" => "256m",
			"accessControl" => "access",
			"attributes" => array(
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
			),
		),
			array(
			"driver"          => "LocalFileSystem",
			"path"            => "../../../../modules/gmap/images",
			"URL"             => "/modules/gmap/images/",
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
			),
		),
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

if ($fmgmap != 'dir_upl' || $fmgmap != 'dir_uplgmi')
{
	header('Location:/index.php');
	exit;
}


?>