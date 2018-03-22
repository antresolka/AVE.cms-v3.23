<div class="title"><h5>{#ModName#}</h5></div>
<div class="widget" style="margin-top: 0px;">
    <div class="body">
    <ul>
		<li>{#ModTitle#}</li>
	</ul>	
    </div>
</div>
<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><strong class="code">{#ModName#}</strong></li>
	    </ul>
	</div>
</div>
{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}
<div class="widget first">
	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">{#UCA_LIST#}</a></li>
	    <li class=""><a href="#tab2">{#UCA_NEW#}</a></li>
	</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content" style="display: block;">
<form action="" method="post" class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings">
			<colgroup>
			    <col width="1">
			    <col width="*">
				<col width="*">
                <col width="100">
				<col width="184">
				<col width="1">
				<col width="1">
			</colgroup>
			<thead>
    <tr class="noborder">
        <td>Id</td>
    	<td>{#UCA_TITLE#}</td>
        <td>{#UCA_EVENTS#}</td>
        <td>{#UCA_RELEV#}</td>
    	<td>{#UCA_CP_TAG#}</td>
    	<td colspan="3">{#UCA_ACTIONS#}</td>
    </tr>
     	   </thead>
		 <tbody>    
			<form action="" method="post" class="mainForm">
            {foreach from=$unicalendars item=unicalendar}
                <tr>
					<td align="center">
        				<strong class="code">{$unicalendar.id}</strong>
					</td>                
					<td align="left">
					  <a class="btn greyishBtn" title="{#UCA_EDIT#}" href="index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=edit&id={$unicalendar.id}&cp={$sess}">{$unicalendar.uca_title|escape}</a>
					</td>
					<td align="center">
						<div align="left">
				    {if $unicalendar.uca_events == 1}<a style="cursor: default;" class="btn greenBtn" href="javascript:void(0);">{#UCA_LIST_ALLDOC_RUB#}&nbsp;&nbsp;<i>{$unicalendar.uca_rubric_title|escape}</i></a> 
				    {elseif $unicalendar.uca_events == 2}<a style="cursor: default;" class="btn blueBtn" href="javascript:void(0);">{#UCA_LIST_SELDOC_RUB#}&nbsp;&nbsp;<i>{$unicalendar.uca_rubric_title|escape}</i></a>
					{else}<strong>{#UCA_EVENTS_WARNING#}</strong>
					{/if}
						</div>
					</td>
                    <td align="center">
                      {* <input type="hidden" name="uca_count_js_{$unicalendar.id}" id="uca_count_js_{$unicalendar.id}" value="" />
                       <input type="hidden" name="uca_count_real_{$unicalendar.id}" id="uca_count_real_{$unicalendar.id}" value="" /> *}
                       <div id="count_wrap_{$unicalendar.id}" class="toprightDir" style="" title=""></div>
                    </td> 
                    <td align="center">
                        <div class="pr12" style="display: table; position: relative; text-align: right;">
                        <input style="width: 130px;" id="uca_{$unicalendar.id}" name="textfield" type="text" readonly value="[mod_unicalendar:{$unicalendar.id}]" size="17" />
                        <a style="text-align: center; padding: 5px 3px 4px 3px;" class="whiteBtn copyBtn topDir" href="javascript:void(0);" data-clipboard-action="copy" data-clipboard-target="#uca_{$unicalendar.id}" title="{#UCA_COPY_BUFF#}">
                        <img style="margin-top: -3px; position: relative; top: 4px; padding: 0 3px;" class="clippy" src="{$ABS_PATH}admin/templates/images/clippy.svg" width="13"></a>
                        </div>
                    </td>                    
					<td align="center">
                        <a class="btn blueBtn" href="index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=edit&id={$unicalendar.id}&cp={$sess}">{#UCA_EDIT#}</a>		
					</td>
					<td align="center">
						<a class="btn redBtn ConfirmDelete" dir="{#UCA_DELETE_UNICLN#}" name="{#UCA_DELETE_UNICLN_A#}" href="index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=delunicalendar&id={$unicalendar.id}&cp={$sess}">{#UCA_DELETE#}</a>
					</td>
				</tr>
<script type="text/javascript">
    // START ПРОВЕРКА АКТУАЛЬНОСТИ ДАННЫХ В КАЛЕНДАРЯХ
    $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}check_rel:'check_rel', tstamp: new Date().getTime(), r_id:'{$unicalendar.uca_rubric_id}', udoc_id:'AND {$unicalendar.uca_doc_id}'{rdelim},
    success: function(data) {ldelim}
    var old_array = '';// объявляем переменную
    var uca_trim_id = 'Id=';// объявляем переменную и пишем в нее значение
    var uca_trim_or = ' OR ';// объявляем переменную и пишем в нее значение
    var uca_trim_br = ' ';// объявляем переменную и пишем в нее значение
    var count_old_array = '';// объявляем переменную
    var count_new_array = '';// объявляем переменную

    old_array1 = str_replace(uca_trim_id, '', '{$unicalendar.uca_doc_id}'); // вырезаем из строки Id=
    old_array2 = str_replace(uca_trim_or, ',', old_array1);// вырезаем из строки OR
    old_array3 = str_replace(uca_trim_br, '', old_array2);// вырезаем из строки пробелы
    old_array = old_array3.split(',');// создаем массив из данных календаря
    var new_array = data.split(',');// создаем массив из данных пришедших из БД по запросу "актуальность календарей"
    var diff = $(old_array).not(new_array).get(); // сравниваем массивы и записываем в переменную ОТСУТСТВУЮЩИЕ Id документов, которые содержит календарь
    count_old_array = old_array.length;// количество элементов в массиве при создании календаря
    count_new_array = new_array.length;// количество элементов в массиве в текущий момент
    if (count_old_array == count_new_array && diff == '' {if $unicalendar.uca_events == 2} || count_old_array < count_new_array && diff == '' {/if})// если условие истинно - календарь актуален
    {ldelim}
    $('#count_wrap_{$unicalendar.id}').prop('style', 'width:18px;height:18px;background:green;-moz-border-radius:50px;-webkit-border-radius:50px;border-radius:50px;');
    $('#count_wrap_{$unicalendar.id}').prop('title', '{#UCA_ALERT_RELEV_YES#}');// выводим подсказку - Ок - данные календаря актуальны        
    {rdelim}
    else if (count_old_array == count_new_array && diff != '' || count_old_array != count_new_array && diff != '')
    {ldelim}
    $('#count_wrap_{$unicalendar.id}').prop('style', 'width:18px;height:18px;background:red;-moz-border-radius:50px;-webkit-border-radius:50px;border-radius:50px;');
    {if $unicalendar.uca_events == 1}
    $('#count_wrap_{$unicalendar.id}').prop('title', '{#UCA_ALERT_RELEV_BAD#}<strong style=\'color:orange\'>{$unicalendar.uca_rubric_title}</strong>{#UCA_ALERT_RELEV_BAD_SE#}<strong style=\'color:orange\'>'+diff+'</strong>{#UCA_ALERT_RELEV_BAD_SF#}');// Внимание - события в календаре неактуальны! На момент создания календаря был(и) выбран(ы) документ(ы), которые(ых) на текущий момент не существует в рубрике. Это приводит к тому, что календарь содержит события, ведущие на страницу с ошибкой 404! Для устранения - пересохраните календарь!
    {elseif $unicalendar.uca_events == 2}
    $('#count_wrap_{$unicalendar.id}').prop('title', '{#UCA_ALERT_RELEV_BAD_SD#}<strong style=\'color:orange\'>{$unicalendar.uca_rubric_title}</strong>{#UCA_ALERT_RELEV_BAD_SE#}<strong style=\'color:orange\'>'+diff+'</strong>{#UCA_ALERT_RELEV_BAD_SF#}');// Внимание - события в календаре неактуальны! На момент создания календаря был(и) выбран(ы) документ(ы), которые(ых) на текущий момент не существует в рубрике. Это приводит к тому, что календарь содержит события, ведущие на страницу с ошибкой 404! Для устранения - пересохраните календарь!
    {/if}
    {rdelim}{if $unicalendar.uca_events == 2}; {elseif $unicalendar.uca_events == 1}
    else if (count_old_array < count_new_array && diff == '')
    {ldelim}
    $('#count_wrap_{$unicalendar.id}').prop('style', 'width:18px;height:18px;background:orange;-moz-border-radius:50px;-webkit-border-radius:50px;border-radius:50px;');
    $('#count_wrap_{$unicalendar.id}').prop('title', '{#UCA_ALERT_RELEV_WAR#}');// выводим подсказку - Внимание - события в календаре неактуальны! На момент создания календаря документов в рубрике было больше, чем на текущий момент...    
    {rdelim};    
    {/if}// завершение условий проверки
    {rdelim},
    error:  function(xhr, str){ldelim}
    $.jGrowl("{#SaveError#}", {ldelim}
    header: '{#SentData#}',
    theme: 'error'
    {rdelim}); 
    {rdelim}
    {rdelim}); // END ПРОВЕРКА АКТУАЛЬНОСТИ ДАННЫХ В КАЛЕНДАРЯХ
</script>
       {/foreach}
    		{if !$unicalendars}
				<tr>
					<td colspan="6">
					<ul class="messages">
						<li class="highlight yellow">{#UCA_NO_ITEMS#}</li>
					</ul>
					</td>
				</tr>
				{/if}
			</form>
    </tbody>
</table>
</form>
</div>
            <div id="tab2" class="tab_content" style="display: none;">
			    <form id="add_unicalendar" name="add_unicalendar" class="mainForm">
                	<table  id="tr_uca" cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr class="noborder">
                			<td width="180">{#UCA_TITLE#}</td>
                			<td>
                				<input placeholder="{#UCA_TITLE#}" name="uca_title" type="text" id="uca_title" value="" style="width:300px" />
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_PUBLIC_DATE#}</td>
                			<td>
                				<input name="uca_date_format" type="hidden" id="uca_date_format" value="dddd, DD MMM YYYY"/>
                				<input type="radio" name="u_date_format" class="u_date_format" value="dddd, DD MMM YYYY" checked="checked">
                				<label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %d %B %Y'|pretty_date}</label>
                				<input type="radio" name="u_date_format" class="u_date_format" value="dddd, DD-MM-YYYY">
                				<label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %d-%m-%Y'|pretty_date}</label>
                				<input type="radio" name="u_date_format" class="u_date_format" value="dddd, YYYY-MM-DD">
                				<label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %Y-%m-%d'|pretty_date}</label>
                				<input type="radio" name="u_date_format" class="u_date_format" value="DD MMM YYYY"> 
                				<label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%d %B %Y'|pretty_date}</label>
                				<input type="radio" name="u_date_format" class="u_date_format" value="DD-MM-YYYY"> 
                				<label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%d-%m-%Y'|pretty_date}</label>
                				<input type="radio" name="u_date_format" class="u_date_format" value="YYYY-MM-DD"> 
                				<label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%Y-%m-%d'|pretty_date}</label>
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_OPEN_LIKS#}</td>
                			<td>
                				<input name="uca_link" type="hidden" id="uca_link" value="true"/>
                				<input type="radio" name="u_link" class="u_link" value="true" checked="checked">
                				<label for="">{#UCA_YES#}</label>
                				<input type="radio" name="u_link" class="u_link" value="false">
                				<label for="">{#UCA_NO#}</label>                				
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_WEEK_START#}</td>                		
                			<td>
                				<input name="uca_day" type="hidden" id="uca_day" value="true"/>
                				<input type="radio" name="u_day" class="u_day" value="true" checked="checked">
                				<label for="">{#UCA_WEEK_START_MONDAY#}</label>
                				<input type="radio" name="u_day" class="u_day" value="false">
                				<label for="">{#UCA_WEEK_START_SUNDAY#}</label>                				
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_SCROLL_BAR#}</td>                		
                			<td>
                				<input name="uca_scroll" type="hidden" id="uca_scroll" value="false"/>
                				<input type="radio" name="u_scroll" class="u_scroll" value="true">
                				<label for="">{#UCA_YES#}</label>
                				<input type="radio" name="u_scroll" class="u_scroll" value="false" checked="checked">
                				<label for="">{#UCA_NO#}</label>                				
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_DESCRIPTION#}</td>                		
                			<td>
                				<input name="uca_descript" type="hidden" id="uca_descript" value="false"/>
                				<input type="radio" name="u_descript" class="u_descript" value="true">
                				<label for="">{#UCA_YES#}</label>
                				<input type="radio" name="u_descript" class="u_descript" value="false" checked="checked">
                				<label for="">{#UCA_NO#}</label>                				
                			</td>
                		</tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_EVENTS_LIMIT#}</td>                        
                            <td>
                                <input name="uca_events_limit" type="text" id="uca_events_limit" value="5" style="width:32px"/>
                            </td>
                        </tr>
						<tr class="noborder">
                			<td width="180">{#UCA_EVENTS#}</td>
                			<td>
                			    <input type="hidden" name="uca_doc_id" id="uca_doc_id" value="" />
                			    <input type="hidden" name="uca_events" id="uca_events" value="" />
                				<select name="uca_events_sel" id="uca_events_sel" style="width: 300px;">
                				<option style="color: #ABABAB;"  value="" >{#UCA_EVENTS_SELECT#}</option>
                				<option value="1">{#UCA_EVENTS_SELECT_A#}</option>
				                <option value="2">{#UCA_EVENTS_SELECT_B#}</option>
				                {* <option value="3">{#UCA_EVENTS_SELECT_C#}</option> *}
			                    </select>
			                </td>
                		</tr>
                	</table>
                  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr>
                 			<td colspan="2">
                			  <div class="pr12" style="display: table; padding: 5px 0px 5px 0px;">
                				<a id="btn_ucasub" class="btn blueBtn" href="javascript:void(0);">{#UCA_BTN_CREATE#}</a>
                                <input name="i_block_create_calendar" type="hidden" id="i_block_create_calendar" value="0"/>
                              </div>
                			</td>
                		</tr>                
                  </table>
			    </form>
			</div>
        </div>
<div class="fix"></div>
</div>
{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}
  <script>
    $('uca_events_sel').styler({ldelim}selectSearch:false, selectVisibleOptions:5{rdelim});// стилизуем селект выбора событий календаря
    // START обнуляем значение value у input Лимит вывода событий при событии focus
    $('#uca_events_limit').focus(function(){ldelim}
    $('#uca_events_limit').val('');
    {rdelim});// END обнуляем значение value у input Лимит вывода событий при событии focus

    // START Получаем значениe value выбранного option - События календаря
    $('#uca_events_sel').change(function(){ldelim}
    $('#uca_events').val('');
    $('#tr_uca_res' ).remove();
    $('#tr_uca_res_doc').remove();
    $('#tr_uca_data').remove();
    var uca_request = '';
    var uca_events = $("#uca_events_sel option:selected").val();
    
    // Если значение value не пустое и выбран тип события "Все документы из заданной рубрики", подставляем значение value в input,
    // создаем таблицу, отправляем AJAX запрос и пишем данные в эту таблицу.
    if (uca_events !='' && uca_events == '1' ){ldelim}
    $('#uca_rubric_id').val('');
    $('#uca_rubric_title').val('');	
    $('#uca_events').val(uca_events);
    $('#tr_uca').after('<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm" id="uca_after_fields"><tr class="noborder" id="tr_uca_res"><td width="180">{#UCA_EVENTS_SELECT_AC#}</td><td><input type="hidden" name="uca_rubric_title" id="uca_rubric_title" value=""><input type="hidden" name="uca_rubric_id" id="uca_rubric_id" value=""><select name="uca_result" id="uca_result" style="width: 300px;"></select></td></tr></table>');
    uca_request = uca_events;
    ucaCall();
    $('#uca_result').change(function(){ldelim}
    $('#uca_rubric_id').val('');
    $('#uca_rubric_title').val('');
    $('#uca_inp_res').val('');
    $('#uca_inptxt_res').val('');
    $('#tr_uca_data').remove();	
    var uca_inp_res = $("#uca_result option:selected").val();
    var uca_inptxt_res = $("#uca_result option:selected").text();
    $('#uca_rubric_id').val(uca_inp_res);
    $('#uca_rubric_title').val(uca_inptxt_res);


    // START выбора полей в рубрике для вывода данных для изображения, описания, места проведения
    var uca_id_sel_rub    = ''; // создаем переменную
    var uca_title_sel_rub = ''; // создаем переменную
    var uca_img_field     = ''; // создаем переменную
    var i_uca_img_field   = ''; // создаем переменную
    var uca_dsc_field     = ''; // создаем переменную
    var i_uca_dsc_field   = ''; // создаем переменную
    var uca_place_field   = ''; // создаем переменную
    var i_uca_place_field = ''; // создаем переменную
    $('#i_uca_img_field').val(''); // очищаем input
    $('#i_uca_dsc_field').val(''); // очищаем input
    $('#i_uca_place_field').val(''); // очищаем input           
    uca_id_sel_rub = $('#uca_rubric_id').val();// пишем в переменную Id выбранной рубрики
    uca_title_sel_rub = $('#uca_rubric_title').val();// пишем в переменную title выбранной рубрики
    if (uca_id_sel_rub !=''){ldelim}// если выбрана рубрика
    //alert("Id рубрики = "+uca_id_sel_rub+" Название рубрики = "+uca_title_sel_rub);
    $('#uca_after_fields').after('<table id="tr_uca_data" cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings"><colgroup><col width="201"><col width="*"><col width="*"><col width="*"><col width="*"><col width="*"></colgroup><thead><tr class="noborder"><td colspan="2" ><h5 class="iFrames" style="text-align: left; padding-left: 10px;">{#UCA_SEL_FIELD_DATA_INF#}</h5></td></tr></thead><tbody><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_TTL#}</td><td align="left"><select disabled="disabled" name="uca_ttl_field" id="uca_ttl_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_TTL#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_H_IMG#}</td><td align="left"><select name="uca_img_field" id="uca_img_field" style="width: 300px;"></select></td><input name="i_uca_img_field" type="hidden" id="i_uca_img_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_DSC#}</td><td align="left"><select name="uca_dsc_field" id="uca_dsc_field" style="width: 300px;"></select></td><input name="i_uca_dsc_field" type="hidden" id="i_uca_dsc_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_PLW#}</td><td align="left"><select name="uca_place_field" id="uca_place_field" style="width: 300px;"></select></td><input name="i_uca_place_field" type="hidden" id="i_uca_place_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_STR#}</td><td align="left"><select disabled="disabled" name="uca_str_field" id="uca_str_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_END#}</td><td align="left"><select disabled="disabled" name="uca_end_field" id="uca_end_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr></tbody></table>');
    uca_frub_id = $('#uca_rubric_id').val();
    ucaRubFields();
    $('#uca_img_field').change(function(){ldelim} // START если есть действия с селектом "Изображение - выбор поля" пишем ID выбранного в скрытый input id="i_uca_img_field" 
    uca_img_field = $('#uca_img_field').val();
    i_uca_img_field = $('#i_uca_img_field').val(uca_img_field);	
    {rdelim});  // END если есть действия с селектом "Изображение - выбор поля" пишем ID выбранного в скрытый input id="i_uca_img_field" 

    $('#uca_dsc_field').change(function(){ldelim} // START если есть действия с селектом "Описание события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_dsc_field" 
    uca_dsc_field = $('#uca_dsc_field').val();
    i_uca_dsc_field = $('#i_uca_dsc_field').val(uca_dsc_field);	
    {rdelim});  // END если есть действия с селектом "Описание события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_dsc_field"

    $('#uca_place_field').change(function(){ldelim} // START если есть действия с селектом "Место события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_place_field" 
    uca_place_field = $('#uca_place_field').val();
    i_uca_place_field = $('#i_uca_place_field').val(uca_place_field);	
    {rdelim});  // END если есть действия с селектом "Место события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_place_field"           

    {rdelim};// END выбора полей в рубрике для вывода данных для изображения, описания, места проведения


    {rdelim});
    {rdelim}// END Если значение value не пустое и выбран тип события "Все документы из заданной рубрики"...

    // Если значение value не пустое и выбран тип события "Выбранные документы из заданной рубрики", подставляем значение value в input,
    // создаем таблицу, отправляем AJAX запрос и пишем данные в эту таблицу.
    if (uca_events !='' && uca_events == '2' ){ldelim}
    $('#tr_uca_data').remove();	
    $('#uca_rubric_id').val('');
    $('#uca_rubric_title').val('');	
    $('#uca_events').val(uca_events);
    $('#tr_uca').after('<table id="tr_uca_res" cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm"><tr class="noborder"><td width="180">{#UCA_EVENTS_SELECT_AC#}</td><td><input type="hidden" name="uca_rubric_title" id="uca_rubric_title" value=""><input type="hidden" name="uca_rubric_id" id="uca_rubric_id" value=""><select name="uca_result" id="uca_result" style="width: 300px;"></select></td></tr></table>');
    uca_request = uca_events;
    ucaCall();
    $('#uca_result').change(function(){ldelim}
    var val_rub = $('#uca_result').val();	
    $('#tr_uca_data').remove();	
    $('#tr_uca_res_doc').remove();	
    $('#uca_rubric_id').val('');
    $('#uca_rubric_title').val('');
    $('#uca_inp_res').val('');
    $('#uca_inptxt_res').val('');
    $('#uca_doc_id').val('');
    var uca_img_field     = ''; // создаем переменную
    var i_uca_img_field   = ''; // создаем переменную
    var uca_dsc_field     = ''; // создаем переменную
    var i_uca_dsc_field   = ''; // создаем переменную
    var uca_place_field   = ''; // создаем переменную
    var i_uca_place_field = ''; // создаем переменную
    $('#i_uca_img_field').val(''); // очищаем input
    $('#i_uca_dsc_field').val(''); // очищаем input
    $('#i_uca_place_field').val(''); // очищаем input     
    var post_doc = '';
    var uca_inp_res = $("#uca_result option:selected").val();
    var uca_inptxt_res = $("#uca_result option:selected").text();
    if (val_rub !=''){ldelim}
    $('#tr_uca_res').after('<table id="tr_uca_data" cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings"><colgroup><col width="201"><col width="*"><col width="*"><col width="*"><col width="*"><col width="*"></colgroup><thead><tr class="noborder"><td colspan="2" ><h5 class="iFrames" style="text-align: left; padding-left: 10px;">{#UCA_SEL_FIELD_DATA_INF#}</h5></td></tr></thead><tbody><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_TTL#}</td><td align="left"><select disabled="disabled" name="uca_ttl_field" id="uca_ttl_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_TTL#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_H_IMG#}</td><td align="left"><select name="uca_img_field" id="uca_img_field" style="width: 300px;"></select></td><input name="i_uca_img_field" type="hidden" id="i_uca_img_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_DSC#}</td><td align="left"><select name="uca_dsc_field" id="uca_dsc_field" style="width: 300px;"></select></td><input name="i_uca_dsc_field" type="hidden" id="i_uca_dsc_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_PLW#}</td><td align="left"><select name="uca_place_field" id="uca_place_field" style="width: 300px;"></select></td><input name="i_uca_place_field" type="hidden" id="i_uca_place_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_STR#}</td><td align="left"><select disabled="disabled" name="uca_str_field" id="uca_str_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_END#}</td><td align="left"><select disabled="disabled" name="uca_end_field" id="uca_end_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr></tbody></table><table id="tr_uca_res_doc" cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm"><colgroup><col width="201" /><col width="*" /></colgroup><col width="*" /></colgroup><col width="*" /><thead><tr class="noborder"><td align="center"><label>{#UCA_SELECT_ALL_INF#} <input style="position:relative; top:3px;" type="checkbox" id="check_all">&nbsp;{#UCA_SELECT_ALL_INF_CH#}</label></td><td align="center">{#UCA_ID_INF#}</td><td align="center">{#UCA_TITLE_INF#}</td><td align="center">{#UCA_DATE_INF#}</td><td align="center">{#UCA_DATE_EXPIRE#}</td></tr></thead><tbody><tr id="result_doc"></tr></tbody></table>');
    $('#uca_rubric_id').val(uca_inp_res);
    $('#uca_rubric_title').val(uca_inptxt_res);
    uca_doc_request = uca_inp_res;
    ucaDoc();

    uca_frub_id = $('#uca_rubric_id').val();
    ucaRubFields();
    $('#uca_img_field').change(function(){ldelim} // START если есть действия с селектом "Изображение - выбор поля" пишем ID выбранного в скрытый input id="i_uca_img_field" 
    uca_img_field = $('#uca_img_field').val();
    i_uca_img_field = $('#i_uca_img_field').val(uca_img_field); 
    {rdelim});  // END если есть действия с селектом "Изображение - выбор поля" пишем ID выбранного в скрытый input id="i_uca_img_field" 

    $('#uca_dsc_field').change(function(){ldelim} // START если есть действия с селектом "Описание события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_dsc_field" 
    uca_dsc_field = $('#uca_dsc_field').val();
    i_uca_dsc_field = $('#i_uca_dsc_field').val(uca_dsc_field); 
    {rdelim});  // END если есть действия с селектом "Описание события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_dsc_field"

    $('#uca_place_field').change(function(){ldelim} // START если есть действия с селектом "Место события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_place_field" 
    uca_place_field = $('#uca_place_field').val();
    i_uca_place_field = $('#i_uca_place_field').val(uca_place_field);   
    {rdelim});  // END если есть действия с селектом "Место события - выбор поля" пишем ID выбранного в скрытый input id="i_uca_place_field" 
    //alert(uca_frub_id);
    {rdelim};
    {rdelim});
    {rdelim}// END Если значение value не пустое и выбран тип события "Выбранные документы из заданной рубрики"...

    // START AJAX запрос вывести все поля рубрики
    function ucaRubFields() {ldelim}
    $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}uca_rub_field:'uca_rub_field',uca_frub_id:uca_frub_id{rdelim},
    success: function(data) {ldelim}
    $("#uca_img_field").html("<option style='color: #ABABAB;' value=''>{#UCA_SEL_FIELD_IMG#}</option>"+data);
    $("#uca_dsc_field").html("<option style='color: #ABABAB;' value=''>{#UCA_SEL_FIELD_DSC#}</option>"+data);
    $("#uca_place_field").html("<option style='color: #ABABAB;' value=''>{#UCA_SEL_FIELD_PLC#}</option>"+data);
    $('select').styler({ldelim}selectSearch:false, selectVisibleOptions:5{rdelim});
    {rdelim}
    {rdelim});
    {rdelim}; // END AJAX запрос вывести все поля рубрики

    // START AJAX запрос по типу выбранного события - "Все документы из заданной рубрики"
    function ucaCall() {ldelim}
    $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}c:uca_request{rdelim},
    success: function(data) {ldelim}
    $("#uca_result").html(data);
    $('select').styler({ldelim}selectSearch:false, selectVisibleOptions:5{rdelim});
    uca_request = ''; 
    {rdelim},
    error:  function(xhr, str){ldelim}
    $.jGrowl("{#SaveError#}", {ldelim}
	header: '{#SentData#}',
	theme: 'error'
	{rdelim}); 
    {rdelim}
    {rdelim});
    {rdelim}; // END AJAX запрос по типу выбранного события - "Все документы из заданной рубрики"

    // START AJAX запрос получаем список документов из выбранной рубрики
    function ucaDoc() {ldelim}
    $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}a:'post_doc',b:uca_doc_request{rdelim},
    success: function(data) {ldelim}
    $("#result_doc").after(data);
    {rdelim},
    error:  function(xhr, str){ldelim}
    $.jGrowl("{#SaveError#}", {ldelim}
	header: '{#SentData#}',
	theme: 'error'
	{rdelim}); 
    {rdelim}
    {rdelim});
    {rdelim}; // END AJAX запрос получаем список документов из выбранной рубрики    

    {rdelim}); // END Получаем значениe value выбранного option - События календаря

    // START ОДНИМ чекбоксом - отмечаем - снимаем сразу все чекбоксы документов и пишем в input значение
    jQuery(function($) {ldelim}
    $( document ).on('click change', "input:checkbox#check_all", function(e) {ldelim}
    var $this = $(this);
    var values = [];
    $("input:checkbox.my-checkbox").prop('checked', $this.prop('checked'));
    $("input:checkbox.my-checkbox").filter(':checked').each(function() {ldelim}
    values.push(this.value);
    {rdelim});
    $('#uca_doc_id').val("Id="+values.join(' OR Id=')+" ");
    {rdelim});
    {rdelim});// END ОДНИМ чекбоксом - отмечаем - снимаем сразу все чекбоксы документов и пишем в input значение

    // START CHEK - отмечаем - снимаем чекбоксы документов по одному и пишем в input значение
    jQuery(function($) {ldelim}
    $( document ).on('click change', "input:checkbox.my-checkbox", function() {ldelim}
    var values = [];
    $("input:checkbox.my-checkbox").filter(':checked').each(function() {ldelim}
    values.push(this.value);
    {rdelim});
    $('#uca_doc_id').val("Id="+values.join(' OR Id=')+" ");
    {rdelim});
    {rdelim});// END CHECK - отмечаем - снимаем чекбоксы документов по одному и пишем в input значение

    // START получаем значение радиокнопки формат даты и пишем в input значение
    $(".u_date_format").on('change', function() {ldelim}
    $('#uca_date_format').val('');	
    var u_date_format = $('input[name="u_date_format"]:checked').val();
    $('#uca_date_format').val(u_date_format);
    {rdelim});// END получаем значение радиокнопки формат даты и пишем в input значение    

    // START получаем значение радиокнопки открыть ссылку и пишем в input значение
    $(".u_link").on('change', function() {ldelim}
    $('#uca_link').val('');	
    var u_link = $('input[name="u_link"]:checked').val();
    $('#uca_link').val(u_link);
    {rdelim});// END получаем значение радиокнопки открыть ссылку и пишем в input значение

    // START получаем значение радиокнопки Отображать начало недели в календаре
    $(".u_day").on('change', function() {ldelim}
    $('#uca_day').val('');	
    var u_day = $('input[name="u_day"]:checked').val();
    $('#uca_day').val(u_day);
    {rdelim});// END получаем значение радиокнопки Отображать начало недели в календаре

    // START получаем значение радиокнопки Включить полосу прокрутки в событиях
    $(".u_scroll").on('change', function() {ldelim}
    $('#uca_scroll').val('');	
    var u_scroll = $('input[name="u_scroll"]:checked').val();
    $('#uca_scroll').val(u_scroll);
    {rdelim});// END получаем значение радиокнопки Включить полосу прокрутки в событиях

    // START получаем значение радиокнопки Раскрывать содержимое всех событий сразу после загрузки
    $(".u_descript").on('change', function() {ldelim}
    $('#uca_descript').val('');	
    var u_descript = $('input[name="u_descript"]:checked').val();
    $('#uca_descript').val(u_descript);
    {rdelim});// END получаем значение радиокнопки Раскрывать содержимое всех событий сразу после загрузки

    // Если произошло событие на кнопке "Добавить" - записываем в БД
    $("#btn_ucasub").on('click', function() {ldelim}
    var msg   = $('#add_unicalendar').serialize();
    var check_fields_title     = $('#uca_title').val();
    var check_fields_events    = $('#uca_events').val();
    var check_fields_rubric_id = $('#uca_rubric_id').val();
    var check_fields_doc_id    = $ ('#uca_doc_id').val();
    $('#i_block_create_calendar').val('0');
    if (check_fields_events == '1' && check_fields_rubric_id !='') // START проверяем и запрещаем создавать календарь, если рубрика содержит только один или два документа, Id которых равны либо главной странице либо странице 404 , либо и то и другое. 
    {ldelim} 

    $.ajax({ldelim}// START если условия выше соответствуют - делаем ajax запрос
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: false,
    data: {ldelim}allowed_rub:'allowed_rub',allowed_rub_id:check_fields_rubric_id{rdelim},
    success: function(data) {ldelim}
    var f_block_create_calendar = '0';//создаем переменную
    var f_id_str = data.split(',');// преобразуем строку в массив
    var f_count_str = f_id_str.length;// считаем количество элементов в массиве
    if (f_count_str == '2' && f_id_str[0] == '1' && f_id_str[1] == {$smarty.const.PAGE_NOT_FOUND_ID} || f_count_str == '1' && f_id_str[0] == '1' || f_count_str == '1' && f_id_str[0] == {$smarty.const.PAGE_NOT_FOUND_ID})// проверка условий
    {ldelim}
      f_block_create_calendar = '1'; // пишем в переменную 1, если условия для запрета совпали
      $('#i_block_create_calendar').val(f_block_create_calendar);
    {rdelim} else {ldelim}
          f_block_create_calendar = '0'; // пишем в переменную 0, если условия для запрета не совпали
      $('#i_block_create_calendar').val(f_block_create_calendar);
    {rdelim};
    {rdelim},
    {rdelim});// END если условия выше соответствуют - делаем ajax запрос
    {rdelim}; // END проверяем и запрещаем создавать календарь, если рубрика содержит только один или два документа, Id которых равны либо главной странице либо странице 404 , либо и то и другое. 
    var block_create_calendar = $('#i_block_create_calendar').val();

    if (block_create_calendar != '1'){ldelim}// не сохраняем если в рубрике ТОЛЬКО или главная страница или 404 стр. или то и другое.

    if (check_fields_title !=''){ldelim}// не сохраняем если не указан заголовок

    if (check_fields_events !=''){ldelim}// не сохраняем если не указан тип событий календаря

    if (check_fields_rubric_id !=''){ldelim}// не сохраняем если не выбрана рубрика

    if (check_fields_events == '1' && check_fields_rubric_id !='' || check_fields_events == '2' && check_fields_doc_id !='Id= ' && check_fields_doc_id !=''){ldelim}// не сохраняем если не выбран ни один документ  
            

    $.ajax({ldelim}
    type: 'POST',
    url: '{$formaction}',
    data: msg,
    success: function(data) {ldelim}
    document.location.href = "index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1&cp={$sess}";
    {rdelim},
    error:  function(xhr, str){ldelim}
    $.jGrowl("{#SaveError#}", {ldelim}
	header: '{#SentData#}',
	theme: 'error'
	{rdelim}); 
    {rdelim}
    {rdelim});


    {rdelim} else {ldelim}
    alert("{#UCA_SEL_DOC_WARNING#}");
    {rdelim};

    {rdelim} else {ldelim}
    alert("{#UCA_SEL_RUB_WARNING#}");
    {rdelim};

    {rdelim} else {ldelim}
    alert("{#UCA_SEL_EVENTS_WARNING#}");
    {rdelim};

    {rdelim} else {ldelim}
    alert("{#UCA_TITLE_WARNING#}");
    {rdelim};

    {rdelim} else {ldelim}
    alert("{#UCA_SEL_RUB_ID_DOC#}");
    {rdelim};

    

    {rdelim}); // END Если произошло событие на кнопке "Добавить" - записываем в БД

    // Копируем системные теги при клике в буфер обмена
    var clipboard = new Clipboard('.copyBtn');

    // Start аналог php функции str_replace
    function str_replace ( search, replace, subject ) {ldelim} 
    if(!(replace instanceof Array)){ldelim}
        replace=new Array(replace);
        if(search instanceof Array){ldelim}
            while(search.length>replace.length){ldelim}
                replace[replace.length]=replace[0];
            {rdelim}
        {rdelim}
    {rdelim}
    if(!(search instanceof Array))search=new Array(search);
    while(search.length>replace.length){ldelim}
        replace[replace.length]='';
    {rdelim}
    if(subject instanceof Array){ldelim}
        for(k in subject){ldelim}
            subject[k]=str_replace(search,replace,subject[k]);
        {rdelim}
        return subject;
    {rdelim}
    for(var k=0; k<search.length; k++){ldelim}
        var i = subject.indexOf(search[k]);
        while(i>-1){ldelim}
            subject = subject.replace(search[k], replace[k]);
            i = subject.indexOf(search[k],i);
        {rdelim}
    {rdelim}
    return subject;
{rdelim} // END аналог php функции str_replace

  </script>        