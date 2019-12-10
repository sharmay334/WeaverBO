/*jslint white: true, browser: true, undef: true, nomen: true, eqeqeq: true, plusplus: false, bitwise: true, regexp: true, strict: true, newcap: true, immed: true, maxerr: 14 */
/*global window: false, REDIPS: true */

/* enable strict mode */
"use strict";

// define redips_init variable
var redips_init;

// redips initialization
redips_init = function () {
	// reference to the REDIPS.drag library and message line
	var	rd = REDIPS.drag,
		msg;
	// initialization
	rd.init();
	// set hover color for TD and TR
	rd.hover.color_td = '#FFCFAE';
	rd.hover.color_tr = '#9BB3DA';
	// set hover border for current TD and TR
	rd.hover.border_td = '2px solid #32568E';
	rd.hover.border_tr = '2px solid #32568E';
	// drop row after highlighted row (if row is dropped to other tables)
	// possible values are "before" and "after"
	rd.row_position = 'after';
//	rd.set_trc();
//	alert(rd.get_position()[0]+"@#$%$#"+rd.get_position()[1]);
	
	// row was clicked - event handler
	rd.myhandler_row_clicked = function () {
		// set current element (this is clicked TR)
		

		var el = rd.obj;
		// find parent table
		el = rd.find_parent('TABLE', el);
		

		
		
		
		
		// every table has only one SPAN element to display messages
//		msg = el.getElementsByTagName('span')[0];
		// display message
		
//		msg.innerHTML = 'Clicked';
	};
	// row was moved - event handler
	rd.myhandler_row_moved = function () {
		// set opacity for moved row
		// rd.obj is reference of cloned row (mini table)
		
		
		rd.row_opacity(rd.obj, 85);
		// set opacity for source row and change source row background color
		// obj.obj_old is reference of source row
		rd.row_opacity(rd.obj_old, 20, 'White');
		
		
		// display message
//		msg.innerHTML = 'Moved';
	};
	// row was not moved - event handler
	rd.myhandler_row_notmoved = function () {
		
		$("#masterTable").removeClass("nolayout");
		
		
//		msg.innerHTML = 'Not moved';
	};
	// row was dropped - event handler
	rd.myhandler_row_dropped = function () {
		// display message
//		msg.innerHTML = 'Dropped';
		
//		var el = rd.obj;
//		// find parent table
//	//	el = rd.find_parent('TABLE', el);
//		if($(el).attr("id")!="masterTable"){
			$("#masterTable").removeClass("nolayout");
			
			
//			//	alert($(".deletedRows").attr("class"));
//				
//		}
//		else{
//		
//			$("#payTransaction.nolayout").attr("class","deletedRows");
//		}
		
		if($(".deletedRows").children().children().length==2)
			if($(".deletedRows").children().children().find("td#fieldName").html()==""){
				$($(".deletedRows").children().children().get(1)).remove();
				$(".deletedRows").addClass("nolayout");
			}
		
		var len = $(".addedRows").find("td#fieldName").length;
		for(var i=0; i<len;i++){
		var ele = $($(".addedRows").find("td#fieldName")).get(i);
		if($(ele).html()==""){
			if($(ele).parent().siblings().length!=1)
		$(ele).parent().remove();
		}
		}
		
//		$("#masterTable").removeClass("nolayout");
//		$(".deletedRows").removeClass("nolayout");
		rd.init();
		var len = $("#drag").find(".drag").length;
		var elemnt ;
		var pos;
		for(var i=0;i<len;i++){
//				alert($(div_drag).find(".drag").get(i).obj);
				elemnt = ($("#drag").find(".drag").get(i));
//				alert($(elemnt).parent().parent().parent().parent().attr("class"));
				if(!$(elemnt).parent().parent().parent().parent().hasClass("deletedRows")){
				if($(elemnt).parent().parent().attr("id")!="firstRow"){
				pos = rd.get_position(elemnt);
				$(elemnt).parent().parent().find("#pageNumber").val(pos[0]-1);
				$(elemnt).parent().parent().find("#fieldSequenceNo").val(pos[1]);
				$(elemnt).parent().parent().find("#fieldDispName").show();
				$(elemnt).parent().parent().find("#selectFieldType").show();
				$(elemnt).parent().parent().find("#selectMini").show();
				$(elemnt).parent().parent().find("a").parent().show();
				$(elemnt).parent().parent().find("#isShow").val("Y");
				
				}
				else{
					pos = rd.get_position(elemnt);
					$(elemnt).parent().parent().find("#page").val(pos[1]+1);
				}
				}
				else{
					if($(elemnt).parent().parent().attr("id")!="firstRow"){
						pos = rd.get_position(elemnt);
						$(elemnt).parent().parent().find("#pageNumber").val(pos[0]-1);
						$(elemnt).parent().parent().find("#fieldSequenceNo").val(pos[1]);
						$(elemnt).parent().parent().find("#fieldDispName").hide();
						$(elemnt).parent().parent().find("#selectFieldType").hide();
						$(elemnt).parent().parent().find("#selectMini").hide();
						$(elemnt).parent().parent().find("a").parent().hide();
						}
						else{
							pos = rd.get_position(elemnt);
							$(elemnt).parent().parent().find("#page").val(pos[1]+1);
						}	
				}
					
			
		}
		
		len = $("#drag").find(".mini").length;
		for(var i=0;i<len;i++){
				elemnt = ($("#drag").find(".mini").get(i));
				pos = rd.get_position(elemnt);
				$("#"+$(elemnt).parent().parent().find('td[id*="mini_"]').html()+"_miniSeqNo").val(pos[1]);
		}
		
		rd.init();
		
	};
	// row was dropped to the source - event handler
	// mini table (cloned row) will be removed and source row should return to original state
	rd.myhandler_row_dropped_source = function () {
		// make source row completely visible (no opacity)
		rd.row_opacity(rd.obj_old, 100);
		
		$("#masterTable").removeClass("nolayout");
		
		// display message
//		msg.innerHTML = 'Dropped to the source';
	};
	/*
	// how to cancel row drop to the table
	rd.myhandler_row_dropped_before = function () {
		//
		// JS logic
		//
		// return source row to its original state
		rd.row_opacity(rd.obj_old, 100);
		// cancel row drop
		return false;
	}
	*/
	// row position was changed - event handler
	rd.myhandler_row_changed = function () {
		// get target and source position (method returns positions as array)
		var pos = rd.get_position();
		// display current table and current row
//		msg.innerHTML = 'Changed: ' + pos[0] + ' ' + pos[1];
	
//		var elemnt = rd.obj;
//		elemnt.getElementById("pageNumber").value=pos[0];
//		elemnt.getElementById("fieldSequenceNo").value=pos[1];
//		$(elemnt).find("#pageNumber").val(pos[0]);
//		$(elemnt).find("#fieldSequenceNo").val(pos[1]);
//		


	};
};

// add onload event listener
/*if (window.addEventListener) {
	window.addEventListener('load', redips_init, false);
}
else if (window.attachEvent) {
	window.attachEvent('onload', redips_init);
}*/