$(function loadFM() {
	// отдельный файловый менеджер
	$('#finder').elfinder({
		url : ave_path+'lib/redactor/elfinder/php/connector_module_gmap.php',
		lang : 'ru',
	   height : 300,
	   title : 'Файловый менеджер'
	}).elfinder('instance');

	$('#elFinder a').hover(
		function () {
			$('#elFinder a').animate({
				'background-position' : '0 -45px'
			}, 300);
		},
		function () {
			$('#elFinder a').delay(400).animate({
				'background-position' : '0 0'
			}, 300);
		}
	);
});
