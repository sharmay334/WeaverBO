<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript">
function onKeyPressAllowNumbers(e)
{
	
	var key = window.event ? e.keyCode : e.which;
	var keychar = String.fromCharCode(key);
	//alert(key);
	if(keychar=="-")
	{
		return false;
	}
	else if(key == 0 || key == 8 || key == 46 ){ 
	 // for sapce and dot backspace
	 //alert(key);
        return true;
    }  
	else{
		reg = /^\d+$/;
		// /^[-]?\d*\.?\d*$/;
	return reg.test(keychar);
	}
}
function onKeyPressBlockChar(e)
{
	var key = window.event ? e.keyCode : e.which;
	var keychar = String.fromCharCode(key);
	//alert(key);
	if((key >= 0 && key <= 8) || key== 46){	// for sapce n backspace
		return true;
	}

	reg = 	/^[a-zA-Z]+$/;
	return reg.test(keychar);

}
function fnValidateIPAddress() {
    //Remember, this function will validate only Class C IP.
    //change to other IP Classes as you need
    var ipaddr = document.getElementById('domainIp').value
    ipaddr = ipaddr.replace( /\s/g, "") //remove spaces for checking
    var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/; //regex. check for digits and in
                                          //all 4 quadrants of the IP
    if (re.test(ipaddr)) {
        //split into units with dots "."
        var parts = ipaddr.split(".");
        //if the first unit/quadrant of the IP is zero
        if (parseInt(parseFloat(parts[0])) == 0) {
        alert("Please insert correct ip address");
        
            return false;
        }
        //if the fourth unit/quadrant of the IP is zero
        if (parseInt(parseFloat(parts[3])) == 0) {
        	alert("Please insert correct ip address");
            return false;
        }
        //if any part is greater than 255
        for (var i=0; i<parts.length; i++) {
            if (parseInt(parseFloat(parts[i])) > 255){
            	alert("Please insert correct ip address");
                return false;
            }
        }
        return true;
    } else {
    	alert("Please insert correct ip address");
        return false;
    }
}	

</script>


<div class="FormSection">

	<div class="greyStrip">
		<h4>
			Blocked Phone Information
		</h4>
	</div>
		<s:form action="bo_dm_blockPhoneSave.action" name="blockIp">
	<div class="innerBox">
		<s:hidden id="domainId" value="%{domainId}" name="domainId" />
		<div class="FormMainBox">

			<div class="labelDiv">
				<label>
					Phone No
				</label>
			</div>
			<div class="InputDiv">
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
					&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				<!--
		
					<input type="text" name="dmDomainInfo.emailId" />
				-->
			</div>
			<br/>
		
			<br/>
			<div class="InputDiv">
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
					&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				<!--
		
					<input type="text" name="dmDomainInfo.emailId" />
				-->
			</div>
				
			<br/>
			<br/>
			<div class="InputDiv">
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
					&nbsp;&nbsp;
				<s:textfield name="ip" id="ip" theme="simple" maxlength="15" id="domainIp"
				onkeypress="return onKeyPressAllowNumbers(event)" cssStyle="width:20%" ></s:textfield>
				<!--
		
					<input type="text" name="dmDomainInfo.emailId" />
				-->
				<br/>
			<br/>
			</div>
			
		</div>
			

			<div class="clearFRM" style=" padding-top: 15px"></div>
		<div class="FormMainBox">

			<div class="labelDiv">
				<label>
					Reason for block phone
				</label>
			</div>
			<div class="InputDiv">
				<s:textfield name="reason" id="reason" theme="simple" maxlength="50"></s:textfield>
				<!--
		
					<input type="text" name="dmDomainInfo.emailId" />
				-->
			</div>

		</div>
	</div>
<div class="box_footer" align="right">
			<s:submit name="createDomain" value="Block Phone" cssClass="button"
				id="submit" theme="simple"></s:submit>
			<input type="submit" id="cancel" name="cancel" value="Cancel"
				class="button">
		</div>
		</s:form>
</div>
