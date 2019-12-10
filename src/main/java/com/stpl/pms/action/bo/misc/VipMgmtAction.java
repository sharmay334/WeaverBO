package com.stpl.pms.action.bo.misc;

//import java.io.IOException;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//
//import org.apache.commons.configuration.PropertiesConfiguration;
//import org.apache.log4j.Logger;
//
//import com.google.gson.Gson;
//import com.google.gson.reflect.TypeToken;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.misc.VipMgmtController;
//import com.stpl.pms.exception.PMSErrorMessage;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.javabeans.VipLevelCriteriaBean;
//import com.stpl.pms.javabeans.VipLevelMasterBean;
//import com.stpl.pms.javabeans.VipRuleDetailBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.Utility;

public class VipMgmtAction extends BaseActionSupport {}
/*
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(VipMgmtAction.class);
	private VipLevelMasterBean vipMaster;
	private  List<VipLevelMasterBean> vipLevelList;
	private List<VipRuleDetailBean>ruleCriList;
	private String plrList;
	private Map<Long, String> playerMap;
	private Long[] playerIdArr;
	private int vipLevel;
	private String errorMsg;
	private Map<String, VipLevelCriteriaBean> activeVipCriteria;
	private String vipChangeAction;
	
	public String fetchVipLevelCriList(){
		try {
			VipMgmtController vipcontroller = new VipMgmtController();
			activeVipCriteria = vipcontroller.fetchVipLevelCriteriaMap("ACTIVE");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}
	public String searchVipLevel() {
		log.info("---searchVipLevel inside VipMgmtAction start---");
		log.info(vipMaster);
		domainId = vipMaster.getDomainId();
		CommonMethodController controller = CommonMethodController.getInstance();
		VipMgmtController vipcontroller = new VipMgmtController();
		try {
			if (domainId > 0 && vipMaster.getLevelType() != null
					&& !"".equals(vipMaster.getLevelType())) {
				if ("BYDEFAULT".equals(controller.getDmProperty(domainId, "vipLevel"))) {
					domainId = 1;
				}
//				vipLevelList = vipcontroller.getVipLevelByType(vipMaster.getLevelType()).get(domainId);
				vipLevelList = vipcontroller.getVipLevelByQuery(vipMaster.getLevelType(), domainId,vipMaster.getVipGroup());
				PropertiesConfiguration config = Utility.fetchGlobalProperties();
				if(vipLevelList==null) {
					vipLevelList = new ArrayList<VipLevelMasterBean>();
				}
				for (VipLevelMasterBean bean : vipLevelList) {
					bean.setVipDispCode(String.valueOf(config.getProperty("global." + bean.getVipDispCode())));
				}
				activeVipCriteria = vipcontroller.fetchVipLevelCriteriaMap("ACTIVE");
				if (vipLevelList != null && vipMaster.getVipGroup()!=null && !"ALL".equals(vipMaster.getVipGroup())) {
					Iterator<VipLevelMasterBean>itr = vipLevelList.iterator();
					while (itr.hasNext()) {
						VipLevelMasterBean vip = (VipLevelMasterBean) itr
								.next();
						if (!vip.getVipGroup().equals(vipMaster.getVipGroup())) {
							itr.remove();
						}
					}
				}
				
			} else {
				log.error("----Domain Id or Level Type Invalid----");
				addActionError("Invalid search data.");
				return "exception_nodecorate";
			}
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception_nodecorate";
		}
		log.info("---searchVipLevel inside VipMgmtAction end---");
		return SUCCESS;
	}
	public String saveVipLevel() {
		log.info("---saveVipLevel inside VipMgmtAction strat---");
		log.info(vipMaster);
		try {
			if ("AUTO".equals(vipMaster.getLevelType())) {
				if (vipMaster.getVipLevel()>=1001 && vipMaster.getVipLevel()<=2000) {
					String vipRule = vipMaster.getVipRule().replace(" ", "").replace(
						"BETWEEN", " BETWEEN ").replace("AND", " AND ").replace("OR", " OR ").replace("(", "( ").replace(")", " )");
					vipMaster.setVipRule(vipRule);
				}else{
					addActionError("Please provide vip level between 1001 and 2000");
					return "exception";
				}
				
			}else if ("MANUAL".equals(vipMaster.getLevelType())) {
				if (!(vipMaster.getVipLevel()>=5001 && vipMaster.getVipLevel()<=6000)) {
					addActionError("Please provide vip level between 5001 and 6000");
					return "exception";
				}
			}
			VipMgmtController controller = new VipMgmtController();
		
			controller.saveVipLevel(vipMaster, userInfoBean.getUserId());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}
		catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		log.info("---saveVipLevel inside VipMgmtAction end---");
		return SUCCESS;
	}
	public String editVipLevel() {
		log.info("---editVipLevel inside VipMgmtAction strat---");
		log.info(vipMaster);
		CommonMethodController controller = CommonMethodController.getInstance();
		VipMgmtController vipcontroller = new VipMgmtController();
		try {
			domainId = vipMaster.getDomainId();
			if (domainId > 0 && vipMaster.getLevelType() != null
					&& !"".equals(vipMaster.getLevelType())&& vipMaster.getVipLevel()>0) {
				if ("BYDEFAULT".equals(controller.getDmProperty(domainId, "vipLevel"))) {
					domainId = 1;
				}
				vipLevelList = vipcontroller.getVipLevelByType(domainId,vipMaster.getLevelType());
				activeVipCriteria = vipcontroller.fetchVipLevelCriteriaMap("ACTIVE");
				for (VipLevelMasterBean vip : vipLevelList) {
					if (vip.getVipLevel() == vipMaster.getVipLevel()) {
						vipMaster = vip;
						break;
					}
				}
				if ("AUTO".equals(vipMaster.getLevelType())) {
					String ruleArr[] = vipMaster.getVipRule().replace("AND", "#").replace("OR", "#").replace("(", "").replace(")", "").split("#");
					ruleCriList = new ArrayList<VipRuleDetailBean>();
					for (String cri : ruleArr) {
						cri = cri.trim();
						String code = cri.split("BETWEEN")[0].trim();
						String[] valArr = cri.split("BETWEEN")[1].trim().split(","); 
						if (activeVipCriteria.get(code)!=null) {
							ruleCriList.add(new VipRuleDetailBean(code,
									activeVipCriteria.get(code).getCriteriaName(),
									valArr[0].trim(), valArr[1].trim()));
							
						}else{
							throw new PMSException("Invalid VIP Rule.");
						}
					}
				}
				
			} else {
				log.error("----Domain Id or Level Type Invalid----");
				addActionError("Invalid search data.");
				return "exception_nodecorate";
			}

		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception_nodecorate";
		}
		log.info("---editVipLevel inside VipMgmtAction end---");
		return SUCCESS;
	}
	public String updateVipLevel() {
		log.info("---updateVipLevel inside VipMgmtAction strat---");
		log.info(vipMaster);
		try {
			if ("AUTO".equals(vipMaster.getLevelType())) {
				String vipRule = vipMaster.getVipRule().replace(" ", "").replace(
						"BETWEEN", " BETWEEN ").replace("AND", " AND ").replace("OR", " OR ").replace("(", "( ").replace(")", " )");
				// Utility.vipLevelMap.get("BYDEFAULT".equals(Utility.dmPropMap.get(vipMaster.getDomainId()).getVipLevel())?(short)1:vipMaster.getDomainId());
				vipMaster.setVipRule(vipRule);
			}
//			vipMaster.setUpdateDatetime(new Timestamp(Calendar.getInstance()
//					.getTimeInMillis()));
//			vipMaster.setLastUpdateBy(userInfoBean.getUserId());
			VipMgmtController controller = new VipMgmtController();
		
			controller.updateVipLevel(vipMaster, userInfoBean.getUserId());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}

		log.info("---updateVipLevel inside VipMgmtAction end---");
		return SUCCESS;
	}

	public String changePlayerVip() {
		log.info("--In changePlayerVip--");
		CommonMethodController controller = CommonMethodController.getInstance();
		VipMgmtController vipcontroller = new VipMgmtController();
		try {
			if (domainId > 0) {
				if ("BYDEFAULT".equals(controller.getDmProperty(domainId, "vipLevel"))) {
					domainId = 1;
				}
				vipLevelList = vipcontroller.getVipLevelByType(domainId, "MANUAL");
				if (vipLevelList != null && vipLevelList.size()>0) {
					if (!(plrList == null || "".equals(plrList))) {
						Type type = new TypeToken<Map<Long, String>>() {
						}.getType();
						playerMap = new Gson().fromJson(plrList, type);
						playerIdArr=playerMap.keySet().toArray(new Long[0]);
					}else {
						log.error("----Invalid Player List----");
						addActionError("Invalid Player List");
						return "exception_nodecorate";
					}
				}else {
					addActionError("No Vip Level Available .");
					return "exception_nodecorate";
				}
				
			} else {
				log.error("----Domain Id Invalid----");
				addActionError("Select atleast one player");
				return "exception_nodecorate";
			}
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception_nodecorate";
		}
		
		return SUCCESS;
	}
	
	public String changePlayerVipSave() {
		VipMgmtController controller = new VipMgmtController();
		try {
			log.info("----------changePlayerVipSave--------");
				if (playerIdArr!=null && playerIdArr.length > 0 ) {
					controller.changePlayerVipSave(playerIdArr,vipLevel,userInfoBean.getUserId(),vipChangeAction);
				}else{
					log.error("----Invalid Data ----vip level--"+vipLevel+"----Player List---"+playerIdArr);
					addActionError("Invalid domain.");
					return "exception";
				}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return ERROR;
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	public void checkVipAvailability() {
		log.info("---checkVipAvailability inside VipMgmtAction strat---");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			VipMgmtController controller = new VipMgmtController();
			VipLevelMasterBean bean = controller.getVipLevelDetail(vipMaster.getVipLevel(), vipMaster.getDomainId());
			if (vipMaster!=null && bean==null) {
				writer.write("success");
			}else{
				writer.write("Vip level not available.");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		}	
		catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
		log.info("---checkVipAvailability inside VipMgmtAction end---");
	}

	public void setVipMaster(VipLevelMasterBean vipMaster) {
		this.vipMaster = vipMaster;
	}

	public VipLevelMasterBean getVipMaster() {
		return vipMaster;
	}



	public void setVipLevelList(List<VipLevelMasterBean> vipLevelList) {
		this.vipLevelList = vipLevelList;
	}



	public List<VipLevelMasterBean> getVipLevelList() {
		return vipLevelList;
	}
	public void setRuleCriList(List<VipRuleDetailBean> ruleCriList) {
		this.ruleCriList = ruleCriList;
	}
	public List<VipRuleDetailBean> getRuleCriList() {
		return ruleCriList;
	}
	public void setPlrList(String plrList) {
		this.plrList = plrList;
	}
	public String getPlrList() {
		return plrList;
	}
	public void setPlayerMap(Map<Long, String> playerMap) {
		this.playerMap = playerMap;
	}
	public Map<Long, String> getPlayerMap() {
		return playerMap;
	}
	
	public void setPlayerIdArr(Long[] playerIdArr) {
		this.playerIdArr = playerIdArr;
	}
	public Long[] getPlayerIdArr() {
		return playerIdArr;
	}
	public void setVipLevel(int vipLevel) {
		this.vipLevel = vipLevel;
	}
	public int getVipLevel() {
		return vipLevel;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	public void setActiveVipCriteria(Map<String, VipLevelCriteriaBean> activeVipCriteria) {
		this.activeVipCriteria = activeVipCriteria;
	}
	public Map<String, VipLevelCriteriaBean> getActiveVipCriteria() {
		return activeVipCriteria;
	}

	public void setVipChangeAction(String vipChangeAction) {
		this.vipChangeAction = vipChangeAction;
	}

	public String getVipChangeAction() {
		return vipChangeAction;
	}
	
	
}
*/