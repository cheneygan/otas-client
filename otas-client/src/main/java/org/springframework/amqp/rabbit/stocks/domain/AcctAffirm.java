package org.springframework.amqp.rabbit.stocks.domain;

public class AcctAffirm {
	private String affirmSeqNo;
	private String acctId;
	private String cardNo;
	private String name;
	private String trustSeqNo;
	private String errorId;
	
	public String getAffirmSeqNo() {
		return affirmSeqNo;
	}
	public void setAffirmSeqNo(String affirmSeqNo) {
		this.affirmSeqNo = affirmSeqNo;
	}
	public String getAcctId() {
		return acctId;
	}
	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTrustSeqNo() {
		return trustSeqNo;
	}
	public void setTrustSeqNo(String trustSeqNo) {
		this.trustSeqNo = trustSeqNo;
	}
	public String getErrorId() {
		return errorId;
	}
	public void setErrorId(String errorId) {
		this.errorId = errorId;
	}
	
	
}
