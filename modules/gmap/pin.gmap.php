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
        $data_request = '';	
       	$filter = '';
        if (isset($_POST['green']))
      {
        $data_request = 'green';	
       	$filter = 'pin-green';
      } elseif (isset($_POST['krayola']))  	
      {  
        $data_request = 'krayola';	
       	$filter = 'pin-krayola';
       } elseif (isset($_POST['persian_red']))  	
      {  
        $data_request = 'persian_red';	
       	$filter = 'pin-persian-red';
       } elseif (isset($_POST['yellow']))  	
      {  
        $data_request = 'yellow';	
       	$filter = 'pin-yellow';
       } elseif (isset($_POST['red']))  	
      {  
        $data_request = 'red';	
       	$filter = 'pin-red';
       } elseif (isset($_POST['dark_blue']))  	
      {  
        $data_request = 'dark_blue';	
       	$filter = 'pin-dark-blue';
       } elseif (isset($_POST['gray']))  	
      {  
        $data_request = 'gray';	
       	$filter = 'pin-gray';
       } elseif (isset($_POST['blue']))  	
      {  
        $data_request = 'blue';	
       	$filter = 'pin-blue';
       } elseif (isset($_POST['purple']))  	
      {  
        $data_request = 'purple';	
       	$filter = 'pin-purple';
       } elseif (isset($_POST['orange']))  	
      {  
        $data_request = 'orange';	
       	$filter = 'pin-orange';
       } elseif (isset($_POST['brown']))  	
      {  
        $data_request = 'brown';	
       	$filter = 'pin-brown';
       } elseif (isset($_POST['user']))  	
      {  
        $data_request = 'user';	
       	$filter = 'pin-user';
       }


		if (isset($_POST[$data_request]))
		{

		$pin_dir = BASE_DIR.'/modules/gmap/images';
		$pin_base_dir = ABS_PATH.'images';
		
		$pins = array();
		if ($handle = opendir($pin_dir . '/')) {
			
					while (false !== ($file = readdir($handle)))
						
					{
						if ($file != '.' && $file != '..' && strpos($file, $filter) === 0)
						{
							$image_title = substr($file, 0, -4);

							$upload_file_ext = strtolower(substr($file, -4));
							
							$upload_filename = prepare_fname($image_title) . $upload_file_ext;

							if (!empty($upload_filename) && $upload_file_ext == '.png')
							{
								$pins[] = array('name' => $image_title, 'path' => $pin_base_dir . '/' . $upload_filename);

								
							}
						}
					}
					closedir($handle);
		}

 } else {
 	echo "<br>НЕИЗВЕСТНЫЙ ЗАПРОС !";
 	$pin_err = 1;
 }

if ($pin_err != 1)
{ 
echo "<table width='100%' border='1' cellspacing='0' cellpadding='0'><tr>";
foreach ( $pins as $k=>$v )
{
echo "<td>";	
echo $v['name']."<br>";
echo "<input type='radio' name='image' value='".$v['name']."'><label style='cursor: pointer;'><img src='".$v['path']."' height='27' ></label>";
echo "</td> ";
// количество столбцов
if ($k%9 == 8)
echo"</tr><tr>";
}
echo "</tr></table>";
}

?>