<?php
$form_tpl = array(
'noajax' =>
'[tag:hide:2:У вас нет прав для заполнения данной формы!]
<div id=\\"[tag:formalias]\\">
	<form method=\\"post\\" enctype=\\"multipart/form-data\\" class=\\"form-horizontal\\" role=\\"form\\" action=\\"\\">
		[tag:if_form_invalid]
		<div class=\\"alert alert-danger alert-dismissable\\">
			При заполнении формы возникли ошибки!
			<button type=\\"button\\" class=\\"close\\" data-dismiss=\\"alert\\" aria-hidden=\\"true\\">&times;</button>
		</div>
		[/tag:if_form_invalid]
		[tag:fld:email]
		[tag:fld:subject]
		[tag:fld:receivers]
		[tag:fld:6]
		[tag:fld:7]
		[tag:fld:8]
		[tag:fld:9]
		[tag:fld:10]
		[tag:fld:11]
		[tag:fld:copy]
		[tag:fld:captcha]
		<div class=\\"form-group\\">
			<div class=\\"col-sm-offset-4 col-sm-4\\">
				<button type=\\"submit\\" class=\\"btn btn-primary\\">Отправить</button>
			</div>
		</div>
	</form>
	[tag:if_form_invalid]
	<script>
		function form_popover () {
			$(\\\'#[tag:formalias] .form-control.invalid\\\').each(function(index, element) {
				$(element).popover(\\\'show\\\')
			});
		}
		$(function() {
			form_popover();
		});
	</script>
	[/tag:if_form_invalid]
</div>
[/tag:hide]',
'ajax' => '[tag:hide:2:У вас нет прав для заполнения данной формы!]
<div id=\\"[tag:formalias]\\">
	<form method=\\"post\\" enctype=\\"multipart/form-data\\" class=\\"form-horizontal\\" role=\\"form\\" action=\\"\\">
		<div class=\\"alert alert-warning alert-dismissable\\">
			Если форма не работает, убедитесь, что скрипт jquery.form.min.js подключен к странице
			<button type=\\"button\\" class=\\"close\\" data-dismiss=\\"alert\\" aria-hidden=\\"true\\">&times;</button>
		</div>
		[tag:if_form_invalid]
		<div class=\\"alert alert-danger alert-dismissable\\">
			При заполнении формы возникли ошибки!
			<button type=\\"button\\" class=\\"close\\" data-dismiss=\\"alert\\" aria-hidden=\\"true\\">&times;</button>
		</div>
		[/tag:if_form_invalid]
		[tag:fld:email]
		[tag:fld:subject]
		[tag:fld:receivers]
		[tag:fld:6]
		[tag:fld:7]
		[tag:fld:8]
		[tag:fld:9]
		[tag:fld:10]
		[tag:fld:11]
		[tag:fld:copy]
		[tag:fld:captcha]
		<div class=\\"form-group\\">
			<div class=\\"col-sm-offset-4 col-sm-4\\">
				<button type=\\"submit\\" class=\\"btn btn-primary\\">Отправить</button>
			</div>
		</div>
	</form>
	<script>
	    $(document).on(\\\'click\\\', \\\'#captcha-ref\\\', function(){$(\\\'#captcha img\\\').attr(\\\'src\\\', \\\'[tag:path][tag:captcha]?refresh=\\\' + new Date().getTime());});
		function form_popover (action) {
			var _action = (action == undefined || !action) ? \\\'show\\\' : action;
			$(\\\'#[tag:formalias] .form-control.invalid\\\').each(function(index, element) {
				$(element).popover(_action);
				if (_action == \\\'hide\\\') $(element).removeClass(\\\'invalid\\\');
			});
		}

		$(document).on(\\\'submit\\\',\\\'#[tag:formalias] form\\\',function (e) {
			e.preventDefault();
			var form = $(this);
			form.ajaxSubmit({
				url: \\\'[tag:path]index.php?module=contactsnew\\\',
				data: {
					alias_id: \\\'[tag:formalias]\\\'
				},
				beforeSubmit: function () {
					$(\\\'button[type=submit]\\\',form).prop(\\\'disabled\\\',true);
					form_popover(\\\'hide\\\');
					form.css(\\\'opacity\\\',0.3);
				},
				success: function (data) {
					form.after(data).remove();
					form_popover(\\\'show\\\');
				}
			});
			return false;
		});
	</script>
</div>
[/tag:hide]',
'ajax_o' =>
'[tag:hide:2:У вас нет прав для заполнения данной формы!]
<div id=\\"[tag:formalias]\\">
	<form method=\\"post\\" enctype=\\"multipart/form-data\\" class=\\"form-horizontal\\" role=\\"form\\" action=\\"\\">
		<div class=\\"alert alert-warning alert-dismissable\\">
			Если форма не работает, убедитесь, что скрипт jquery.form.min.js подключен к странице
			<button type=\\"button\\" class=\\"close\\" data-dismiss=\\"alert\\" aria-hidden=\\"true\\">&times;</button>
		</div>
		[tag:if_form_invalid]
		<div class=\\"alert alert-danger alert-dismissable\\">
			При заполнении формы возникли ошибки!
			<button type=\\"button\\" class=\\"close\\" data-dismiss=\\"alert\\" aria-hidden=\\"true\\">&times;</button>
		</div>
		[/tag:if_form_invalid]
		[tag:fld:email]
		[tag:fld:subject]
		[tag:fld:receivers]
		[tag:fld:6]
		[tag:fld:7]
		[tag:fld:8]
		[tag:fld:9]
		[tag:fld:10]
		[tag:fld:11]
		[tag:fld:copy]
		<div class=\\"form-group\\">
			<div class=\\"col-sm-offset-4 col-sm-4\\">
				<button type=\\"submit\\" class=\\"btn btn-primary\\">Отправить</button>
			</div>
		</div>
	</form>
	<script>
		$(document).on(\\\'submit\\\',\\\'#[tag:formalias] form\\\',function (e) {
			e.preventDefault();
			var form = $(this);
			form.ajaxSubmit({
				url: \\\'[tag:path]index.php?module=contactsnew\\\',
				data: {
					alias_id: \\\'[tag:formalias]\\\',
					action: \\\'validate\\\'
				},
				dataType: \\\'json\\\',
				beforeSubmit: function () {
					$(\\\'button[type=submit]\\\',form).prop(\\\'disabled\\\',true);
					//form.css(\\\'opacity\\\',0.3);
				},
				success: function (data) {
					alert(\\\'Данные получены и отправлены в консоль console.log(data). Если у вас Chrome, нажмите F12.\\\');
					console.log(data);
				}
			});
			return false;
		});
	</script>
</div>
[/tag:hide]'
);

$demo = array(
	'mail_set' => array(
		'from_name' => '[tag:if_user]Администратор сайта [tag:sitename][/tag:if_user]
[tag:if_admin][tag:uname] ([tag:ulogin])[/tag:if_admin]',
		'from_email' => '[tag:if_user]admin@form.ru[/tag:if_user]
[tag:if_admin][tag:fld:email][/tag:if_admin]',
		'subject_tpl' => '[tag:if_user]Вы заполнили форму "[tag:fld:subject]" на сайте [tag:sitename][/tag:if_user]
[tag:if_admin]Заполнена форма: [tag:formtitle] ([tag:formalias])[/tag:if_admin]',
		'receivers' => array(
			array(
				'email' => 'form@form.ru',
				'name'	=> 'form'
			)
		),
		'format' => 'text',
	),
	'rubheader' => '<!--
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="[tag:path]modules/contactsnew/js/jquery.form.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>' . ($_REQUEST['demo'] != 'noajax' ? '
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>' : '') . '
-->',
	'form_tpl' => $form_tpl[$_REQUEST['demo']],
	'mail_tpl' => '[tag:if_user]
Здравствуйте, [tag:uname]!

Вы заполнили форму на нашем сайте и ввели следующие данные:

[tag:easymail]

В ближайшее время администрация рассмотрит вашу заявку
--
С уважением, Администрация
[/tag:if_user]

[tag:if_admin]
Здравствуйте!

Пользователь [tag:uname] ([tag:ulogin]) заполнил форму \\\'[tag:formtitle]\\\' ([tag:formalias]) и ожидает ответа.

Введённые данные:
[tag:easymail]
[/tag:if_admin]',
	'finish_tpl' => '<div class="alert alert-success">
	Форма успешно отправлена!
</div>',
	'code_onsubmit' => '',
	'code_onvalidate' => '',
	'code_onsend' => '',
	'fields' => array(
		1 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'email',
			'active' => 1,
			'type' => 'input',
			'main' => 1,
			'setting' => 'FILTER_VALIDATE_EMAIL',
			'required' => 1,
			'defaultval' => '[tag:uemail]',
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_invalid]invalid[/tag:if_invalid]" placeholder="[tag:title]" data-placement="right" data-content="Неверный email!" data-container="body" data-trigger="manual"',
			'tpl' => '<div class="form-group [tag:if_valid]has-feedback has-success[/tag:if_valid] [tag:if_invalid]has-feedback has-error[/tag:if_invalid]">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title] *
	</label>
	<div class="col-sm-4">
		[tag:fld]
		[tag:if_valid]<span class="glyphicon glyphicon-ok form-control-feedback"></span>[/tag:if_valid]
		[tag:if_invalid]<span class="glyphicon glyphicon-remove form-control-feedback"></span>[/tag:if_invalid]
	</div>
</div>'
		),
		2 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'subject',
			'active' => 1,
			'type' => 'input',
			'main' => 1,
			'setting' => '',
			'required' => 1,
			'defaultval' => 'Тема по умолчанию',
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_empty]invalid[/tag:if_empty]" placeholder="[tag:title]" data-placement="right" data-content="Укажите тему!" data-container="body" data-trigger="manual"',
			'tpl' => '<div class="form-group [tag:if_notempty]has-feedback has-success[/tag:if_notempty] [tag:if_empty]has-feedback has-error[/tag:if_empty]">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title] *
	</label>
	<div class="col-sm-4">
		[tag:fld]
		[tag:if_notempty]<span class="glyphicon glyphicon-ok form-control-feedback"></span>[/tag:if_notempty]
		[tag:if_empty]<span class="glyphicon glyphicon-remove form-control-feedback"></span>[/tag:if_empty]
	</div>
</div>'
		),
		3 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'receivers',
			'active' => 1,
			'type' => 'select',
			'main' => 1,
			'setting' => array(
				0 => array(
					'email' => 'sales@form.ru',
					'name'	=> 'Отдел продаж'
				),
				1 => array(
					'email' => 'support@form.ru',
					'name'	=> 'Служба поддержки'
				)
			),
			'required' => 0,
			'defaultval' => 0,
			'attributes' => 'id="fld[[tag:id]]" class="form-control" placeholder="[tag:title]"',
			'tpl' => '<div class="form-group">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title]
	</label>
	<div class="col-sm-4">
		[tag:fld]
	</div>
</div>'
		),
		4 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'copy',
			'active' => 1,
			'type' => 'checkbox',
			'main' => 1,
			'setting' => '',
			'required' => 0,
			'defaultval' => 1,
			'attributes' => '',
			'tpl' => '<div class="form-group">
	<div class="col-sm-offset-4 col-sm-4">
		<div class="checkbox">
			<label>
				[tag:fld] [tag:title]
			</label>
		</div>
	</div>
</div>'
		),
		5 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'captcha',
			'active' => 1,
			'type' => 'input',
			'main' => 1,
			'setting' => '',
			'required' => 1,
			'defaultval' => '',
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_invalid]invalid[/tag:if_invalid]" placeholder="Введите защитный код" data-placement="right" data-content="Неверный код!" data-container="body" autocomplete="off" data-trigger="manual"',
			'tpl' => '<div class="form-group [tag:if_invalid]has-feedback has-error[/tag:if_invalid]">
	<div class="col-sm-offset-4 col-sm-4">
		<div class="checkbox" style="text-align:center">
		<span id="captcha">	
		<img src="[tag:path][tag:captcha]" alt="Капча"></span><br>
		</div>
		<div style="text-align:center">
			<img id="captcha-ref" style="cursor: pointer; margin:10px 0 10px 0px;" src="[tag:path]modules/contactsnew/images/ref.png" alt="" title="Обновить код" width="30" height="30" border="0" />
		</div>
			<div class="col-sm-offset-2 col-sm-8">
		[tag:fld]
		[tag:if_invalid]<span class="glyphicon glyphicon-remove form-control-feedback"></span>
		[/tag:if_invalid]
			</div>
		</div>
	</div>'
		),
		6 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'Выбор',
			'active' => 1,
			'type' => 'select',
			'main' => 0,
			'setting' => array('выберите','а','б','в'),
			'required' => 1,
			'defaultval' => 0,
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_empty]invalid[/tag:if_empty]" placeholder="[tag:title]" data-placement="right" data-content="Выберите что-нибудь!" data-container="body" data-trigger="manual"',
			'tpl' => '<div class="form-group [tag:if_notempty]has-success[/tag:if_notempty] [tag:if_empty]has-error[/tag:if_empty]">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title] *
	</label>
	<div class="col-sm-4">
		[tag:fld]
	</div>
</div>'
		),
		7 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'Текстовое поле',
			'active' => 1,
			'type' => 'textarea',
			'main' => 0,
			'setting' => '',
			'required' => 0,
			'defaultval' => '',
			'attributes' => 'id="fld[[tag:id]]" class="form-control" placeholder="[tag:title]"',
			'tpl' => '<div class="form-group [tag:if_notempty]has-feedback has-success[/tag:if_notempty] [tag:if_empty]has-feedback has-error[/tag:if_empty]">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title]
	</label>
	<div class="col-sm-4">
		[tag:fld]
		[tag:if_notempty]<span class="glyphicon glyphicon-ok form-control-feedback"></span>[/tag:if_notempty]
		[tag:if_empty]<span class="glyphicon glyphicon-remove form-control-feedback"></span>[/tag:if_empty]
	</div>
</div>'
		),
		8 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'Мульти',
			'active' => 1,
			'type' => 'multiselect',
			'main' => 0,
			'setting' => array(1,2,3,4,5),
			'required' => 1,
			'defaultval' => array(0,3),
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_empty]invalid[/tag:if_empty]" placeholder="[tag:title]" data-placement="right" data-content="Выберите что-нибудь!" data-container="body" data-trigger="manual"',
			'tpl' => '<div class="form-group [tag:if_notempty]has-success[/tag:if_notempty] [tag:if_empty]has-error[/tag:if_empty]">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title] *
	</label>
	<div class="col-sm-4">
		[tag:fld]
	</div>
</div>'
		),
		9 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'Файл (до 1мб)',
			'active' => 1,
			'type' => 'file',
			'main' => 0,
			'setting' => 1,
			'required' => 0,
			'defaultval' => '',
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_invalid]invalid[/tag:if_invalid] [tag:if_empty]invalid[/tag:if_empty]" placeholder="[tag:title]" data-placement="right" data-content="[tag:if_invalid]Слишком большой файл![/tag:if_invalid][tag:if_empty]Отсутствует файл![/tag:if_empty]" data-container="body" data-trigger="manual"',
			'tpl' => '<div class="form-group [tag:if_notempty][tag:if_valid]has-feedback has-success[/tag:if_valid][/tag:if_notempty] [tag:if_invalid]has-feedback has-error[/tag:if_invalid] [tag:if_empty]has-feedback has-error[/tag:if_empty]">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title]
	</label>
	<div class="col-sm-4">
		[tag:fld]
		[tag:if_notempty][tag:if_valid]<span class="glyphicon glyphicon-ok form-control-feedback"></span>[/tag:if_valid][/tag:if_notempty]
		[tag:if_invalid]<span class="glyphicon glyphicon-remove form-control-feedback"></span>[/tag:if_invalid]
		[tag:if_empty]<span class="glyphicon glyphicon-remove form-control-feedback"></span>[/tag:if_empty]
	</div>
</div>'
		),
		10 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'Документ',
			'active' => 1,
			'type' => 'doc',
			'main' => 0,
			'setting' => array(1),
			'required' => 0,
			'defaultval' => '',
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_empty]invalid[/tag:if_empty]" placeholder="[tag:title]"',
			'tpl' => '<div class="form-group">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title]
	</label>
	<div class="col-sm-4">
		[tag:fld]
	</div>
</div>'
		),
		11 => array(
			'new' => true,
			'form_id' => $fid,
			'title' => 'Мультидокумент',
			'active' => 1,
			'type' => 'multidoc',
			'main' => 0,
			'setting' => array(1,2),
			'required' => 0,
			'defaultval' => '',
			'attributes' => 'id="fld[[tag:id]]" class="form-control [tag:if_empty]invalid[/tag:if_empty]" placeholder="[tag:title]"',
			'tpl' => '<div class="form-group">
	<label for="fld[[tag:id]]" class="col-sm-4 control-label">
		[tag:title]
	</label>
	<div class="col-sm-4">
		[tag:fld]
	</div>
</div>'
		)
	)
);
