<?php

/**
 * Модуль "Контакты New"
 *
 * @package AVE.cms
 * @subpackage module: ContactsNew
 * @since 1.4
 * @author vudaltsov
 * @filesource
 */

if(!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
	$modul['ModuleName'] = 'Контакты New';
	$modul['ModuleSysName'] = 'contactsnew';
	$modul['ModuleVersion'] = '1.2.4';
	$modul['ModuleDescription'] = 'Данный модуль предназначен для создания веб-форм (например, обратной связи или простейшего оформления заказа), которые могут состоять из любого набора полей. Для вывода в публичной части сайта используйте тег <strong>[mod_contactsnew:XXX]</strong>, где XXX - это id или алиас формы.';
	$modul['ModuleAutor'] = 'vudaltsov UPD Repellent';
	$modul['ModuleCopyright'] = '&copy; 2007-2017 AVE.CMS Team';
	$modul['ModuleIsFunction'] = 1;
	$modul['ModuleAdminEdit'] = 1;
	$modul['ModuleFunction'] = 'mod_contactsnew';
	$modul['ModuleTag'] = '[mod_contactsnew:alias/id:email]';
	$modul['ModuleTagLink'] = null;
	$modul['ModuleAveTag'] = '#\\\[mod_contactsnew:([A-Za-z0-9-_]{1,20})]#';
	$modul['ModulePHPTag'] = "<?php mod_contactsnew(''$1''); ?>";
}

/**
 * Тег
 */
function mod_contactsnew($alias_id)
{
	global $AVE_Template;

	require_once(BASE_DIR . '/modules/contactsnew/class.contactsnew.php');

	$contactsnew = new ContactsNew;
	$contactsnew->tpl_dir = BASE_DIR . '/modules/contactsnew/templates/';

	$lang_file = BASE_DIR . '/modules/contactsnew/lang/' . $_SESSION['user_language'] . '.txt';
	$AVE_Template->config_load($lang_file);

	echo $contactsnew->form_display($alias_id);
}

/**
 * AJAX-методы
 */
if (! defined('ACP') && isset($_REQUEST['module']) && $_REQUEST['module'] == 'contactsnew')
{
	global $AVE_Template;

	$alias_id = $_REQUEST['alias_id'];

	require_once(BASE_DIR . '/modules/contactsnew/class.contactsnew.php');

	$contactsnew = new ContactsNew;
	$contactsnew->tpl_dir = BASE_DIR . '/modules/contactsnew/templates/';

	$lang_file = BASE_DIR . '/modules/contactsnew/lang/' . $_SESSION['user_language'] . '.txt';
	$AVE_Template->config_load($lang_file);

	switch($_REQUEST['action'])
	{
		case '':
		case 'full':
			exit ($contactsnew->form_display($alias_id));

		case 'validate':
			$contactsnew->form_display($alias_id);
			$contactsnew->_json($contactsnew->form['ajax'], true);
	}
}

/**
 * Админка
 */
if (defined('ACP') && isset($_REQUEST['mod']) && $_REQUEST['mod'] == 'contactsnew' && !empty($_REQUEST['moduleaction']))
{
	$fid = !empty($_REQUEST['fid']) ? (int)$_REQUEST['fid'] : 0;

	require_once(BASE_DIR . '/modules/contactsnew/class.contactsnew.php');

	$contactsnew = new ContactsNew;
	$contactsnew->tpl_dir = BASE_DIR . '/modules/contactsnew/templates/';

	$lang_file = BASE_DIR . '/modules/contactsnew/lang/' . $_SESSION['admin_language'] . '.txt';
	$AVE_Template->config_load($lang_file);

	// создаём переменные с версией движка
	$ave14 = ((float)str_replace(',', '.', APP_VERSION) < 1.5);
	$AVE_Template->assign('ave14', $ave14);
	$AVE_Template->assign('ave15', !$ave14);

	switch($_REQUEST['moduleaction'])
	{
		case '1':
			$contactsnew->forms_list();
			break;

		case 'form_edit':
			$response = $contactsnew->form_edit($fid);
			break;

		case 'form_save':
			$response = $contactsnew->form_save($fid);
			// если передан запрос на обновление полей, передаём tpl
			if (isset($_REQUEST['fields_reload']) && $_REQUEST['fields_reload'] == 1)
			{
				exit ($contactsnew->form_fields_fetch());
			}
			break;

		case 'form_del':
			$contactsnew->form_del($fid);
			header('Location: index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=1&cp=' . SESSION);
			exit;

		case 'form_copy':
			$fid_new = $contactsnew->form_copy($fid);
			$_SESSION['module_contactsnew_admin'][$fid_new]['edit_alert'] = array('text' => 'copied', 'theme' => 'accept');
			header('Location: index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=form_edit&fid=' . $fid_new . '&cp=' . SESSION);
			exit;

		case 'email_validate':
			$response = (int)$contactsnew->_email_validate($_REQUEST['email']);
			break;

		case 'alias_validate':
			$response = $contactsnew->_alias_validate($_REQUEST['alias'],$fid);
			$response = ($response === 'syn') ? 'syn' : (int)$response;
			break;

		case 'history_list':
			$contactsnew->history_list($fid);
			break;

		case 'email_del':
		    $hid = !empty($_REQUEST['hid']) ? (int)$_REQUEST['hid'] : 0;
			$contactsnew->email_del($hid);
			$fid = !empty($_REQUEST['fid']) ? (int)$_REQUEST['fid'] : 0;
			header('Location: index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=history_list&fid=' . $fid . '&cp=' . SESSION);
			exit;

		case 'history_dialog':
			$hid = !empty($_REQUEST['hid']) ? (int)$_REQUEST['hid'] : 0;
			$contactsnew->history_dialog($hid);
			break;

		case 'history_dialog_submit':
			$hid = !empty($_REQUEST['hid']) ? (int)$_REQUEST['hid'] : 0;
			$contactsnew->history_dialog_submit($hid);
			break;

		case 'dialog_status':
			$hid = !empty($_REQUEST['hid']) ? (int)$_REQUEST['hid'] : 0;
			$contactsnew->dialog_status($hid);
			break;
	}
	if ($_REQUEST['ajax']) exit((string)$response);
}
?>