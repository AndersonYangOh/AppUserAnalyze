package com.chinauicom.research.stockmanagement.bi.sms.dao;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitterReturnValueHandler;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.stockmanagement.bi.report.entity.CustomerNumVo;
import com.chinauicom.research.stockmanagement.bi.sms.entity.Msg;
import com.chinauicom.research.stockmanagement.bi.system.operator.entity.SysOperator;

@Repository
public class MsgDao extends BaseDao {
	
	
	public Msg findmsgByMobile(String mobile) throws Exception{
		return (Msg) getSqlSession().selectOne("Msg.findmsgByMobile", mobile);
	}

	public void sendmsgByMobile(String mobile) throws Exception{
		// TODO Auto-generated method stub
		
	}

	public Msg findLastMsgByMobile(String mobile) throws Exception{
		return (Msg) getSqlSession().selectOne("Msg.findLastMsgByMobile", mobile);
	}

	public Msg addMsg(Msg msg)throws Exception {
		 if(msg == null) return null;
		return (Msg)insert("Msg.insert", msg);
	}

	public int findMsgNo(String mobile) throws Exception{
		int msgNo = (int) getSqlSession().selectOne("Msg.findMsgNo",mobile);
		return msgNo;
	}
	
	
}
