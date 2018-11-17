{**
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 *}
<script>
	$(function() {ldelim}
		// Attach the form handler.
		$('#pdfjsSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="pdfjsSettingsForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	{csrf}
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="pdfjsSettingsFormNotification"}

	<div id="description">{translate key="plugins.generic.pdfJsViewer.settings.description"}</div>

	{fbvFormArea id="webFeedSettingsFormArea"}
		{fbvElement id="pdfJsViewerDownloadOffset" type="text" name="pdfJsViewerDownloadOffset" value=$pdfJsViewerDownloadOffset label="plugins.generic.pdfJsViewer.settings.downloadOffset"}
	{/fbvFormArea}

	{fbvFormButtons}

	<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</form>
