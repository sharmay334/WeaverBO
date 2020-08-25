var relatedTo = new Array();
var serNameArr = new Array();
var Language;
function relatedToData() {
	

	if(Language=="vi")
	var relatedToArr = "RG|RG,BONUS|Bonus,CASHIER|Cashier,RISK_MGT|Risk Mgmt,ROLE_MGT|Role MGMT,MISC|Miscellaneous,PLAYER_MGT|Player Mgmt,ACT_MGT|Account Mgmt,USER_MGT|Quản lý người dùng,HURDLE_MGT|Hurdle Mgmt,GAME_MGT|Quản lý trò chơi,CMS|CMS,REPORTS|Reports,SERVICE_MGMT|Service Mgmt,DOMAIN_MGT|Domain Mgmt,LOYALTY|Loyalty,COMM_MGMT|Communication Mgmt,TICKET_MGMT|Ticket Mgmt,MASTER_MGMT|MASTER MGMT".split(",");
	else
	var relatedToArr = "CASHIER|Cashier,RISK_MGT|Risk Mgmt,ROLE_MGT|Role MGMT,MISC|Miscellaneous,PLAYER_MGT|Player Mgmt,ACT_MGT|Account Mgmt,USER_MGT|User Master,CMS|CMS,REPORTS|Reports,SERVICE_MGMT|Service Mgmt,DOMAIN_MGT|Domain Mgmt,COMM_MGMT|Communication Mgmt,COMPANY_MGMT|Company Master,ACCOUNTING_MGMT|Accounting Master,INVENTORY_MGMT|Inventory Master,TRANSACTION_MGMT|Transaction Master,HR_MGMT|HR Master,ORDER_VCHR|Order Voucher".split(",");

		for ( var i = 0; i < relatedToArr.length; i += 1) {
		var relatedToStr = relatedToArr[i].split("|");
		relatedTo[relatedToStr[0]] = relatedToStr[1];
		 //alert(relatedTo[relatedToStr[0]]);
	}
}
relatedToData();


function _buidActionPath(relatedTo,service) {
	// alert(relatedTo+"--"+service);
	if (service == 'MGMT') {
		service = 'mgmt';
	}
		if (relatedTo == "MISC") {
			return projectName +"/com/stpl/pms/action/bo/misc/";// +service+"/action/miscellaneous/";
		} else {
			if (relatedTo == "ROLE_MGT") {
				return projectName +"/com/stpl/pms/action/bo/rm/";// +service+"/action/roleMgmt/";
			}else {
				if (relatedTo == "PLAYER_MGT") {
					return projectName +"/com/stpl/pms/action/bo/pm/";// +service+"/action/plrMgmt/";
				}else {
					if (relatedTo == "HURDLE_MGT") {
						return projectName +"/com/stpl/pms/action/bo/hm";// +service+"/action/hurdleMgmt/";
					}else {
					if (relatedTo == "ACT_MGT") {
						return projectName +"/com/stpl/pms/action/bo/am/";// +service+"/action/accMgmt/";
					}else {
						if (relatedTo == "USER_MGT" || relatedTo=="COMPANY_MGMT" || relatedTo=="ACCOUNTING_MGMT" || relatedTo=="INVENTORY_MGMT" || relatedTo=="TRANSACTION_MGMT" || relatedTo=="HR_MGMT" || relatedTo=="ORDER_VCHR") {
							return projectName +"/com/stpl/pms/action/bo/um/";// +service+"/action/userMgmt/";
						}
						else {
							if (relatedTo == "CMS") {
								return projectName +"/com/stpl/pms/action/bo/cms/";// +service+"/action/cmsMgmt/";
							}else {
								if (relatedTo == "REPORTS") {
									return projectName +"/com/stpl/pms/action/bo/um/";// +service+"/action/reportMgmt/";
								}
								else {
									if (relatedTo == "DOMAIN_MGT") {
										return projectName +"/com/stpl/pms/action/bo/dm/";
									}
									else {
										if (relatedTo == "RISK_MGT") {
											return projectName +"/com/stpl/pms/action/bo/riskMgmt/";
										}else {
											if (relatedTo == "CASHIER") {
												return projectName +"/com/stpl/pms/action/bo/cashier/";
											}else {
												if (relatedTo == "BONUS") {
													return projectName +"/com/stpl/pms/action/bo/bonus/";
												}
												else {
													if (relatedTo == "GAME_MGT" || relatedTo =="TICKET_MGMT") {
														return projectName +"/com/stpl/pms/action/bo/gl/";
													}else {
														if (relatedTo == "RG") {
															return projectName +"/com/stpl/pms/action/bo/rg/";
														}else {
															if(relatedTo == "LOYALTY"){
																return projectName +"/com/stpl/pms/action/bo/loyalty/";
															}else {
																if(relatedTo == "COMM_MGMT"){
																	return projectName +"/com/stpl/pms/action/bo/cms/";
																}
															}
														}
													}
												}	
											}
										}
									}
								}
								
							}
						}
						
					}
				}
			}
		  }		
		}
	}
/*
 * function _buidActionPath(relatedTo, service) { var str = ''; if (service ==
 * 'Home') { service = 'mgmt'; } if (relatedTo == "ACT_MGT") { if (service ==
 * 'EntWine') { str = projectName + "/com/skilrock/igs/web/entWine/accMgmt/"; }
 * else { str = projectName + "/com/skilrock/igs/web/accountMgmt/"; } } else if
 * (relatedTo == "PLAYER_MGT") { str = projectName +
 * "/com/skilrock/igs/web/plrMgmt/"; } else if (relatedTo == "GAME_MGT") { if
 * (service == 'ige') { str = projectName + "/com/skilrock/igs/web/ige/"; } str =
 * projectName + "/com/skilrock/igs/web/authentication/"; } else if (relatedTo ==
 * "PLAY_MGT") { str = projectName + "/com/skilrock/igs/web/" + service +
 * "/playMgmt/"; } return str; }
 */	

function buldMainActionPath(service) {
	var str = '';
	if (service == 'EW') {
		str = projectName + '/com/skilrock/igs/web/entWine/loginMgmt/';
	} else if (service == 'MGMT') {
		str = projectName + '/com/stpl/pms/action/bo/lm/';
	} else if (service == 'BGE') {
		str = projectName + '/com/stpl/pms/action/bo/gameEngine/action/loginMgmt/';
	}  else if (service == 'RUMMY') {
		str = projectName + '/com/stpl/pms/action/bo/lm/';
	}  else if (service == 'IGE') {
			str = projectName + '/com/stpl/pms/action/bo/lm/';
	 } else if (service == 'CASINO') {
			str = projectName + '/com/stpl/pms/action/bo/lm/';
	 } else if (service == 'SGE') {
			str = projectName + '/com/stpl/pms/action/bo/lm/';
	 }
	return str;
}






function createMenu(activeTab) {
	var serviceMenu = menuStr.split(';');
	var mainMenu = '<ul id="nav">';
	var subMenu = '<ul class="sf-menu sf-js-enabled sf-shadow">';
	for ( var i = 0; i < serviceMenu.length; i += 1) {
		var serDisplayName = serviceMenu[i].split('~');
		serviceMenu[i] = serDisplayName[1];
		serDisplayName = serDisplayName[0];
		var menu = serviceMenu[i].split('$');
		if (menu.length == 2) {
			if(Language=="vi")
				serDisplayName = "Nhà";
			else
				serDisplayName = "Home";
			var mainTab = menu[0].split('@');
			mainMenu = mainMenu + '<li class="active"><a href="'
			+ buldMainActionPath(mainTab[0]) 
			+ 'bo_home_page.action?serviceName='+mainTab[0]+'"><span>' + serDisplayName + '</span></a></li>';
			if (mainTab[0] == activeTab) {
						
				var menuAction = buldMainActionPath(mainTab[0])  + 'bo_home_page.action?serviceName='+mainTab[0];	
	
				if (menu[1] == '{}') {
					subMenu = '';
				}else{
					var subTab = menu[1].split(','); // .replace('{','').replace('}','')
					for ( var j = 0; j < subTab.length; j += 1) {
						var subMenuTab = subTab[j].split('=');
						var subMenuName = subMenuTab[0].replace('{', '')
								.replace('}', '');
						subMenu = subMenu + '<li><a href="javascript:void(0);" class="sf-with-ul">'+relatedTo[subMenuName]+
								'<span class="sf-sub-indicator"> »</span></a><ul style="float: none; width: 15em">';
						var dropDownTab = subMenuTab[1].split('!');
						var actionPath = _buidActionPath(subMenuName,
								mainTab[0]);
						
						for ( var k = 0; k < dropDownTab.length; k += 1) {
							var drapdown = dropDownTab[k].replace('{', '')
									.replace('}', '').split(':');
						
							 var dropdownUrl = drapdown[1].split('|');
							 if(drapdown[0].replace('{', '').replace('}','').includes("header")){
								 subMenu = subMenu
									+ '<li style="white-space: normal; float: left; width: 100%;"><a style="float: none; width: auto;pointer-events: none;" href="'
									+ actionPath
									+ (dropdownUrl[0].replace('{', '').replace(
											'}', ''))
									+ '.action">'
									+ drapdown[0].replace('{', '').replace('}',
											'').replace('header','')
									+ '</a></li>'; 
								 
							 }
							 else{
								 subMenu = subMenu
									+ '<li style="white-space: normal; float: left; width: 100%;"><a style="float: none; width: auto;" href="'
									+ actionPath
									+ (dropdownUrl[0].replace('{', '').replace(
											'}', ''))
									+ '.action">'
									+ drapdown[0].replace('{', '').replace('}',
											'')
									+ '</a></li>';
							 }
							
						}
						subMenu = subMenu + '</ul></li>';
					}
					if(activeTab == 'IGE'){
						subMenu = subMenu + '<li class="showmore"><a href = "'+menuAction+'" id="showMoreId"><span style="showmore"><u>show more </u></span></li></ul></li><li class="splitSubnav"></li></ul>';
					}
				}
			} 
		} else {
			alert('some error occur');
		}
	}

	// mainMenu = mainMenu + '<li class="active"><a
	// href="'+buldMainActionPath('MGMT')
	// +'bo_home_page.action?serviceName=RUMMY"><span>Rummy</span></a></li></ul>';
	if (subMenu != '') {
		subMenu = subMenu + '</ul>';
	}
	document.getElementById('navbox').innerHTML = mainMenu;
	document.getElementById('main_menu').innerHTML = subMenu;
	
// alert(document.getElementById('navbox').innerHTML);
	
	mobileView();
}


function mobileView(){
	
	if($(window).width() < 992){
		if($('body').hasClass('mobileNav')){	
		}else{mobileMenu();}
	}

	$(window).resize(function(){
		if($(window).width() < 992){
			if($('body').hasClass('mobileNav')){	
			}else{mobileMenu();}

		}else{
			removeMobileMenu();
		}
	});	
}

function mobileMenu(){

	$('body').addClass('mobileNav');
	
	$('#Navigation #navbox').append("<div class='offcanvasNavTrigger'><span></span><span></span><span></span></div>");
	
	var offCanvasNavStr = "<div class='offcanvasNavWrap'><div class='offcanvasNav'><div class='closeBtn'>x</div>"+$('#Navigation #top_bar > div').html()+"</div></div>";
	
	$( "body" ).prepend(offCanvasNavStr);
	
	$('.offcanvasNav > ul, .offcanvasNav > ul *').removeAttr('class style');
	
	$('.offcanvasNavTrigger').on('click',function(){
		$('body').addClass('openOffcanvasNav');
	});
	
	$('.offcanvasNav > .closeBtn').on('click',function(){
		$('body').removeClass('openOffcanvasNav');
	});
		
}

function removeMobileMenu(){
	$('body').removeClass('mobileNav');
	$('.offcanvasNavTrigger,.offcanvasNavWrap').remove();
}



var BrowserDetect = {
	init: function () {
		this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
		this.version = this.searchVersion(navigator.userAgent)
			|| this.searchVersion(navigator.appVersion)
			|| "an unknown version";
		this.OS = this.searchString(this.dataOS) || "an unknown OS";
	},
	searchString: function (data) {
		for (var i=0;i<data.length;i++)	{
			var dataString = data[i].string;
			var dataProp = data[i].prop;
			this.versionSearchString = data[i].versionSearch || data[i].identity;
			if (dataString) {
				if (dataString.indexOf(data[i].subString) != -1)
					return data[i].identity;
			}
			else if (dataProp)
				return data[i].identity;
		}
	},
	searchVersion: function (dataString) {
		var index = dataString.indexOf(this.versionSearchString);
		if (index == -1) return;
		return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
	},
	dataBrowser: [
		{
			string: navigator.userAgent,
			subString: "Chrome",
			identity: "Chrome"
		},
		{ 	string: navigator.userAgent,
			subString: "OmniWeb",
			versionSearch: "OmniWeb/",
			identity: "OmniWeb"
		},
		{
			string: navigator.vendor,
			subString: "Apple",
			identity: "Safari",
			versionSearch: "Version"
		},
		{
			prop: window.opera,
			identity: "Opera"
		},
		{
			string: navigator.vendor,
			subString: "iCab",
			identity: "iCab"
		},
		{
			string: navigator.vendor,
			subString: "KDE",
			identity: "Konqueror"
		},
		{
			string: navigator.userAgent,
			subString: "Firefox",
			identity: "Firefox"
		},
		{
			string: navigator.vendor,
			subString: "Camino",
			identity: "Camino"
		},
		{		// for newer Netscapes (6+)
			string: navigator.userAgent,
			subString: "Netscape",
			identity: "Netscape"
		},
		{
			string: navigator.userAgent,
			subString: "MSIE",
			identity: "Explorer",
			versionSearch: "MSIE"
		},
		{
			string: navigator.userAgent,
			subString: "Gecko",
			identity: "Mozilla",
			versionSearch: "rv"
		},
		{ 		// for older Netscapes (4-)
			string: navigator.userAgent,
			subString: "Mozilla",
			identity: "Netscape",
			versionSearch: "Mozilla"
		}
	],
	dataOS : [
		{
			string: navigator.platform,
			subString: "Win",
			identity: "Windows"
		},
		{
			string: navigator.platform,
			subString: "Mac",
			identity: "Mac"
		},
		{
			string: navigator.platform,
			subString: "Linux",
			identity: "Linux"
		}
	]

};


String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}