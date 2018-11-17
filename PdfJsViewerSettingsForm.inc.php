<?php

import('lib.pkp.classes.form.Form');

class PdfJsViewerSettingsForm extends Form {

	/** @var int */
	var $_journalId;

	/** @var object */
	var $_plugin;

	/**
	 * Constructor
	 * @param $plugin PdfJsViewerPlugin
	 * @param $journalId int
	 */
	function __construct($plugin, $journalId) {
		$this->_journalId = $journalId;
		$this->_plugin = $plugin;

		parent::__construct($plugin->getTemplatePath() . 'settingsForm.tpl');

		$this->addCheck(new FormValidator($this, 'pdfJsViewerDownloadOffset', 'required', 'plugins.generic.pdfJsViewer.settings.downloadOffsetIsRequired'));

		$this->addCheck(new FormValidatorPost($this));
		$this->addCheck(new FormValidatorCSRF($this));
	}

	/**
	 * Initialize form data.
	 */
	function initData() {
		$this->_data = array(
			'pdfJsViewerDownloadOffset' => $this->_plugin->getSetting($this->_journalId, 'pdfJsViewerDownloadOffset'),
		);
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	function readInputData() {
		$this->readUserVars(array('pdfJsViewerDownloadOffset'));
	}

	/**
	 * Fetch the form.
	 * @copydoc Form::fetch()
	 */
	function fetch($request) {
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->assign('pluginName', $this->_plugin->getName());
		return parent::fetch($request);
	}

	/**
	 * Save settings.
	 */
	function execute() {
		$this->_plugin->updateSetting($this->_journalId, 'pdfJsViewerDownloadOffset', trim($this->getData('pdfJsViewerDownloadOffset'), "\"\';"), 'int');
	}
}

?>
