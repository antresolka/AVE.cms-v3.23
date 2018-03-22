<?php

/**
 * Класс работы с картами
 *
 * @package AVE.cms
 * @subpackage module_gmap
 * @filesource
 */
class Gmap
{


	/**
	 * ФУНКЦИИ ПУБЛИЧНОЙ ЧАСТИ
	 */

	/**
	 * Вывод карты
	 *
	 * @param int $gmap_id - идентификатор карты
	 */
	
	function gmapShow($tpl_dir, $gmap_id)
	{
		global $AVE_DB, $AVE_Template;

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_gmap
			WHERE id = '" . $gmap_id . "'
		");
		$row_gs = $sql->FetchAssocArray();
		
		$sql = $AVE_DB->Query("
			SELECT * 	
			FROM " . PREFIX . "_module_gmap_markers
			WHERE gmap_id = '" . $gmap_id . "'
		");
		
		$markers = array();
		while ($row = $sql->FetchAssocArray())
		{
			array_push($markers, $row);
		}

		$AVE_Template->assign('gmap', $row_gs);
		$AVE_Template->assign('markers', json_encode($markers));
		$AVE_Template->assign('api_key', GOOGLE_MAP_API_KEY);
		$AVE_Template->display($tpl_dir . 'map.tpl');
	}

	/**
	 * ФУНКЦИИ АДМИНИСТРАТИВНОЙ ЧАСТИ
	 */


	/**
	 * КАТЕГОРИИ - СОЗДАНИЕ - ДОБАВЛЕНИЕ - РЕДАКТИРОВАНИЕ
	 */


    // Просмотр существующих категорий в админ панели

    function gmapCategoryShow($tpl_dir)
    {
        global $AVE_DB, $AVE_Template;
        $gcats = array();
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_gmap_category
		
		");
		//$row_gcat = $sql->FetchRow();
		while($row = $sql->FetchAssocArray())
		{
			array_push($gcats, $row);
		}

        



        $AVE_Template->assign('gcats', $gcats);
        $AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gmap_category.tpl'));

    }

        // Редактирование маркеров

    function gmapMarkerEdit($tpl_dir, $id)
    {
        global $AVE_DB, $AVE_Template;
        $gmarkers = array();
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_gmap_markers
		WHERE id = '" . (int)$id. "'
		");
		
		while($row = $sql->FetchAssocArray())
		{
			array_push($gmarkers, $row);
		}

		$gcats = array();
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_gmap_category
		
		");
		//$row_gcat = $sql->FetchRow();
		while($row = $sql->FetchAssocArray())
		{
			array_push($gcats, $row);
		}

        
        $AVE_Template->assign('gcats', $gcats);

        $AVE_Template->assign('gmarkers', $gmarkers);
        $AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gmap_edit_marker.tpl'));

    }

       // Сохранение отредактированного маркера

    	function gmapMarkerEditSave($id){
		if (isset($_POST['e_marker']))
		{
			global $AVE_DB;
			
			
			$markerDataE =  $_POST['e_marker'];
			$sql = "UPDATE " . PREFIX . "_module_gmap_markers
					SET
						id = '" . $markerDataE['id'] . "',
						gmap_id = '" . $markerDataE['gmap_id'] . "',
						latitude = '" . $markerDataE['latitude'] . "',
						longitude = '" . $markerDataE['longitude'] . "',
						title = '" . $markerDataE['title'] . "',
						title_link = '" . $markerDataE['title_link'] . "',
						marker_cat_id = '" . $markerDataE['marker_cat_id'] . "',
						marker_cat_title = '" . $markerDataE['marker_cat_title'] . "',
						marker_cat_link = '" . $markerDataE['marker_cat_link'] . "',
						img_title = '" . $markerDataE['img_title'] . "',
						marker_city = '" . $markerDataE['marker_city'] . "',
						marker_street = '" . $markerDataE['marker_street'] . "',
						marker_building = '" . $markerDataE['marker_building'] . "',
						marker_dopfield = '" . $markerDataE['marker_dopfield'] . "',
						marker_phone = '" . $markerDataE['marker_phone'] . "',
						marker_www = '" . $markerDataE['marker_www'] . "',
						image = '" . $markerDataE['image']. "'
						WHERE id =  '" . (int)$id. "'
			";
			$AVE_DB->Query($sql);
			//$markerDataE['id'] = $AVE_DB->InsertId();
			
			echo json_encode($markerDataE);
			exit;
		}
	
	} 

    // Добавление и сохранение новых категорий в админ панели модуля и вывод категории при создании
    
    	function gmapCategoryNewAdd(){
		if (isset($_POST['category']))
		{
			global $AVE_DB;
			
			
			$categoryData =  $_POST['category'];
			$sql = "
					INSERT
					INTO " . PREFIX . "_module_gmap_category
					SET
						id = '',
						gcat_title = '" . $categoryData['gcatnewadd'] . "',
						gcat_link = '" . $categoryData['gct_link'] . "'
			";
			$AVE_DB->Query($sql);
			$categoryData['id'] = $AVE_DB->InsertId();
			 
        $sql = $AVE_DB->Query("
		SELECT gcat_title
		FROM " . PREFIX . "_module_gmap_category
		ORDER BY id DESC
        LIMIT 1
		");    				
		$row_gcat = $sql->FetchRow();
		$categoryData['gcat_title'] = $row_gcat->gcat_title;	
			echo json_encode($categoryData);
			exit;
		}
	
	}

	/**
	 * Удаление категории
	 *
	 * @param int $id - идентификатор категории
	 */
	
	function gmapCategoryDel($id){
		global $AVE_DB;
			
			$sql = "DELETE FROM " . PREFIX . "_module_gmap_category WHERE id = '" . (int)$id. "'";
			$AVE_DB->Query("DELETE FROM " . PREFIX . "_module_gmap_markers WHERE marker_cat_id = '" . (int)$id . "'");
			
			$AVE_DB->Query($sql);
			echo $id;
			exit;
		
	
	}

	/**
	 * Просмотр маркеров карты и добавление новых в админке
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $gmap_id - идентификатор карты
	 */
	function gmapMarkersShow($tpl_dir, $gmap_id)
	{
		global $AVE_DB, $AVE_Template;
		
/*		
		$pin_dir = BASE_DIR.'/modules/gmap/images';
		$pin_base_dir = ABS_PATH.'modules/gmap/images';
		
		$pins = array();
		if ($handle = opendir($pin_dir . '/')) {
			
					while (false !== ($file = readdir($handle)))
					{
						if ($file != '.' && $file != '..')
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
*/		
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_gmap
			WHERE id = '" . $gmap_id . "'
		");
		$row_gs = $sql->FetchAssocArray();
		
		$sql = $AVE_DB->Query("
			SELECT * 	
			FROM " . PREFIX . "_module_gmap_markers
			WHERE gmap_id = '" . $gmap_id . "'
		");
		
		$load_markers = array();
		while ($row = $sql->FetchAssocArray())
		{
			array_push($load_markers, $row);
		}
		
		
		
		$limit = 5;
		$start = get_current_page() * $limit - $limit;

		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS *
			FROM " . PREFIX . "_module_gmap_markers
			WHERE gmap_id = '" . $gmap_id . "'
			ORDER BY id ASC
			LIMIT " . $start . "," . $limit . "
		");

		$sql_num = $AVE_DB->Query("SELECT FOUND_ROWS()");
		$num = $sql_num->GetCell();
		
		$markers = array();
		
		while ($row = $sql->FetchAssocArray())
		{
			array_push($markers, $row);
		}
		
		if ($num > $limit)
		{
			$page_nav = ' <a class="pnav" href="index.php?do=modules&action=modedit&mod=gmap&moduleaction=show&id=' . $gmap_id . '&page={s}&amp;cp=' . SESSION . '">{t}</a> ';
			$page_nav = get_pagination(ceil($num / $limit), 'page', $page_nav);
		}
		else
		{
			$page_nav = '';
		}

        $gcats = array();
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_gmap_category
		
		");
		//$row_gcat = $sql->FetchRow();
		while($row = $sql->FetchAssocArray())
		{
			array_push($gcats, $row);
		}

        



        $AVE_Template->assign('gcats', $gcats);
        $AVE_Template->assign('gcats_id', $row['id']);		
		$AVE_Template->assign('api_key', GOOGLE_MAP_API_KEY);
		$AVE_Template->assign('page_nav', $page_nav);
        $AVE_Template->assign('gmap', $row_gs);
        $AVE_Template->assign('gmap_id', $row_gs['id']);
        $AVE_Template->assign('gmap_title', $row_gs['gmap_title']);
		$AVE_Template->assign('markers', $markers);
		$AVE_Template->assign('load_markers', json_encode($load_markers));
		//$AVE_Template->assign('pins', $pins);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gmap_markers.tpl'));
	}

	

	/**
	 * Вывод списка карт
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 */
	function gmapListShow($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		$gmaps = array();

		$limit = 20;
		$start = get_current_page() * $limit - $limit;
		
		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS
				g.*,
				COUNT(m.id) AS marker_count
			FROM
				" . PREFIX . "_module_gmap AS g
			LEFT JOIN
				" . PREFIX . "_module_gmap_markers AS m
					ON m.gmap_id = g.id
			GROUP BY g.id
			ORDER BY g.id ASC
			LIMIT " . $start . "," . $limit . "
		");

		$sql_num = $AVE_DB->Query("SELECT FOUND_ROWS()");
		$num = $sql_num->GetCell();

		while($row = $sql->FetchAssocArray())
		{
			array_push($gmaps, $row);
		}
		
		if ($num > $limit)
		{
			$page_nav = "<li><a href=\"index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&page={s}&amp;cp=" . SESSION . "\">{t}</a></li>";
			$page_nav = get_pagination(ceil($num / $limit), 'page', $page_nav);
		}
		else
		{
			$page_nav = '';
		}
		
		$AVE_Template->assign('page_nav', $page_nav);

		if (!empty($_REQUEST['alert']))
		{
			$AVE_Template->assign('alert', htmlspecialchars(stripslashes($_REQUEST['alert'])));
		}
        $AVE_Template->assign('api_key', GOOGLE_MAP_API_KEY);
		$AVE_Template->assign('gmaps', $gmaps);
		$AVE_Template->assign('formaction', 'index.php?do=modules&action=modedit&mod=gmap&moduleaction=new&sub=save&amp;cp=' . SESSION);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gmap_list.tpl'));
	}

	
	/**
	 * Сохранение маркеров
	 *
	 * @param int $gmap_id - идентификатор карты
	 */
	
	function gmapMarkersAdd($gmap_id){
		if (isset($_POST['marker']))
		{
			global $AVE_DB;
			
			
			$markerData =  $_POST['marker'];
			$sql = "
					INSERT
					INTO " . PREFIX . "_module_gmap_markers
					SET
						id = '',
						gmap_id = '".(int)$gmap_id."',
						latitude = '" . $markerData['latitude'] . "',
						longitude = '" . $markerData['longitude'] . "',
						title = '" . $markerData['title'] . "',
						title_link = '" . $markerData['title_link'] . "',
						marker_cat_id = '" . $markerData['marker_cat_id'] . "',
						marker_cat_title = '" . $markerData['marker_cat_title'] . "',
						marker_cat_link = '" . $markerData['marker_cat_link'] . "',
						img_title = '" . $markerData['img_title'] . "',
						marker_city = '" . $markerData['marker_city'] . "',
						marker_street = '" . $markerData['marker_street'] . "',
						marker_building = '" . $markerData['marker_building'] . "',
						marker_dopfield = '" . $markerData['marker_dopfield'] . "',
						marker_phone = '" . $markerData['marker_phone'] . "',
						marker_www = '" . $markerData['marker_www'] . "',
						image = '" . $markerData['image']. "'
			";
			$AVE_DB->Query($sql);
			$markerData['id'] = $AVE_DB->InsertId();
			
			echo json_encode($markerData);
			exit;
		}
	
	}
	
	/**
	 * Сохранение редактирования описания маркера
	 *
	 * @param int $id - идентификатор маркера
	 */
	
	
	function gmapMarkerSave($id){
		if (isset($_POST['marker_title']))
		{
			global $AVE_DB;
			
			
			$markerData =  $_POST['marker_title'];
			$sql = "UPDATE " . PREFIX . "_module_gmap_markers
					SET
						title = '" . $markerData . "' WHERE id =  '" . (int)$id. "'
			";
			$AVE_DB->Query($sql);
			
		}
		exit;
	}
	
	/**
	 * Удаление маркера
	 *
	 * @param int $id - идентификатор маркера
	 */
	
	function gmapMarkersDel($id){
		global $AVE_DB;
			
			$sql = "DELETE FROM " . PREFIX . "_module_gmap_markers WHERE id = '" . (int)$id. "'";
			
			$AVE_DB->Query($sql);
			exit;
		
	
	}
	
	/**
	 * Получение описания маркера
	 *
	 * @param int $id - идентификатор маркера
	 */
	
	function gmapMarkersGet($id){
			
			global $AVE_DB;
			
			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_module_gmap_markers
				WHERE id = '" . $id . "'
			");
			$row_gs = $sql->FetchRow();
                echo "<div style='white-space: nowrap; overflow:hidden; min-height: 64px;'>";
            if ($row_gs->img_title != '/modules/gmap/img/no_image.png'){
                echo "<img style='margin: 0px 10px 0px 0px;' src='/index.php?thumb=".$row_gs->img_title."&height=64&width=64&mode=f'>";
            } else {
                echo "<img style='margin: 0px 10px 0px 0px;' src='/modules/gmap/img/no_image.png'>";            	
            }
                echo "<ul style='list-style:none; margin-top:-68px; margin-left: 72px;'>";
            if ($row_gs->marker_cat_title != ''){
            	if ($row_gs->marker_cat_link == '/' || $row_gs->marker_cat_link == 'javascript:void(0);'){
            	echo "<li><a style='font-size:11px; color:#828282; text-decoration:none;' onmouseover=\"this.style.color='#181818';\" onmouseout=\"this.style.color='#828282';\" href='".$row_gs->marker_cat_link."'>".$row_gs->marker_cat_title."</a></li>";
            } else {
            	echo "<li><a style='font-size:11px; color:#828282; text-decoration:none;' onmouseover=\"this.style.color='#181818';\" onmouseout=\"this.style.color='#828282';\" href='/".$row_gs->marker_cat_link."'>".$row_gs->marker_cat_title."</a></li>";            	
            }
            }
            if ($row_gs->title != ''){
            	if ($row_gs->title_link == '/' || $row_gs->title_link == 'javascript:void(0);'){
            	echo "<li><a style='font-size:18px; color:#181818; text-decoration:none; border-bottom:2px solid;' onmouseover=\"this.style.color='#FF6600';\" onmouseout=\"this.style.color='#181818';\" href='".$row_gs->title_link."'><strong>".$row_gs->title."</strong></a></li>";
            } else {
            	echo "<li><a style='font-size:18px; color:#181818; text-decoration:none; border-bottom:2px solid;' onmouseover=\"this.style.color='#FF6600';\" onmouseout=\"this.style.color='#181818';\" href='/".$row_gs->title_link."'><strong>".$row_gs->title."</strong></a></li>";            	
            }
            }

            if ($row_gs->marker_street != '')
            	echo "<li style='margin-top:5px;'><span style='font-size:12px; color:#68809B;'>".$row_gs->marker_city.', '.$row_gs->marker_street.', '.$row_gs->marker_building."</span></li>";


            if ($row_gs->marker_dopfield != '')
            	echo "<li style='margin-top:5px;'><div style='max-width:280px; white-space: normal !important; color:#828282;'>".$row_gs->marker_dopfield."</div></li></ul>";





                echo "<ul style='margin-top:-8px; list-style:none; text-align: center;'>";
            if ($row_gs->marker_phone != '')
                echo "<li  style='margin-top:10px;'><img style='position: relative; top:4px;' src='/modules/gmap/img/phone.png'>".$row_gs->marker_phone."</li>";
            if ($row_gs->marker_www != ''){
            	$placeholders = array('http://www.', 'https://www.', 'http://', 'https://');
                echo "<li><a style='font-size:12px; color:#828282; text-decoration:none;' onmouseover=\"this.style.color='#181818';\" onmouseout=\"this.style.color='#828282';\" href='".$row_gs->marker_www."'><img style='position: relative; top:4px;' src='/modules/gmap/img/url.png'>".str_replace($placeholders, 'www.', $row_gs->marker_www)."</a></li></ul>";
            }
                echo "</div>";
			exit;
	}
	
	/**
	 * Создание карты
	 *
	 */
	function gmapNew()
	{
		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			global $AVE_DB;

			$cont = true;
			$alert = '';

			if (empty($_POST['gmap_title']))
			{
				$alert = '&alert=empty_gmap_title';
				$cont = false;
			}

			if ($cont)
			{
				$AVE_DB->Query("
					INSERT
					INTO " . PREFIX . "_module_gmap
					SET
						id = '',
						gmap_title = '" . $_POST['gmap_title'] . "',
						gmap_height = '" . $_POST['gmap_height'] . "',
						gmap_width = '" . $_POST['gmap_width'] . "',
						longitude = '" . $_POST['longitude'] . "',
						latitude = '" . $_POST['latitude'] . "',
						gmap_zoom = '" . (int)$_POST['gmap_zoom'] . "'
				");

			}

			header('Location:index.php?do=modules&action=modedit&mod=gmap&moduleaction=1'. $alert);
			exit;
		}
	}

	/**
	 * Редактирование карты
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $gmap_id - идентификатор карты
	 */
	function gmapEdit($tpl_dir, $gmap_id)
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			

			$AVE_DB->Query("
				UPDATE " . PREFIX . "_module_gmap
				SET
					gmap_title = '" . $_POST['gmap_title'] . "',
					gmap_height = '" . $_POST['gmap_height'] . "',
					gmap_width = '" . $_POST['gmap_width'] . "',
					longitude = '" . $_POST['longitude'] . "',
					latitude = '" . $_POST['latitude'] . "',
					gmap_zoom = '" . (int)$_POST['gmap_zoom'] . "'
				WHERE
					id = '" . (int)$gmap_id . "'
			");

			header('Location:index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&amp;cp=' . SESSION);
			exit;
		}

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_gmap
			WHERE id = '" . (int)$gmap_id . "'
		");
		$row = $sql->FetchAssocArray();
		$AVE_Template->assign('api_key', GOOGLE_MAP_API_KEY);
		$AVE_Template->assign('gmap', $row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gmap_edit.tpl'));
	}

	/**
	 * Удаление карты
	 *
	 * @param int $gmap_id - идентификатор карты
	 */
	function gmapDelete($gmap_id)
	{
		global $AVE_DB;

		$AVE_DB->Query("DELETE FROM " . PREFIX . "_module_gmap WHERE id = '" . $gmap_id . "'");
		$AVE_DB->Query("DELETE FROM " . PREFIX . "_module_gmap_markers WHERE gmap_id = '" . $gmap_id . "'");

		header('Location:index.php?do=modules&action=modedit&mod=gmap&moduleaction=1&amp;cp=' . SESSION);
		exit;
	}
}

?>