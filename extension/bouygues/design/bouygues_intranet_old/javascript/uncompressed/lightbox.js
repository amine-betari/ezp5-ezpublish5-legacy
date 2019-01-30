Lightbox = {
	divWidth:null,
	isActive:false,
	divHeight:null,
	divHtml:'<div id="divLightbox"></div>',
	divBox:'<div id="divLightboxContent" tabindex="0"></div>',
	divBoxLoading:'<div id="divLightboxLoading"></div>',
	divBoxClose: '<a class="lightbox-close" id="divLightboxClose"></a>',
	divBoxWidth: 500,
	divBoxHeight: 400,
	divBoxTop: null,
	divBoxLeft: null,
	defaultWidth: 615,
	initialize: function(){
	
	},
	open: function(url, callback, width_lightbox, message){	
		
		if(Lightbox.isActive == false){
			$("#flash").hide();
			Lightbox.isActive = true;
        	
			$("body").prepend(Lightbox.divHtml);
			Lightbox.resize();
			
			$("body").prepend(Lightbox.divBox);
			
			$("#divLightbox").css({'opacity': 0.5}).fadeIn(function(){
				$("body").prepend(Lightbox.divBoxLoading);
				if(message){
					
					$("#divLightboxContent").html(
							
						'<div id="lightbox-global" class="lightbox-global">'
						+'	<div class="boxA">'
						+'		<div class="top">'
						+'			<div class="left"></div>'
						+'			<div class="right"></div>'
						+'			<div class="middle"></div>'
						+'		</div>'
						+'		<div class="content">'
						+'			<div class="userValidation">'
						+ 				message		
						+'			</div>'
						+'		</div>'
						+'		<div class="bottom">'
						+'			<div class="left"></div>'
						+'			<div class="right"></div>'
						+'			<div class="middle"></div>'
						+'		</div>'
						+'	</div>'
						+'</div>'
							
							
					);
					
					if(width_lightbox)
						$("#lightbox-global").css('width',parseInt(width_lightbox)+'px');
					else
						$("#lightbox-global").css('width',parseInt(Lightbox.defaultWidth)+'px');
					
					$("#divLightboxContent").css({'opacity':'0'}).fadeIn(function(){
						Lightbox.getTopLeft();
						$("#divLightboxContent").prepend(Lightbox.divBoxClose);
						$("#divLightboxClose").css({'left':$("#divLightboxContent").width()-35,'top':'34px'});
        	
						$("#divLightboxContent").animate({ 'top':Lightbox.divBoxTop,'left':Lightbox.divBoxLeft,'opacity':'1'});
						$("#divLightboxContent .lightbox-close").unbind('click').click(function(){Lightbox.close()});
						$("#divLightbox").unbind('click').click(function(){Lightbox.close()});
						
						if(callback) eval(callback);
					});
				}else if(url){

					$("#divLightboxContent").load(url, function(){
						
						if(width_lightbox)
							$("#lightbox-global").css('width',parseInt(width_lightbox)+'px');
						else
							$("#lightbox-global").css('width',parseInt(Lightbox.defaultWidth)+'px');
	    	
						//$("#divLightboxContent").fadeTo(500,1,function(){
							Lightbox.getTopLeft();
							$("#divLightboxContent").prepend(Lightbox.divBoxClose);
							$("#divLightboxClose").css({'left':$("#divLightboxContent").width()-35,'top':'5px'});
        	
							$("#divLightboxContent").css({ 'top':Lightbox.divBoxTop,'left':Lightbox.divBoxLeft});
							
							$("#divLightboxContent").fadeIn('slow');
				
							$("#divLightboxContent .lightbox-close").unbind('click').click(function(){Lightbox.close()});
							$("#divLightbox").unbind('click').click(function(){Lightbox.close()});
							
							$("#divLightboxLoading").hide();
							$(this).focus();
							if(callback) eval(callback);
						//});
					});
				}
				$('#divLightbox').bgiframe();
			});
			
			$(window).unbind('resize').resize(function(){
				Lightbox.resize();
				
				Lightbox.getTopLeft();
				var totalWidth = $(document).width()- Lightbox.divBoxWidth;
				Lightbox.divBoxLeft = totalWidth/2;
				
				$("#divLightboxContent").css({'top':Lightbox.divBoxTop,'left':Lightbox.divBoxLeft});
			});
			
			$(window).unbind('scroll').scroll(function(){
				Lightbox.getTopLeft();
				if($("#divLightboxContent").height() < $(window).height()) $("#divLightboxContent").css({'top':Lightbox.divBoxTop,'left':Lightbox.divBoxLeft});
			});
			
			$(document).keypress(function(e){
				var kC  = (window.event) ? 
				                 event.keyCode : e.keyCode;
				
				if(kC == 27) Lightbox.close();
				
			});
			//Common.pngFix();
		}
	},
	getTopLeft: function(){
		Lightbox.divBoxWidth = $("#divLightboxContent").width();
		Lightbox.divBoxHeight = $("#divLightboxContent").height();	
	
		Lightbox.divBoxTop = $(window).scrollTop() + (-Lightbox.divBoxHeight+$(window).height())/2 - 20;
		if(Lightbox.divBoxTop < 0) Lightbox.divBoxTop = 20;
		 
		totalWidth = $(document).width() - Lightbox.divBoxWidth;
		Lightbox.divBoxLeft = totalWidth/2;

		Lightbox.resize();
	},
	close: function(callback){
		
		$("#divLightboxLoading").hide();
		$("#divLightboxContent").fadeTo(500,0, function(){
			$("#divLightboxContent").remove();
			$("#divLightboxLoading").remove();
			$("#divLightbox").remove();
			
			Lightbox.isActive = false;
			
			$(window).unbind('scroll');
			
			if(callback) eval(callback);
			
		});		
	},
	resize:function(){	
		
		if($(window).width() > $(document).width() || $(window).width() > 990) 	Lightbox.divWidth = $(window).width();
		else 											Lightbox.divWidth = $(document).width();
		
		if($(window).height() > $(document).height()) 	Lightbox.divHeight = $(window).height();
		else 											Lightbox.divHeight = $(document).height();
		
		$("#divLightbox").css({'width':parseInt(Lightbox.divWidth),'height':parseInt(Lightbox.divHeight)});
	}
}