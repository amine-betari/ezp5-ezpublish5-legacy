(function($) {
	var self;

	$.fn.diaporamaMajes = function(o) {		
	    return this.each(function() {
            new $dpm(this, o);
	    });
	};
	
	// Default configuration properties.
    var defaults = {
        currentId: null,
		diaporamaItems: null,
		playStatus: null,
		timePlay: 5000,
		timeout: null,
		path: 'images/btns/',
		url_zoom: null,
		carousel: null,
		domId: null
    };
    
    $.diaporamaMajes = function(e, o, callback) {
    	var self = this;
    	this.options    = $.extend({}, defaults, o || {});
    	
    	var domId = $(e).attr('id');
    	this.options.domId = domId;

		$('#'+domId+' .diaporama_next').unbind('click').click(function(){self.loadNext(domId);});
		$('#'+domId+' .diaporama_previous').unbind('click').click(function(){self.loadPrevious(domId);});
		$('#'+domId+' .diaporama_play').unbind('click').click(function(){self.play(null,domId);});
		$('#'+domId+' .diaporama_zoom').unbind('click').click(function(){Lightbox.open(currentLang+self.options.url_zoom+'(nodeid)/'+self.options.currentId,null,'900', null);});
		
		$('.'+domId+'_load').unbind('click').click(function(){
			var selectedId = $(this).attr('id');
			self.loadPhoto(selectedId, domId);
		});
		
		/*IF IE6 : css hover*/
		$('#'+domId).hover(function(){
			$('#'+domId+' .diaporama_next').css('display', 'block');
			$('#'+domId+' .diaporama_previous').css('display', 'block');
			$('#'+domId+' .diaporama_play').css('display', 'block');
			$('#'+domId+' .diaporama_zoom').css('display', 'block');
		}, function(){
			$('#'+domId+' .diaporama_next').css('display', 'none');
			$('#'+domId+' .diaporama_previous').css('display', 'none');
			$('#'+domId+' .diaporama_play').css('display', 'none');
			$('#'+domId+' .diaporama_zoom').css('display', 'none');
		});
		
		$('#'+domId+' img.diaporama_large').load(function(){

			var leftPosition = (parseInt($('#'+domId).css('width'))-self.options.diaporamaItems[self.options.currentId].width)/2;
			var topPosition = (parseInt($('#'+domId).css('height'))-self.options.diaporamaItems[self.options.currentId].height)/2;
			
			/*Margin and width*/
			$(this).css({
				'left': '0px',
				'top': '0px',
				'margin-top':topPosition+'px',
				'margin-left':leftPosition+'px'
			});

		});
		
    	this.loadPhoto(this.options.currentId,domId);
		if(callback) eval(callback);
		
    };
	
	var $dpm = $.diaporamaMajes;

    $dpm.fn = $dpm.prototype = {
        diaporamaMajes: '0.1'
    };

    $dpm.fn.extend = $dpm.extend = $.extend;

    $dpm.fn.extend({
    	loadPhoto: function(selectedId, domId){
    		var self = this;
			this.options.currentId = selectedId;
				
			$('#'+domId+' .diaporama_large').css({
				'left': '-5000px',
				'top': '-5000px',
				'margin-top':'0px',
				'margin-left':'0px'
			});
			
			$('#'+domId+' img.diaporama_large').attr('src',self.options.diaporamaItems[selectedId].path);
			if(self.options.diaporamaItems[self.options.currentId].alt != '')
				$('#'+domId+' img.diaporama_large').attr('title',self.options.diaporamaItems[self.options.currentId].alt);
			else
				$('#'+domId+' img.diaporama_large').attr('title',self.options.diaporamaItems[self.options.currentId].title);
			$('.'+domId+'_legend').html(self.options.diaporamaItems[self.options.currentId].legend);
			$('.'+domId+'_copyright').html(self.options.diaporamaItems[self.options.currentId].copyright);
			$('.'+domId+'_title').html(self.options.diaporamaItems[self.options.currentId].title);

			//If there is a carousel, then we move it if necessary
			if(self.options.carousel != null){
				$('#'+self.options.carousel+' span.item_small').removeClass('on');
				$('#'+self.options.carousel+' #'+selectedId+' span.item_small').addClass('on');
			}
			
			
			
    	},
    	loadNext: function(domId){
    		var self = this;
			var elementId = this.options.diaporamaItems[this.options.currentId].next;
			this.loadPhoto(elementId, domId);	
		},
		loadPrevious: function(domId){
			var self = this;
			var elementId = this.options.diaporamaItems[this.options.currentId].previous;
			this.loadPhoto(elementId, domId);
		},
		play: function(force, domId){

			var self = this;
			
			if(this.options.playStatus == null || force == 1){
				this.options.playStatus = 1;
								
				this.options.timeout = setTimeout(function(){
					var elementId = self.options.diaporamaItems[self.options.currentId].next;
					self.loadPhoto(elementId, self.options.domId);
					self.play(1);
					
				}, this.options.timePlay);
				$('#'+domId+' .diaporama_play').css('background','url('+this.options.path+'diaporama-pause.png)');
			}else{
				clearTimeout(this.options.timeout);
				this.options.playStatus = null;
				$('#'+domId+' .diaporama_play').css('background','url('+this.options.path+'diaporama-play.png)');
			}
			
		}
    });
	

})(jQuery);