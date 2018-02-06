<?php
/**
 * AVE.cms - Модуль Универсальный календарь событий
 *
 * @autor Repellent
 * @package AVE.cms
 * @subpackage module_unicalendar
 * @filesource
 */

if(!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
    $modul['ModuleName'] = 'Универсальный календарь событий';
    $modul['ModuleSysName'] = 'unicalendar';
    $modul['ModuleVersion'] = '1.2.8';
    $modul['ModuleDescription'] = '<br>Модуль позволяет создавать различные календари событий. <br> Для вывода календаря используйте системный тег <strong>[mod_unicalendar:XXX]</strong>';
    $modul['ModuleAutor'] = 'Repellent';
    $modul['ModuleCopyright'] = '&copy; AVE.cms Team 2017';
    $modul['ModuleIsFunction'] = 1;
    $modul['ModuleAdminEdit'] = 1;
    $modul['ModuleFunction'] = 'mod_unicalendar';
    $modul['ModuleTag'] = '[mod_unicalendar:XXX]';
    $modul['ModuleTagLink'] = null;
    $modul['ModuleAveTag'] = '#\\\[mod_unicalendar:([\\\d-]+)]#';
    $modul['ModulePHPTag'] = "<?php mod_unicalendar(''$1''); ?>";
}
/**
 * Публичная часть - вывод календаря
 *
 * @param string $id идентификатор календаря
  */

function mod_unicalendar($id)
{
    global $AVE_Template;

    require_once(BASE_DIR . '/modules/unicalendar/class.unicalendar.php');
    $unicalendar = new Unicalendar;

    // папка с шаблонами
    $tpl_dir = BASE_DIR . '/modules/unicalendar/templates/';

    // ленги
    $lang_file = BASE_DIR . '/modules/unicalendar/lang/' . $_SESSION['user_language'] . '.txt';

    $AVE_Template->config_load($lang_file);

    $unicalendar->unicalendarShow($tpl_dir, $id);
}

/**
 * Админка
 */

if (defined('ACP') && (isset($_REQUEST['moduleaction'])))
{
    // класс
    require_once(BASE_DIR . '/modules/unicalendar/class.unicalendar.php');
    $unicalendar = new Unicalendar;

    // папка с шаблонами
    $tpl_dir = BASE_DIR . '/modules/unicalendar/templates/';

    // ленги
    $AVE_Template->config_load(BASE_DIR . '/modules/unicalendar/lang/' . $_SESSION['admin_language'] . '.txt', 'admin');
    $AVE_Template->assign('config_vars', $AVE_Template->get_config_vars());

    switch($_REQUEST['moduleaction'])
    {
        case '1': // Просмотр списка календарей
            $unicalendar->unicalendarList($tpl_dir);
            break;
        case 'new': // Создать новый календарь
            $unicalendar->unicalendarNew();
            break;
        case 'events_new': // Выбор событий календаря
            $unicalendar->unicalendarEventsNew();
            break;            
        case 'edit': // Редактировать календарь
            $unicalendar->unicalendarEdit($tpl_dir, intval($_REQUEST['id']));
            break; 
        case 'edit_save': // Сохранение календаря после редактирования
            $unicalendar->unicalendarEditSave(intval($_REQUEST['id']));
            break;                       
        case 'delunicalendar': // Удаление календаря
            $unicalendar->unicalendarDelete(intval($_REQUEST['id']));
            break;    
    }
}
    // проверяем на наличие файла uca.res.php и если файл существует - удаляем его, начиная с версии >= v1.1.3 он не нужен 
	if (file_exists(BASE_DIR . '/modules/unicalendar/uca.res.php')) unlink(BASE_DIR . '/modules/unicalendar/uca.res.php'); 

?>