package com.chinauicom.research.stockmanagement.bi.sms.entity;

import com.chinauicom.research.commons.utils.BaseVO;

public class SmsSendReqRpttInfo extends BaseVO implements java.io.Serializable{

	
	private static final long serialVersionUID = 5080988912706823918L;
    
    private String thirdId; //12位yyyymmddhhmmssss+4为随机数

	private String status; //0成功，1,等待发送 2,发送失败 其他失败

    private String type; //0上行短信 1状态报告

    private String date;

    private String msg; //渠道编码例100008

    private String sign;  //md5(thirdId+phone+messageContent+date+channel +key) key cOncf869

    private String errorCode;//当State=2时为错误码值，否则为0

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
    
	
    
}
