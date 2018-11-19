{**
 * plugins/generic/pdfJsViewer/templates/display.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Embedded viewing of a PDF galley.
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>{translate key="article.pageTitle" title=$title}</title>

	{load_header context="frontend" headers=$headers}
	{load_stylesheet context="frontend" stylesheets=$stylesheets}
	{load_script context="frontend" scripts=$scripts}
	{literal}
	<style>
	a#downloadPDF {
	padding-left: 20px;
	padding-right: 20px;
	border-right: 1px dotted #000000;
	}
	a#printPDF {
	padding-left: 20px;
	padding-right: 20px;
	}

	#downloadPDF::before
		{display: inline-block;
		font: normal normal normal 14px/1 FontAwesome;
		font-size: inherit;
		text-rendering: auto;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
		transform: translate(0, 0);
		content: "\f019";}
	#printPDF::before
	    {display: inline-block;
 		font: normal normal normal 14px/1 FontAwesome;
	    font-size: inherit;
	    text-rendering: auto;
    	-webkit-font-smoothing: antialiased;
	    -moz-osx-font-smoothing: grayscale;
    	transform: translate(0, 0);
		content: "\f02f";}
	@media (min-width: 768px)
		{.header_view div a span 
			{display: inline-block;}
		}
	@media (max-width: 768px)
		{.header_view div a span
		        {display: none;}
		}
	</style>
	{/literal}
	<!-- Disable Copy and Paste-->
	{if ! $allowDownload}
	{literal}
	<script>
		window.onload = function() {
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("user-select", "none");
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("-ms-user-select", "none");
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("-o-user-select", "none");
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("-moz-user-select", "none");
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("-khtml-user-select", "none");
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("-webkit-user-select", "none");
			$("#pdfCanvasIframe").contents().find("#outerContainer").css("-webkit-touch-callout", "none");
	    }
	</script>
	{/literal}
	{/if}
</head>
<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">

	{* Header wrapper *}
	<header class="header_view">

		<a href="{$parentUrl}" class="return">
			<span class="pkp_screen_reader">
				{if $parent instanceOf Issue}
					{translate key="issue.return"}
				{else}
					{translate key="article.return"}
				{/if}
			</span>
		</a>

		<a href="{$parentUrl}" class="title">
			{$title}
		</a>
		{if $allowDownload}
		<div style="display: flex; flex-direction: row; top: 0px; position: absolute; right: 0px; line-height: 30px; background-color: rgb(255, 255, 255);">
		<a id="downloadPDF" href="{$pdfUrl}">
			<span class="labelDownload">
				{translate key="common.download"}
			</span>
			<span class="pkp_screen_reader">
				{translate key="common.downloadPdf"}
			</span>
		</a>
		<a id="printPDF" href="{$pdfUrl}" onclick="return printPDF()">
			<span class="labelPrint">
				Печать
			</span>
			<span class="pkp_screen_reader">
				Печать
			</span>
		</a>
		</div>
		{/if}

	</header>

	<script type="text/javascript" src="{$pluginUrl}/pdf.js/build/pdf.js"></script>
	<script type="text/javascript">
		{literal}
			$(document).ready(function() {
				PDFJS.workerSrc='{/literal}{$pluginUrl}/pdf.js/build/pdf.worker.js{literal}';
				PDFJS.getDocument({/literal}'{$pdfUrl|escape:"javascript"}'{literal}).then(function(pdf) {
					// Using promise to fetch the page
					pdf.getPage(1).then(function(page) {
						var pdfCanvasContainer = $('#pdfCanvasContainer');
						var canvas = document.getElementById('pdfCanvas');
						canvas.height = pdfCanvasContainer.height();
						canvas.width = pdfCanvasContainer.width()-2; // 1px border each side
						var viewport = page.getViewport(canvas.width / page.getViewport(1.0).width);
						var context = canvas.getContext('2d');
						var renderContext = {
							canvasContext: context,
							viewport: viewport
						};
						page.render(renderContext);
					});
				});
			});
		{/literal}
	</script>
	<script type="text/javascript">
		{literal}
		function printPDF(){
			$("#pdfCanvasIframe").contents().find("#print").click();
			return false;
		}
		{/literal}
	</script>
	<script type="text/javascript" src="{$pluginUrl}/pdf.js/web/viewer.js"></script>

	<div id="pdfCanvasContainer" class="galley_view">
		<iframe id="pdfCanvasIframe" src="{$pluginUrl}/pdf.js/web/viewer.html?file={$pdfUrl|escape:"url"}" width="100%" height="100%" style="min-height: 500px;" allowfullscreen webkitallowfullscreen></iframe>
	</div>
	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
