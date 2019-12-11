package com.chinauicom.research.stockmanagement.bi.sms.entity;

import java.util.Date;

import com.chinauicom.research.commons.utils.BaseVO;

public class Msg extends BaseVO {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;

	private String tel;

    private String time;

    private String code;   //code

    private String validFlag;
    
    private String createdBy;
    
    private Date createdTs;
    
    private String comments;
    
    
    
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Date getCreatedTs() {
		return createdTs;
	}

	public void setCreatedTs(Date createdTs) {
		this.createdTs = createdTs;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time == null ? null : time.trim();
    }

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(String validFlag) {
		this.validFlag = validFlag;
	}

}