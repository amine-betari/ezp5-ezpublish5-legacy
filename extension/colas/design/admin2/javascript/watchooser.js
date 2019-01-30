function watmanager(id) {
	
	this.watid = id;
	this.iCurrentPage = 1;
	this.sUrl = '/wat/flux';
	this.oVideos = {};
	
	this.sTemplateOverlay = '<div class="watoverlay videochooser_overlay"></div>';
	this.sTemplatePopin = '<div class="clearlooks2 watbox videochooser_box"><div class="mceWrapper"><div class="mceTop"><div class="mceLeft"></div><div class="mceCenter"></div><div class="mceRight"></div><span><div class="watclose"></div>Sélection d\'une vidéo WAT TV</span></div><div class="mceMiddle"><div class="mceLeft"></div><span class="watContent">&nbsp;</span><div class="mceRight"></div></div><div class="mceBottom"><div class="mceLeft"></div><div class="mceCenter"></div><div class="mceRight"></div></div></div></div>';
	
	// Initialise la fenêtre
	this.init = function() {
		// Supprime les éventuelles autres fenêtres avant d'afficher celle là
		$('.videochooser_overlay').remove();
		$('.videochooser_box').remove();

		var obj = this;
		
		if ($('#watchooser_box_' + this.watid).length == 0) {

			$(this.sTemplateOverlay).appendTo($('#page')).attr('id', 'overlay_' + this.watid).css({opacity: '0.5', height: $(document).height()});
			$(this.sTemplatePopin).appendTo($('#page')).attr('id', 'watchooser_box_' + this.watid);
			$('#overlay_' + this.watid).click(function(oEvent){obj.close(oEvent, this);});
			$('#watchooser_box_' + this.watid + ' .watclose').click(function(oEvent){obj.close(oEvent, this);});
			
			// Positionnement de la fenêtre
			this.center();
			$(window).bind('resize', this.center);
			$(window).bind('scroll', this.center);
			
		}
		
		this.iCurrentPage = 1;
		this.load(this.iCurrentPage);
		
	};
	
	// Centre la fenêtre au scroll ou au redimmentionnement
	this.center = function() {
		var oBox = $('#watchooser_box_' + this.watid);
		oBox.css('top', (($(window).height() - oBox.outerHeight()) / 2) + $(window).scrollTop() + 'px');
		oBox.css('left', (($(window).width() - oBox.outerWidth()) / 2) + $(window).scrollLeft() + 'px');
	};
	
	// Ajoute/retire le loading
	this.switchLoading = function() {
		if ($('.watchooserloading').length == 0) {
			$('.watchoosernext').remove();
			$('#watchooser_box_' + this.watid + ' .watContent').append('<div class="watchooserloading"><img src="/extension/colas/design/bouygues_intranet/images/pictos/ajax-loader.gif" /></div>');
		}
		else {
			$('.watchooserloading').remove();
		}
		this.center();
	};
	
	// Charge les résultats
	this.load = function(page) {
		this.switchLoading();
		// Récupère le flux XML avec la liste des vidéos au format JSON
		$.ajax({
			context: this,
			url: '/wat/flux',
			type: 'GET',
			data: {page: page},
			dataType: 'json',
			success: function(response) {this.ajaxSuccess(response);},
			error: function() {this.ajaxError();}
		});
	};
	
	// En cas d'erreur de la requête AJAX
	this.ajaxError = function() {
		this.switchLoading();
		alert('Impossible de récupérer le flux de WAT TV, une erreur est survenue');
	};
	
	// Gère les réponses AJAX possibles
	this.ajaxSuccess = function(response) {
        console.log(response);

		if (response.action == 1) {
			this.display(response.videos);
		}
		else {
			alert('Impossible de lire le flux de WAT TV, une erreur est survenue');
		}
	};
	
	// Ajoute la liste des vidéos
	this.display = function(videos) {
		this.iCurrentPage++;
		var obj = this;
		var content = $('#watchooser_box_' + this.watid + ' .watContent');
		$(videos).each(function() {
			obj.oVideos['v' + this.id] = this;
			content.append('<div class="watchooservideo"><img src="' + this.previews.preview[1] + '" /><br />' + this.created + ' - ' + this.title + '<br /><input type="button" value="Sélectionner" class="button watselection" data="' + this.id + '"></div>');
		});
		this.switchLoading();
		content.append('<div class="watchoosernext"><a onclick="javascript:this.load(this.iCurrentPage);">Voir les 25 vidéos suivantes</a></div>');
		$('.watchoosernext').click(function(oEvent){obj.load(obj.iCurrentPage);});
		$('.watselection').unbind('click', function(oEvent){obj.choose(oEvent, this);});
		$('.watselection').click(function(oEvent){obj.choose(oEvent, this);});
		this.center();
	};
	
	// Enregistre le choix et ferme la fenêtre
	this.choose = function(oEvent, oElement) {
		
		var iVideoId = $(oElement).attr('data');
		var oVideo = this.oVideos['v' + iVideoId];
		
		// Champ caché pour le JSON
		$('#watchooser_hidden_data_text_' + this.watid).val(JSON.stringify(oVideo, null, 2));
		
		// Force le titre & la description
		$('.ezcca-bouygues_video_titre').val(oVideo.title);
		tinyMCE.get($('.ezcca-edit-description .oe-window textarea').attr('id')).setContent(oVideo.description);
		
		// Affiche la vidéo
		this.displayVideo(this.oVideos['v' + iVideoId]);
		
		this.close();
		
	};
	
	// Affiche une vidéo dans la zone de preview
	this.displayVideo = function(oVideo) {
		$('#watnovideo').css({display: 'none'});
		$('#watvideorow').css({display: 'table-row'});
		$('#watvideorow').children('.watcellpreview').html('<img src="' + oVideo.previews.preview[1] + '" />');
		$('#watvideorow').children('.watcelldate').html(oVideo.created);
		$('#watvideorow').children('.watcellname').html(oVideo.title);
	};
	
	// Ferme la fenêtre
	this.close = function(oEvent, oElement) {
		$('#overlay_' + this.watid).remove();
		$('#watchooser_box_' + this.watid).remove();
	};
	
	// Initialisation
	if ($('#watchooser_hidden_data_text_' + this.watid).val() != '') {
		this.displayVideo(JSON.parse($('#watchooser_hidden_data_text_' + this.watid).val()));
	}
};