
jQuery(document).ready(function(){

	
	
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
        	   document.location = currentLang+'/ebyperso/home';
            },  
           "html"  
        );
}