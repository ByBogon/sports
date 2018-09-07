$(document).ready(function(){
	$('.right.menu.open').on("click",function(e){
        e.preventDefault();
		$('.ui.vertical.navbar.menu').toggle();
	});
    
	$('.ui.dropdown').dropdown();
});
