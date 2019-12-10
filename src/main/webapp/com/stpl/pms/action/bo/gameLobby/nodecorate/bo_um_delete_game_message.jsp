<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="FormSection">

			<s:if test="hasActionErrors()">
	<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>Game
					does not exist.
				</div>
			</div>
        <s:actionerror />
    </s:if>
    <s:if test="hasActionMessages()">
    <div class="greyStrip">
				<h4>Success Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert succes_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>Data
					Deleted Successfully.
				</div>
			</div>
        <s:actionmessage />    
    </s:if>
</div>