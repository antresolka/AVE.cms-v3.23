<div class="title"><h5>{#ModName#}</h5></div>
<div class="widget" style="margin-top: 0px;">
    <div class="body">
    <ul>
		<li>{#UCA_EDIT_INFO#}</li>
	</ul>	
    </div>
</div>
<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li><strong class="code">{#UCA_EDIT_CALEND#}</strong></li>
	    </ul>
	</div>
</div>
{foreach from=$unicalendars item=unicalendars}
<div class="widget first">
<div class="head">
<h5 class="iFrames">{#UCA_EDIT_CALEND#} - <span id="ed_title">{$unicalendars.uca_title|escape}</span></h5>
</div>
    <div class="body">
        <ul>
		    <li><h5 class="iFrames">{#UCA_SET_CALENDAR#}</h5></li>
		    <li style="margin-top: 5px; margin-bottom: 5px;"><span class="doclink">{#UCA_ID#}</span>&nbsp;&nbsp;<span class="cmsStats">{$unicalendars.id}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="doclink">{#UCA_EVENTS#} = </span>&nbsp;&nbsp;<span class="cmsStats">{if $unicalendars.uca_events == 1}{#UCA_LIST_ALLDOC_RUB#}&nbsp;&nbsp;<i id="title_rub"> {$unicalendars.uca_rubric_title|escape}</i>{elseif $unicalendars.uca_events == 2}{#UCA_LIST_SELDOC_RUB#}&nbsp;&nbsp;<i> {$unicalendars.uca_rubric_title|escape}</i>{/if}</span></li>
		</ul>	
    </div>
</div>
        {if $unicalendars.uca_events == 1}
                    
                	<table  id="tr_uca" cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr class="noborder" style="background:#D5E0EC; height: 20px;">
                			<td></td>
                			<td><input name="uca_events" type="hidden" id="uca_events" value="{$unicalendars.uca_events|escape}"/></td>
                		</tr>                	
                		<tr class="noborder">
                			<td width="180">{#UCA_TITLE#}</td>
                			<td>
                				<input name="uca_title" type="text" id="uca_title" value="{$unicalendars.uca_title|escape}" style="width:300px" />
                			</td>
                		</tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_PUBLIC_DATE#}</td>
                            <td>
                                <input name="uca_date_format" type="hidden" id="uca_date_format" value="{$unicalendars.uca_date_format|escape}"/>
                                <input type="radio" name="u_date_format" class="u_date_format" value="dddd, DD MMM YYYY" {if $unicalendars.uca_date_format == 'dddd, DD MMM YYYY'} checked="checked" {/if}>
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %d %B %Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="dddd, DD-MM-YYYY" {if $unicalendars.uca_date_format == 'dddd, DD-MM-YYYY'} checked="checked" {/if}>
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %d-%m-%Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="dddd, YYYY-MM-DD" {if $unicalendars.uca_date_format == 'dddd, YYYY-MM-DD'} checked="checked" {/if}>
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %Y-%m-%d'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="DD MMM YYYY" {if $unicalendars.uca_date_format == 'DD MMM YYYY'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%d %B %Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="DD-MM-YYYY" {if $unicalendars.uca_date_format == 'DD-MM-YYYY'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%d-%m-%Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="YYYY-MM-DD" {if $unicalendars.uca_date_format == 'YYYY-MM-DD'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%Y-%m-%d'|pretty_date}</label>
                            </td>
                        </tr>                        
                		<tr class="noborder">
                			<td width="180">{#UCA_OPEN_LIKS#}</td>
                			<td>
                				<input name="uca_link" type="hidden" id="uca_link" value="{$unicalendars.uca_link|escape}"/>
                                <input type="radio" name="u_link" class="u_link" value="true" {if $unicalendars.uca_link == 'true'} checked="checked" {/if}>
                				<label for="">{#UCA_YES#}</label>
                                <input type="radio" name="u_link" class="u_link" value="false" {if $unicalendars.uca_link == 'false'} checked="checked" {/if}>
                				<label for="">{#UCA_NO#}</label>                				
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_WEEK_START#}</td>                		
                			<td>
                				<input name="uca_day" type="hidden" id="uca_day" value="{$unicalendars.uca_day|escape}"/>
                				<input type="radio" name="u_day" class="u_day" value="true" {if $unicalendars.uca_day == 'true'} checked="checked" {/if}>
                				<label for="">{#UCA_WEEK_START_MONDAY#}</label>
                				<input type="radio" name="u_day" class="u_day" value="false" {if $unicalendars.uca_day == 'false'} checked="checked" {/if}>
                				<label for="">{#UCA_WEEK_START_SUNDAY#}</label>                				
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_SCROLL_BAR#}</td>                		
                			<td>
                				<input name="uca_scroll" type="hidden" id="uca_scroll" value="{$unicalendars.uca_scroll|escape}"/>
                				<input type="radio" name="u_scroll" class="u_scroll" value="true" {if $unicalendars.uca_scroll == 'true'} checked="checked" {/if}>
                				<label for="">{#UCA_YES#}</label>
                				<input type="radio" name="u_scroll" class="u_scroll" value="false" {if $unicalendars.uca_scroll == 'false'} checked="checked" {/if}>
                				<label for="">{#UCA_NO#}</label>                				
                			</td>
                		</tr>
                		<tr class="noborder">
                			<td width="180">{#UCA_DESCRIPTION#}</td>                		
                			<td>
                				<input name="uca_descript" type="hidden" id="uca_descript" value="{$unicalendars.uca_descript|escape}"/>
                				<input type="radio" name="u_descript" class="u_descript" value="true" {if $unicalendars.uca_descript == 'true'} checked="checked" {/if}>
                				<label for="">{#UCA_YES#}</label>
                				<input type="radio" name="u_descript" class="u_descript" value="false" {if $unicalendars.uca_descript == 'false'} checked="checked" {/if}>
                				<label for="">{#UCA_NO#}</label>                				
                			</td>
                		</tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_EVENTS_LIMIT#}</td>                        
                            <td>
                                <input name="uca_events_limit" type="text" id="uca_events_limit" value="{$unicalendars.uca_events_limit|escape}" style="width:32px"/>
                            </td>
                        </tr>
						<tr class="noborder">
                			<td width="180"><div style="padding-bottom: 8px; padding-top: 8px;">{#UCA_EVENTS#}</div></td>
                			<td id="uca_result">
                			<input type='hidden' name='uca_rubric_title' id='uca_rubric_title' value='{$unicalendars.uca_rubric_title|escape}'>
                			<input type='hidden' name='uca_rubric_id' id='uca_rubric_id' value='{$unicalendars.uca_rubric_id|escape}'>
                            <span>{#UCA_LIST_ALLDOC_RUB#} <span class="cmsStats">{$unicalendars.uca_rubric_title|escape}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a class="btn redBtn" href="javascript:void(0);" onclick="ucaCangeRub();">{#UCA_CHANGE_RUBRIC#}</a></span>
			                </td>
                		</tr>
                	</table>

                    <div id="uca_rub_after_fields"></div>

                  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr>
                 			<td colspan="2">
                			  <div class="pr12" style="display: table; padding: 5px 0px 5px 0px;">
                				<a id="btn_save_edit" class="btn blueBtn" href="javascript:void(0);">{#UCA_SAVE_EDIT#}</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a class="btn greenBtn" href="index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1&cp={$sess}">{#UCA_RETURN_LIST#}</a>
                              </div>
                			</td>
                		</tr>                
                  </table>
        {/if}

        {if $unicalendars.uca_events == 2}
                    
                    <table  id="tr_uca" cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                        <tr class="noborder" style="background:#D5E0EC; height: 20px;">
                            <td></td>
                            <td>
                            <input type="hidden" name="uca_doc_id" id="uca_doc_id" value="{$unicalendars.uca_doc_id|escape}" />
                            <input name="uca_events" type="hidden" id="uca_events" value="{$unicalendars.uca_events|escape}"/>
                            </td>
                        </tr>                   
                        <tr class="noborder">
                            <td width="180">{#UCA_TITLE#}</td>
                            <td>
                                <input name="uca_title" type="text" id="uca_title" value="{$unicalendars.uca_title|escape}" style="width:300px" />
                            </td>
                        </tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_PUBLIC_DATE#}</td>
                            <td>
                                <input name="uca_date_format" type="hidden" id="uca_date_format" value="{$unicalendars.uca_date_format|escape}"/>
                                <input type="radio" name="u_date_format" class="u_date_format" value="dddd, DD MMM YYYY" {if $unicalendars.uca_date_format == 'dddd, DD MMM YYYY'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %d %B %Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="dddd, DD-MM-YYYY" {if $unicalendars.uca_date_format == 'dddd, DD-MM-YYYY'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %d-%m-%Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="dddd, YYYY-MM-DD" {if $unicalendars.uca_date_format == 'dddd, YYYY-MM-DD'} checked="checked" {/if}>
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%A, %Y-%m-%d'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="DD MMM YYYY" {if $unicalendars.uca_date_format == 'DD MMM YYYY'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%d %B %Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="DD-MM-YYYY" {if $unicalendars.uca_date_format == 'DD-MM-YYYY'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%d-%m-%Y'|pretty_date}</label>
                                <input type="radio" name="u_date_format" class="u_date_format" value="YYYY-MM-DD" {if $unicalendars.uca_date_format == 'YYYY-MM-DD'} checked="checked" {/if}> 
                                <label class="code" style="background: #fff; margin-right: 5px; margin-left: 5px;" for="">{$smarty.now|date_format:'%Y-%m-%d'|pretty_date}</label>
                            </td>
                        </tr>                        
                        <tr class="noborder">
                            <td width="180">{#UCA_OPEN_LIKS#}</td>
                            <td>
                                <input name="uca_link" type="hidden" id="uca_link" value="{$unicalendars.uca_link|escape}"/>
                                <input type="radio" name="u_link" class="u_link" value="true" {if $unicalendars.uca_link == 'true'} checked="checked" {/if}>
                                <label for="">{#UCA_YES#}</label>
                                <input type="radio" name="u_link" class="u_link" value="false" {if $unicalendars.uca_link == 'false'} checked="checked" {/if}>
                                <label for="">{#UCA_NO#}</label>                                
                            </td>
                        </tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_WEEK_START#}</td>                     
                            <td>
                                <input name="uca_day" type="hidden" id="uca_day" value="{$unicalendars.uca_day|escape}"/>
                                <input type="radio" name="u_day" class="u_day" value="true" {if $unicalendars.uca_day == 'true'} checked="checked" {/if}>
                                <label for="">{#UCA_WEEK_START_MONDAY#}</label>
                                <input type="radio" name="u_day" class="u_day" value="false" {if $unicalendars.uca_day == 'false'} checked="checked" {/if}>
                                <label for="">{#UCA_WEEK_START_SUNDAY#}</label>                             
                            </td>
                        </tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_SCROLL_BAR#}</td>                     
                            <td>
                                <input name="uca_scroll" type="hidden" id="uca_scroll" value="{$unicalendars.uca_scroll|escape}"/>
                                <input type="radio" name="u_scroll" class="u_scroll" value="true" {if $unicalendars.uca_scroll == 'true'} checked="checked" {/if}>
                                <label for="">{#UCA_YES#}</label>
                                <input type="radio" name="u_scroll" class="u_scroll" value="false" {if $unicalendars.uca_scroll == 'false'} checked="checked" {/if}>
                                <label for="">{#UCA_NO#}</label>                                
                            </td>
                        </tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_DESCRIPTION#}</td>                        
                            <td>
                                <input name="uca_descript" type="hidden" id="uca_descript" value="{$unicalendars.uca_descript|escape}"/>
                                <input type="radio" name="u_descript" class="u_descript" value="true" {if $unicalendars.uca_descript == 'true'} checked="checked" {/if}>
                                <label for="">{#UCA_YES#}</label>
                                <input type="radio" name="u_descript" class="u_descript" value="false" {if $unicalendars.uca_descript == 'false'} checked="checked" {/if}>
                                <label for="">{#UCA_NO#}</label>                                
                            </td>
                        </tr>
                        <tr class="noborder">
                            <td width="180">{#UCA_EVENTS_LIMIT#}</td>                        
                            <td>
                                <input name="uca_events_limit" type="text" id="uca_events_limit" value="{$unicalendars.uca_events_limit|escape}" style="width:32px"/>
                            </td>
                        </tr>
                        <tr class="noborder">
                            <td width="180"><div style="padding-bottom: 8px; padding-top: 8px;">{#UCA_EVENTS#}</div></td>
                            <td id="uca_result">
                            <input type='hidden' name='uca_rubric_title' id='uca_rubric_title' value='{$unicalendars.uca_rubric_title|escape}'>
                            <input type='hidden' name='uca_rubric_id' id='uca_rubric_id' value='{$unicalendars.uca_rubric_id|escape}'>
                            <span>{#UCA_LIST_SELDOC_RUB#} <span class="cmsStats">{$unicalendars.uca_rubric_title|escape}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           {*<a class="btn redBtn" href="javascript:void(0);" onclick="ucaCangeRub();">{#UCA_CHANGE_RUBRIC#}</a></span>*}
                            </td>
                        </tr>
                    </table>

                    <div id="uca_rub_after_fields"></div>


                    <table id="tr_uca_res_doc" cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                        <colgroup>
                            <col width="201" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                        </colgroup>
                    <thead>
                        <tr class="noborder">
                            <td align="center">{#UCA_EVENTS_SELECT_DOC#}</td>
                            <td align="center">{#UCA_ID_INF#}</td>
                            <td align="center">{#UCA_TITLE_INF#}</td>
                            <td align="center">{#UCA_DATE_INF#}</td>
                            <td align="center">{#UCA_DATE_EXPIRE#}</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="result_doc">
                            <td iwidth="180" align="center">
                           <div><span id="alert_mes"></span></div>
                            </td>
                        </tr>
                        <span id="ref_doc">
                        {foreach from=$unidocs item=unidocs}
                        <tr class='noborder'>
                        <td align='center'><input id="inp_doc_{$unidocs.Id}" type='checkbox' class='my-checkbox' name='u_chek{$unidocs.Id}' value='{$unidocs.Id}'></td>
                        <td align='center'>{$unidocs.Id}</td>
                        <td>{$unidocs.document_title}</td>
                        <td align='center'>{$unidocs.document_published|date_format:$TIME_FORMAT|pretty_date}</td>
                        <td align='center'>{$unidocs.document_expire|date_format:$TIME_FORMAT|pretty_date}</td>
                        </tr>
                        {/foreach}
                        </span>
                    </tbody>
                    </table>

                  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                        <tr>
                            <td colspan="2">
                              <div class="pr12" style="display: table; padding: 5px 0px 5px 0px;">
                                <a id="btn_save_edit" class="btn blueBtn" href="javascript:void(0);">{#UCA_SAVE_EDIT#}</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a class="btn greenBtn" href="index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=1&cp={$sess}">{#UCA_RETURN_LIST#}</a>
                              </div>
                            </td>
                        </tr>                
                  </table>
        {/if}

{/foreach}

<script>
    {if $unicalendars.uca_events == 1 || $unicalendars.uca_events == 2}// START Если событиями календаря являются все доки из рубрики или выбранные доки из рубрики

    var uca_frub_id = '';
    $('#i_uca_img_field').val('');
    $('#i_uca_dsc_field').val('');
    $('#i_uca_place_field').val('');
    var uca_img_field     = ''; // создаем переменную
    var i_uca_img_field   = ''; // создаем переменную
    var uca_dsc_field     = ''; // создаем переменную
    var i_uca_dsc_field   = ''; // создаем переменную
    var uca_place_field   = ''; // создаем переменную
    var i_uca_place_field = ''; // создаем переменную    

      $("#uca_rub_after_fields").html('<table id="tr_uca_data" cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings"><colgroup><col width="201"><col width="*"><col width="*"><col width="*"><col width="*"><col width="*"></colgroup><thead><tr class="noborder"><td colspan="2" ><h5 class="iFrames" style="text-align: left; padding-left: 10px;">{#UCA_SEL_FIELD_DATA_INF#}</h5></td></tr></thead><tbody><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_TTL#}</td><td align="left"><select disabled="disabled" name="uca_ttl_field" id="uca_ttl_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_TTL#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_H_IMG#}</td><td align="left"><select name="uca_img_field" id="uca_img_field" style="width: 300px;"></select></td><input name="i_uca_img_field" type="hidden" id="i_uca_img_field" value="{$unicalendars.uca_img_field|escape}"/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_DSC#}</td><td align="left"><select name="uca_dsc_field" id="uca_dsc_field" style="width: 300px;"></select></td><input name="i_uca_dsc_field" type="hidden" id="i_uca_dsc_field" value="{$unicalendars.uca_dsc_field|escape}"/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_PLW#}</td><td align="left"><select name="uca_place_field" id="uca_place_field" style="width: 300px;"></select></td><input name="i_uca_place_field" type="hidden" id="i_uca_place_field" value="{$unicalendars.uca_place_field|escape}"/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_STR#}</td><td align="left"><select disabled="disabled" name="uca_str_field" id="uca_str_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_END#}</td><td align="left"><select disabled="disabled" name="uca_end_field" id="uca_end_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr></tbody></table>');

    uca_frub_id = $('#uca_rubric_id').val();
    ucaRubFieldsEditAll();

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

    {/if}// END Если событиями календаря являются все доки из рубрики

    {if $unicalendars.uca_events == 2}// START Если событиями календаря являются выбранные доки из рубрики
    // START получаем данные активных чекбоксов-документов
    {foreach from=$check_docs item=check_docs}
    $("#inp_doc_{$check_docs.Id}").attr('checked', 'checked' );// активируем чекбоксы в списке документов
    {/foreach} 
    // END получаем данные активных чекбоксов-документов

    // START пишем значение активных чекбоксов в input, т.к. календарь мог стать не актуальным с момента его создания до момента редактирования
    var values = [];
    $("input:checkbox.my-checkbox").filter(':checked').each(function() {ldelim}
    values.push(this.value);
    {rdelim});
    $('#uca_doc_id').val("Id="+values.join(' OR Id=')+" ");
    // END пишем значение активных чекбоксов в input, т.к. календарь мог стать не актуальным с момента его создания до момента редактирования

    // START считаем активные чекбоксы при открытии страницы и если находим только один активный чекбокс выбранного документа - запрещаем редактирование
    var count = $(':checkbox.my-checkbox:checked').length;// ведем подсчет отмеченных чекбоксов
    if (count <= '1'){ldelim}//если количество чекбоксов документов <= 1
    $(':checkbox.my-checkbox:checked').prop('disabled', true);//блокируем чекбокс
    $('#alert_mes').html("<img class='toprightDir' style='cursor: pointer;' src='{$ABS_PATH}modules/unicalendar/images/question_start_one.png' title='{#UCA_DISABLE_START_EDIT#}' border='0' />");//выводим предупреждение о запрете редактирования единственного документа
    {rdelim} else {ldelim}
    $('#alert_mes').html("<img class='toprightDir' style='cursor: pointer;' src='{$ABS_PATH}modules/unicalendar/images/question_select.png' title='{#UCA_ABLE_EDIT_DOC#}' border='0'/>")
    {rdelim};// END считаем активные чекбоксы при открытии страницы и если находим только один активный чекбокс выбранного документа - запрещаем редактирование

    // START ОДНИМ чекбоксом - отмечаем - снимаем сразу все чекбоксы документов и пишем в input значение
    jQuery(function($) {ldelim}
    $('#check_all').on('click change', function(e) {ldelim}
    var $this = $(this);
    var values = [];
    $("input:checkbox.my-checkbox").prop('checked', $this.prop('checked'));
    $("input:checkbox.my-checkbox").filter(':checked').each(function() {ldelim}
    values.push(this.value);
    {rdelim});
    $('#uca_doc_id').val("Id="+values.join(' OR Id=')+" ");
    {rdelim});
    {rdelim});// END ОДНИМ чекбоксом - отмечаем - снимаем сразу все чекбоксы документов и пишем в input значение

    // START CHECK - отмечаем - снимаем чекбоксы документов по одному и пишем в input значение
    jQuery(function($) {ldelim}
    $( document ).on('click change', "input:checkbox.my-checkbox", function() {ldelim}
    var $this = $(this);    
    var count = $(':checkbox.my-checkbox:checked').length;//ведем подсчет отмеченных чекбоксов
    if (count <= '1'){ldelim}//если количество чекбоксов документов <= 1
    $(':checkbox.my-checkbox:checked').prop('disabled', true).prev().attr('class', 'jqTransformCheckbox jqTransformCheckedDisable jqTransformCheckedDisableCheck jqTransformChecked');//блокируем чекбокс
    $('#alert_mes').html("<img class='toprightDir' style='cursor: pointer;' src='{$ABS_PATH}modules/unicalendar/images/question_alert.png' title='{#UCA_DISABLE_START_EDIT#}' border='0'/>");//выводим предупреждение о запрете редактирования единственного документа
    {rdelim};
    if (count > '1'){ldelim}//если количество чекбоксов документов > 1
    $(':checkbox.my-checkbox:checked').prop('disabled', false);//если находим заблокированный чекбокс - снимаем с него блокировку
    $('a.jqTransformCheckedDisableCheck').attr('class', 'jqTransformCheckbox jqTransformChecked')
    $('#alert_mes').html("<img class='toprightDir' style='cursor: pointer;' src='{$ABS_PATH}modules/unicalendar/images/question_select.png' title='{#UCA_ABLE_EDIT_DOC#}' border='0'/>");//убираем предупреждение о запрете редактирования единственного документа
    {rdelim};    
    var values = [];
    $("input:checkbox.my-checkbox").filter(':checked').each(function() {ldelim}
    values.push(this.value);
    {rdelim});
    $('#uca_doc_id').val("Id="+values.join(' OR Id=')+" ");
    {rdelim});
    {rdelim});// END CHECK - отмечаем - снимаем чекбоксы документов по одному и пишем в input значение
    {/if}// END Если событиями календаря являются выбранные доки из рубрики



	// START обнуляем значение value у input Название календаря при событии focus
	$('#uca_title').focus(function(){ldelim}
	$('#uca_title').val('');
	{rdelim});// END обнуляем значение value у input Название календаря при событии focus

    // START обнуляем значение value у input Лимит вывода событий при событии focus
    $('#uca_events_limit').focus(function(){ldelim}
    $('#uca_events_limit').val('');
    {rdelim});// END обнуляем значение value у input Лимит вывода событий при событии focus    

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

function ucaRubFieldsEditAll() {ldelim} //START AJAX запросов - вывести поля рубрики + активные пункты в select
$.when( $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}uca_edit_rub_field_img:'uca_edit_rub_field_img',uca_frub_id:uca_frub_id,id:{$unicalendars.id}{rdelim},
    success: function(data) {ldelim}
    $("#uca_img_field").html("<option style='color: #ABABAB;' value=''>{#UCA_SEL_FIELD_IMG#}</option>"+data);
    {rdelim}
    {rdelim}), $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}uca_edit_rub_field_dsc:'uca_edit_rub_field_dsc',uca_frub_id:uca_frub_id,id:{$unicalendars.id}{rdelim},
    success: function(data) {ldelim}
    $("#uca_dsc_field").html("<option style='color: #ABABAB;' value=''>{#UCA_SEL_FIELD_DSC#}</option>"+data);
    {rdelim}
    {rdelim}), $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}uca_edit_rub_field_plc:'uca_edit_rub_field_plc',uca_frub_id:uca_frub_id,id:{$unicalendars.id}{rdelim},
    success: function(data) {ldelim}
    $("#uca_place_field").html("<option style='color: #ABABAB;' value=''>{#UCA_SEL_FIELD_PLC#}</option>"+data);
    {rdelim}
    {rdelim}) ).then( function (resp1, resp2, resp3) {ldelim}
    /* Этот callback запустится один раз, когда все AJAX запросы будут завершены
        и будут получены все ответы сервера в параметрах resp1, resp2, resp3 и только 
        тогда разукрашиваем гребанный select */
        $('select').styler({ldelim}selectSearch:false, selectVisibleOptions:5{rdelim});
{rdelim});
{rdelim}; //END AJAX запросов - вывести поля рубрики + активные пункты в select

    // START AJAX запрос при клике по кнопке Сменить рубрику
    function ucaCangeRub() {ldelim}
    $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=events_new&cp={$sess}',
    async: true,
    data: {ldelim}c:'s'{rdelim},
    success: function(data) {ldelim}
    $("#uca_result").html("<input type='hidden' name='uca_rubric_title' id='uca_rubric_title' value=''><input type='hidden' name='uca_rubric_id' id='uca_rubric_id' value=''><span style='position:relative; top:2px; padding-right:6px;'>{#UCA_LIST_ALLDOC_RUB#}</span><select name='uca_result' id='uca_result' style='width: 300px;'>"+data+"</select>");
    $('#uca_rub_after_fields').html('');
    $('select').styler({ldelim}selectSearch:false, selectVisibleOptions:5{rdelim});
    {rdelim},
    error:  function(xhr, str){ldelim}
    $.jGrowl("{#SaveError#}", {ldelim}
	header: '{#SentData#}',
	theme: 'error'
	{rdelim}); 
    {rdelim}
    {rdelim});
    {rdelim}; // END AJAX запрос при клике по кнопке Сменить рубрику

    // START если был выполнен AJAX запрос при клике по кнопке Сменить рубрику
    $('#uca_result').change(function(){ldelim}
    $('#uca_rubric_id').val('');
    $('#uca_rubric_title').val('');
    $('#uca_inp_res').val('');
    $('#uca_inptxt_res').val('');
    $('#uca_rub_after_fields').html('');

    var uca_inp_res = $("#uca_result option:selected").val();
    var uca_inptxt_res = $("#uca_result option:selected").text();
    $('#uca_rubric_id').val(uca_inp_res);
    $('#uca_rubric_title').val(uca_inptxt_res);
{if $unicalendars.uca_events == 1}
    var uca_res_new_rub = $('#uca_rubric_id').val();

    if(uca_res_new_rub !='')
    {ldelim}    
    $('#uca_rub_after_fields').html('<table id="tr_uca_data" cellpadding="0" cellspacing="0" width="100%" class="tableStatic settings"><colgroup><col width="201"><col width="*"><col width="*"><col width="*"><col width="*"><col width="*"></colgroup><thead><tr class="noborder"><td colspan="2" ><h5 class="iFrames" style="text-align: left; padding-left: 10px;">{#UCA_SEL_FIELD_DATA_INF#}</h5></td></tr></thead><tbody><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_TTL#}</td><td align="left"><select disabled="disabled" name="uca_ttl_field" id="uca_ttl_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_TTL#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_H_IMG#}</td><td align="left"><select name="uca_img_field" id="uca_img_field" style="width: 300px;"></select></td><input name="i_uca_img_field" type="hidden" id="i_uca_img_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_DSC#}</td><td align="left"><select name="uca_dsc_field" id="uca_dsc_field" style="width: 300px;"></select></td><input name="i_uca_dsc_field" type="hidden" id="i_uca_dsc_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_PLW#}</td><td align="left"><select name="uca_place_field" id="uca_place_field" style="width: 300px;"></select></td><input name="i_uca_place_field" type="hidden" id="i_uca_place_field" value=""/></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_STR#}</td><td align="left"><select disabled="disabled" name="uca_str_field" id="uca_str_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr><tr class="noborder"><td align="left">{#UCA_SEL_FIELD_DATA_END#}</td><td align="left"><select disabled="disabled" name="uca_end_field" id="uca_end_field" style="width: 300px;"><option style="color: #ABABAB;" value="">{#UCA_SEL_FIELD_SDOC#}</option></select></td></tr></tbody></table>');
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
    {rdelim} else {ldelim}
    uca_res_new_rub = '';
    $('#uca_rub_after_fields').html('');
    {rdelim};
    {/if}
    {rdelim}); // END если был выполнен AJAX запрос при клике по кнопке Сменить рубрику


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

    // START Если произошло событие клик на кнопке Сохранить изменения - отправляем AJAX запрос и пишем в БД данные
    $("#btn_save_edit").on('click', function() {ldelim}
    var uca_events           = $('#uca_events').val();
    var uca_title            = $('#uca_title').val();
    var uca_date_format      = $('#uca_date_format').val();
    var uca_link             = $('#uca_link').val();
    var uca_day              = $('#uca_day').val();
    var uca_scroll           = $('#uca_scroll').val();
    var uca_descript         = $('#uca_descript').val();
    var uca_events_limit     = $('#uca_events_limit').val();   
    var uca_rubric_id        = $('#uca_rubric_id').val();
    var uca_rubric_title     = $('#uca_rubric_title').val();
    var uca_doc_id           = $('#uca_doc_id').val();
    var send_uca_img_field   = $('#i_uca_img_field').val();
    var send_uca_dsc_field   = $('#i_uca_dsc_field').val();
    var send_uca_place_field = $('#i_uca_place_field').val();

    var check_fields = $('#uca_title').val();
    var check_fields_rubric_id = $('#uca_rubric_id').val();
    if (check_fields !=''){ldelim}

    if (check_fields_rubric_id !=''){ldelim}    

    $.ajax({ldelim}
    type: 'POST',
    url: 'index.php?do=modules&action=modedit&mod=unicalendar&moduleaction=edit_save&id={$unicalendars.id}&cp={$sess}',
    data: {ldelim}uca_events:uca_events,uca_title:uca_title,uca_date_format:uca_date_format,uca_link:uca_link,uca_day:uca_day,uca_scroll:uca_scroll,uca_descript:uca_descript,uca_events_limit:uca_events_limit,uca_rubric_id:uca_rubric_id,uca_rubric_title:uca_rubric_title,uca_doc_id:uca_doc_id,send_uca_img_field:send_uca_img_field,send_uca_dsc_field:send_uca_dsc_field,send_uca_place_field:send_uca_place_field{rdelim},
    success: function(data) {ldelim}
    $('#ed_title').html(uca_title);
    $('#title_rub').html('&nbsp;&nbsp;'+uca_rubric_title);
    $.jGrowl("{#UCA_ALERT_SAVE_EDIT_S#}", {ldelim}
    header: '{#UCA_ALERT_SAVE_EDIT#}'+uca_title,
    theme: 'accept'
    {rdelim});
    {rdelim},
    error:  function(xhr, str){ldelim}
    $.jGrowl("{#UCA_ALERT_SAVE_EDIT_E#}", {ldelim}
	header: '{#UCA_ALERT_SAVE_EDIT#}{$unicalendars.id}',
	theme: 'error'
	{rdelim}); 
    {rdelim}
    {rdelim});

    {rdelim} else {ldelim}
    alert("{#UCA_SEL_RUB_WARNING#}");
    {rdelim};

    {rdelim} else {ldelim}
    alert("{#UCA_TITLE_WARNING#}");
    {rdelim};

    {rdelim});// END Если произошло событие клик на кнопке Сохранить изменения - отправляем AJAX запрос и пишем в БД данные 
</script>