package com.stpl.pms.action.bo.rg;

//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.util.List;
//
//import org.apache.log4j.Logger;
//
//import com.google.gson.Gson;
//import com.google.gson.reflect.TypeToken;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.rg.RespGamingController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.javabeans.RespGamingBean;
//import com.stpl.pms.javabeans.VipLevelMasterBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class RespGamingAction extends BaseActionSupport{
}
/*	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(RespGamingAction.class);

	private Integer vipLevel;
	private String criteriaType;
	private String group;
	private List<RespGamingBean> operatorLimitList;
	private String criteriaJson;
	
	
	
	public String getDomainNameList() {
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}
		
		return SUCCESS;
	}
	
	public void fetchRgData(){
		Gson gson = new Gson();
		PrintWriter out = null;
		try{
			List<VipLevelMasterBean> vipList = CommonMethodController.getInstance().fetchDomainVipLevelList(domainId,"");
			String jsonList = gson.toJson(vipList);
			out = response.getWriter();
			out.write(jsonList);
		}catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public String fetchOperatorLimit() {
		logger.info("I am inside get criteria action");
		RespGamingController controller = new RespGamingController();
		try {
			operatorLimitList = controller.fetchOperatorLimit(domainId, vipLevel, criteriaType, group);
		} catch (PMSException e) {
			logger.info("Exception occured");
			return "exception_nodecorate";
		}
		logger.info("Exit from get criteria action");
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String setLimitAction() {
		RespGamingController controller = new RespGamingController();
		try {
			logger.info("Inside set limit action");
			Type type = new TypeToken<List<RespGamingBean>>() {}.getType();
			operatorLimitList = (List<RespGamingBean>)new Gson().fromJson(criteriaJson, type);
			controller.setOperatorLimit(operatorLimitList, domainId,vipLevel, userInfoBean.getUserId());
			logger.info(operatorLimitList);
		} catch (Exception be) {
			logger.info("Exception occured");
			addActionError("Some Internal Error!");
			return "exception";
		}
		logger.info("Exit from set limit helper");
		return SUCCESS;
	}
	
	public String getCriteriaType() {
		return criteriaType;
	}

	public void setCriteriaType(String criteriaType) {
		this.criteriaType = criteriaType;
	}

	public Integer getVipLevel() {
		return vipLevel;
	}

	public void setVipLevel(Integer vipLevel) {
		this.vipLevel = vipLevel;
	}

	public List<RespGamingBean> getOperatorLimitList() {
		return operatorLimitList;
	}

	public void setOperatorLimitList(List<RespGamingBean> operatorLimitList) {
		this.operatorLimitList = operatorLimitList;
	}
	
	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getCriteriaJson() {
		return criteriaJson;
	}

	public void setCriteriaJson(String criteriaJson) {
		this.criteriaJson = criteriaJson;
	}
}
*/