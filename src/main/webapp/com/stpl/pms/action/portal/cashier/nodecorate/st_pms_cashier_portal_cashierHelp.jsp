<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Help</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"
			href="<%=path%>/css/old/cashier_help.css">
			
		<script type="text/javascript">
	$(document).ready(function() {
		$("#CashDepoHelp").accordion( {
			collapsible : true,
			clearStyle : true,
			header : 'div[class*="yelowHeaderAcc"]',
			icons : {
				header : "defaultIconRed",
				headerSelected : "selectedIconRed"
			},
			active : false
		});
		$("#depositsSub").accordion( {
			collapsible : true,
			clearStyle : true,
			header : 'div[class*="RedStripSmall"]',
			icons : {
				header : "defaultIconWhite",
				headerSelected : "selectedIconWhite"
			},
			active : false
		});
		$("#withdrawalExpand").accordion( {
			collapsible : true,
			clearStyle : true,
			header : 'div[class*="RedStripSmall"]',
			icons : {
				header : "defaultIconWhite",
				headerSelected : "selectedIconWhite"
			},
			active : false
		});
	});
</script>
	</head>
	<body>
		<div class="amountBoxCash">
			<div id="CashDepoHelp" class="CashDepoBox">
				<div class="yelowHeaderAcc">
					<a href="#" class="hd6"><font style="color: #c70000;">Real
							Money Deposits</font> </a>
				</div>
				<div id="realMoneySub">
					<div class="RealText">
						<p>
							This page is where you can find everything you need to know about
							cash deposits and withdrawals. Real money deposits into your
							Khelplay Rummy Account are accepted in several ways. The minimum
							deposit across all options is Rs. 25.00 (unless otherwise
							stated). Make sure you read the Terms & Conditions. For further
							queries, contact us on <a href="mailto:care@khelplayrummy.com"
								style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>.
						</p>
						<p>
							For further queries, contact us on
							<a href="mailto:care@khelplayrummy.com"
								style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>.
						</p>
					</div>
					<div class="RedStripSmall">
						<table width="100%" height="25" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td width="25%" align="center" valign="middle" class="hd8">
									&nbsp;
								</td>
								<td width="25%" align="center" valign="middle" class="hd8">
									Methods
								</td>
								<td width="25%" align="center" valign="middle" class="hd8">
									Deposit
								</td>
								<td width="25%" align="center" valign="middle" class="hd8">
									Cash Out
								</td>
							</tr>
						</table>
					</div>
					<table border="0" cellspacing="0" cellpadding="0" align="center"
						id="DepositTbl" style="margin-top: -5px">
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/visa.png" alt="Visa" />
							</td>
							<td width="25%" align="center" valign="middle">
								Visa
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wrong.png" alt="wrong" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/master-card.png" alt="Master Card" />
							</td>
							<td width="25%" align="center" valign="middle">
								Master Card
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wrong.png" alt="wrong" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/mastero.png" alt="Maestro Card" />
							</td>
							<td width="25%" align="center" valign="middle">
								Maestro Card
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wrong.png" alt="wrong" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/netbanking.png" alt="Net Banking" />
							</td>
							<td width="25%" align="center" valign="middle">
								Net Banking
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wrong.png" alt="wrong" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/cash-payment.png" alt="Cash Payment" />
							</td>
							<td width="25%" align="center" valign="middle">
								Cash Payment
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wrong.png" alt="wrong" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/khelplay_cashcard.png"
									alt="Cash Card" />
							</td>
							<td width="25%" align="center" valign="middle">
								Cash Card
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wrong.png" alt="wrong" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wire-transfer.png"
									alt="Wire Transfer" />
							</td>
							<td width="25%" align="center" valign="middle">
								Wire Transfer
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/bank-transfer.png"
									alt="BankDraft/Cheque" />
							</td>
							<td width="25%" align="center" valign="middle">
								BankDraft/Cheque
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
						</tr>
					</table>
					<div class="RealText">
						<p style="font-weight: bold; text-decoration: underline;">
							Cashing Out Your Rummy Winnings
						</p>
					</div>
					<div class="RedStripSmall">
						<table width="100%" height="25" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td width="25%" align="center" valign="middle" class="hd8">
									&nbsp;
								</td>
								<td width="25%" align="center" valign="middle" class="hd8">
									Methods
								</td>
								<td width="25%" align="center" valign="middle" class="hd8">
									Deposit
								</td>
								<td width="25%" align="center" valign="middle" class="hd8">
									Cash Out
								</td>
							</tr>
						</table>
					</div>
					<table border="0" cellspacing="0" cellpadding="0" align="center"
						id="DepositTbl" style="margin-top: -5px">
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/check-payment.png"
									alt="Check Payment" />
							</td>
							<td width="25%" align="center" valign="middle">
								Check Payment
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
						</tr>
						<tr>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/wire-transfer.png"
									alt="Online Fund Transfer" />
							</td>
							<td width="25%" align="center" valign="middle">
								Online Fund Transfer
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
							<td width="25%" align="center" valign="middle">
								<img src="<%=path%>/css/old/images/right.png" alt="right" />
							</td>
						</tr>
					</table>
					<div class="RealText">
						<p>
							To cash out, click 'Cashier' in the Khelplayrummy Lobby and
							select 'Withdrawal'. Enter the amount** you wish to withdraw and
							select the withdrawal 'Type' and click on 'Submit'.
						</p>
						<p>
							**Kindly note the minimum withdrawal need to be for an amount of
							INR 500.00
						</p>
						<p>
							See our Withdrawal Policies for available options and details on
							how withdrawals are processed.
						</p>
						<p>
							If you have any other questions about playing online rummy for
							real money at Khelplayrummy, contact 03592-305000 or write to
							<a href="mailto:support@Khelplayrummy.com"
								style="color: #9f0202; font-weight: bold">support@Khelplayrummy.com</a>.
							Even if you don't want to deposit real money at this time, you
							can still practice rummy at any one of the play money tables.
							Good luck!
						</p>
					</div>
				</div>
				<div class="yelowHeaderAcc">
					<a href="#" class="hd6"><font style="color: #c70000;">Deposits</font>
					</a>
				</div>
				<div id="depositsSub">
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">Visa:
								Debit Card & Credit Card</font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/visa.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										A VISA card purchases is fully integrated via the
										Khelplayrummy 'Cashier' screen. When you click on "Cashier",
										you will see the option "Debit card" in the Deposit tab. Enter
										the amount you wish to buy the cash chips for and select VISA
										from the drop down list and click on 'Continue'.
									</p>
									<p>
										In the Payment Page, you are required to enter all the valid
										information. For added security, a Card Verification Value
										(CVV) is required. The CVV is a 3-digit number located on the
										back of the card, above the signature.
									</p>
									<p>
										When you click 'Make Payment', your request will be submitted
										to your bank servers via Payment gateway and you will receive
										confirmation in due course. During the process do not click
										Back or Enter/backspace key. Purchase transactions are
										identified on your Debit Card statement as "SacharGaming".
									</p>
									<p>
										Kindly note Khelplayrummy does not charge any other fees for
										using VISA cards. Players are responsible to co-ordinate with
										their respective banks if any fees charged by their card
										issuer for transaction.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>


								</td>
							</tr>
						</table>
					</div>

					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">Master
								Card: Debit & Credit Card</font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/master-card.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										A Master Card purchase is fully integrated via the
										Khelplayrummy 'Cashier' screen. When you click on "Cashier",
										you will see the option "Debit Card" in the Deposit tab. Enter
										the amount you wish to buy the cash chips for and select
										Master Card from the drop down list and click on 'Continue'.
									</p>
									<p>
										In the Payment Page, you are required to enter all the valid
										information. For added security, a Card Verification Value
										(CVV) is required. The CVV is a 3-digit number located on the
										back of the card, above the signature.
									</p>
									<p>
										When you click 'Make Payment', your request will be submitted
										to your bank servers via Payment gateway and you will receive
										confirmation in due course. During the process do not click
										Back or Enter/backspace key. Purchase transactions are
										identified on your Debit Card statement as "SacharGaming".
									</p>
									<p>
										Kindly note Khelplayrummy does not charge any other fees for
										using Master cards. Players are responsible to co-ordinate
										with their respective banks if any fees charged by their card
										issuer for transaction.
									</p>

									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>


								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">Maestro:
								Debit Card</font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/mastero.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Maestro debit card purchases are fully integrated via the
										Khelplayrummy cashier screen. When you click on "Cashier", you
										will see the option "Debit Card" in the Deposit tab. Enter the
										amount you wish to buy the cash chips for and select Maestro
										Card from the drop down list and click on 'Continue'.
									</p>
									<p>
										In the Payment Page, you are required to enter all the valid
										information. For added security, a Card Verification Value
										(CVV) is required. The CVV is a 3-digit number located on the
										back of the card, above the signature.
									</p>
									<p>
										After you've clicked on 'Submit', (3D secure) processing by
										Maestro Card will take place. Once you confirm your 3D secure
										password, your request will be submitted to your bank's
										servers via Payment gateway and you will receive confirmation
										on successful or rejected transaction in due course. During
										the process do not click Back or Enter/backspace key. Purchase
										transactions are identified on your Debit Card statement as
										"SacharGaming".
									</p>
									<p>
										Kindly note Khelplayrummy does not charge any other fees for
										using Maestro cards. Players are responsible to co-ordinate
										with their respective banks if any fees charged by their card
										issuer for transaction.
									</p>

									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">Net
								Banking</font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/netbanking.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Net Banking is an Online Bank Transfer allows you to make a
										real-time bank transfer from your bank account to your
										Khelplayrummy account.
									</p>
									<p>
										Net Banking is integrated via the Khelplayrummy cashier
										screen. You will see the option "Net Banking" in the Deposit
										tab. Enter the amount you wish to buy the cash chips for and
										select the bank from the drop down list and click on
										'Continue' and you will be presented with a Net Banking screen
										of the bank you have selected from drop down list. Provide
										your online banking login credentials to verify and authorize
										the payment. Payment gateway Khelplayrummy will thereafter
										complete the transaction with your bank as per amount you have
										entered on your behalf. Please keep in mind that sessions are
										time bound, if not processed appropriately you may need to
										re-process transaction. You have 10 minutes to complete the
										transfer.
									</p>
									<p>
										Your Khelplayrummy account is credited instantaneously with
										message, if the transaction is successful; else error message
										with details will be displayed.
									</p>
									<p>
										Kindly note Khelplayrummy does not charge any other fees for
										using Maestro cards. Players are responsible to co-ordinate
										with their respective banks if any fees charged by their card
										issuer for transaction.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Cash Payment : OLA </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/cash-payment.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Khelplayrummy also provides an exclusive way of making
										purchase. You can walk in to our nearest OLA (Off Line
										Affiliate) Locations and make a deposit to be credited to your
										Khelplayrummy account. You need to provide your Player ID/User
										Name and the amount (real money) desired for deposit. The OLA
										personnel will collect the money and uses our backend system
										to credit your Khelplayrummy account.
									</p>
									<p>
										Kindly note Khelplayrummy does not charge any other fees for
										using Cash Payment Option.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Cash Card - Khelplay Cash Card </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/khelplay_cashcard.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Kheplay Cash Card is a prepaid voucher available in major
										cities of India that allows you to quickly and easily deposit
										funds to your Khelplayrummy account. It is very easy to use -
										simply follow these instructions;
									</p>
									<p>
										Purchase a <b>Khelplay Cash Card</b> at any of authorized Pay world Outlets. To find out outlets information you may contact Payworld Support Desk Toll Free Number: <b>1800 102 1222 </b>(from 9:00 am to 9:00 pm, 24x7)
									</p>
									<p>
										You will see the option "Cash Card" in the Deposit tab. Enter
										the amount you wish to buy the cash chips for and select the
										cash card type as "Khelplay" from the drop down list. Enter
										the Serial No, PIN (which is mentioned on Khelplay cash card)
										and click on 'Continue' and your Khelplayrummy account is
										credited instantaneously if the transaction is successful.
									</p>
									<p>
										Payworld T&C condition as applicable as per their respective
										organisation as per URL provided:
										<a href="http://www.payworldindia.com/terms_condtions.php" target="_blank">http://www.payworldindia.com/terms_condtions.php</a>
									</p>
									<p>
										Kindly note Khelplayrummy does not charge any other fees for
										using Khelplay Cash Card. Do not share or reveal Serial & Pin
										details of your Khelplaycash card. Sachar Gaming Pvt Ltd
										and/or Payworld (SDUS) are not responsible in case of lost,
										theft or misuse of Khelplay cash card.

									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Wire Transfer </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/wire-transfer.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										A Wire Transfer allows you to deposit money in your
										Khelplayrummy account in an easy manner. To make a deposit
										using this option, login to your Khelplayrummy account, click
										the 'Cashier' button and select 'Deposit' and click on
										'Continue'. You will be presented with our Bank Details where
										you can wire the money for deposit. You need to approach your
										bank to process the Wire Transfer.
									</p>
									<p>
										After completing the wire transfer please send fax or scan
										copy of your transfer slip along with your user id to
										<a href="mailto:accounts@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">accounts@khelplayrummy.com</a>
										or contact customer service executive for updating your
										account balance.
									</p>
									<p>
										Once your Wire Transfer has been processed, it may take 24 to
										48 Hours to appear on your Khelplayrummy account.

									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Bank Draft/Cheque </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/check-payment.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Bank Draft allows you to make secure deposit from your bank
										account to your Khelplayrummy account. When you click on
										"Cashier" and then on "Deposit", you will see an option to use
										Wire Transfer/Draft. Click on the 'Continue' button, you will
										be then presented with details of the address you need to send
										the Cheque/Draft for crediting your account.
									</p>
									<p>
										As it can take up to 7 working days for the funds to be
										received from your bank after the cheque is deposited in our
										bank. Your deposit will be in 'un cleared' status in your
										Khelplayrummy account. The amount will be credited to your
										Khelplayrummy account once the cheque/Draft is cleared.
									</p>
									<p>
										If a cheque deposited is not honored by your bank and is
										returned as unpaid, other restrictions will apply to cheque
										deposit option in future.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>

				</div>
				<div class="yelowHeaderAcc">
					<a href="#" class="hd6"><font style="color: #c70000;">Withdrawals</font>
					</a>
				</div>
				<div id="withdrawalExpand">
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Check Payments </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/check-payment.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Depending on your state of residence in India (Except Assam &
										Orissa), Khelplayrummy offers players the option of receiving
										checks ONLY in Indian Currency.
									</p>
									<p>
										There are no fees charged by Khelplayrummy.com to issue a
										check for withdrawal of funds 2 times in a month. However, we
										charge additional 75.00 INR per check for subsequent
										withdrawals in a month.
									</p>
									<p>
										Furthermore, for the checks issued by us, some banks or
										financial institutions may charge additional fees for handling
										checks. Before requesting a check, we suggest that you check
										with your bank or financial institution for any charges that
										you may incur when banking or cashing your check.
									</p>
									<p>
										Checks will be delivered by regular mail are expected to
										arrive within 15 business days. To be able to use our courier
										service we will need your contact phone number and your
										address must not be a PO Box or rural route address.
									</p>
									<p>
										Checks are sent to the full name and mailing address listed in
										your Khelplayrummy account at the time you make your
										withdrawal request. Kindly note if a check is sent to an
										incorrect name or mailing address (as per the records), you
										will incur a fee to place a stop-payment order on this check.
									</p>
									<p>
										*All our successful withdrawals are processed only on Monday
										and Thursday.
									</p>
									<p>
										**We strongly advise that you deposit your check at a
										reputable bank or financial institution.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Online Bank Transfer </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top">
									<img src="<%=path%>/css/old/images/bank-transfer.png" alt="logo"
										style="margin: 6px 0px 4px 57px" />
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										An Online Bank Transfer is a withdrawal method that allows you
										to receive your winnings/funds by having them credited
										directly to your bank account.
									</p>
									<p>
										To make a withdrawal request via Online Bank Transfer, login
										to your Khelplayrummy account, click the 'Cashier' button and
										select 'Withdrawal'. Enter your withdrawal amount and choose
										the 'Online Transfer' option in the withdrawal screen. You
										will then be asked to enter and subsequently confirm
										information about your bank account. Once your bank account
										details have been submitted, you will be brought back to the
										withdrawal screen to confirm your 'Online Transfer' request.
									</p>
									<p>
										Only your bank account details are required; intermediary bank
										information should not be included in the Online Transfer
										form.
									</p>
									<p>
										Note: Online Transfers can only be sent to a bank account
										registered in your name and your bank state must match the
										state registered in your Khelplayrummy account. It may take up
										to 48 hours for Khelplayrummy to process your withdrawal
										request and another 2-5 business days for funds to be credited
										to your designated bank account.
									</p>
									<p>
										There are no fees charged by Khelplayrummy.com for using
										'Online Transfer' for withdrawal of funds 2 times in a month.
										However, we charge additional 50.00 INR per transaction for
										subsequent withdrawals in one month. Players are responsible
										for any fees charged by their bank or intermediary bank (if
										applicable) for receiving Online Transfers. For more
										information on your bank's policy concerning fees for
										receiving Online Transfers, please contact your bank directly.
									</p>
									<p>
										*All our successful withdrawals are processed only on Monday
										and Thursday.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="RedStripSmall">
						<a href="#" class="hd7"><font style="color: #fff;">
								Withdrawal Policies </font> </a>
					</div>
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="left" valign="top" class="RealText2">
									<p>
										Khelplayrummy has a total and unwavering commitment to the
										safety and security of player funds. Player balances are kept
										in segregated accounts and not used for operational expenses.
										This ensures that your funds are always available for you to
										cash out in accordance with our banking and security
										procedures.
									</p>
									<p>
										Please note, Khelplayrummy reserves the right to use
										additional eligibility criteria to determine the withdrawal
										options players may be offered at any given time. How to Make
										a Withdrawal Request?
									</p>
									<p>
										To make a withdrawal request, login to your Khelplayrummy and
										visit the Cashier. Next, select the 'Withdrawal' Tab. Input
										the amount you'd like to withdraw, choose the withdrawal
										option and click on 'Submit'.
									</p>
									<p>
										The screen will display how your withdrawal will be processed.
										This is only an estimation of how your funds will be
										disbursed. We cannot guarantee that your withdrawal will be
										processed exactly as described, as this estimation does not
										take into account any temporary connectivity problems.
									</p>
									<p>
										Review the information on this screen carefully before you
										complete your withdrawal request. If you see that account
										designated to receive your withdrawal has been cancelled/has
										any issues, please cancel your withdrawal request and email us
										at
										<a href="mailto:support@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">support@khelplayrummy.com</a>
										In order to protect against collusion and fraud, a 48-hour
										delay is imposed on cashing out from your last deposit.
										Therefore, please allow 48 hours from your last deposit before
										requesting your withdrawal.
									</p>
									<p>
										Wire Transfer withdrawals will be sent for processing within
										72 hours. Please allow 2-5 business days for funds to be
										credited to your designated bank account.
									</p>
									<p>
										Checks will be delivered by regular mail and are expected to
										arrive within 15 business days from the withdrawal process
										date.
									</p>
									<p>
										An email notification from Khelplayrummy will be sent to you
										confirming each transaction made within your Khelplayrummy
										account. Always refer to your confirmation email after you've
										made a withdrawal request to confirm how your funds were
										processed.
									</p>
									<p>
										In special cases, additional information may be required for a
										withdrawal to be processed.
									</p>
									<p>
										For any clarifications please contact us on 03592-305000 or
										write to us at
										<a href="mailto:care@khelplayrummy.com"
											style="color: #9f0202; font-weight: bold">care@khelplayrummy.com</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
