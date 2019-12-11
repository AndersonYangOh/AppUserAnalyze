package com.chinauicom.research.stockmanagement.bi.sms.service;


import com.chinauicom.research.stockmanagement.bi.sms.entity.Msg;
import com.chinauicom.research.stockmanagement.bi.sms.entity.SmsSendRequestInfo;

public interface SmsService  {


	public String sendSmsSer(SmsSendRequestInfo info) throws Exception;
	public String sendSmsSerTask(SmsSendRequestInfo info) throws Exception;
	
	public Msg findmsgByMobile(String mobile) throws Exception;

	public void sendmsgByMobile(String mobile) throws Exception;

	public Msg findLastMsgByMobile(String mobile) throws Exception;

	public Msg addMsg(Msg msg) throws Exception;

	public int findMsgNo(String mobile) throws Exception;
}
