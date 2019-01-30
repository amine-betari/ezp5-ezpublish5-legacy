/*
 * Script from NETTUTS.com [by James Padolsey]
 * @requires jQuery($), jQuery UI & sortable/draggable UI modules
 */

var iNettuts = {
    
    jQuery : $,
    
    settings : {
        columns : '.column',
        widgetSelector: '.widget',
        handleSelector: '.widget-head',
        contentSelector: '.widget-content',
        widgetDefault : {
            movable: true,
            removable: true,
            collapsible: true,
            editable: true,
            colorClasses : ['color-yellow', 'color-red', 'color-blue', 'color-white', 'color-orange', 'color-green']
        },
        widgetIndividual : {
            widget3 : {
                collapsible: true,
                editable: false
            },
            widget2 : {
                collapsible: true,
                editable: false
            }
        }
    },

    init : function () {
        this.addWidgetControls();
        this.makeSortable();
			
		$(".closeFavoriteWidget").click(function(){
			$('#widget4 a.edit').css({backgroundPosition: '', width: ''})
			$('#widget4 .edit-box').hide();
			$("#widget4 .widget-head").removeClass("widget-edit-head");
		});
		
		$(".closeMeteoWidget").click(function(){
			$('#widget6 a.edit').css({backgroundPosition: '', width: ''})
			$('#widget6 .edit-box').hide();
			$("#widget6 .widget-head").removeClass("widget-edit-head");
		});
		
		$(".closeViewsWidget").click(function(){
			$('#widget5 a.edit').css({backgroundPosition: '', width: ''})
			$('#widget5 .edit-box').hide();
			$("#widget5 .widget-head").removeClass("widget-edit-head");
		});
		
    },
    
/*    reload : function () {
    	
        this.makeSortable();
    },
*/    
    getWidgetSettings : function (id) {
        var $ = this.jQuery,
            settings = this.settings;
        return (id&&settings.widgetIndividual[id]) ? $.extend({},settings.widgetDefault,settings.widgetIndividual[id]) : settings.widgetDefault;
    },
    
    addWidgetControls : function () {
        var iNettuts = this,
            $ = this.jQuery,
            settings = this.settings;
            
        $(settings.widgetSelector, $(settings.columns)).each(function () {
            var thisWidgetSettings = iNettuts.getWidgetSettings(this.id);
            if (thisWidgetSettings.removable) {
                $('<a href="#" class="remove">'+delLabel+'</a>').mousedown(function (e) {
                    e.stopPropagation();    
                }).click(function () {
                    if(confirm(delConfirm)) {
                        $(this).parents(settings.widgetSelector).animate({
                            opacity: 0    
                        },function () {
                            $(this).wrap('<div/>').parent().slideUp(function () {
								/* update cookie if remove widget */
                                if($(this).remove()){
									iNettuts.savePreferences();
								}
                            });
                        });
                    }
                    return false;
                }).appendTo($(settings.handleSelector, this));
            }
            
            if (thisWidgetSettings.editable) {
                $('<a href="#" class="edit">'+setLabel+' | </a>').mousedown(function (e) {
                    e.stopPropagation();    
                }).toggle(function () {
                    $(this).parents(settings.widgetSelector)
                            .find('.edit-box').show().find('input').focus();
                    $(this).parent(".widget-head").addClass("widget-edit-head");
                    return false;
                },function () {
                    $(this).css({backgroundPosition: '', width: ''})
                        .parents(settings.widgetSelector)
                            .find('.edit-box').hide();
                    $(this).parent(".widget-head").removeClass("widget-edit-head");
                    return false;
                }).appendTo($(settings.handleSelector,this));
 				
            }
            
            if (thisWidgetSettings.collapsible) {
                $('<a href="#" class="collapse">COLLAPSE</a>').mousedown(function (e) {
                    e.stopPropagation();    
                }).toggle(function () {
                    $(this).css({backgroundPosition: '-38px 0'})
                        .parents(settings.widgetSelector)
                            .find(settings.contentSelector).hide();
                    return false;
                },function () {
                    $(this).css({backgroundPosition: ''})
                        .parents(settings.widgetSelector)
                            .find(settings.contentSelector).show();
                    return false;
                }).prependTo($(settings.handleSelector,this));
            }
        });
        	
    },
    
    attachStylesheet : function (href) {
        var $ = this.jQuery;
        return $('<link href="' + href + '" rel="stylesheet" type="text/css" />').appendTo('head');
    },
    
    makeSortable : function () {
        var iNettuts = this,
            $ = this.jQuery,
            settings = this.settings,
            $sortableItems = (function () {
                var notSortable = '';
                $(settings.widgetSelector,$(settings.columns)).each(function (i) {
                    if (!iNettuts.getWidgetSettings(this.id).movable) {
                        if(!this.id) {
                            this.id = 'widget-no-id-' + i;
                        }
                        notSortable += '#' + this.id + ',';                        
                    }
                    
                });
                
                var selector = '> li';
                if(notSortable && notSortable != '')
                selector = '> li:not(' + notSortable + ')';
                return $(selector, settings.columns);
                //return $('> li:not(' + notSortable + ')', settings.columns);
            })();
            
        $sortableItems.find(settings.handleSelector).css({
            cursor: 'move'
        }).mousedown(function (e) {
            $sortableItems.css({width:''});
            $(this).parent().css({
                width: $(this).parent().width() + 'px'
            });
        }).mouseup(function () {
            if(!$(this).parent().hasClass('dragging')) {
                $(this).parent().css({width:''});
            } else {
                $(settings.columns).sortable('disable');
            }
        });

        $(settings.columns).sortable({
            items: $sortableItems,
            connectWith: $(settings.columns),
            handle: settings.handleSelector,
            placeholder: 'widget-placeholder',
            forcePlaceholderSize: true,
            revert: 300,
            delay: 100,
            opacity: 0.8,
            containment: 'document',
            start: function (e,ui) {
                $(ui.helper).addClass('dragging');
            },
            stop: function (e,ui) {
                $(ui.item).css({width:''}).removeClass('dragging');
                $(settings.columns).sortable('enable');
				iNettuts.savePreferences();
				
            }
        });
    },
	
	savePreferences : function () {
        var iNettuts = this,
            $ = this.jQuery,
            settings = this.settings,
            cookieString = '';
		
		/* Assemble the cookie string */
        $(settings.columns).each(function(i){
           cookieString += (i===0) ? '' : '|';
            $(settings.widgetSelector,this).each(function(i){
                
                /* ID of widget: */
                cookieString += $(this).attr('id') + ',';
            });
            cookieString = cookieString.substr(0,cookieString.length-1);
        });
		
		$.ajax({
			
			type: "POST",
			url: "/ebyperso/action",
			data: 'LayoutUpdAjax=1&MyLayout=' + cookieString,
		    success: function(msg){
				top.location.href = currentLang+'/ebyperso/home';
			}
			
		});
    }
  
};

function updSettings(id, str){
	
	if(!str)
		var str = $("#form" +id).serialize();

	$.post(  
		'/ebyperso/action',  
           {
        	   WidgetUpdAjax:'1',
        	   WidgetId:id,
        	   WidgetConf:str             
           },  
           function(data) { 
        	   if(data){
        		 alert(data);  
        	   }
        	   //alert('retour');
        	   document.location = currentLang+'/ebyperso/home';
        	   //iNettuts.reload();
        	   
        	   //$("#idebyperso").unbind();
        	   //iNettuts.init();
            },  
           "html"  
        );
}

function deleteCity(idCity,idBloc){
	
	$("#"+idCity).remove();
	$("#newville").remove();
	updSettings(idBloc);
}

jQuery(document).ready(function(){
	
	iNettuts.init();
		
	$('#select-city-one').change(function () {
		
		$('#select-city-two option').removeAttr('disabled');
		
		var selectedId = $('#select-city-one option:selected').attr('value');
		
		$("#select-city-two option[value='"+ selectedId +"']").attr('disabled','disabled');
		
	});
	
	$('#select-city-two').change(function () {
		
		$('#select-city-one option').removeAttr('disabled');
		
		var selectedId = $('#select-city-two option:selected').attr('value');
		
		$("#select-city-one option[value='"+ selectedId +"']").attr('disabled','disabled');
		
	});
	
	
	/* widget menu */
	$('.btn-ebyPersoAddContent').click(function () {
      $(".box-add").show();
    });  
	
	$('.box-add-top').click(function () {
	  $(".box-add").hide();
	});  
	
	$('.btn-add-widget').click(function () {
		
		var id = $(this).parent().attr('id');
		var wTab = id.split('_');
		
		 $.ajax({
			   type: "POST",
			   url: "/ebyperso/action",
			   data: {WidgetAddAjax:1,WidgetSel:wTab[1]},
			   success: function(msg){
				   //ID 6     
				   if(id == 'widget_6'){
					 updSettings(6, 'ville1=FRXX0076&ville2=USNY0996&villes%5B%5D=');
				   }else
					top.location.href = currentLang+'/ebyperso/home';
			   }
			 });


		
    }); 
	

	
});