package com.chinauicom.research.stockmanagement.bi.sms.entity;

import com.chinauicom.research.commons.utils.BaseVO;

public class SmsSendRequestInfo extends BaseVO implements java.io.Serializable{

	
	private static final long serialVersionUID = 5080988912706823918L;
    
    private String thirdId; //12位yyyymmddhhmmssss+4为随机数

	private String phone;

    private String messageContent;

    private String date;

    private String channel; //渠道编码例100008

    private String sign;  //md5(thirdId+phone+messageContent+date+channel +key) key cOncf869
    
    private String code; //yanzhengma
    
    

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getThirdId() {
		return thirdId;
	}

	public void setThirdId(String thirdId) {
		this.thirdId = thirdId;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}
    
    
    
}
