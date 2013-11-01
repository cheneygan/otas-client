package org.springframework.amqp.rabbit.stocks.domain;

public class Account {
	private String name;
	private String cardType;
	private String cardNo;
	private String acctType;
	private String address;
	private String mobile;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getAcctType() {
		return acctType;
	}
	public void setAcctType(String acctType) {
		this.acctType = acctType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Account(String name, String cardType, String cardNo,
			String acctType, String address, String mobile) {
		super();
		this.name = name;
		this.cardType = cardType;
		this.cardNo = cardNo;
		this.acctType = acctType;
		this.address = address;
		this.mobile = mobile;
	}
	@Override
	public String toString() {
		return "Account [name=" + name + ", cardType=" + cardType + ", cardNo="
				+ cardNo + ", acctType=" + acctType + ", address=" + address
				+ ", mobile=" + mobile + "]";
	}
	
	

}
