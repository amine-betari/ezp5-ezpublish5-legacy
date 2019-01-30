function youtubemanager( params ) {

	this.apiUrlPlaylistItems = params.playlistItemsApiUrl;
	this.apiUrlVideos = params.videosApiUrl;
	this.youtubeAttributeId = params.attributeId;
	this.nextPageToken = '';
	this.maxResults = 0;
	this.totalResults = 0;
	this.oVideos = {};

	this.sTemplateOverlay = '<div class="youtubeoverlay videochooser_overlay"></div>';
	this.sTemplatePopin = '<div class="clearlooks2 youtubebox videochooser_box"><div class="mceWrapper"><div class="mceTop"><div class="mceLeft"></div><div class="mceCenter"></div><div class="mceRight"></div><span><div class="youtubeclose"></div>Sélection d\'une vidéo YouTube</span></div><div class="mceMiddle"><div class="mceLeft"></div><span class="youtubeContent">&nbsp;</span><div class="mceRight"></div></div><div class="mceBottom"><div class="mceLeft"></div><div class="mceCenter"></div><div class="mceRight"></div></div></div></div>';

	this.init = function() {
		this.maxResults = this.getUrlVars(this.apiUrlPlaylistItems)['maxResults'];

		// Supprime les éventuelles autres fenêtres avant d'afficher celle en cours
		$('.videochooser_overlay').remove();
		$('.videochooser_box').remove();

		this.monitorChooserChange();
	};

	this.monitorChooserChange = function() {
		var obj = this;

		if ($('#youtubechooser_box_' + this.youtubeAttributeId).length == 0) {

			$(this.sTemplateOverlay).appendTo($('#page')).attr('id', 'overlay_' + this.youtubeAttributeId).css({opacity: '0.5', height: $(document).height()});
			$(this.sTemplatePopin).appendTo($('#page')).attr('id', 'youtubechooser_box_' + this.youtubeAttributeId);
			$('#overlay_' + this.youtubeAttributeId).click(function(oEvent){obj.close(oEvent, this);});
			$('#youtubechooser_box_' + this.youtubeAttributeId + ' .youtubeclose').click(function(oEvent){obj.close(oEvent, this);});

			// Positionnement de la fenêtre
			this.center();
			$(window).bind('resize', this.center);
			$(window).bind('scroll', this.center);

		}

		this.load({"pageToken":this.nextPageToken});
	};

	// Centre la fenêtre au scroll ou au redimmentionnement
	this.center = function() {
		var oBox = $('#youtubechooser_box_' + this.youtubeAttributeId);
		oBox.css('top', (($(window).height() - oBox.outerHeight()) / 2) + $(window).scrollTop() + 'px');
		oBox.css('left', (($(window).width() - oBox.outerWidth()) / 2) + $(window).scrollLeft() + 'px');
	};

	// Ajoute/retire le loading
	this.switchLoading = function() {
		if ($('.youtubechooserloading').length == 0) {
			$('.youtubechoosernext').remove();
			$('#youtubechooser_box_' + this.youtubeAttributeId + ' .youtubeContent').append('<div class="youtubechooserloading"><img src="/extension/colas/design/bouygues_intranet/images/pictos/ajax-loader.gif" /></div>');
		}
		else {
			$('.youtubechooserloading').remove();
		}
		this.center();
	};

	// Charge les résultats
	this.load = function(params) {
		this.switchLoading();
		// Récupère le flux JSON de la liste des vidéos
		$.ajax({
			context: this,
			url: this.apiUrlPlaylistItems,
			type: 'GET',
			data: params,
			dataType: 'json',
			success: function(response) {this.ajaxListSuccess(response);},
			error: function() {this.ajaxListError();}
		});
	};

	// En cas d'erreur de la requête AJAX
	this.ajaxListError = function() {
		this.switchLoading();
		alert('Impossible de récupérer le flux de YouTube, une erreur est survenue');
	};

	// Gère les réponses AJAX possibles
	this.ajaxListSuccess = function(response) {
		console.log(response);

		if (response.items) {
			this.totalResults = response.pageInfo.totalResults;
			this.nextPageToken = '';
			if ( response.nextPageToken ) {
				this.nextPageToken = response.nextPageToken;
			}
			this.display(response.items);
		}
		else {
			alert('Impossible de lire le flux de YouTube, une erreur est survenue');
		}
	};

	// Ajoute la liste des vidéos
	this.display = function(videos) {
		var obj = this;
		var content = $('#youtubechooser_box_' + this.youtubeAttributeId + ' .youtubeContent');
		$(videos).each(function() {
			var vidObj = this.snippet;
			obj.oVideos[vidObj.resourceId.videoId] = vidObj;
			content.append('<div class="youtubechooservideo"><img src="' + vidObj.thumbnails.medium.url + '" width="220" class="youtubeselection" data="' + vidObj.resourceId.videoId + '" /><p class="sinfo" title="' + vidObj.title + '">' + obj.prettyDate(vidObj.publishedAt) + ' - ' + obj.truncateStr(vidObj.title,80) + '</p><input type="button" value="Sélectionner" class="button youtubeselection" data="' + vidObj.resourceId.videoId + '" title="'+vidObj.title+'"></div>');
		});
		this.switchLoading();
		if ( this.nextPageToken != '' ) {
			content.append('<div class="youtubechoosernext"><a>Voir les ' + this.maxResults + ' vidéos suivantes sur ' + this.totalResults + '</a></div>');
			$('.youtubechoosernext').click(function(oEvent){obj.load({"pageToken":obj.nextPageToken});});
		}
		else {
			content.append('<div class="youtubechooserend"></div>');
		}
		$('.youtubeselection').unbind('click', function(oEvent){obj.choose(oEvent, this);});
		$('.youtubeselection').click(function(oEvent){obj.choose(oEvent, this);});
		this.center();
	};

	// Enregistre le choix et ferme la fenêtre
	this.choose = function(oEvent, oElement) {

		var iVideoId = $(oElement).attr('data');
		var oVideo = this.oVideos[iVideoId];

		// Récupération des tags de la vidéo choisie (car ils ne sont pas dans le flux des playlistItems) AVANT de les stocker + URLs
		this.addAdditionalVideoData(iVideoId);
		// Maintenant, on peut réécrire et stocker les données (complétées) de la vidéo choisie
		oVideo = this.oVideos[iVideoId];

		// Champ caché pour le JSON
		$('#youtubechooser_hidden_data_text_' + this.youtubeAttributeId).val(JSON.stringify(oVideo, null, 2));

		// Force le titre & la description
		$('.ezcca-bouygues_video_titre').val(oVideo.title);
		tinyMCE.get($('.ezcca-edit-description .oe-window textarea').attr('id')).setContent(this.nl2br(this.normalizePlayFirstChar(oVideo.description)));

		// Affiche la vidéo sélectionnée dans l'attribut
		this.displayVideo(this.oVideos[iVideoId]);

		this.close();

	};

	this.addAdditionalVideoData = function(videoId) {
		if ( this.oVideos[videoId]['tags'] == undefined ) {
			// Doit être fait après que this.oVidoes[videoId] existe bien entendu
			$.ajax({
				context: this,
				url: this.apiUrlVideos,
				async: false,
				type: 'GET',
				data: {'id':videoId},
				dataType: 'json',
				success: function(response) {
					//console.log("Get video '"+videoId+"' to update tags in playlistItems");
					//console.log(response);
					if ( response.items && response.items[0] && response.items[0].snippet ) {
						var video = response.items[0];
						if ( this.oVideos[video.id]['tags'] == undefined ) {
							this.oVideos[video.id]['tags'] = [];
						}
						if ( video.snippet['tags'] != undefined ) {
							this.oVideos[video.id]['tags'] = video.snippet['tags'];
						}
					}
					else {
						alert('Impossible de lire le flux de la vidéo YouTube, une erreur est survenue');
					}
				},
				error: function(response) {
					console.log("Error response below");
					console.log(response);
					alert('Impossible de récupérer des informations supplémentaires sur la vidéo YouTube, une erreur est survenue');
				}
			});
		}
		// Ajout des URLs d'accès à la vidéo sur YouTube
		this.oVideos[videoId]['url'] = 'https://www.youtube.com/watch?v=' + videoId;
		this.oVideos[videoId]['iframeUrl'] = 'https://www.youtube.com/embed/' + videoId;
	};

	// Affiche une vidéo dans la zone de preview
	this.displayVideo = function(oVideo) {
		$('#youtubenovideo').css({display: 'none'});
		$('#youtubevideoheaders').css({display: 'table-row'});
		$('#youtubevideorow').css({display: 'table-row'});
		$('#youtubevideorow').children('.youtubecellpreview').html('<img src="' + oVideo.thumbnails.medium.url + '" />');
		$('#youtubevideorow').children('.youtubecelldate').html(this.prettyDate(oVideo.publishedAt));
		$('#youtubevideorow').children('.youtubecelltitle').html(oVideo.title);
		$('#youtubevideorow').children('.youtubecelldescription').html(this.nl2br(oVideo.description));
		this.enableRemoveButton();
	};

	this.removeVideo = function() {
		$('#youtubenovideo').css({display: 'table-row'});
		$('#youtubevideoheaders').css({display: 'none'});
		$('#youtubevideorow').css({display: 'none'});
		$('#youtubevideorow').children('.youtubecellpreview').html('');
		$('#youtubevideorow').children('.youtubecelldate').html('');
		$('#youtubevideorow').children('.youtubecelltitle').html('');
		$('#youtubevideorow').children('.youtubecelldescription').html('');
		$('#youtubechooser_hidden_data_text_' + this.youtubeAttributeId).val('');
		this.disableRemoveButton();
	};

	this.enableRemoveButton = function() {
		var removeButton = $('#youtuberemover_button_' + this.youtubeAttributeId);
		var obj = this;
		removeButton.click(function(oEvent){obj.removeVideo();});
		removeButton.removeClass('button-disabled');
		removeButton.addClass('button');
		removeButton.removeAttr('disabled');
	};

	this.disableRemoveButton = function() {
		var removeButton = $('#youtuberemover_button_' + this.youtubeAttributeId);
		var obj = this;
		removeButton.unbind('click', function(oEvent){obj.removeVideo();});
		removeButton.removeClass('button');
		removeButton.addClass('button-disabled');
		removeButton.attr('disabled','disabled');
	};

	// Ferme la fenêtre
	this.close = function(oEvent, oElement) {
		this.nextPageToken = '';
		$('#overlay_' + this.youtubeAttributeId).remove();
		$('#youtubechooser_box_' + this.youtubeAttributeId).remove();
	};

	this.getUrlVars = function(url) {
		var vars = {};
		var parts = url.replace(/[?&]+([^=&]+)=([^&]*)/gi,
			function(m,key,value) {
				vars[key] = value;
			});
		return vars;
	};

	this.prettyDate = function(date) {
		return date.replace('T', ' ').replace('.000Z','');
	};

	this.nl2br = function(str) {
		return str.replace(/\n/g,'<br>');
	};

	this.normalizePlayFirstChar = function(str) {
		// Seul moyen pour annuler le CSS de :first-child:first-letter de <p> que ezoe accepte sans tout casser - #52363#note-51
		return str.replace(/^►/gi,'<em>&nbsp;</em>►');
	};

	this.truncateStr = function(str,length) {
		if (str.length > length) {
			str = str.substring(0,length)+'...';
		}
		return str;
	};
	// Initialisation
	if ($('#youtubechooser_hidden_data_text_' + this.youtubeAttributeId).val() != '') {
		this.displayVideo(JSON.parse($('#youtubechooser_hidden_data_text_' + this.youtubeAttributeId).val()));
	}

};
