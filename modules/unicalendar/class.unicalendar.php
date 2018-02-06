<?php
/**
 * Класс работы с календарями событий - модуля Unicalendar
 *
 * @autor Repellent
 * @package AVE.cms
 * @subpackage module_unicalendar
 * @filesource
 */

class Unicalendar
{
	/**
	 * ФУНКЦИИ ПУБЛИЧНОЙ ЧАСТИ
	 */

	/**
	 * Вывод календаря событий
     * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $id - идентификатор календаря
	 */
	function unicalendarShow($tpl_dir, $id)
	{
		require(BASE_DIR . '/modules/unicalendar/lang/'.$_SESSION['user_language'].'.php'); // загружаем файл ленгов для php переменных
		// подключаем JS скрипты и CSS файлы календаря в секцию head
        $eventCalendar_css = '<link rel="stylesheet" href="'.ABS_PATH.'modules/unicalendar/css/eventCalendar.css" type="text/css" media="screen" />';
        $eventCalendar_theme_responsive_css = '<link rel="stylesheet" href="'.ABS_PATH.'modules/unicalendar/css/eventCalendar_theme_responsive.css" type="text/css" media="screen" />';
        $moment_js = '<script src="'.ABS_PATH.'modules/unicalendar/js/moment.js" type="text/javascript"></script>';
        $jquery_eventCalendar_js = '<script src="'.ABS_PATH.'modules/unicalendar/js/jquery.eventCalendar.js" type="text/javascript"></script>';
        $GLOBALS['user_header']['module_unicalendar_'] = $eventCalendar_css."\n".$eventCalendar_theme_responsive_css."\n".$moment_js."\n".$jquery_eventCalendar_js;
        // подключаем в секции <head> js файл с данным , согласно Id календаря
        $data_dir = "/modules/unicalendar/js/data-files";
        $filename = BASE_DIR .$data_dir."/data".$id.".js";
        if (file_exists($filename))
        {
            $GLOBALS['user_header']['module_unicalendar_' . $id] = '<script src="'.ABS_PATH.'modules/unicalendar/js/data-files/data'.$id.'.js" type="text/javascript"></script>';
        }
        else {
        	echo $uca_file_not_found.$id.".js"; // если не смогли подключить файл -выводим сообщение-подсказку
        };        
		global $AVE_Template;
		$AVE_Template->assign('id', $id);
		$AVE_Template->display($tpl_dir . 'unicalendar.tpl');
	}

	/**
	 * ФУНКЦИИ АДМИНИСТРАТИВНОЙ ЧАСТИ
	 */


	/**
	 * Вывод списка календарей
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 */
	function unicalendarList($tpl_dir)
	{   
		global $AVE_DB, $AVE_Template;

		$unicalendars = array();

		$limit = 20;
		$start = get_current_page() * $limit - $limit;
		
		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS
				u.*,
				COUNT(u.id) AS uca_count
			FROM
				" . PREFIX . "_module_unicalendar AS u
			GROUP BY u.id
			ORDER BY u.id ASC
			LIMIT " . $start . "," . $limit . "
		");

		$sql_num = $AVE_DB->Query("SELECT FOUND_ROWS()");
		$num = $sql_num->GetCell();

		while($row = $sql->FetchAssocArray())
		{
			array_push($unicalendars, $row);
		}
		
		if ($num > $limit)
		{
			$page_nav = "<li><a href=\"index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1&page={s}&amp;cp=" . SESSION . "\">{t}</a></li>";
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

        $AVE_Template->assign('unicalendars', $unicalendars);
		$AVE_Template->assign('formaction', 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=new&sub=save&amp;cp=' . SESSION);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_unicalendar_list.tpl'));
	}

	/**
	 * Создание календаря
	 *
	 */
	function unicalendarNew()
	{
		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			global $AVE_DB;
			$cont = true;
			$alert = '';
			if (empty($_POST['uca_title']))
			{
				$alert = '&alert=empty_uca_title';
				$cont = false;
			}
			if ($cont)
			{
				$AVE_DB->Query("
					INSERT
					INTO " . PREFIX . "_module_unicalendar
					SET
						id = '',
						uca_title = '" . $_POST['uca_title'] . "',
						uca_date_format = '" . $_POST['uca_date_format'] . "',
						uca_events = '" . $_POST['uca_events'] . "',
						uca_rubric_id = '" . $_POST['uca_rubric_id'] . "',
						uca_rubric_title = '" . $_POST['uca_rubric_title'] . "',
						uca_doc_id = '" . $_POST['uca_doc_id'] . "',
						uca_link = '" . $_POST['uca_link'] . "',
						uca_day = '" . $_POST['uca_day'] . "',
						uca_scroll = '" . $_POST['uca_scroll'] . "',
						uca_descript = '" . $_POST['uca_descript'] . "',
						uca_events_limit = '" . $_POST['uca_events_limit'] . "',
						uca_img_field = '" . $_POST['i_uca_img_field'] . "',
						uca_dsc_field = '" . $_POST['i_uca_dsc_field'] . "',
						uca_place_field = '" . $_POST['i_uca_place_field'] . "'
				");

        // Получаем обновленные данные календаря
		require(BASE_DIR . '/modules/unicalendar/lang/'.$_SESSION['admin_language'].'.php'); // загружаем файл ленгов для php переменных		
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_unicalendar
		WHERE id = '".$AVE_DB->InsertId()."'
		");
		$unicalendars = array();
		while ($row = $sql->FetchAssocArray())
	   {
		array_push($unicalendars, $row);
	   }
        foreach ( $unicalendars as $k=>$v )
       {
       	$uca_id            = $v['id'];
       	$uca_dfrm          = $v['uca_date_format'];
       	$uevents           = $v['uca_events'];
       	$urubric_id        = $v['uca_rubric_id'];
       	$udoc_id           = $v['uca_doc_id'];
       	$uca_day           = $v['uca_day'];
       	$uca_scroll        = $v['uca_scroll'];
       	$uca_link          = $v['uca_link'];
       	$uca_descript      = $v['uca_descript'];
       	$uca_events_limit  = $v['uca_events_limit'];
       	$uca_img_field     = $v['uca_img_field'];
       	$uca_dsc_field     = $v['uca_dsc_field'];
       	$uca_place_field   = $v['uca_place_field'];
       }
       if ($uca_dsc_field != 0) {$ellipsis = '… ';} else {$ellipsis = '';};// если описания нет не добавляем многоточие при выводе description
       	// Если выбрали вывести все документы из заданной рубрики - документы с Id=1 (Главная) и 404 страница - выводиться не будут!
       	if ($uevents !='' && $uevents == '1'){
       	$sql = $AVE_DB->Query("
            SELECT Id, document_alias, document_title, document_published, document_expire, document_meta_description 
            FROM " . PREFIX . "_documents
            WHERE rubric_id = '" . $urubric_id . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."' 
        ");
       $results = array();
       while ($row = $sql->FetchAssocArray())
       {
       array_push($results, $row);   
       }
       //получаем данные всех документов из заданной рубрики циклом, формируем строку JSON
       foreach ( $results as $k=>$v )
       {
        $uni_data .= "{ \"date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_published']))."\", \"expire_date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_expire']))."\", \"title\": \"".$v['document_title']."\", \"image\": \"".strstr(get_document_field($v['Id'], $uca_img_field), '|', true)."\", \"description\": \"".rtrim(mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_dsc_field))), 0, 255, 'UTF-8'), "!,.-").$ellipsis."\", \"location\": \"".mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_place_field))), 0, 300, 'UTF-8')."\", \"url\": \"".$v['document_alias']."\" },";
        $rubric_count .= $v['Id']." OR Id=";
       }
        $js_data_files = "$(function(){"."var data".$uca_id." = [".$uni_data."];  $(\"#eventCalendar".$uca_id."\").eventCalendar({jsonData: data".$uca_id.", jsonDateFormat: \"human\", startWeekOnMonday: ".$uca_day.", eventsScrollable: ".$uca_scroll.", openEventInNewWindow: ".$uca_link.", dateFormat: \"".$uca_dfrm."\", showDescription: ".$uca_descript.", eventsLimit: ".$uca_events_limit.", locales: {locale: \"".$uca_locale."\", txt_noEvents: \"".$uca_no_events."\", txt_SpecificEvents_prev: \"\", txt_SpecificEvents_after: \"".$uca_real_events."\", txt_NextEvents: \"".$uca_next_events."\", txt_GoToEventUrl: \"".$uca_look_events."\", moment: {\"months\" : ".$uca_months_events.", \"monthsShort\" : ".$uca_monshort_events.", \"weekdays\" : ".$uca_weekdays_events.", \"weekdaysShort\" : ".$uca_wdayshort_events.", \"weekdaysMin\" : ".$uca_wdaymin_events."}}});});";
        
        // Получаем Id документов в категории на момент создания календаря и записываем значение в БД
        $rubric_count ='Id='.$rubric_count;
        $rubric_count = chop($rubric_count, ' OR Id=');

        $AVE_DB->Query("
		UPDATE
		" . PREFIX . "_module_unicalendar
		SET
		uca_doc_id = '" . $rubric_count . "'
		WHERE id = '" . $uca_id . "'
		");        

        // Создаем js файл для календаря с названием dataXXX.js - где XXX = Id календаря
        $fdir = "/modules/unicalendar/js/data-files/";
        mkdir(BASE_DIR . $fdir, 0777, true);
        chmod(BASE_DIR . $fdir, 0777);
        $df = fopen(BASE_DIR . "/modules/unicalendar/js/data-files/data".$uca_id.".js", "w")
        or die($uca_not_write_file);// ругаемся если нет прав на запись в директорию data-files !
        flock($df,2);
        fwrite($df, $js_data_files);
        flock($df,3);
        fclose($df);
       }

       	// Если выбрали вывести выбранные документы из заданной рубрики - документы с Id=1 (Главная) и 404 страница - выводиться не будут!
       	if ($uevents !='' && $uevents == '2'){
       	$sql = $AVE_DB->Query("
            SELECT Id, document_alias, document_title, document_published, document_expire, document_meta_description 
            FROM " . PREFIX . "_documents
            WHERE rubric_id = '" . $urubric_id . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."' AND ".$udoc_id."
        ");
       $results = array();
       while ($row = $sql->FetchAssocArray())
       {
       array_push($results, $row);   
       }
       //получаем данные выбранных документов из заданной рубрики циклом, формируем строку JSON
        foreach ( $results as $k=>$v )
       {
        $uni_data .= "{ \"date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_published']))."\", \"expire_date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_expire']))."\", \"title\": \"".$v['document_title']."\", \"image\": \"".strstr(get_document_field($v['Id'], $uca_img_field), '|', true)."\", \"description\": \"".rtrim(mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_dsc_field))), 0, 255, 'UTF-8'), "!,.-").$ellipsis."\", \"location\": \"".mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_place_field))), 0, 300, 'UTF-8')."\", \"url\": \"".$v['document_alias']."\" },";
        $rubric_count .= $v['Id'].",";
       }
        $js_data_files = "$(function(){"."var data".$uca_id." = [".$uni_data."];  $(\"#eventCalendar".$uca_id."\").eventCalendar({jsonData: data".$uca_id.", jsonDateFormat: \"human\", startWeekOnMonday: ".$uca_day.", eventsScrollable: ".$uca_scroll.", openEventInNewWindow: ".$uca_link.", dateFormat: \"".$uca_dfrm."\", showDescription: ".$uca_descript.", eventsLimit: ".$uca_events_limit.", locales: {locale: \"".$uca_locale."\", txt_noEvents: \"".$uca_no_events."\", txt_SpecificEvents_prev: \"\", txt_SpecificEvents_after: \"".$uca_real_events."\", txt_NextEvents: \"".$uca_next_events."\", txt_GoToEventUrl: \"".$uca_look_events."\", moment: {\"months\" : ".$uca_months_events.", \"monthsShort\" : ".$uca_monshort_events.", \"weekdays\" : ".$uca_weekdays_events.", \"weekdaysShort\" : ".$uca_wdayshort_events.", \"weekdaysMin\" : ".$uca_wdaymin_events."}}});});";

        // Создаем js файл для календаря с названием dataXXX.js - где XXX = Id календаря
        $fdir = "/modules/unicalendar/js/data-files/";
        mkdir(BASE_DIR . $fdir, 0777, true);
        chmod(BASE_DIR . $fdir, 0777);
        $df = fopen(BASE_DIR . "/modules/unicalendar/js/data-files/data".$uca_id.".js", "w")
        or die($uca_not_write_file);// ругаемся если нет прав на запись в директорию data-files !
        flock($df,2);
        fwrite($df, $js_data_files);
        flock($df,3);
        fclose($df);
       }
			}
			header('Location:index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1'. $alert);
			exit;
		}
	}

	/**
	 * Редактирование календаря
	 * @param int $unicalendar_id - идентификатор календаря
	 */
		function unicalendarEdit($tpl_dir, $unicalendar_id)
	{
		global $AVE_DB, $AVE_Template; 
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_unicalendar
			WHERE id = '" . $unicalendar_id . "'
		");
		$unicalendars = array();
		while ($row = $sql->FetchAssocArray())
	   {
		array_push($unicalendars, $row);
	   }
        foreach ( $unicalendars as $k=>$v )
       {
        $uevents    = $v['uca_events'];
       	$urubric_id = $v['uca_rubric_id'];
       	$udoc_id    = $v['uca_doc_id'];
       }

       if($uevents == 2)
       {
       	$sql = $AVE_DB->Query("
        SELECT Id, document_alias, document_title, document_published, document_expire, document_meta_description
        FROM " . PREFIX . "_documents
        WHERE rubric_id = '" . $urubric_id . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."' 
        ");
		$unidocs = array();
		while ($row = $sql->FetchAssocArray())
	   {
		array_push($unidocs, $row);
	   }
	    $AVE_Template->assign('unidocs', $unidocs);

	    $sql = $AVE_DB->Query("
        SELECT Id
        FROM " . PREFIX . "_documents
        WHERE rubric_id = '" . $urubric_id . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."' AND ".$udoc_id."
        ");
		$check_docs = array();
		while ($row = $sql->FetchAssocArray())
	   {
		array_push($check_docs, $row);
	   }
	    $AVE_Template->assign('check_docs', $check_docs);
       }
		
		//$AVE_Template->assign('uca_rub_fields', $uca_rub_fields);
        $AVE_Template->assign('unicalendars', $unicalendars);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_unicalendar_edit.tpl'));

	}

	/**
	 * Сохранение календаря после редактирования
	 * @param int $unicalendar_id - идентификатор календаря
	 */
    function unicalendarEditSave($unicalendar_id)
    { 
    	global $AVE_DB;
		$AVE_DB->Query("
		UPDATE
		" . PREFIX . "_module_unicalendar
		SET
		uca_title = '" . $_POST['uca_title'] . "',
		uca_date_format = '" . $_POST['uca_date_format'] . "',
		uca_doc_id = '" . $_POST['uca_doc_id'] . "',
		uca_events = '" . $_POST['uca_events'] . "',
		uca_rubric_id = '" . $_POST['uca_rubric_id'] . "',
		uca_rubric_title = '" . $_POST['uca_rubric_title'] . "',
		uca_link = '" . $_POST['uca_link'] . "',
		uca_day = '" . $_POST['uca_day'] . "',
		uca_scroll = '" . $_POST['uca_scroll'] . "',
		uca_descript = '" . $_POST['uca_descript'] . "',
		uca_events_limit = '" . $_POST['uca_events_limit'] . "',
		uca_img_field = '" . $_POST['send_uca_img_field'] . "',
		uca_dsc_field = '" . $_POST['send_uca_dsc_field'] . "',
		uca_place_field = '" . $_POST['send_uca_place_field'] . "'
		WHERE id = '" . $unicalendar_id . "'
		");
    	$as = array();	    	
        $as->$_POST['uca_title'];
        $as->$_POST['uca_rubric_title'];
        echo json_encode($as);
        // Получаем обновленные данные календаря
        require(BASE_DIR . '/modules/unicalendar/lang/'.$_SESSION['admin_language'].'.php'); // загружаем файл ленгов для php переменных
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_unicalendar
		WHERE id = '" . $unicalendar_id . "'
		");
		$unicalendars = array();
		while ($row = $sql->FetchAssocArray())
	   {
		array_push($unicalendars, $row);
	   }
        foreach ( $unicalendars as $k=>$v )
       {
       	$uevents           = $v['uca_events'];
       	$uca_dfrm          = $v['uca_date_format'];
       	$urubric_id        = $v['uca_rubric_id'];
       	$udoc_id           = $v['uca_doc_id'];
       	$uca_day           = $v['uca_day'];
       	$uca_scroll        = $v['uca_scroll'];
       	$uca_link          = $v['uca_link'];
       	$uca_descript      = $v['uca_descript'];
       	$uca_events_limit  = $v['uca_events_limit'];
       	$uca_img_field     = $v['uca_img_field'];
       	$uca_dsc_field     = $v['uca_dsc_field'];
       	$uca_place_field   = $v['uca_place_field'];
       }
       if ($uca_dsc_field != 0) {$ellipsis = '… ';} else {$ellipsis = '';};// если описания нет не добавляем многоточие при выводе description
       	// Если выбрали вывести все документы из заданной рубрики - документы с Id=1 (Главная) и 404 страница - выводиться не будут!
       	if ($uevents !='' && $uevents == '1'){
       	$sql = $AVE_DB->Query("
            SELECT Id, document_alias, document_title, document_published, document_expire, document_meta_description 
            FROM " . PREFIX . "_documents
            WHERE rubric_id = '" . $urubric_id . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."'
        ");
       $results = array();
       while ($row = $sql->FetchAssocArray())
       {
       array_push($results, $row);   
       }
       //получаем данные всех документов из заданной рубрики циклом, формируем строку JSON
        foreach ( $results as $k=>$v )
       {
        $uni_data .= "{ \"date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_published']))."\", \"expire_date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_expire']))."\", \"title\": \"".$v['document_title']."\", \"image\": \"".strstr(get_document_field($v['Id'], $uca_img_field), '|', true)."\", \"description\": \"".rtrim(mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_dsc_field))), 0, 255, 'UTF-8'), "!,.-").$ellipsis."\", \"location\": \"".mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_place_field))), 0, 300, 'UTF-8')."\", \"url\": \"".$v['document_alias']."\" },";
        $rubric_count .= $v['Id']." OR Id=";
       }
        $js_data_files = "$(function(){"."var data".$unicalendar_id." = [".$uni_data."];  $(\"#eventCalendar".$unicalendar_id."\").eventCalendar({jsonData: data".$unicalendar_id.", jsonDateFormat: \"human\", startWeekOnMonday: ".$uca_day.", eventsScrollable: ".$uca_scroll.", openEventInNewWindow: ".$uca_link.", dateFormat: \"".$uca_dfrm."\", showDescription: ".$uca_descript.", eventsLimit: ".$uca_events_limit.", locales: {locale: \"".$uca_locale."\", txt_noEvents: \"".$uca_no_events."\", txt_SpecificEvents_prev: \"\", txt_SpecificEvents_after: \"".$uca_real_events."\", txt_NextEvents: \"".$uca_next_events."\", txt_GoToEventUrl: \"".$uca_look_events."\", moment: {\"months\" : ".$uca_months_events.", \"monthsShort\" : ".$uca_monshort_events.", \"weekdays\" : ".$uca_weekdays_events.", \"weekdaysShort\" : ".$uca_wdayshort_events.", \"weekdaysMin\" : ".$uca_wdaymin_events."}}});});";
        
        // Получаем Id документов в категории на момент создания календаря и записываем значение в БД
        $rubric_count ='Id='.$rubric_count;
        $rubric_count = chop($rubric_count, ' OR Id=');

        $AVE_DB->Query("
		UPDATE
		" . PREFIX . "_module_unicalendar
		SET
		uca_doc_id = '" . $rubric_count . "'
		WHERE id = '" . $unicalendar_id . "'
		"); 

        // Создаем js файл для календаря с названием dataXXX.js - где XXX = Id календаря
        $fdir = "/modules/unicalendar/js/data-files/";
        mkdir(BASE_DIR . $fdir, 0777, true);
        chmod(BASE_DIR . $fdir, 0777);
        $df = fopen(BASE_DIR . "/modules/unicalendar/js/data-files/data".$unicalendar_id.".js", "w")
        or die($uca_not_write_file);// ругаемся если нет прав на запись в директорию data-files !
        flock($df,2);
        fwrite($df, $js_data_files);
        flock($df,3);
        fclose($df);
       }

       	// Если выбрали вывести выбранные документы из заданной рубрики - документы с Id=1 (Главная) и 404 страница - выводиться не будут!
       	if ($uevents !='' && $uevents == '2'){
       	$sql = $AVE_DB->Query("
            SELECT Id, document_alias, document_title, document_published, document_expire, document_meta_description 
            FROM " . PREFIX . "_documents
            WHERE rubric_id = '" . $urubric_id . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."' AND ".$udoc_id."
        ");
       $results = array();
       while ($row = $sql->FetchAssocArray())
       {
       array_push($results, $row);   
       }
       //получаем данные выбранных документов из заданной рубрики циклом, формируем строку JSON
        foreach ( $results as $k=>$v )
       {
        $uni_data .= "{ \"date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_published']))."\", \"expire_date\": \"".pretty_date(strftime('%Y-%m-%d %H:%M:%S', $v['document_expire']))."\", \"title\": \"".$v['document_title']."\", \"image\": \"".strstr(get_document_field($v['Id'], $uca_img_field), '|', true)."\", \"description\": \"".rtrim(mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_dsc_field))), 0, 255, 'UTF-8'), "!,.-").$ellipsis."\", \"location\": \"".mb_substr(preg_replace('|[\s]+|su', ' ', strip_tags(get_document_field($v['Id'], $uca_place_field))), 0, 300, 'UTF-8')."\", \"url\": \"".$v['document_alias']."\" },";
        $rubric_count .= $v['Id'].",";
       }
        $js_data_files = "$(function(){"."var data".$unicalendar_id." = [".$uni_data."];  $(\"#eventCalendar".$unicalendar_id."\").eventCalendar({jsonData: data".$unicalendar_id.", jsonDateFormat: \"human\", startWeekOnMonday: ".$uca_day.", eventsScrollable: ".$uca_scroll.", openEventInNewWindow: ".$uca_link.", dateFormat: \"".$uca_dfrm."\", showDescription: ".$uca_descript.", eventsLimit: ".$uca_events_limit.", locales: {locale: \"".$uca_locale."\", txt_noEvents: \"".$uca_no_events."\", txt_SpecificEvents_prev: \"\", txt_SpecificEvents_after: \"".$uca_real_events."\", txt_NextEvents: \"".$uca_next_events."\", txt_GoToEventUrl: \"".$uca_look_events."\", moment: {\"months\" : ".$uca_months_events.", \"monthsShort\" : ".$uca_monshort_events.", \"weekdays\" : ".$uca_weekdays_events.", \"weekdaysShort\" : ".$uca_wdayshort_events.", \"weekdaysMin\" : ".$uca_wdaymin_events."}}});});";

        // Создаем js файл для календаря с названием dataXXX.js - где XXX = Id календаря
        $fdir = "/modules/unicalendar/js/data-files/";
        mkdir(BASE_DIR . $fdir, 0777, true);
        chmod(BASE_DIR . $fdir, 0777);
        $df = fopen(BASE_DIR . "/modules/unicalendar/js/data-files/data".$unicalendar_id.".js", "w")
        or die($uca_not_write_file);// ругаемся если нет прав на запись в директорию data-files !
        flock($df,2);
        fwrite($df, $js_data_files);
        flock($df,3);
        fclose($df);
       }

    exit;
    }

	/**
	 * Выбор событий календаря
	 *
	 */

    function unicalendarEventsNew()
    {
      require_once(BASE_DIR . '/modules/unicalendar/lang/'.$_SESSION['admin_language'].'.php'); // загружаем файл ленгов для php переменных

      if (isset($_POST['c'])) // если пришел запрос вывести все категории, получаем данные и отдаем их в шаблон (выпадающий список)
      {
       global $AVE_DB;
       $sql = $AVE_DB->Query("
       SELECT Id, rubric_title 
       FROM " . PREFIX . "_rubrics
       ");
       echo "<option style='color: #ABABAB;'  value='' >".$select_category."</option>";
       while($result = $sql->FetchRow())
       {
        echo "<option value=".$result->Id.">".$result->rubric_title."</option>";
       };  
      }

      if (isset($_POST['a'])) // если пришел запрос вывести все документы (не будет выведен документ с Id=1 это Главная страница и документ Ошибка 404), получаем и выводим чекбоксами
      {
       global $AVE_DB;  
       $sql = $AVE_DB->Query("
       SELECT Id, document_alias, document_title, document_published, document_expire, document_meta_description 
       FROM " . PREFIX . "_documents
       WHERE rubric_id = '" . $_POST['b'] . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."'
       ");
	   $u_sel_doc = array();
	   while ($row = $sql->FetchAssocArray())
	   {
	    array_push($u_sel_doc, $row);
	   }
       foreach ( $u_sel_doc as $k=>$v )
       {
        echo "<tr class='noborder'><td align='center'><input type='checkbox' class='my-checkbox' name='u_chek".$v['Id']."' value='".$v['Id']."'></td>"."<td align='center'>".$v['Id']."</td>"."<td>".$v['document_title']."</td>"."<td align='center'>".$v['document_published'] = pretty_date(strftime(TIME_FORMAT, $v['document_published']))."</td>"."<td align='center'>".$v['document_expire'] = pretty_date(strftime(TIME_FORMAT, $v['document_expire']))."</td></tr>";
       }
      }


      if (isset($_POST['uca_rub_field'])) // если пришел запрос вывести поля категории, получаем данные и отдаем их в шаблон (выпадающий список)
      {
       global $AVE_DB;
       $sql = $AVE_DB->Query("
       SELECT Id, rubric_field_title 
       FROM " . PREFIX . "_rubric_fields
       WHERE rubric_id = '" . $_POST['uca_frub_id'] . "'
       ");
       while($result = $sql->FetchRow())
       {
        echo "<option value=".$result->Id.">".$result->rubric_field_title."</option>";
       };  
      }

        global $AVE_DB;
        $sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_module_unicalendar
		WHERE id = '".intval($_REQUEST['id'])."'
		");
		$unica = array();
		while ($row = $sql->FetchAssocArray())
	   {
		array_push($unica, $row);
	   }
        foreach ( $unica as $k=>$v )
       {
       	$uca_img_field     = $v['uca_img_field'];
       	$uca_dsc_field     = $v['uca_dsc_field'];
       	$uca_place_field   = $v['uca_place_field'];
       }

      if (isset($_POST['uca_edit_rub_field_img'])) // если пришел запрос вывести поля изображение при редактировании, получаем данные и отдаем их в шаблон (выпадающий список)
      {
       global $AVE_DB;
       $sql = $AVE_DB->Query("
       SELECT Id, rubric_field_title 
       FROM " . PREFIX . "_rubric_fields
       WHERE rubric_id = '" . $_POST['uca_frub_id'] . "'
       ");
       while($result = $sql->FetchRow())
       {
       	if($result->Id == $uca_img_field) {$sel = 'selected=\'selected\'';} else {$sel = '';};
        echo "<option ".$sel." value=".$result->Id.">".$result->rubric_field_title."</option>";
       };  
      }

      if (isset($_POST['uca_edit_rub_field_dsc'])) // если пришел запрос вывести поля описание при редактировании, получаем данные и отдаем их в шаблон (выпадающий список)
      {
       global $AVE_DB;
       $sql = $AVE_DB->Query("
       SELECT Id, rubric_field_title 
       FROM " . PREFIX . "_rubric_fields
       WHERE rubric_id = '" . $_POST['uca_frub_id'] . "'
       ");
       while($result = $sql->FetchRow())
       {
       	if($result->Id == $uca_dsc_field) {$sel = 'selected=\'selected\'';} else {$sel = '';};
        echo "<option ".$sel." value=".$result->Id.">".$result->rubric_field_title."</option>";
       };  
      }

      if (isset($_POST['uca_edit_rub_field_plc'])) // если пришел запрос вывести поля место при редактировании, получаем данные и отдаем их в шаблон (выпадающий список)
      {
       global $AVE_DB;
       $sql = $AVE_DB->Query("
       SELECT Id, rubric_field_title 
       FROM " . PREFIX . "_rubric_fields
       WHERE rubric_id = '" . $_POST['uca_frub_id'] . "'
       ");
       while($result = $sql->FetchRow())
       {
       	if($result->Id == $uca_place_field) {$sel = 'selected=\'selected\'';} else {$sel = '';};
        echo "<option ".$sel." value=".$result->Id.">".$result->rubric_field_title."</option>";
       };  
      }            


		if (isset($_POST['check_rel'])) // если пришел запрос-проверка актуальности календаря (не будет выведен документ с Id=1 это Главная страница и документ Ошибка 404)
        {
        global $AVE_DB;
        $sql = $AVE_DB->Query("
        SELECT Id 
        FROM " . PREFIX . "_documents
        WHERE rubric_id = '" . $_POST['r_id'] . "' AND Id !=1 && Id != '".PAGE_NOT_FOUND_ID."'
        ");
        $all_doc_rub = array();
        while ($row = $sql->FetchAssocArray())
       {
        array_push($all_doc_rub, $row);   
       }
       foreach ( $all_doc_rub as $k=>$v )
       {
       	$doc_count .= $v['Id'].",";
       }
        echo $doc_count = chop($doc_count, ' ,');
       }
       if (isset($_POST['allowed_rub'])) //если пришел запрос "проверяем и запрещаем создавать календарь, если рубрика содержит только один или два документа, Id которых равны либо главной странице либо странице 404 , либо и то и другое"
       {
       global $AVE_DB;
       $sql = $AVE_DB->Query("
       SELECT Id 
       FROM " . PREFIX . "_documents
       WHERE rubric_id = '" . $_POST['allowed_rub_id'] . "'
       ");
       $all_doc_rub = array();
       while ($row = $sql->FetchAssocArray())
       {
        array_push($all_doc_rub, $row);   
       }
       foreach ( $all_doc_rub as $k=>$v )
       {
       	$doc_count .= $v['Id'].",";
       }
        echo $doc_count = chop($doc_count, ' ,');
       } 
      exit;
    }

	/**
	 * Удаление календаря
	 *
	 * @param int $unicalendar_id - идентификатор календаря
	 */
		function unicalendarDelete($unicalendar_id)
	{
		global $AVE_DB;
		$AVE_DB->Query("DELETE FROM " . PREFIX . "_module_unicalendar WHERE id = '" . $unicalendar_id . "'");
		// Удаляем js файл с данными из директории /modules/unicalendar/js/data-files/
        $data_dir = "/modules/unicalendar/js/data-files";
        $filename = BASE_DIR .$data_dir."/data".$unicalendar_id.".js";
        if (file_exists($filename))
        {
            unlink($filename); 
        }
		header('Location:index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1&amp;cp=' . SESSION);
		exit;
	}
}	
?>