$(document).ready(function(){

	//$("a").attr("target", "_self");
  	//$("table.dataTable tbody td:first-of-type").text("");

  	var allSubHeaders = $(".subheader");
  	var allMenuItems = $(".sidebar-menu li");


  	var idToMapping = {
  		"diff": {
  			"menuitem": $(allMenuItems[0]),
  			"upindex": false
  		},
  		"corr-hitting": {
  			"menuitem": $(allMenuItems[1]),
  			"upindex": "diff"
  		},
  		"corr-pitching": {
  			"menuitem": $(allMenuItems[2]),
  			"upindex": "corr-hitting"
  		}
  	}

  	var listenToElement = function(elem){
  		var pageTop = $(window).scrollTop() + 30;
  		var pageBottom = $(window).height() - 60;
  		var pageHalf = (pageTop + 0.25 * pageBottom) *0.25;
  		var elemTop = $(elem).offset().top - pageTop;

  		elemID = elem.attr("id");

		var isElemOnPage = (0 < elemTop && elemTop < pageBottom);

		if(isElemOnPage && (elemTop < pageHalf)){
			//highlight the menu item of this element
			change(elemID);
		} else if((elemID !== "diff") && isElemOnPage && (elemTop > pageHalf)){
			//highlight the menu item one above the element's
			//except for "diff" because nothing is above it
			change(idToMapping[elemID].upindex);
		}
  	}

  	var change = function(changeID){
  		idToMapping[changeID].menuitem.css("background-color", "#cc0000");

  		nonElems = allSubHeaders.each(function(index, value){
	  		if(value.id !== changeID){
	  			idToMapping[value.id].menuitem.css("background-color", "inherit");
	  		} 
  		});
  	}

	$(window).scroll(function() {
		listenToElement($("#diff"))
		listenToElement($("#corr-hitting"))
		listenToElement($("#corr-pitching"))
    });
});
