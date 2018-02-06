<?php

if (!function_exists('isAjax'))
{
	function isAjax()
	{
		return (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && (strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest'));
	}
}

/**
 * Модуль "Контакты New"
 *
 * @package AVE.cms
 * @subpackage module: ContactsNew
 * @since 1.4
 * @author vudaltsov UPD Repellent
 * @filesource
 */

class ContactsNew
{

/**
 *	Свойства класса
 */

	// папка с шаблонами
	public $tpl_dir;
	// основные поля
	public $fields_main = array();
	public $fields_main_in_string = array();
	public $fields_main_data = array(
		'email' => array(
			'new'		=> true,
			'title'		=> 'email',
			'type'		=> 'input',
			'main'		=> 1,
			'setting'	=> 'FILTER_VALIDATE_EMAIL',
			'required'	=> 1
		),
		'subject' => array(
			'new'		=> true,
			'title'		=> 'subject',
			'type'		=> 'input',
			'main'		=> 1
		),
		'receivers' => array(
			'new'		=> true,
			'title'		=> 'receivers',
			'type'		=> 'select',
			'main'		=> 1,
			'setting'	=> array()
		),
		'copy' => array(
			'new'		=> true,
			'title'		=> 'copy',
			'type'		=> 'checkbox',
			'main'		=> 1
		),
		'captcha' => array(
			'new'		=> true,
			'title'		=> 'captcha',
			'type'		=> 'input',
			'main'		=> 1,
			'required'	=> 1
		)
	);
	// переменная для хранения формы
	public $form = array();

/**
 *	Внутренние методы класса
 */

	/**
	 * Конструктор
	 */
	function __construct ()
	{
		$this->fields_main = array_keys($this->fields_main_data);
		$this->fields_main_in_string = "'" . implode("','",$this->fields_main) . "'";
	}


	/**
	 * Возвращаем JSON
	 */
	function _json($data, $exit = false)
	{
		header("Content-Type: application/json;charset=utf-8");

		$json = json_encode($data);

		if ($json === false)
		{
			$json = json_encode(array("jsonError", json_last_error_msg()));

			if ($json === false)
			{
				$json = '{"jsonError": "unknown"}';
			}

			http_response_code(500);
		}

		echo $json;

		if ($exit)
			exit;
	}


	/**
	 * Метод забирает форму из бд по алиасу/id
	 */
	function _form ($alias_id, $_fields = true)
	{
		global $AVE_DB, $AVE_Template;

		// иначе забираем из бд форму
		$form = array();

		// основные параметры
		$form = $AVE_DB->Query("
			SELECT * FROM " . PREFIX . "_module_contactsnew_forms
			WHERE
				" . (is_numeric($alias_id) ? 'id' : 'alias') . " = '" . $alias_id . "'
		")->FetchAssocArray();

		// если форма не обнаружена, выходим
		if (empty($form))
			return array();

		$form['alias_id'] = $alias_id;

		// получатели
		$form['mail_set'] = unserialize($form['mail_set']);

		if ($_fields === true)
		{
			// поля
			$sql = $AVE_DB->Query("
				SELECT * FROM " . PREFIX . "_module_contactsnew_fields
				WHERE form_id = '" . $form['id'] . "'
				ORDER BY id ASC
			");

			$form['fields'] = array();

			while ($field = $sql->FetchAssocArray())
			{
				// раскрываем массив настроек для селектов
				if (in_array($field['type'],array('select','multiselect','doc','multidoc')))
				{
					// @fix для v1.0 beta <= 2: поддержка одной рубрики, не массива
					if (in_array($field['type'],array('doc','multidoc')) && !empty($field['setting']) && is_numeric($field['setting']))
						$field['setting'] = array(0 => $field['setting']);
					else
						$field['setting'] = unserialize($field['setting']) !== false ? unserialize($field['setting']) : array();
				}
				// если тип поля поменялся, ставим пустую строку
				elseif (unserialize($field['setting']) !== false) $field['setting'] = '';

				// раскрываем массив опций по умолчанию для мультиселекта
				if ($field['type'] == 'multiselect')
				{
					$field['defaultval'] = unserialize($field['defaultval']) !== false ? unserialize($field['defaultval']) : array();
				}
				// если тип поля поменялся, ставим пустую строку
				elseif (unserialize($field['defaultval']) !== false) $field['defaultval'] = '';

				// главные поля
				if (in_array($field['title'],$this->fields_main) && $field['main'])
				{
					$form['fields_main'][$field['title']] = $field['id'];
					$field['title_lang'] = $AVE_Template->get_config_vars('mfld_' . $field['title']);
				}

				$form['fields'][$field['id']] = $field;
			}
		}

		// убираем слеши
		$form = $this->_stripslashes($form);

		// сохраняем форму в переменную класса
		$this->form = $form;

		return $form;
	}

	/**
	 * Метод убирает слэши во всей переменной
	 */
	function _stripslashes($var)
	{
		if (! is_array($var))
			return stripslashes($var);
		else
			return array_map(array($this, '_stripslashes'), $var);
	}

	/**
	 * Метод тримует всю переменную
	 */
	function _trim($var)
	{
		if (! is_array($var))
			return trim($var);
		else
			return array_map(array($this, '_trim'), $var);
	}

	/**
	 * Метод чистит переменную от пустых значений и массивов
	 */
	function _cleanvar($var)
	{
		if (! is_array($var))
			return trim($var) > ''
				? trim($var)
				: null;

		$narr = array();

		while(list($key, $val) = each($var))
		{
			if (is_array($val))
			{
				$val = _cleanvar($val);

				if (count($val) > 0)
					$narr[$key] = $val;
			}
			else
			{
				if (trim($val) > '')
					$narr[$key] = $val;
			}
		}

		unset ($var);

		return $narr;
	}

	/**
	 * Валидация Email-а
	 */
	function _email_validate ($email = '')
	{
		return (filter_var($email, FILTER_VALIDATE_EMAIL) === false ? false : true);
	}

	/**
	 * Проверка алиаса тега на валидность и уникальность
	 */
	function _alias_validate ($alias = '', $fid = 0)
	{
		global $AVE_DB;

		// соответствие требованиям
		if (
			empty ($alias) ||
			preg_match('/^[A-Za-z0-9-_]{1,20}$/i', $alias) !== 1 ||
			is_numeric($alias)
		) return 'syn';

		// уникальность
		return !(bool)$AVE_DB->Query("
			SELECT 1 FROM " . PREFIX . "_module_contactsnew_forms
			WHERE
				alias	= '" . $alias . "' AND
				id		!= '" . $fid . "'
		")->GetCell();
	}


	/**
	 * Получение списка рубрик
	 */
	function _rubrics ()
	{
		global $AVE_DB;

		$rubs = array();

		$sql = $AVE_DB->Query("
			SELECT Id, rubric_title FROM " . PREFIX . "_rubrics
		");

		while ($rub = $sql->FetchAssocArray())
			$rubs[$rub['Id']] = $rub['rubric_title'];

		return $rubs;
	}


	/**
	 * Получение списка документов
	 */
	function _docs ($rubs_id = array())
	{
		global $AVE_DB;

		if (empty($rubs_id))
			return array();

		// @fix для v1.0 beta <= 2: поддержка одной рубрики, не массива
		if (! is_array($rubs_id))
			$rubs_id = array(0 => $rubs_id);

		$docs = array();

		$sql = $AVE_DB->Query("
			SELECT Id, document_title FROM " . PREFIX . "_documents
			WHERE rubric_id IN (" . implode(',',$rubs_id) . ")
		");

		while ($doc = $sql->FetchAssocArray())
			$docs[$doc['Id']] = $doc['document_title'];

		return $docs;
	}


	/**
	 * Парсинг главных тегов
	 */
	function _parse_tags ($str)
	{
		global $AVE_Core, $AVE_DB;

		if (empty($_SESSION['user_login']))
			$_SESSION['user_login'] = (UGROUP != 2)
				? $AVE_DB->Query("SELECT user_name FROM " . PREFIX . "_users WHERE Id = '" . UID . "'")->GetCell()
				: '';

		$str = preg_replace_callback('/\[tag:(css|js):([^ :\/]+):?(\S+)*\]/', array($AVE_Core, '_parse_combine'), $str);

		$str = parse_hide($str);

		return str_replace(array(
				'[tag:docid]',
				'[tag:formtitle]',
				// @fix для v1.0 beta <= 2: поддержка тега formaction
				'[tag:formaction]',
				'[tag:document]',
				'[tag:formalias]',
				'[tag:path]',
				'[tag:mediapath]',
				'[tag:captcha]',
				'[tag:uname]',
				'[tag:ufname]',
				'[tag:ulname]',
				'[tag:ulogin]',
				'[tag:uemail]',
				'[tag:sitename]',
				'[tag:sitehost]',
			),array(
				$AVE_Core->curentdoc->Id,
				$this->form['title'],
				$_SERVER['REQUEST_URI'],
				$_SERVER['REQUEST_URI'],
				$this->form['alias'] ? $this->form['alias'] : $this->form['id'],
				ABS_PATH,
				ABS_PATH . 'templates/' . THEME_FOLDER . '/',
				'inc/captcha.php',
				$_SESSION['user_name'],
				get_user_rec_by_id(UID)->firstname,
				get_user_rec_by_id(UID)->lastname,
				$_SESSION['user_login'],
				$_SESSION['user_email'],
				htmlspecialchars(get_settings('site_name'), ENT_QUOTES),
				$_SERVER['HTTP_HOST'],
		), $str);
	}

	/**
	 * Внутренний PHP-парсер
	 */
	function _eval2var($code)
	{
		global $AVE_DB, $AVE_Core, $AVE_Template;

		ob_start();

		eval($code);

		return ob_get_clean();
	}

	/**
	 * Приведение тегов главных полей к стандартной форме
	 */
	function _parse_tag_fld_main ($tpl='', $save_is=false)
	{
		foreach ($this->fields_main as $field_title)
		{
			$count = 0;

			$tpl = str_replace(array(
				'[tag:fld:' . $field_title . ']',
				'[tag:if_fld:' . $field_title,
				'[tag:elseif_fld:' . $field_title,
			), array(
				'[tag:fld:' . $this->form['fields_main'][$field_title] . ']',
				'[tag:if_fld:' . $this->form['fields_main'][$field_title],
				'[tag:elseif_fld:' . $this->form['fields_main'][$field_title],
			),$tpl,$count);

			if ($save_is)
				$this->form['is_' . $field_title] = $count > 0 ? true : false;
		}

		return $tpl;
	}

	/**
	 * Замена тега условия
	 */
	function _parse_tag_if (&$tpl,$tag='',$open = true)
	{
		if ($open)
			$tpl = str_replace(array('[tag:' . $tag . ']','[/tag:' . $tag . ']'),'',$tpl);
		else
			$tpl = preg_replace('/\[tag:' . $tag . '](.*?)\[\/tag:' . $tag . ']/si','',$tpl);
	}

	/**
	 * Замена тега названия поля
	 */
	function _parse_tag_title ($matches)
	{
		$field_id = $matches[1];

		return !$this->form['fields'][$field_id]['main']
			? $this->form['fields'][$field_id]['title']
			: $this->form['fields'][$field_id]['title_lang'];
	}

	/**
	 * Замена тега поля на значение $_POST
	 */
	function _parse_tag_fld_post ($matches)
	{
		return $_POST['form-' . $this->form['alias_id']][$matches[1]];
	}

	/**
	 * Замена тега поля при выводе формы
	 */
	function _parse_tag_fld_form ($matches)
	{
		$field_id = (int)$matches[1];

		// забираем массив поля
		$field = $this->form['fields'][$field_id];

		// если поля нет, возвращаем тег обратно
		if (empty($field))
			return $matches[0];

		// если поле выключено, возвращаем пустую строку
		if (empty($field['active']))
			return '';

		$alias_id = $this->form['alias_id'];

		$fld_val = $this->form['is_submited']
			? $this->_stripslashes($_POST['form-' . $alias_id][$field_id])
			: (in_array($field['type'],array('input','textarea'))
				? $this->_eval2var('?>' . $field['defaultval'] . '<?')
				: $field['defaultval']);

		$attributes = trim($field['attributes']);

		$this->form['fields'][$field_id]['is_used'] = true;

		$input = '';
		$return = '';

		switch ($field['type'])
		{
				case 'input':
				$input = '<input ' . (strpos(strtolower($attributes),'type=') === false ? ' type="text" ' : ' ') . '
				 name="form-' . $alias_id . '[' . $field['id'] . ']"
				 ' . (strpos(strtolower($attributes),'value=') === false ? ' value="' . ($field['title'] == 'captcha' ? '' : htmlspecialchars($fld_val,ENT_QUOTES)) . '" ' : ' ') . ' ' . $attributes . '>';
				break;

			case 'textarea':
				$input = '<textarea name="form-' . $alias_id . '[' . $field['id'] . ']" ' . $attributes . '>' . htmlspecialchars($fld_val,ENT_QUOTES) . '</textarea>';
				break;

			case 'select':
				$input = '<select name="form-' . $alias_id . '[' . $field['id'] . ']" ' . $attributes . '>';
				foreach ($field['setting'] as $val => $title)
				{
					$input .= '<option value="' . $val . '"' . ($val == $fld_val ? ' selected="selected"' : '') . '>' . (is_array($title) ? $title['name'] : $title) . '</option>';
				}
				$input .= '</select>';
				break;

			case 'multiselect':
				$input = '<select multiple="multiple" name="form-' . $alias_id . '[' . $field['id'] . '][]" ' . $attributes . '>';
				foreach ($field['setting'] as $val => $title)
				{
					$input .= '<option value="' . $val . '"' . (in_array($val,$fld_val) ? ' selected="selected"' : '') . '>' . $title . '</option>';
				}
				$input .= '</select>';
				break;

			case 'checkbox':
				$input = '
					<input type="hidden" name="form-' . $alias_id . '[' . $field['id'] . ']" value="0">
					<input type="checkbox" name="form-' . $alias_id . '[' . $field['id'] . ']"' . ($fld_val ? ' checked="checked"' : '') . ' value="1"	 ' . $attributes . '>';
				break;

			case 'file':
				$input = '<input type="file" name="form-' . $alias_id . '[' . $field['id'] . ']" ' . $attributes . '>';
				break;

			case 'doc':
				$input = '<select name="form-' . $alias_id . '[' . $field['id'] . ']" ' . $attributes . '>';
				$docs = $this->_docs($field['setting']);
				foreach ($docs as $val => $title)
				{
					$input .= '<option value="' . $val . '"' . ($val == $fld_val ? ' selected="selected"' : '') . '>' . $title . '</option>';
				}
				$input .= '</select>';
				break;

			case 'multidoc':
				$input = '<select multiple="multiple" name="form-' . $alias_id . '[' . $field['id'] . '][]" ' . $attributes . '>';
				$docs = $this->_docs($field['setting']);
				foreach ($docs as $val => $title)
				{
					$input .= '<option value="' . $val . '"' . (in_array($val,$fld_val) ? ' selected="selected"' : '') . '>' . $title . '</option>';
				}
				$input .= '</select>';
				break;
		}

		// вставляем поле в шаблон поля
		$return = trim($field['tpl']) > ''
			? str_replace('[tag:fld]',$input,$field['tpl'])
			: $input;

		// парсим теги названия и id
		$return = str_replace(array(
			'[tag:id]',
			'[tag:title]',
		), array(
			$field['id'],
			'[tag:title:' . $field_id . ']',
		), $return);

		// если попытка отправить форму, обрабатываем валидацию и пустоту
		if ($this->form['is_submited'])
		{
			// валидация (только для капчи, input, textarea и file)
			if (
				($field['title'] == 'captcha' && $field['main'] && $this->form['is_captcha'] === true) ||
				(in_array($field['type'],array('input','textarea','file')) && !empty($field['setting']))
			)
			{
				$valid = false;
				// если капча
				if ($field['title'] == 'captcha') $valid = (empty($_SESSION['captcha_keystring']) || empty($fld_val) || $_SESSION['captcha_keystring'] != $fld_val) ? false : true;
				// если файл
				elseif ($field['type'] == 'file') $valid = ($_FILES['form-' . $alias_id]['size'][$field_id] / 1024 / 1024) <= $field['setting'];
				// если передали регулярку
				elseif ($field['setting']{0} == '/') $valid = preg_match($field['setting'],$fld_val) === 1 ? true : false;
				// если константу
				elseif (defined($field['setting'])) $valid = filter_var($fld_val,constant($field['setting'])) !== false ? true : false;
				// иначе, ничего не делаем
				else return 'Неверные параметры валидации!';
				// парсим теги валидности
				$this->_parse_tag_if($return,'if_valid',$valid);
				$this->_parse_tag_if($return,'if_invalid',!$valid);
				// записываем результаты
				$this->form['ajax']['fields'][$field_id]['validate'] = true;
				$this->form['ajax']['fields'][$field_id]['pattern'] = $field['setting'];
				$this->form['ajax']['fields'][$field_id]['is_valid'] = $valid;
				if (!$valid)
				{
					$this->form['is_valid'] = false;
					$this->form['ajax']['form']['is_valid'] = false;
				}
			}
			else
			{
				$this->form['ajax']['fields'][$field_id]['validate'] = false;
				$this->form['ajax']['fields'][$field_id]['is_valid'] = null;
			}

			// пустота (для любых обязательных полей)
			if (! empty($field['required']) && $field['required'])
			{
				if ($field['type'] == 'file')
					$empty = (
						 empty($_FILES['form-' . $alias_id]['tmp_name'][$field_id]) ||
						!empty($_FILES['form-' . $alias_id]['error'][$field_id])
					);
				else
				{
					$clean_fld_val = $this->_cleanvar($fld_val);
					$empty = empty($clean_fld_val);
				}
				// парсим теги
				$this->_parse_tag_if($return,'if_empty',$empty);
				$this->_parse_tag_if($return,'if_notempty',!$empty);
				// записываем результаты
				$this->form['ajax']['fields'][$field_id]['required'] = true;
				$this->form['ajax']['fields'][$field_id]['is_empty'] = $empty;
				if ($empty)
				{
					$this->form['is_valid'] = false;
					$this->form['ajax']['form']['is_valid'] = false;
				}
			}
			else
			{
				$this->form['ajax']['fields'][$field_id]['required'] = false;
				$this->form['ajax']['fields'][$field_id]['is_empty'] = null;
			}
		}
		// удаляем оставшиеся теги
		$this->_parse_tag_if($return,'if_valid',false);
		$this->_parse_tag_if($return,'if_invalid',false);
		$this->_parse_tag_if($return,'if_empty',false);
		$this->_parse_tag_if($return,'if_notempty',false);

		return $return;
	}

	/**
	 * Замена тега поля в шаблоне письма
	 */
	function _parse_tag_fld_mail ($matches)
	{
		global $AVE_DB, $AVE_Template;

		$field_id = (int)$matches[1];
		// забираем массив поля
		$field = $this->form['fields'][$field_id];
		// если поля нет, возвращаем тег обратно
		if (empty($field)) return $matches[0];
		// если поля не было в шаблоне формы, убираем тег
		if ($field['is_used'] !== true || empty($field['active'])) return '';
		// иначе, продолжаем
		$alias_id = $this->form['alias_id'];
		$val = $_POST['form-' . $alias_id][$field_id];
		$newval = '';
		$tag_mail_empty = ($this->form['mail_set']['format'] === 'text' ? '<' : '&lt;') . $AVE_Template->get_config_vars('tag_mail_empty') . ($this->form['mail_set']['format'] === 'text' ? '>' : '&gt;');

		// делаем поправки для типов
		switch ($field['type'])
		{
			case 'select':
				$newval = $field['setting'][$val];
				if ($field['title'] == 'receivers') $newval = $newval['name'];
				break;

			case 'multiselect':
				foreach ($val as $val1) $newval .= $field['setting'][$val1] . ',';
				$newval = rtrim($newval,',');
				break;

			case 'checkbox':
				$newval = ($val ? $AVE_Template->get_config_vars('yes') : $AVE_Template->get_config_vars('no'));
				break;

			case 'doc':
				if (!empty($val)) $newval = $AVE_DB->Query("SELECT document_title FROM " . PREFIX . "_documents WHERE Id='" . $val . "'")->GetCell();
				break;

			case 'multidoc':
				if (!empty($val))
				{
					$sql = $AVE_DB->Query("SELECT document_title FROM " . PREFIX . "_documents WHERE Id IN (" . implode(',',$val) . ")");
					while ($titl = $sql->GetCell()) $titls[] = $titl;
					$newval = implode(', ',$titls);
				}
				break;

			case 'file':
				$newval = implode(', ',$_FILES['form-' . $alias_id]['name']);
				break;

			default:
				$newval = $val;
		}
		return (empty($newval) ? $tag_mail_empty : $newval);
	}

/**
 *	Внешние методы класса
 */

	/**
	 * Вывод списка форм
	 */
	function forms_list ()
	{
		global $AVE_DB, $AVE_Template;
		$assign = array();

		$limit = 20;
		$start = get_current_page() * $limit - $limit;
		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS
				f.*,
				SUM(IF(h.status='new',1,0)) AS history_new,
				SUM(IF(h.status='viewed',1,0)) AS history_viewed,
				SUM(IF(h.status='replied',1,0)) AS history_replied
			FROM " . PREFIX . "_module_contactsnew_forms AS f
			LEFT OUTER JOIN " . PREFIX . "_module_contactsnew_history AS h ON f.id = h.form_id
			GROUP BY f.id
			ORDER BY f.id ASC
			LIMIT " . $start . "," . $limit . "
		");
		$num = (int)$AVE_DB->Query("SELECT FOUND_ROWS()")->GetCell();
		$pages = @ceil($num / $limit);
		if ($num > $limit)
		{
			$page_nav = '<a class="pnav" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=1&amp;page={s}&amp;cp=' . SESSION . '">{t}</a>';
			$page_nav = get_pagination($pages, 'page', $page_nav);
			$AVE_Template->assign('page_nav', $page_nav);
		}

		while ($row = $sql->FetchAssocArray())
		{
			$assign['forms'][] = $row;
		}

		$AVE_Template->assign($assign);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'forms.tpl'));
	}

	/**
	 * Создание/редактирование формы
	 */
	function form_edit ()
	{
		global $AVE_DB, $AVE_Template;
		$form = array();
		$assign = array();
		$fid = $assign['fid'] = !empty($_REQUEST['fid']) ? (int)$_REQUEST['fid'] : 0;

		if ($fid)
		{
			$form = $this->_form($fid);

			// для правильного вывода селектов
			if (empty($form['mail_set']['receivers'])) $form['mail_set']['receivers'] = array(0 => array());
			foreach ($form['fields'] as &$field)
			{
				if (($field['type'] == 'select' || $field['type'] == 'multiselect') && empty($field['setting']))
				{
					$field['setting'] = array(0 => '');
					$field['setting_empty'] = true;
				}
			}
		}

		// алерт при открытии правки
		if (!empty($_SESSION['module_contactsnew_admin'][$fid]['edit_alert']))
		{
			$assign['alert']['text'] = $AVE_Template->get_config_vars($_SESSION['module_contactsnew_admin'][$fid]['edit_alert']['text']);
			$assign['alert']['theme'] = $_SESSION['module_contactsnew_admin'][$fid]['edit_alert']['theme'];
			unset($_SESSION['module_contactsnew_admin'][$fid]['edit_alert']);
		}
		$assign['form'] = $form;
		$assign['form_fields_tpl'] = $this->tpl_dir . 'form_fields.tpl';
		$assign['rubrics'] = $this->_rubrics();

		// назначаем массив CodeMirror
		$assign['codemirror'] = array(
			'rubheader'			=> 200,
			'from_name'			=> 60,
			'from_email'		=> 60,
			'subject_tpl'		=> 60,
			'form_tpl'			=> 460,
			'mail_tpl'			=> 460,
			'finish_tpl'		=> 320,
			'code_onsubmit'		=> 200,
			'code_onvalidate'	=> 200,
			'code_onsend'		=> 200
		);

		$AVE_Template->assign($assign);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'form_edit.tpl'));
	}

	/**
	 * Получение полей через аякс
	 */
	function form_fields_fetch ()
	{
		global $AVE_DB, $AVE_Template;
		$fid = $assign['fid'] = !empty($_REQUEST['fid']) ? (int)$_REQUEST['fid'] : 0;
		if (!$fid) return;
		$form = $this->_form($fid);
		// для правильного вывода селектов
		if (empty($form['mail_set']['receivers'])) $form['mail_set']['receivers'] = array(0 => array());
		foreach ($form['fields'] as &$field)
		{
			if (($field['type'] == 'select' || $field['type'] == 'multiselect') && empty($field['setting']))
			{
				$field['setting'] = array(0 => '');
				$field['setting_empty'] = true;
			}
		}
		$AVE_Template->assign('fields',$form['fields']);
		$AVE_Template->assign('rubrics',$this->_rubrics());
		$AVE_Template->assign('field_tpl_open',$_REQUEST['field_tpl_open']);

		return $AVE_Template->fetch($this->tpl_dir . 'form_fields.tpl');
	}

	/**
	 * Сохранение формы
	 */
	function form_save ($fid)
	{
		global $AVE_DB;

		// проверяем Email-ы получателей
		$receivers = array();
		foreach ($_REQUEST['mail_set']['receivers'] as $receiver)
		{
			if ($this->_email_validate($receiver['email'])) $receivers[] = $receiver;
		}
		$_REQUEST['mail_set']['receivers'] = $receivers;
		// параметры отправителя
		if (!trim($_REQUEST['mail_set']['from_email']) > '') $_REQUEST['mail_set']['from_email'] = get_settings('mail_from');
		if (!trim($_REQUEST['mail_set']['from_name']) > '') $_REQUEST['mail_set']['from_name'] = get_settings('mail_from_name');

		if ($fid)
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_module_contactsnew_forms
				SET
					title			= '" . addslashes($_REQUEST['title']) . "',
					protection		= '" . (int)$_REQUEST['protection'] . "',
					" . (($_REQUEST['alias'] === '' || $this->_alias_validate($_REQUEST['alias'],$fid) === true) ? " alias = '" . $_REQUEST['alias'] . "'," : '') . "
					mail_set		= '" . addslashes(serialize($_REQUEST['mail_set'])) . "',
					rubheader		= '" . addslashes($_REQUEST['rubheader']) . "',
					form_tpl		= '" . addslashes($_REQUEST['form_tpl']) . "',
					mail_tpl		= '" . addslashes($_REQUEST['mail_tpl']) . "',
					finish_tpl		= '" . addslashes($_REQUEST['finish_tpl']) . "',
					code_onsubmit	= '" . addslashes($_REQUEST['code_onsubmit']) . "',
					code_onvalidate	= '" . addslashes($_REQUEST['code_onvalidate']) . "',
					code_onsend		= '" . addslashes($_REQUEST['code_onsend']) . "'
				WHERE
					id = '" . $fid . "'
			");
		}
		else
		{
			$mail_set = array(
				'from_name'		=> get_settings('mail_from_name'),
				'from_email'	=> get_settings('mail_from'),
				'receivers' 	=> array(0 => array(
						'name'	=> get_settings('mail_from_name'),
						'email'	=> get_settings('mail_from')
					),
				),
				'subject_tpl'	=> '[tag:formtitle]',
				'format'		=> 'text'
			);
			$AVE_DB->Query("
				INSERT INTO " . PREFIX . "_module_contactsnew_forms
				SET
					title		= '" . addslashes($_REQUEST['title']) . "',
					" . (($this->_alias_validate($_REQUEST['alias'],$fid) === true || $_REQUEST['alias'] === '') ? " alias = '" . $_REQUEST['alias'] . "'," : '') . "
					mail_set	= '" . addslashes(serialize($mail_set)) . "'
			");
			$fid = (int)$AVE_DB->InsertId();
			$_REQUEST['fields'] = $this->fields_main_data;
			// прописываем алерт об успешном создании
			if ($fid > 0) $_SESSION['module_contactsnew_admin'][$fid]['edit_alert'] = array('text' => 'created', 'theme' => 'accept');

			// если устанавливаем пример
			if (!empty($_REQUEST['demo']))
			{
				$demo = array();
				include(BASE_DIR . '/modules/contactsnew/demo.php');
				$_REQUEST = array_merge($_REQUEST,$demo);
				// обновляем форму с данными примера
				$this->form_save($fid);
				// подставляем в шаблон новые id полей
				$demo['form_tpl'] = preg_replace_callback('/\[tag:fld:(\d+)]/', create_function('$matches','return "[tag:fld:" . $_REQUEST["demo_change"][(int)$matches[1]] . "]";'),$demo['form_tpl']);
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_module_contactsnew_forms
					SET
						form_tpl = '" . addslashes($demo['form_tpl']) . "'
					WHERE id = '" . $fid . "'
				");
				return $fid;
			}
		}

		// сохраняем поля
		foreach ($_REQUEST['fields'] as $field_id => $field)
		{
			if (!trim($field['title'])) continue;
			if (is_array($field['setting']))
			{
				$settings = array();
				foreach ($field['setting'] as $setting)
				{
					// если получатели
					if ($field['title'] == 'receivers' && is_array($setting) && trim($setting['name']) > '' && trim($setting['email']) > '' && $this->_email_validate($setting['email']))
						$settings[] = $setting;
					// другое
					elseif (!is_array($setting) && trim($setting) > '')
						$settings[] = $setting;
				}
				$field['setting'] = serialize($settings);
			}
			elseif ($field['type'] == 'file') $field['setting'] = (int)$field['setting'];

			if (is_array($field['defaultval'])) $field['defaultval'] = serialize($field['defaultval']);

			$sql = 	"
				title		= '" . addslashes($field['title']) . "',
				active		= '" . (int)$field['active'] . "',
				type		= '" . $field['type'] . "',
				setting		= '" . addslashes($field['setting']) . "',
				required	= '" . (int)$field['required'] . "',
				defaultval	= '" . addslashes($field['defaultval']) . "',
				attributes	= '" . addslashes(trim($field['attributes'])) . "',
				tpl			= '" . addslashes($field['tpl']) . "'
			";
			if ($field['new'])
			{
				$AVE_DB->Query("
					INSERT INTO " . PREFIX . "_module_contactsnew_fields
					SET
						form_id	= '" . (int)$fid . "',
						main	= '" . (int)$field['main'] . "',
						" . $sql . "
				");
				if ($_REQUEST['demo']) $_REQUEST['demo_change'][$field_id] = (int)$AVE_DB->InsertId();
			}
			else
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_module_contactsnew_fields
					SET
						" . $sql . "
					WHERE
						id			= '" . (int)$field_id . "' AND
						form_id		= '" . $fid . "'
				");
			}
		}
		foreach ($_REQUEST['field_del'] as $field_id => $delete)
		{
			if (empty($delete)) continue;
			$AVE_DB->Query("
				DELETE FROM " . PREFIX . "_module_contactsnew_fields
				WHERE
					id		 = '" . (int)$field_id . "' AND
					main	!= '1'
			");
		}

		return $fid;
	}

	/**
	 * Удаление формы
	 */
	function form_del ($fid)
	{
		global $AVE_DB;

		$AVE_DB->Query("
			DELETE FROM " . PREFIX . "_module_contactsnew_forms
			WHERE id = '" . $fid . "'
		");
		$AVE_DB->Query("
			DELETE FROM " . PREFIX . "_module_contactsnew_fields
			WHERE form_id = '" . $fid . "'
		");
	}

	/**
	 * Сохранение формы
	 */
	function form_copy ($fid)
	{
		global $AVE_DB;

		// форма
		$form = $AVE_DB->Query("
			SELECT * FROM " . PREFIX . "_module_contactsnew_forms
			WHERE id = '" . $fid . "'
		")->FetchAssocArray();
		if (empty($form)) return;
		$query = "INSERT INTO " . PREFIX . "_module_contactsnew_forms SET ";
		foreach ($form as $key => $val)
		{
			if ($key == 'id' || $key == 'alias') continue;
			$query .= $key . " = '" . addslashes($val) . "', ";
		}
		$query = rtrim($query,', ');
		$AVE_DB->Query($query);
		$fid_new = (int)$AVE_DB->InsertId();

		// поля
		$sql = $AVE_DB->Query("
			SELECT * FROM " . PREFIX . "_module_contactsnew_fields
			WHERE form_id = '" . $fid . "'
		");
		while ($row = $sql->FetchAssocArray())
		{
			if (empty($row['id'])) continue;
			$query = "INSERT INTO " . PREFIX . "_module_contactsnew_fields SET ";
			foreach ($row as $key => $val)
			{
				if ($key == 'id') continue;
				elseif ($key == 'form_id') $val = $fid_new;
				$query .= $key . " = '" . addslashes($val) . "', ";
			}
			$query = rtrim($query,', ');
			$AVE_DB->Query($query);
		}

		return $fid_new;
	}


	/**
	 * Вывод формы
	 */
	function form_display ($alias_id)
	{
		global $AVE_Template;

		$form = $this->_form($alias_id);

		if (empty($form))
			return "[mod_contactsnew:$alias_id] - " . $AVE_Template->get_config_vars('form_notfound');

		// по дефолту форма валидна, но не отправлена - потом перезаписываем, если что
		$this->form['is_valid'] = true;
		$this->form['ajax']['form']['is_valid'] = true;
		$this->form['ajax']['form']['is_sent'] = false;
		$this->form['ajax']['form']['finish_tpl'] = null;

		// rubheader
		$GLOBALS['user_header']['module_contactsnew_' . $alias_id] = $this->_parse_tags($this->form['rubheader']);

		// вывод финишной страницы, если включена проверка от повторной отправки
		if (! empty($_GET['mcnfinish']) && $form['protection'])
		{
			if ($_SESSION['mcnfinish'][$form['id'] . $_GET['mcnfinish']] === true)
			{
				unset($_SESSION['mcnfinish'][$form['id'] . $_GET['mcnfinish']]);

				// формируем финишную страницу
				$tpl = $this->_parse_tags($form['finish_tpl']);
				$tpl = $this->_eval2var('?>' . $tpl . '<?');

				return $tpl;
			}
			else
			{
				header('Location: ' . trim(str_replace('mcnfinish=' . $_GET['mcnfinish'],'',$_SERVER['REQUEST_URI']),'?&'));
				exit;
			}
		}
		// определяем (bool) отправка формы
		else
			$this->form['is_submited'] = false;

		if (! empty($_POST['form-' . $alias_id]))
		{
			$this->form['is_submited'] = true;
			// выполняем код после отправки формы
			eval('?>' . $this->form['code_onsubmit'] . '<?');
		}

		$tpl = $this->form['form_tpl'];
		// меняем теги основных полей на стандартные
		$tpl = $this->_parse_tag_fld_main($tpl,true);
		// парсим теги полей и названий
		$tpl = preg_replace_callback('/\[tag:fld:(\d+)]/', array($this,'_parse_tag_fld_form'), $tpl);
		$tpl = preg_replace_callback('/\[tag:title:([A-Za-z0-9-_]+)]/', array($this,'_parse_tag_title'),$tpl);

		// выполняем код после валидации
		eval('?>' . $this->form['code_onvalidate'] . '<?');

		// если форма валидна, отправляем её
		if ($this->form['is_submited'] === true && $this->form['is_valid'] === true)
			return $this->form_submit($alias_id);
		// иначе - заканчиваем вывод
		else
		{
			// парсим основные теги
			$tpl = $this->_parse_tags($tpl);
			// теги общей валидности
			if ($this->form['is_submited'])
			{
				$this->_parse_tag_if($tpl,'if_form_valid',$this->form['is_valid']);
				$this->_parse_tag_if($tpl,'if_form_invalid',!$this->form['is_valid']);
			}
			else
			{
				$this->_parse_tag_if($tpl,'if_form_valid',false);
				$this->_parse_tag_if($tpl,'if_form_invalid',false);
			}
			// заменяем теги условий
			$tpl = preg_replace('/\[tag:(if|elseif)_fld:(\d*)(.*?)]/si','<? $1 (\$_POST["fields"][$2]$3): ?>',$tpl);
			$tpl = str_replace(array('[tag:else_fld]','[/tag:if_fld]'),array('<? else: ?>','<? endif ?>'),$tpl);
			// выполняем код
			return $this->_eval2var('?>' . $tpl . '<?');
		}
	}


	/**
	 * Отправка формы
	 */
	function form_submit ($alias_id)
	{
		global $AVE_DB, $AVE_Template;

		$form = $this->form;

		$fields = $form['fields'];

		$fid = $form['id'];

		// формируем список получателей
		$recs = array();

		// пользователь (отправка копии)
		if (
			($form['is_copy'] === true && $_POST['form-' . $alias_id][$form['fields_main']['copy']] == 1) ||
			$fields[$form['fields_main']['copy']]['defaultval'] == 1
		)
		{
			$email = '';

			if ($form['is_email'] === true)
				$email = $_POST['form-' . $alias_id][$form['fields_main']['email']];

			if (empty($email))
				$email = $_SESSION['user_email'];

			if (! empty($email))
			{
				$recs[] = array(
					'email' => $email,
					'name'	=> $_SESSION['user_name'],
					'agent'	=> 'user',
				);
			}

			$history['email'] = $email;
		}
		else // если чекбоксы - отправить копию неактивные
		{
			$email = '';

			if ($form['is_email'] === true)
				$email = $_POST['form-' . $alias_id][$form['fields_main']['email']];

			if (empty($email))
				$email = $_SESSION['user_email'];

			$history['email'] = $email;
		}

		// главные получатели
		$recs = array_merge($recs, $form['mail_set']['receivers']);

		// выбранные в форме получатели
		if ($this->form['is_receivers'] === true)
		{
			$recs_field_id = $form['fields_main']['receivers'];
			$recs[] = $fields[$recs_field_id]['setting'][$_POST['form-' . $alias_id][$recs_field_id]];
		}

		// если ни один получатель не назначен, отправляем админскому
		if (empty($recs)) $recs[] = array(
			'name' => get_settings('mail_from_name'),
			'email' => get_settings('mail_from')
		);

		// перезаписываем список уникальных получателей в переменную письма
		$this->form['receivers'] = array();

		foreach ($recs as $rec)
		{
			if (!isset($this->form['receivers'][$rec['email']]) && trim($rec['email']) > '')
				$this->form['receivers'][trim($rec['email'])] = $rec;
		}

		$recs = $this->form['receivers'];
		$recs[] = array('agent' => 'history');

		// обрабатываем тему по умолчанию
		if (!$form['fields'][$form['fields_main']['subject']]['active'] || !$form['fields'][$form['fields_main']['subject']]['is_used'])
		{
			$_POST['form-' . $alias_id][$form['fields_main']['subject']] = $form['fields'][$form['fields_main']['subject']]['defaultval'];
		}

		// обрабатываем шаблон письма
		$tpl = $form['mail_tpl'];

		// меняем теги основных полей на стандартные
		$tpl = $this->_parse_tag_fld_main($tpl);

		// парсим [tag:easymail]
		if (strpos($tpl,'[tag:easymail]') !== false)
		{
			$easy = '';

			foreach ($fields as $field_id => $field)
			{
				if ($field['is_used'] !== true || $field['title'] == 'captcha' || empty($field['active']))
					continue;

				$easy .= "[tag:title:$field_id]" . ": [tag:fld:$field_id];" . ($form['mail_set']['format'] === 'text' ? "\r\n" : '<br>');
			}

			// убираем последний перевод строки
			$easy = ($form['mail_set']['format'] === 'text') ? rtrim($easy) : substr($easy,0,-4);
			$tpl = str_replace('[tag:easymail]',$easy,$tpl);
		}

		// парсим теги полей и названий
		$tpl = preg_replace_callback('/\[tag:fld:(\d+)]/', array($this,'_parse_tag_fld_mail'),$tpl);
		$tpl = preg_replace_callback('/\[tag:title:([A-Za-z0-9-_]+)]/', array($this,'_parse_tag_title'),$tpl);

		// парсим основные теги
		$tpl = $this->_parse_tags($tpl);

		// заменяем теги условий
		$tpl = preg_replace('/\[tag:(if|elseif)_fld:(\d*)(.*?)]/si','<? $1 (\$_POST["form-' . $alias_id . '"][$2]$3): ?>',$tpl);
		$tpl = str_replace(array('[tag:else_fld]','[/tag:if_fld]'),array('<? else: ?>','<? endif ?>'),$tpl);

		// файлы-вложения
		$attach = array();

		if (! empty($_FILES['form-' . $alias_id]['tmp_name']))
		{
			foreach ($_FILES['form-' . $alias_id]['name'] as $field_id => $fname)
			{
				$ext = (end(explode('.', $fname)));

				if (
					!empty($_FILES['form-' . $alias_id]['tmp_name'][$field_id]) &&
					!empty($form['fields'][$field_id]) &&
					empty($_FILES['form-' . $alias_id]['error'][$field_id]) &&
					!in_array($ext,array('php', 'phtml', 'php3', 'php4', 'php5', 'js', 'pl'))
				)
				{
					$fname = BASE_DIR . '/' . ATTACH_DIR . '/' . str_replace(' ', '_', mb_strtolower(trim($fname)));

					if (file_exists($fname))
						$fname = rtrim($fname,'.' . $ext) . '_' . mt_rand(0,10000) . '.' . $ext;

					@move_uploaded_file($_FILES['form-' . $alias_id]['tmp_name'][$field_id], $fname);

					$attach[] = $fname;
				}
			}
		}

		// Имя отправителя
		$from_name_tpl = $form['mail_set']['from_name'];
		$from_name_tpl = $this->_parse_tags($from_name_tpl);
		$from_name_tpl = $this->_parse_tag_fld_main($from_name_tpl);
		$from_name_tpl = preg_replace_callback('/\[tag:fld:(\d+)]/', array($this,'_parse_tag_fld_post'),$from_name_tpl);

		// Email отправителя
		$from_email_tpl = $form['mail_set']['from_email'];
		$from_email_tpl = $this->_parse_tags($from_email_tpl);
		$from_email_tpl = $this->_parse_tag_fld_main($from_email_tpl);
		$from_email_tpl = preg_replace_callback('/\[tag:fld:(\d+)]/', array($this,'_parse_tag_fld_post'),$from_email_tpl);

		// Тема
		$subject_tpl = $form['mail_set']['subject_tpl'];
		$subject_tpl = $this->_parse_tags($subject_tpl);
		$subject_tpl = $this->_parse_tag_fld_main($subject_tpl);
		$subject_tpl = preg_replace_callback('/\[tag:fld:(\d+)]/', array($this,'_parse_tag_fld_post'),$subject_tpl);

		// отправляем письма
		foreach ($recs as $rec)
		{
			$mail = $tpl;

			$from_name = $from_name_tpl;

			$from_email = $from_email_tpl;

			$subject = $subject_tpl;

			$if_user_open = ($rec['agent'] === 'user');
			$if_admin_open = !$if_user_open;

			$this->_parse_tag_if($mail,'if_user',$if_user_open);
			$this->_parse_tag_if($mail,'if_admin',$if_admin_open);
			$this->_parse_tag_if($subject,'if_user',$if_user_open);
			$this->_parse_tag_if($subject,'if_admin',$if_admin_open);

			// @fix для v1.0 beta <= 2: поддержка тега if_notuser
			$this->_parse_tag_if($mail,'if_notuser',$if_admin_open);
			$this->_parse_tag_if($subject,'if_notuser',$if_admin_open);

			$mail = trim($this->_eval2var('?>' . $mail . '<?'));
			$subject = trim($this->_eval2var('?>' . $subject . '<?'));

			// сохраняем в бд историю (письмо, которое пришло админу)
			if ($rec['agent'] === 'history')
			{
				$history['dialog']['request']['body'] = $mail;
				$history['dialog']['request']['format'] = $form['mail_set']['format'];

				$AVE_DB->Query("
					INSERT INTO " . PREFIX . "_module_contactsnew_history
					SET
						form_id		= '" . $fid . "',
						email		= '" . $history['email'] . "',
						subject		= '" . addslashes($subject) . "',
						date		= '" . time() . "',
						dialog		= '" . addslashes(serialize($history['dialog'])) . "',
						postdata	= '" . addslashes(serialize($_POST)) . "'
				");

				unset($history);
			}
			// иначе, отправляем письмо
			else
			{
				$this->_parse_tag_if($from_name,'if_user',$if_user_open);
				$this->_parse_tag_if($from_name,'if_admin',$if_admin_open);
				$this->_parse_tag_if($from_email,'if_user',$if_user_open);
				$this->_parse_tag_if($from_email,'if_admin',$if_admin_open);

				$from_name = $this->_eval2var('?>' . $from_name . '<?');
				$from_name = trim(preg_replace('/\s+/',' ',$from_name));
				$from_email = $this->_eval2var('?>' . $from_email . '<?');
				$from_email = trim(preg_replace('/\s+/','',$from_email));

				if (empty($from_email))
					$from_email = get_settings('mail_from');

				send_mail(
					$rec['email'],
					$mail,
					$subject,
					$from_email,
					$from_name,
					$form['mail_set']['format'],
					$attach,
					false,
					false
				);
				// @fix для AVE.cms.v1.5.beta <= 28: в send_mail() не выключен кэш в конце
				//ob_end_clean();
			}
		}

		// выполняем код после отправки писем
		eval('?>' . $this->form['code_onsend'] . '<?');

		// если включена защита от повторной отправки и не ajax
		if ($form['protection'] && ! isAjax())
		{
			$rand = mt_rand();
			$_SESSION['mcnfinish'][$form['id'] . $rand] = true;
			header('Location: ' . $_SERVER['REQUEST_URI'] . ((strpos($_SERVER['REQUEST_URI'], '?') !== false) ? '&' : '?') . 'mcnfinish=' . $rand);
			exit;
		}
		// иначе
		else
		{
			// формируем финишную страницу
			$tpl = $this->_parse_tags($form['finish_tpl']);
			$tpl = $this->_eval2var('?>' . $tpl . '<?');
			// сохраняем информацию для аякса
			$this->form['ajax']['form']['is_sent'] = true;
			$this->form['ajax']['form']['finish_tpl'] = $tpl;

			return $tpl;
		}
	}

	/**
	 * Вывод истории
	 */
	function history_list ($fid)
	{
		global $AVE_DB, $AVE_Template;
		$assign = array();
		$assign['fid'] = $fid;
		$assign['form'] = $this->_form($fid,false);

		$limit = 50;
		$start = get_current_page() * $limit - $limit;
		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS *
			FROM " . PREFIX . "_module_contactsnew_history
			WHERE form_id = '" . $fid . "'
			ORDER BY date DESC
			LIMIT " . $start . "," . $limit . "
		");
		$num = (int)$AVE_DB->Query("SELECT FOUND_ROWS()")->GetCell();
		$pages = @ceil($num / $limit);
		if ($num > $limit)
		{
			$page_nav = '<a class="pnav" href="index.php?do=modules&amp;action=modedit&amp;mod=contactsnew&amp;moduleaction=history_list&amp;fid=' . $fid . '&amp;page={s}&amp;cp=' . SESSION . '">{t}</a>';
			$page_nav = get_pagination($pages, 'page', $page_nav);
			$AVE_Template->assign('page_nav', $page_nav);
		}

		while ($row = $sql->FetchAssocArray())
		{
			unset($row['dialog']);
			$assign['dialogs'][] = $row;
		}

		$assign = $this->_stripslashes($assign);
		$AVE_Template->assign($assign);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'history.tpl'));
	}

		/**
	 * Удаление выбранного e-mail
	 */
	function email_del ($hid)
	{
		global $AVE_DB, $AVE_Template;

		$AVE_DB->Query("
			DELETE FROM " . PREFIX . "_module_contactsnew_history
			WHERE id = '" . $hid . "'
		");
	}

	/**
	 * Сохранение статуса диалога
	 */
	function dialog_status ($hid)
	{
		global $AVE_DB;

		if ($_REQUEST['status'] !== 'new')
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_module_contactsnew_history
				SET
					status = '" . $_REQUEST['status'] . "'
				WHERE id = '" . $hid . "'
			");
		}

		if (empty($_REQUEST['ajax']))
		{
			header('Location: index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=history_list&fid=' . $_REQUEST['fid'] . '&cp=' . SESSION);
			exit;
		}
	}

	/**
	 * Вывод диалога
	 */
	function history_dialog ($hid)
	{
		global $AVE_DB, $AVE_Template;
		$assign = array();

		$assign['hid'] = $hid;
		$history = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_contactsnew_history
			WHERE id = '" . $hid . "'
		")->FetchAssocArray();
		$history['dialog'] = unserialize($history['dialog']);
		$history = $this->_stripslashes($history);
		$assign['fid'] = $history['form_id'];
		$assign['form'] = $this->_form($history['form_id'],false);

		// меняем статус на прочитанное
		if ($history['status'] === 'new')
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_module_contactsnew_history
				SET
					status = 'viewed'
				WHERE id = '" . $hid . "'
			");
		}

		// обращение
		$request_author = $AVE_DB->Query("
			SELECT Id AS user_id, user_name, firstname, lastname
			FROM " . PREFIX . "_users
			WHERE email = '" . $history['email'] . "'
		")->FetchAssocArray();
		if (!empty($request_author)) $history['dialog']['request'] = array_merge($history['dialog']['request'], $request_author);

		// ответы
		foreach ($history['dialog']['response'] as &$response)
		{
			$response_author = $AVE_DB->Query("
				SELECT user_name, firstname, lastname
				FROM " . PREFIX . "_users
				WHERE Id = '" . $response['user_id'] . "'
			")->FetchAssocArray();
			if (!empty($response_author)) $response = array_merge($response, $response_author);
		}

		// форма ответа
		if (empty($history['dialog']['response_draft']))
		{
			$history['dialog']['response_draft'] = array(
				'from_email'	=> get_settings('mail_from'),
				'from_name'		=> get_settings('mail_from_name'),
				'body'			=> "\r\n\r\n\r\n--\r\n" . get_settings('mail_signature'),
			);
		}

		// алерт при открытии
		if (!empty($_SESSION['module_contactsnew_admin'][$fid]['dialog_alert']))
		{
			$assign['alert']['text'] = $AVE_Template->get_config_vars($_SESSION['module_contactsnew_admin'][$fid]['dialog_alert']['text']);
			$assign['alert']['theme'] = $_SESSION['module_contactsnew_admin'][$fid]['dialog_alert']['theme'];
			unset($_SESSION['module_contactsnew_admin'][$fid]['dialog_alert']);
		}

		$AVE_Template->assign($assign);
		$AVE_Template->assign($history);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'dialog.tpl'));
	}

	/**
	 * Сохранение и отправка ответа
	 */
	function history_dialog_submit ($hid)
	{
		global $AVE_DB;

		$history = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_module_contactsnew_history
			WHERE id = '" . $hid . "'
		")->FetchAssocArray();
		$history['dialog'] = unserialize($history['dialog']);

		if ($_REQUEST['send'])
		{
			$response = $_POST;
			$response['user_id'] = UID;
			$response['date'] = time();
			$history['dialog']['response'][] = $response;
			$history['status'] = 'replied';
			unset($history['dialog']['response_draft']);
			send_mail(
				$history['email'],
				$_POST['body'],
				$_POST['subject'],
				$_POST['from_email'],
				$_POST['from_name'],
				$_POST['format'],
				array(),
				false,false
			);
		}
		else
		{
			$history['dialog']['response_draft'] = $_POST;
		}

		$AVE_DB->Query("
			UPDATE " . PREFIX . "_module_contactsnew_history
			SET
				dialog	= '" . addslashes(serialize($history['dialog'])) . "',
				status	= '" . $history['status'] . "'
			WHERE id = '" . $hid . "'
		");

		if ($_REQUEST['send'])
		{
			// прописываем алерт об успешной отправке письма
			$_SESSION['module_contactsnew_admin'][$fid]['dialog_alert'] = array('text' => 'respose_sent', 'theme' => 'accept');

			header('Location: index.php?do=modules&action=modedit&mod=contactsnew&moduleaction=history_dialog&hid=' . $hid . '&cp=' . SESSION);
			exit;
		}
	}
}
?>
