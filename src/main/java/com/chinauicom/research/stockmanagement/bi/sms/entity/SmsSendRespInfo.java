package com.chinauicom.research.stockmanagement.bi.sms.entity;

import com.chinauicom.research.commons.utils.BaseVO;

public class SmsSendRespInfo extends BaseVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 5080988912706823918L;
	
	private String thirdId; //12位yyyymmddhhmmssss+4为随机数

	private String status;// 1 接受成功，等待下发;-1,数据加密错误 其他失败

    private String msg;

	public String getThirdId() {
		return thirdId;
	}

	public void setThirdId(String thirdId) {
		this.thirdId = thirdId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}


    
}
