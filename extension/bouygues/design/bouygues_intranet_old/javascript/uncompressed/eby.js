/* global functions */
eby = {
	timeout: null,
	timeoutsub: null,
	annuaireLogin: 'UNDEFINED',
	annuaireDomain: 'UNDEFINED',
	annuaireAxisloaded: '',
	isAjax: false,
	isHome: false,
	initialize : function() {
		var slideMajesActuFiliere = false;
		var slideMajesActuGoupe = false;
		
		var ebyfontSize = parseFloat(eby.readCookie('fontSize'));

		if(ebyfontSize > 1 && eby.isHome == false) 			
			$('html').css('font-size', ebyfontSize);		
		
		$('.lightboxTest').unbind('click').click(function() {
			Lightbox.open(currentLang+'/layout/set/lightbox/configuration/lightbox');
		});
		
		$('.UserConnect').unbind('click').click(function() {
			var fromString = 'fromDefault';
			if($(this).hasClass('fromNewsletter')) 			fromString = 'fromNewsletter';
			else if($(this).hasClass('fromMaj')) 			fromString = 'fromMaj';
			else if($(this).hasClass('fromComment')) 		fromString = 'fromComment';
			else if($(this).hasClass('fromEbyperso')) 		fromString = 'fromEbyperso';
			else if($(this).hasClass('fromWhoswho')) 		fromString = 'fromWhoswho';
			else if($(this).hasClass('fromWhoshwhoData')) 	fromString = 'fromWhoshwhoData';
			
			if($(this).attr('rel'))
				Lightbox.open(currentLang+'/layout/set/lightbox/user/login/?lb=1&from='+fromString+'&callback='+encodeURIComponent($(this).attr('href'))+'&uriReturn='+encodeURIComponent($(this).attr('rel')));
			else
				Lightbox.open(currentLang+'/layout/set/lightbox/user/login/?lb=1&from='+fromString+'&callback='+encodeURIComponent($(this).attr('href')));
		});
		
		/* Login */
		$('#username_identification').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('#loginAjaxForm').submit();
			}
		});
		
		$('#password_identification').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('#loginAjaxForm').submit();
			}
		});
		
		/* Retrieve password */
		$('#username_registration_identification').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('#subscribeAjaxForm').submit();
			}
		});
		
		$('.contactForm').live( 'keyup', function(e) {
			if(e.keyCode == 13) {
				$('.contactForm').submit();
			}
		});
		
		eby.firstLetter($('.default .intro').children("p:first"));

		/* RSS page */
		$('.btn-plus').hover(function(){
			if( ! $(this).hasClass('.btn-less') ){
				$(this).addClass('btn-plus-hover');
			}
		},function(){
			if( ! $(this).hasClass('.btn-less') ){
				$(this).removeClass('btn-plus-hover');
			}
		});
		
		$('.btn-less').live('mouseover',function(){
			//alert('yes');
			$(this).addClass('btn-less-hover');
		});
		
		$('.btn-less').live('mouseout',function(){
			//alert('yes');
			$(this).removeClass('btn-less-hover');
		});
		
		/* Home page */
		
		var homeActuMode = 'image';
		$('.btn-mode-text').unbind('click').click(function() {
			homeActuMode = 'text';
			$('.show-mode-image').hide();
			$('.show-mode-text').show();

			$('.btn-mode-image-on').addClass('btn-mode-image');
			$('.btn-mode-image').removeClass('btn-mode-image-on');
			$(this).addClass('btn-mode-text-on');
			
			$('#mycarousel-pagination').hide();
			$('#mycarousel-pagination-groupe').hide();
			
		});
		
		$('.btn-mode-image-on').unbind('click').click(function() {
			homeActuMode = 'image';
			$('.show-mode-text').hide();
			$('.show-mode-image').show();
			$('.btn-mode-text').removeClass('btn-mode-text-on');
			$(this).addClass('btn-mode-image-on');
			
			if($('.filiere').css('display') == 'block'){
				$('#mycarousel-pagination-groupe').hide();
				$('#mycarousel-pagination').show();
			}
		});
		
		
		$('.btn-actu-groupe').unbind('click').click(function() {
			$(this).addClass('on');
			$('.btn-actu-filiere').removeClass('on');
			$('.filiere').hide();
			$('.groupe').show();
			
			if(homeActuMode == 'image'){
				$('.show-mode-image').show();
				$('.show-mode-text').hide();				
			}else if(homeActuMode == 'text'){
				$('.show-mode-image').hide();
				$('.show-mode-text').show();
			}
			
			$('#mycarousel-pagination').hide();
			$('#mycarousel-pagination-groupe').hide();
			
		});
		
		$('.btn-actu-filiere').unbind('click').click(function() {
			$(this).addClass('on');
			$('.btn-actu-groupe').removeClass('on');
			$('.groupe').hide();
			$('.filiere').show();
			
			if(homeActuMode == 'image'){
				$('.show-mode-image').show();
				$('.show-mode-text').hide();
				
				$('#mycarousel-pagination-groupe').hide();
				$('#mycarousel-pagination').show();
			}else if(homeActuMode == 'text'){
				$('.show-mode-image').hide();
				$('.show-mode-text').show();
			}
			
			
			
			if(slideMajesActuFiliere == false){
				slideMajesActuFiliere = $("#carousel-actu").slideMajes( { 
					numElementDisplayed: 3,
					controls: false,
					pagination: true,
					paginationId: 'mycarousel-pagination',
					timePlay: '10000'
				} );
			}
		});
		
		
		/* Module du header */
		
		$('.aContactGroup').unbind('click').click(function() {
			$('#container #header #menu .contactGroup').show();
			$('#userNom').focus();
			$('#pagesView').hide();
		});
		
		$('.contactGroup .top').unbind('click').click(function() {
			$('#container #header #menu .contactGroup').hide();
		});

		$('.aPageView').unbind('click').click(function() {
			if($('#pagesView').css('display') == 'none'){
				$('#pagesView').show().focus();	
				$('#container #header #menu .contactGroup').hide();
			}else{
				$('#pagesView').hide();
			}
		});
		
		$('#pagesView .top').unbind('click').click(function() {
			$('#pagesView').hide();
		});
		

		$('.btn-close-box').unbind('click').click(function() {
			$(this).parent().hide();
									
		});
		

		$('.sendtofriend').unbind('click').click(function() {
			var strUrl = document.location;
			Lightbox.open(currentLang+'/layout/set/lightbox/tools/sendtofriend/?url=' + encodeURIComponent(strUrl), 'eby.sendtofriend()');
		});
		
		$('.forgotten-password').unbind('click').click(function() {
			var strUrl = document.location;
			Lightbox.open(currentLang+'/layout/set/lightbox'+$(this).attr('href'), 'eby.forgottenpassword()');
		});
		
		
		$('.newsletter-subscribe').unbind('click').click(function(){
			$.ajax({
				type: "POST",
		    	url: $(this).attr('href'),
		    	success: function(msg){
		    		Lightbox.open(currentLang+'/layout/set/lightbox/profile/yournewslettersubscribed/');
		    	}
						
			});
		});
		
		$('.notification-subscribe').unbind('click').click(function(){
			Lightbox.open(currentLang+'/layout/set/lightbox'+$(this).attr('href'));
		});
		
		$('.whoswho-subscribe').unbind('click').click(function(){
			Lightbox.open(currentLang+'/layout/set/lightbox'+$(this).attr('href'));
		});
		
		$('.whoswho-unsubscribe').unbind('click').click(function(){
			Lightbox.open(currentLang+'/layout/set/lightbox'+$(this).attr('href'));
		});
		
		$('.print').unbind('click').click(function() {
			var strUrl = document.location;
			Lightbox.open(currentLang+'/layout/set/lightbox'+$(this).attr('href')+'?param='+encodeURIComponent($(this).attr('rel')));
		});
		
		$('.printBag').unbind('click').click(function() {
			var strUrl = document.location;
			Lightbox.open(currentLang+'/layout/set/lightbox/tools/print/');
		});
		
		
		//Navigation
		
		// -- > Header
		$("#navigation ul li").each(function() {
			$(this).hover(function() {
				clearTimeout(eby.timeout);
				
				if($(this).children("ul").hasClass('back')){
					$(this).children("ul").css({'left':$(this).position().left-85});
				}
				
				$(this).children("ul").removeClass("hideSub");
				
				$(this).prev().children("ul").addClass("hideSub");
				$(this).siblings().children("ul").addClass("hideSub");
				
				if($(this).hasClass('back')){
					$(this).children("ul").css({'left':$(this).position().left-356, 'z-index':'-1'});
				}
				
			}, function(){
				
				if($(this).hasClass('first')){
					if($(this).children("ul").hasClass('back')){
						$(this).children("ul").css({'left':'-999em'});
					}
					eby.timeout = setTimeout('$("#navigation ul li.first ul").addClass("hideSub");',500);
				}
				
				if($(this).hasClass('back')){
					$(this).children("ul").css({'left':'-999em', 'z-index':'900'});
				}
				
			});
		});
		
		// -- > Left
		$('.show-next-level').each(function() {
			$(this).children("a").unbind('click').click(function() {
				$(this).parent().children("ul").toggle("fast",function(){		
					if($(this).css('display') == 'none'){
						
						if($(this).parent().children("a").hasClass('sbLinkOn')){
							$(this).parent().children("a").removeClass();
							$(this).parent().children("a").addClass('colorDefault2 border4');
						}else{
							$(this).parent().children("a").removeClass();
							$(this).parent().removeClass();
							$(this).parent().children("a").addClass('linkOff colorDefault1 border4');
						}
					
					}else{
						
						if($(this).parent().children("a").hasClass('colorDefault2')){
							$(this).parent().children("a").removeClass();
							$(this).parent().children("a").addClass('sbLinkOn color1 border4');
						}else{
							$(this).parent().children("a").removeClass();
							$(this).parent().addClass('bgColor3 listOn');
							$(this).parent().children("a").addClass('bgColor4 color1 linkOn').removeClass('linkOff colorDefault1 border4');
						}
						
					}
				});
		
			});
		});

		// Increase Font Size
		$(".increaseFont").click(function() {
			var currentFontSize = $('html').css('font-size');
			var currentFontSizeNum = parseFloat(currentFontSize);
			var newFontSize = currentFontSizeNum + 2;
			$('html').css('font-size', newFontSize);
			
			eby.setCookie('fontSize', newFontSize, 30);
			
			return false;
		});

		// Decrease Font Size
		$(".decreaseFont").click(function() {
			var currentFontSize = $('html').css('font-size');
			var currentFontSizeNum = parseFloat(currentFontSize);
			var newFontSize = currentFontSizeNum - 2;
			

			if(newFontSize >= 10){
				$('html').css('font-size', newFontSize);
				eby.setCookie('fontSize', newFontSize, 30);
			}
			return false;
		});

		
		jQuery.validator.addMethod("initials", function(initials, element) {
			if(initials != ''){
				var regex = /^[A-Za-z]+$/;
				var match = false;

				if(regex.test(initials)){
					return true
				}else{
					return false
				}

			}else{
				return true
			}

		}, "Please specify a valid INITIALS value");

		$("#contactGroupForm").validate({
			errorElement: "span",
			wrapper: '',
			rules: {
				userNom: {
					required: function(element) {
						if($("#contactGroupForm input[name=userInitiales]").val() == '')
							return true;
						else
							return false;
		      		}
				}
			}
		});
		
		$("#container #middle .annuaire .bloc-result .item .more").click(function(){

					if($(this).parent().parent().hasClass('on'))
						$(this).parent().parent().removeClass('on');
					else{
						$(this).parent().parent().addClass('on');
					}
					return false;
		});
		
		$("#container #middle .annuaire .bloc-result .item").click(function(){

					if($(this).hasClass('on'))
						$(this).removeClass('on');
					else{
						$(this).addClass('on');
					}
					//return false;
		});
		
		
		$("#container #middle .annuaire .bloc-result .item").hover(function(){
			var srcPicto = $(this).children('.collaborator').children('.picto').attr('src');
			var namepicto = srcPicto.substring(0, srcPicto.length-4);
			var newnamePicto = namepicto+'_B.gif';

			$(this).addClass('hover');
			$(this).children('.collaborator').children('.picto').attr('src', srcPicto.replace('.gif', '_B.gif'));
			
			
		},function(){
			var srcPicto = $(this).children('.collaborator').children('.picto').attr('src');
			var namepicto = srcPicto.substring(0, srcPicto.length-6);
			var newnamePicto = namepicto+'.gif';
			
			$(this).removeClass('hover');
			$(this).children('.collaborator').children('.picto').attr('src', srcPicto.replace('_B.gif', '.gif'));
		});
		
		$("#container #middle .ezsearch .bloc-result .item").hover(function(){
			$(this).addClass('hover');
		},function(){
			$(this).removeClass('hover');
		});		
		
		$(".columns .column .contact .widget-content .widget-overview .person .btn-person-details").unbind('click').click(function(){
			if($(this).parent().hasClass('plusfavorite'))
				$(this).parent().removeClass('plusfavorite');
			else
				$(this).parent().addClass('plusfavorite');
		});
		
		$(window).unbind('resize').resize(function(){
			
			if($(window).width() > $(document).width() || $(window).width() > 990) var divWidth = $(window).width();
			else 											var divWidth = $(document).width();
			
			$("#base").css('width',parseInt(divWidth));
			$("#base-top").css('width', parseInt(divWidth));
			$("#base-bottom").css('width', parseInt(divWidth));
			
		});

		$(document).keydown(function(e){
			var kC  = (window.event) ? 
			                 event.keyCode : e.keyCode;

			if(kC==27) $('.btn-close-box').trigger('click');
			
		});

	},
	
	sfHover:function() {
		var sfEls = $("#navigation ul li");
		for (var i=0; i<sfEls.length; i++) {
		      sfEls[i].onmouseover=function() {
		         this.className+=" sfhover";     
		       };
		
		      sfEls[i].onmouseout=function() {
		         this.className=this.className.replace(new RegExp("sfhover\\b"), "");
		      }
		   }
		},
	
	sendtofriend: function(){
		var options = {
			url :currentLang+'/tools/sendtofriend',
			type: 'POST',
			success : function(msg) {
				$("#formSendtofriend").fadeOut( function() {
					$(".ajaxReload-sendtofriend").html(msg);
				});
			}
		};
		
		$("#formSendtofriend").validate( {
			errorElement: "span",
			rules: {
				sender_email: {
				    remote: "/tools/sendtofriend/?action=checkemail"
				},
				email: {
				    remote: "/tools/sendtofriend/?action=checkemails"
				}
			},
			submitHandler : function(error) {
				$("#formSendtofriend").ajaxSubmit(options);
			}
		});
	},
	formWhoswho: function(){
		
		$("#formWhoswho").validate( {
			errorElement: "span",
			rules: {
				email: {

				}
			}
		});

	},
	formWhoswhoSubmitted: function(){
		Lightbox.open(currentLang+'/layout/set/lightbox/profile/yourwhoswhodataconfirm/', 'eby.isAjax=false;');
	},
	print: function(){
		Lightbox.close('window.print()');
	},
	printBagDelete: function(id, params){
		if(id)
			$.ajax({
				
				type: "POST",
		    	url: currentLang+"/layout/set/ajax2/tools/print/delete/"+id+"?param="+encodeURIComponent(params),
		    	success: function(msg){
		    		$("#print-item-"+id).remove();
		    	}
						
			});
		else
			$.ajax({
				
				type: "POST",
		    	url: currentLang+"/layout/set/ajax2/tools/print/delete",
		    	success: function(msg){
		    		$('.print-bag-list').html(msg);
		    	}
						
			});
	},
	firstLetter: function(first_paragraph){

		if(!first_paragraph.html())
			return false;
	  
		var first_paragraph_content = first_paragraph.html().replace(/^\s+/g,'').replace(/\s+$/g,'');
		var first_letter = first_paragraph_content.substr(0,1);

		if(first_letter != '<')
			first_paragraph.html('<span class="firstletter color3">'+ first_letter +'</span>'+first_paragraph_content.slice(1));
		else{
			var second_letter = first_paragraph_content.substr(1,1);
			var wrapper = first_paragraph.children(second_letter+':first-child');

			eby.firstLetter(wrapper);
		}
		
	},
	checkEnter: function(e, domForm){ //e is event object passed from function invocation
		var characterCode;// literal character code will be stored in this variable

		if(e && e.which){ //if which property of event object is supported (NN4)
			e = e;
			characterCode = e.which; //character code is contained in NN4's which property
		}
		else{
			e = event;
			characterCode = e.keyCode; //character code is contained in IE's keyCode property
		}

		if(characterCode == 13){ //if generated character code is equal to ascii 13 (if enter key)
			domForm.submit(); //submit the form
			return false;
		}
		else{
			return true;
		}

	},
	newsletterSubscription: function(){
		Lightbox.open(currentLang+'/layout/set/lightbox/profile/yournewslettersubscribed/');
	},
	newsletterUnSubscription: function(){
		Lightbox.open(currentLang+'/layout/set/lightbox/profile/yournewsletterunsubscribed/');
	},
	notificationUnSubscription: function(){
		Lightbox.open(currentLang+'/layout/set/lightbox/profile/yournotificationunsubscribed/');
	},	
	newsletter: function(newsletter_id){
		
		$.ajax({
			
			type: "POST",
	    	url: "/profile/yournewsletter/subscribe/"+newsletter_id,
	    	success: function(msg){
				eby.newsletterSubscription();
	    	}
		});
		
	
	},
	addFavorite: function(user_id, annuaire_user_id){
		$.ajax({
			
			type: "POST",
	    	url: currentLang+"/layout/set/ajax2/annuaire/",
			data: "addfavorite=1&user_id="+user_id+"&annuaire_user_id="+annuaire_user_id,
	    	success: function(msg){
	    		$('#annuaireFavoriteList').html(msg);
				eby.loadFavoriteActionsList();
	    	}
					
		});
	},
	delFavorite: function(user_id, annuaire_user_id){
		$.ajax({
			
			type: "POST",
	    	url: currentLang+"/layout/set/ajax2/annuaire/",
			data: "delfavorite=1&user_id="+user_id+"&annuaire_user_id="+annuaire_user_id,
	    	success: function(msg){
	    		$('#annuaireFavoriteList').html(msg);
				eby.loadFavoriteActionsList();
	    	}
					
		});
	},
	setOrderFavorite: function(user_id, annuaire_user_id, type){
		$.ajax({
			type: "POST",
	    	url: currentLang+"/layout/set/ajax2/annuaire/",
			data: "setOrderFavorite=1&user_id="+user_id+"&annuaire_user_id="+annuaire_user_id+"&type="+type,
	    	success: function(msg){
	    		$('#annuaireFavoriteList').html(msg);
				eby.loadFavoriteActionsList();
	    	}
		});
	},
	loadFavoriteActionsList: function(){
		$.ajax({
			
			type: "POST",
	    	url: currentLang+"/layout/set/ajax2/annuaire/",
			data: "listFavoriteActions=1",
	    	success: function(msg){
	    		$('#annuaireListActionsAjax').html(msg);
	    	}
					
		});
	},
	errorGalby: function(){
		Lightbox.open(currentLang+'/layout/set/lightbox/ebyidentification/error/');
	},
	contactOk: function(who){
		Lightbox.open(currentLang+'/layout/set/lightbox/static/webmastersubmitted/?who='+who);
	},
	setUserData: function(checkSet){
		if(checkSet == '1')
			Lightbox.open(currentLang+'/layout/set/lightbox/ebyidentification/setuserdata/');
		else if(checkSet == '2')
			Lightbox.open(currentLang+'/layout/set/lightbox/ebyidentification/setuserdataemail/');
	},
	setCookie: function(nom,valeur,jours) {
        var expDate = new Date();
        expDate.setTime(expDate.getTime() + (jours * 24 * 3600 * 1000));
        document.cookie = nom + "=" + escape(valeur) + ";path=/;expires=" + expDate.toGMTString();
    },
	readCookie: function(nom) {
      var deb,fin;
      deb = document.cookie.indexOf(nom + "=");
      if (deb >= 0) {
         deb += nom.length + 1;
         fin = document.cookie.indexOf(";",deb);
         if (fin < 0) fin = document.cookie.length;
         return unescape(document.cookie.substring(deb,fin));
         }
      return "";
    },
	loginCallback: function(hrefValue){
			Lightbox.open(currentLang+'/layout/set/lightbox'+hrefValue);
	}, 
	initCheckEmail: function(){
		jQuery.validator.addMethod("checkEmailEby", function(value, element, param) { 
		    if ( this.optional(element) )
				return "dependency-mismatch";
			
			var previous = this.previousValue(element);
			
			if (!this.settings.messages[element.name] )
				this.settings.messages[element.name] = {};
			this.settings.messages[element.name].checkEmailEby = typeof previous.message == "function" ? previous.message(value) : previous.message;
			
			param = typeof param == "string" && {url:param} || param; 
			
			if ( previous.old !== value ) {
				previous.old = value;
				var validator = this;
				this.startRequest(element);
				var data = {};
				data[element.name] = value;
				$.ajax($.extend(true, {
					url: param,
					data: data,
					success: function(response) {
						
						if ( response == 'true') {
							var errors = {};
							errors[element.name] =  '';
							previous.errormsg = '';
							
							var submitted = validator.formSubmitted;
							validator.prepareElement(element);
							validator.formSubmitted = submitted;
							validator.successList.push(element);
							validator.showErrors();
	
						} else {
							var errors = {};
							errors[element.name] =  response;
							previous.errormsg = response;
							validator.showErrors(errors);
							response = false;
						}
						
						previous.valid = response;
						validator.stopRequest(element, response);
					}
				}, param));
				return "pending";
			} else if( this.pending[element.name] ) {
				return "pending";
			}else if(previous.valid != 'true'){
				
				var validator = this;
				var errors = {};
				errors[element.name] =  previous.errormsg;
				validator.showErrors(errors);
				
				return "pending";
			}

			return previous.valid;
		}, '');
		
		
		
	},
	loadActiveX: function(){
		
		try
		{
			var obj = new ActiveXObject("AXAnnuaireGroupe.AXLogon");
			eby.annuaireLogin = obj.Login;
			eby.annuaireDomain = obj.domain;
			eby.annuaireAxisloaded = obj.IsLoaded;
			
		}
		catch(ex)
		{
			var IE = /*@cc_on!@*/false;
			if(IE)
				$('#activeXInfo').show();
		}
	},
	checkClickToCall: function(){
		$.ajax({
			url: '/tools/isctc',
			type: 'POST',
			data: 'domain='+eby.annuaireDomain,
			success: function(response){
				if(response == 'ko'){
					$('.clicktocalllink').css('cursor','default');
				}else{
					$('.clicktocalllink').css('cursor','pointer');
				}
			}
		});
	},
	getActiveX: function(){
		$('#activx').html('<OBJECT ID="ax" CLASSID="CLSID:21C93758-555D-4655-BAF0-138EB2CB4A92" CODEBASE="/external/bin/AXAnnuaireGroupe.dll" style="display: none"></OBJECT>');
		return false;
	},
	annuaireMakeCall: function(company, telephoneNumber){
		$.ajax({
			url: '/tools/makecall',
			type: 'POST',
			data: 'company='+company+'&telephoneNumber='+encodeURIComponent(telephoneNumber)+'&login='+eby.annuaireLogin+'&domain='+eby.annuaireDomain,
			success: function(response){

			}
		});
		
	},
	annuairePagination: function(domElement, counterPage){
		$("#"+currentPage).hide();
		$('#'+$(domElement).attr('rel')).show();
		
		$('.pages span.current').removeClass('current');
		$(domElement).parent().addClass('current');
		
		currentPage = $('.pages span.current a').attr('rel');
		if(currentPage == 'divPage1'){
			currentPageInt = 1;
			previousPage = null;
			nextPage = 'divPage2';
			$('#searchNextDiv').css('display', 'none');
		}else if(currentPage == 'divPage'+counterPage){
			currentPageInt = counterPage;
			nextPage = null;
			previousPage = 'divPage'+(counterPage-1);
			$('#searchNextDiv').css('display', 'block');
		}else{
			nextPage = $('.pages span.current').next().children().attr('rel');
			previousPage = $('.pages span.current').prev().children().attr('rel');
			$('#searchNextDiv').css('display', 'none');
		}
		
		
		if($('.pages span.current a').attr('rel') == 'divPage1'){
			$('.divPageButtonPrevious').hide();
		}else
			$('.divPageButtonPrevious').show();
		if($('.pages span.current a').attr('rel') == 'divPage'+counterPage){
			$('.divPageButtonNext').hide();
		}else
			$('.divPageButtonNext').show();
			
		$('.pages span').hide();
		$('.pages span.dotdotdot').remove();
		$('.pages span a[rel=divPage1]').parent().show();
		$('.pages span a[rel=divPage'+counterPage+']').parent().show();
		$('.pages span a[rel='+currentPage+']').parent().show();
		$('.pages span a[rel='+currentPage+']').parent().prev().show();
		$('.pages span a[rel='+currentPage+']').parent().prev().prev().show();
		
		if(currentPage != 'divPage1' && currentPage != 'divPage2' && currentPage != 'divPage3' && currentPage != 'divPage4')
			$('.pages span a[rel='+currentPage+']').parent().prev().prev().before('<span class="dotdotdot"> ... </span>');
			
		if(currentPage != 'divPage'+counterPage && currentPage != 'divPage'+(counterPage-1) && currentPage != 'divPage'+(counterPage-2) && currentPage != 'divPage'+(counterPage-3))
			$('.pages span a[rel='+currentPage+']').parent().next().next().after('<span class="dotdotdot"> ... </span>');
		
		$('.pages span a[rel='+currentPage+']').parent().next().show();
		$('.pages span a[rel='+currentPage+']').parent().next().next().show();
		
		return false;
	}

};

$().ready(function() {
	eby.initialize();
	eby.sfHover();

	$('#navigation #first ul').bgiframe();
});

function ativaOptionsDisabled(){
    var sels = document.getElementsByTagName('select');
    for(var i=0; i < sels.length; i++){
        sels[i].onchange= function(){
            if(this.options[this.selectedIndex].disabled){
                if(this.options.length<=1){
                    this.selectedIndex = -1;
                }else if(this.selectedIndex < this.options.length - 1){
                    this.selectedIndex++;
                }else{
                    this.selectedIndex--;
                }
            }
        };
        if(sels[i].options[sels[i].selectedIndex].disabled){
            sels[i].onchange();
        }    
        for(var j=0; j < sels[i].options.length; j++){
            if(sels[i].options[j].disabled){
                sels[i].options[j].style.color = '#CCC';
            }
        }
    }
}