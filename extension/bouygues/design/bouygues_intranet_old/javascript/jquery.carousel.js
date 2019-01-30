;(function($){$.fn.carousel=function(params){var params=$.extend({direction:"horizontal",loop:false,dispItems:1,pagination:false,paginationPosition:"inside",nextBtn:"<span>Next</span>",prevBtn:"<span>Previous</span>",btnsPosition:"inside",nextBtnInsert:"appendTo",prevBtnInsert:"prependTo",autoSlide:false,autoSlideInterval:3000,delayAutoSlide:3000,combinedClasses:false,effect:"slide",slideEasing:"swing",animSpeed:"normal",equalWidths:"true",callback:function(){}},params);if(params.btnsPosition=="outside"){params.prevBtnInsert="insertBefore";params.nextBtnInsert="insertAfter";}
return this.each(function(){var env={$elts:{},params:params,launchOnLoad:[]};env.$elts.carousel=$(this).addClass("js");env.$elts.content=$(this).children().css({position:"absolute","top":0});env.$elts.wrap=env.$elts.content.wrap('<div class="carousel-wrap"></div>').parent().css({overflow:"hidden",position:"relative"});env.steps={first:0,count:env.$elts.content.find(">*").length};env.steps.last=env.steps.count-1;env.$elts.prevBtn=$(params.prevBtn)[params.prevBtnInsert](env.$elts.carousel).addClass("carousel-control previous carousel-previous").data("firstStep",-(env.params.dispItems));env.$elts.nextBtn=$(params.nextBtn)[params.nextBtnInsert](env.$elts.carousel).addClass("carousel-control next carousel-next").data("firstStep",env.params.dispItems);initButtonsEvents(env,function(e){slide(e,this,env);});if(env.params.pagination)initPagination(env);$(function(){var $firstItem=env.$elts.content.find(">*:eq(0)");env.itemWidth=$firstItem.outerWidth();if(params.direction=="vertical"){env.contentWidth=env.itemWidth;}else{if(params.equalWidths){env.contentWidth=env.itemWidth*env.steps.count;}else{env.contentWidth=(function(){var totalWidth=0;env.$elts.content.find(">*").each(function(){totalWidth+=$(this).outerWidth();});return totalWidth;})();}}
env.$elts.content.width(env.contentWidth);env.itemHeight=$firstItem.outerHeight();if(params.direction=="vertical"){env.$elts.content.css({height:env.itemHeight*env.steps.count+"px"});env.$elts.content.parent().css({height:env.itemHeight*env.params.dispItems+"px"});}else{env.$elts.content.parent().css({height:env.itemHeight});}
updateButtonsState(env);$.each(env.launchOnLoad,function(i,fn){fn();});if(env.params.autoSlide){window.setTimeout(function(){env.autoSlideInterval=window.setInterval(function(){env.$elts.nextBtn.click();},env.params.autoSlideInterval);},env.params.delayAutoSlide);}});});};function slide(e,btn,env){var $btn=$(btn);var newFirstStep=$btn.data("firstStep");env.params.callback(newFirstStep);switch(env.params.effect){case"no":if(env.params.direction=="vertical"){env.$elts.content.css("top",-(env.itemHeight*newFirstStep)+"px");}else{env.$elts.content.css("left",-(env.itemWidth*newFirstStep)+"px");}
break;case"fade":if(env.params.direction=="vertical"){env.$elts.content.hide().css("top",-(env.itemHeight*newFirstStep)+"px").fadeIn(env.params.animSpeed);}else{env.$elts.content.hide().css("left",-(env.itemWidth*newFirstStep)+"px").fadeIn(env.params.animSpeed);}
break;default:if(env.params.direction=="vertical"){env.$elts.content.stop().animate({top:-(env.itemHeight*newFirstStep)+"px"},env.params.animSpeed,env.params.slideEasing);}else{env.$elts.content.stop().animate({left:-(env.itemWidth*newFirstStep)+"px"},env.params.animSpeed,env.params.slideEasing);}}
env.steps.first=newFirstStep;updateButtonsState(env);if(!!e.clientX&&env.autoSlideInterval){window.clearInterval(env.autoSlideInterval);}};function updateButtonsState(env){env.$elts.prevBtn.data("firstStep",env.steps.first-env.params.dispItems);env.$elts.nextBtn.data("firstStep",env.steps.first+env.params.dispItems);if(env.$elts.prevBtn.data("firstStep")<0){if(env.params.loop&&env.steps.count>env.params.dispItems){env.$elts.prevBtn.data("firstStep",env.steps.count-env.params.dispItems);env.$elts.prevBtn.trigger("enable");}else{env.$elts.prevBtn.trigger("disable");}}else{env.$elts.prevBtn.trigger("enable");}
if(env.$elts.nextBtn.data("firstStep")>=env.steps.count){if(env.params.loop&&env.steps.count>env.params.dispItems){env.$elts.nextBtn.data("firstStep",0);env.$elts.nextBtn.trigger("enable");}else{env.$elts.nextBtn.trigger("disable");}}else{env.$elts.nextBtn.trigger("enable");}
if(env.params.pagination){env.$elts.paginationBtns.removeClass("active").filter(function(){return($(this).data("firstStep")==env.steps.first)}).addClass("active");}};function initButtonsEvents(env,slideEvent){env.$elts.nextBtn.add(env.$elts.prevBtn).bind("enable",function(){var $this=$(this).bind("click",slideEvent).removeClass("disabled");if(env.params.combinedClasses){$this.removeClass("next-disabled previous-disabled");}}).bind("disable",function(){var $this=$(this).unbind("click").addClass("disabled");if(env.params.combinedClasses){if($this.is(".next")){$this.addClass("next-disabled");}else if($this.is(".previous")){$this.addClass("previous-disabled");}}});env.$elts.nextBtn.add(env.$elts.prevBtn).hover(function(){$(this).addClass("hover");},function(){$(this).removeClass("hover");});};function initPagination(env){env.$elts.pagination=$('<div class="center-wrap"><div class="carousel-pagination"><p></p></div></div>')[((env.params.paginationPosition=="outside")?"insertAfter":"appendTo")](env.$elts.carousel).find("p");env.$elts.paginationBtns=$([]);env.$elts.content.find("li").each(function(i){if(i%env.params.dispItems==0){env.$elts.paginationBtns=env.$elts.paginationBtns.add($('<a role="button"><span>'+(env.$elts.paginationBtns.length+1)+'</span></a>').data("firstStep",i));}});env.$elts.paginationBtns.appendTo(env.$elts.pagination);env.$elts.paginationBtns.slice(0,1).addClass("active");env.launchOnLoad.push(function(){env.$elts.paginationBtns.click(function(e){slide(e,this,env);});});};})(jQuery);