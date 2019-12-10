package com.stpl.pms.action.bo.cashier;

//import com.google.gson.Gson;
//import com.google.gson.JsonArray;
//import com.google.gson.JsonElement;
//import com.google.gson.JsonParser;
//import com.google.gson.JsonSyntaxException;
//import com.stpl.loyalty.common.Log;
//import com.stpl.pms.controller.cashier.BOCashierController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.PaymentCorrectionBean;
//import com.stpl.pms.javabeans.PlayerPaymentCorrection;

public class PaymentCorrectionJob implements Runnable {

	@Override
	public void run() {
		// TODO Auto-generated method stub
		
	}
}
/*
	private String correctionList;
	private short domainId;
	private int userId;
	private String correctionType;
	private String withdrawableImpact;
	private short aliasId;



	public PaymentCorrectionJob(String correctionList, short domainId,short aliasId,
			int userId, String correctionType, String withdrawableImpact) {
		this.correctionList = correctionList;
		this.domainId = domainId;
		this.aliasId=aliasId;
		this.userId = userId;
		this.correctionType = correctionType;
		this.withdrawableImpact = withdrawableImpact;
	}


	@Override
	public void run() {

		BOCashierController controller = new BOCashierController();
		JsonParser jsonParser = new JsonParser();
		Gson googleJson = new Gson();
		
		try {
			/*raise the system level flag of bulkPlrPaymentCorrection process
			System.setProperty(CashierAction.BULK_PAYMENT_CORRECTION_RUNNING, "true");

			JsonArray arr = jsonParser.parse(correctionList).getAsJsonArray();

			for(JsonElement obj : arr){

				try {
					PaymentCorrectionBean correctionBean = googleJson.fromJson(obj, PaymentCorrectionBean.class);
					Double playerId = Double.parseDouble(correctionBean.getPlayerId());
					StDmDomainAliasNameMaster stDmDomainAliasNameMaster = CommonMethodController.getInstance().getAliasMaster(this.aliasId); 
					
					short domainId = stDmDomainAliasNameMaster.getDomainMaster().getDomainId();
					
					PlayerPaymentCorrection correction = new PlayerPaymentCorrection(playerId.longValue(), domainId, aliasId,Double.parseDouble(correctionBean.getSettlementAmount()), this.correctionType, correctionBean.getReason(), this.withdrawableImpact);
					controller.plrPaymentCorrection(correction,this.userId);
					Thread.sleep(100);
				} catch (PMSException e) {
					e.printStackTrace();
				}catch (InterruptedException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (JsonSyntaxException e) {
			Log.exception(e);
		}finally {
			System.clearProperty(CashierAction.BULK_PAYMENT_CORRECTION_RUNNING);
		}
	}

}
*/