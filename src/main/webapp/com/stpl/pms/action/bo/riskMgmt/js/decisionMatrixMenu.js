var decisionValueArr = new Array();
$(function() {
	$("#accordion").accordion( {
		collapsible : true,
		clearStyle : true,
		header : 'div[class*="accordianHeader"]',
		icons : {
			header : "plus1",
			headerSelected : "minus1"
		},
		active : false
	});
});

$(document)
		.ready(
				function() {
					$('.payTransaction').tableDnD( {
						onDrop : function(table, row) {
							var rows = table.tBodies[0].rows;
							for ( var i = 1; i < rows.length; i++) {
								$(rows[i].cells[3]).html(i);
								decisionValueArr[rows[i].id].newPriority = i;
							}
						},
						dragHandle : ".dragHandle"
					});

					$(".payTransaction tr").hover(function() {
						$(this.cells[0]).addClass('showDragHandle');
					}, function() {
						$(this.cells[0]).removeClass('showDragHandle');
					});

					$("select[id*='status_']")
							.change(function() {
								// alert($(this).attr('id') + "*****" +
								// $(this).closest('tr').attr('id'));
									decisionValueArr[$(this).closest('tr').get(
											0).id].newStatus = $(this).val();
								});

					$('tr[id*="tr_"]')
							.each(
									function() {
										var trId = $(this).attr('id');
										var mappingId = $(
												$(this).get(0).cells[0]).find(
												'input[id*="mappingId_"]')
												.val();
										var priority = $
												.trim($($(this).get(0).cells[3])
														.html());
										var status = $($(this).get(0).cells[4])
												.find('select[id*="status_"]')
												.val();
										// alert(trId+'**'+priority+"**"+status);
										decisionValueArr[trId] = new decisionValue(
												trId, mappingId, priority,
												status);
									});

					$("#submitFrm")
							.submit(
									function() {
										console.log("----Submit Button---");
										var data = "";
										$('tr[id*="tr_"]')
												.each(
														function() {
															var trId = $(this)
																	.attr('id');
															if (decisionValueArr[trId].newPriority != decisionValueArr[trId].oldPriority
																	|| decisionValueArr[trId].newStatus != decisionValueArr[trId].oldStatus) {
																data += "&mappingId="
																		+ decisionValueArr[trId].mappingId;
																data += "&priorityOrder="
																		+ decisionValueArr[trId].newPriority;
																data += "&status="
																		+ decisionValueArr[trId].newStatus;
															}
														});
										// console.log("----Submited
										// Data---"+data.substring(1));
										console
												.log("----Submit Button End ---");
										_ajaxCallDiv($(this).attr('action'),data.substring(1),'resultDiv');
										return false;
									});
				});

function decisionValue(id, mappingId, priority, status) {
	this.id = id;
	this.mappingId = mappingId;
	this.oldPriority = priority;
	this.oldStatus = status;
	this.newPriority = priority;
	this.newStatus = status;
}