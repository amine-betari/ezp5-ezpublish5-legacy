(function($) {
	var self;

	$.fn.slideMajes = function(o) {		
	    return this.each(function() {
            new $slm(this, o);
	    });
	};
	
	// Default configuration properties.
    var defaults = {
		numElementDisplayed: 6,
		type: 'horizontal',
		animateDuration : 1500,
		methodEasing: 'jswing',
		includeMargin: false,
		controls: true,
		pagination: false,
		paginationId: 'mycarousel-pagination',
		paginationCurrent: 1,
		playStatus: null,
		timeout: null,
		timePlay:4000,
		playCurrent: 1,
		paginationNb: 1,
		domId: '',
		containerSize: '',
		playWay: 'next',
		diaporamaItems: null,
		slideCount: 0,
		slideMax: 0,
		gotopage: null
    };
    
    $.slideMajes = function(e, o) {
   		var self = this;
    	this.options    = $.extend({}, defaults, o || {});
    	
    	var domId = $(e).attr('id');
		this.options.domId = domId;
		this.options.slideCount = 0;
		var totalSize = 0;
		var totalSizeWithMargin = 0;

    	if(this.options.type == 'horizontal'){
    		var direction = 'left';
			if($('#'+domId+' .mycarousel.global .mycarousel.container div.item').width() > 0){

   				var elementSize = $('#'+domId+' .mycarousel.global .mycarousel.container div.item').width();
   				var margin = parseInt($('#'+domId+' .mycarousel.global .mycarousel.container div.item').css('margin-right'));
				var containerSize = $('#'+domId+' .mycarousel.global').width();
			}else{
				var elementSize = parseInt($('#'+domId+' .mycarousel.global .mycarousel.container div.item').css('width'));
   				var margin = parseInt($('#'+domId+' .mycarousel.global .mycarousel.container div.item').css('margin-right'));
				var containerSize = parseInt($('#'+domId+' .mycarousel.global').css('width'));
			}
			$("#"+domId+" .mycarousel.global .mycarousel.container div.item").each(function(i){
				if($(this).width() > 0){
					totalSize += $(this).width();
					totalSizeWithMargin += $(this).width()+margin;
				}else{
					totalSize += parseInt($(this).css('width'));
					totalSizeWithMargin += parseInt($(this).css('width'))+margin;
				}
			});
			
   		}else if(this.options.type == 'vertical'){
   			var direction = 'top';   
   			var elementSize = $('#'+domId+' .mycarousel.global .mycarousel.container div.item').height();
   			var margin = parseInt($('#'+domId+' .mycarousel.global .mycarousel.container div.item').css('margin-bottom'));
			var containerSize = $('#'+domId+' .mycarousel.global').height();
			
			$("#"+domId+" .mycarousel.global .mycarousel.container div.item").each(function(i){
				totalSize += $(this).height();
				totalSizeWithMargin += $(this).height()+margin;
			});
   		}

   		if(this.options.includeMargin == true)
			containerSize += margin;
		
		this.options.containerSize = containerSize;
		
		var containerTotalWidth = totalSizeWithMargin;
		this.options.slideMax = -1 + ((totalSize / elementSize) / this.options.numElementDisplayed);
		this.options.paginationNb =this.options.slideMax+1;
	
		if(this.options.controls == true){
		
			if(this.options.slideCount >= this.options.slideMax)
				$("#"+domId+" .slide-next").addClass('off');
	
			if(this.options.slideCount <= 0)		
				$("#"+domId+" .slide-prev").addClass('off');
				
			/*IE6 fix*/
			if(this.options.slideCount >= this.options.slideMax)	$("#"+domId+" .slide-next").addClass('offNext');
			if(this.options.slideCount <= 0)						$("#"+domId+" .slide-prev").addClass('offPrev');
			
		
			$("#"+domId+" .slide-next").unbind('click').click(function(){
	
				if(self.options.slideCount < self.options.slideMax){

					if(self.options.type == 'horizontal')
						$("#"+domId+" .mycarousel.global div").animate({'left':'-='+containerSize+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
					else if(self.options.type == 'vertical')
						$("#"+domId+" .mycarousel.global div").animate({'top':'-='+containerSize+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
					self.options.slideCount += 1;
					
					if(self.options.slideCount >= self.options.slideMax)
						$("#"+domId+" .mycarousel.slide-next").addClass('off');
						
					if(self.options.slideCount > 0)
						$("#"+domId+" .mycarousel.slide-prev").removeClass('off');
						
					/*IE6 fix*/
					if(self.options.slideCount >= self.options.slideMax)	$("#"+domId+" .slide-next").addClass('offNext');
					if(self.options.slideCount > 0)							$("#"+domId+" .slide-prev").removeClass('offPrev');
				}

			});
			
			$("#"+domId+" .mycarousel.slide-prev").unbind('click').click(function(){
			
				if(self.options.slideCount > 0){
					if(self.options.type == 'horizontal')
						$("#"+domId+" .mycarousel.global div").animate({'left':'+='+containerSize+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
					else if(self.options.type == 'vertical')
						$("#"+domId+" .mycarousel.global div").animate({'top':'+='+containerSize+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
					self.options.slideCount -= 1;
					
					if(self.options.slideCount <= 0)
						$("#"+domId+" .mycarousel.slide-prev").addClass('off');
					
					if(self.options.slideCount < self.options.slideMax)
						$("#"+domId+" .mycarousel.slide-next").removeClass('off');
						
					/*IE6 fix*/
					if(self.options.slideCount < self.options.slideMax)		$("#"+domId+" .slide-next").removeClass('offNext');
					if(self.options.slideCount <= 0)						$("#"+domId+" .slide-prev").addClass('offPrev');
				}
			
			});
			
			
		}
		
		if(this.options.pagination == true){
			
			$("#"+this.options.paginationId+" a").unbind('click').click(function(){
				self.move($(this), 1);
				return false;
			});

		}
		
		if(this.options.controls == false)
			this.play(1);
			
		if(self.options.diaporamaItems != null)
			this.movetopg(self.options.diaporamaItems[self.options.currentId].numpage);
		
    	if(self.options.gotopage != null)
			this.movetopg(self.options.gotopage);
    };
    
 	var $slm = $.slideMajes;

    $slm.fn = $slm.prototype = {
        slideMajes: '0.1'
    };

	$slm.fn.extend = $slm.extend = $.extend;

    $slm.fn.extend({
	
		play: function(force){

			var self = this;
			if(force == 1){
				this.options.playStatus = 1;
				this.options.timeout = setTimeout(function(){
					var elementRel = self.options.playCurrent;
					self.move($("#"+self.options.paginationId+" a[rel="+elementRel+"]"));
					
					if(self.options.playWay == 'next'){
					
						if(elementRel >= self.options.paginationNb){
							self.options.playCurrent--;
							self.options.playWay = 'previous';
						}else
							self.options.playCurrent++;
							
					}else if(self.options.playWay == 'previous'){
						if(elementRel > 1)
							self.options.playCurrent--;
						else if(elementRel == 1){
							self.options.playCurrent++;
							self.options.playWay = 'next';
						}
					}
					
					self.play(1);
				}, this.options.timePlay);

			}
			
		},
		move: function (domElement, stopAnim){
			var self = this;
			var cursor = self.options.paginationCurrent - domElement.attr('rel');
			var deplacementWidth = cursor*self.options.containerSize;

			$('#mycarousel-pagination .page').removeClass('on');
			$(domElement).addClass('on');

			$("#"+self.options.domId+" .mycarousel.global div").animate({'left':'+='+deplacementWidth+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
							
			self.options.paginationCurrent = domElement.attr('rel');
			if(stopAnim == 1)
				clearTimeout(self.options.timeout);
		},
		movetopg: function (numpage){
			var self = this;
			var cursor = self.options.paginationCurrent - numpage;
			var deplacementWidth = cursor*self.options.containerSize;
			
			if(self.options.type == 'horizontal')
				$("#"+self.options.domId+" .mycarousel.global div").animate({'left':'+='+deplacementWidth+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
			else if(self.options.type == 'vertical')
				$("#"+self.options.domId+" .mycarousel.global div").animate({'top':'+='+deplacementWidth+'px'},{'easing': self.options.methodEasing,duration: self.options.animateDuration});
			
				
			self.options.paginationCurrent = numpage;			
			this.options.slideCount = numpage - 1;

			if(this.options.slideCount >= this.options.slideMax)
				$("#"+this.options.domId+" .mycarousel.slide-next").addClass('off');

			if(this.options.slideCount > 0)
				$("#"+this.options.domId+" .mycarousel.slide-prev").removeClass('off');
			
		}
	});

 })(jQuery);