package com.chinauicom.research.stockmanagement.bi.sms.service.bo;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinauicom.research.commons.HttpClientUtils;
import com.chinauicom.research.commons.sms.DES;
import com.chinauicom.research.commons.sms.MD5Secret;
import com.chinauicom.research.commons.utils.DateUtils;
import com.chinauicom.research.stockmanagement.bi.sms.dao.MsgDao;
import com.chinauicom.research.stockmanagement.bi.sms.entity.Msg;
import com.chinauicom.research.stockmanagement.bi.sms.entity.SmsSendRequestInfo;
import com.chinauicom.research.stockmanagement.bi.sms.service.SmsService;

import net.sf.json.JSONObject;

@Service
public class SmsServiceImpl implements SmsService {
	
	@Autowired
	private MsgDao msgDao;
	
	@Override
	public String sendSmsSer(SmsSendRequestInfo info) throws Exception {
		String res = null;
		
		// TODO Auto-generated method stub
		  String key = "cOncf869"; //秘钥
	      Map<String, Object> map = new HashMap<String, Object>();
	      int len = 12;
	      String code = "";
			while(code.length()<len){
				code+=(int)(Math.random()*10);
			}
	      long thirdId = Long.parseLong(code);
	      map.put("thirdId", thirdId);
	    
	      String phone = info.getPhone();
	      String messageContentDes = null;
	      String phoneDes = null;
	      try {
	         messageContentDes = DES.encryptDES("验证码是"+info.getCode()+"，请勿告诉其他人，感谢您的使用！【中国联通】", key);
	         phoneDes = DES.encryptDES(phone,key);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      map.put("phone", phoneDes);
	      map.put("messageContent", messageContentDes);
	      String date = DateUtils.getDateString(new Date());
	      map.put("date", date);
	      String channel = "100008";
	      map.put("channel", channel);
	      String sign = MD5Secret.MD5(thirdId+phoneDes+messageContentDes+date+channel+key);
	      map.put("sign", sign);
	      String param = JSONObject.fromObject(map).toString();

	    res = HttpClientUtils.httpJson(param,"http://super.wo.cn/sms/smsSend");
		
		return res;
	}
	
	@Override
	public String sendSmsSerTask(SmsSendRequestInfo info) throws Exception {
		String res = null;
		
		// TODO Auto-generated method stub
		  String key = "cOncf869"; //秘钥
	      Map<String, Object> map = new HashMap<String, Object>();
	      int len = 12;
	      String code = "";
			while(code.length()<len){
				code+=(int)(Math.random()*10);
			}
	      long thirdId = Long.parseLong(code);
	      map.put("thirdId", thirdId);
	     
	      String phone = info.getPhone();
	      String messageContentDes = null;
	      String phoneDes = null;
	      try {
	         messageContentDes = DES.encryptDES(info.getCode()+"模型作业，请知悉。[存量运营数据分析平台]", key);
	         phoneDes = DES.encryptDES(phone,key);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      map.put("phone", phoneDes);
	      map.put("messageContent", messageContentDes);
	      String date = DateUtils.getDateString(new Date());
	      map.put("date", date);
	      String channel = "100008";
	      map.put("channel", channel);
	      String sign = MD5Secret.MD5(thirdId+phoneDes+messageContentDes+date+channel+key);
	      map.put("sign", sign);
	      String param = JSONObject.fromObject(map).toString();

	    res = HttpClientUtils.httpJson(param,"http://super.wo.cn/sms/smsSend");
		
		return res;
	}

	@Override
	public Msg findmsgByMobile(String mobile) throws Exception{
		// TODO Auto-generated method stub
		return msgDao.findmsgByMobile(mobile);
	}

	@Override
	public void sendmsgByMobile(String mobile) throws Exception{
		// TODO Auto-generated method stub
		
	}

	@Override
	public Msg findLastMsgByMobile(String mobile) throws Exception{
		// TODO Auto-generated method stub
		return msgDao.findLastMsgByMobile(mobile);
	}

	@Override
	public Msg addMsg(Msg msg) throws Exception{
		// TODO Auto-generated method stub
		return msgDao.addMsg(msg);
	}

	@Override
	public int findMsgNo(String mobile) throws Exception{
		// TODO Auto-generated method stub
		return msgDao.findMsgNo(mobile);
	}
	
}
