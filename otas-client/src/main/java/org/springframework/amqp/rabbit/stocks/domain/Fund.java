package org.springframework.amqp.rabbit.stocks.domain;

public class Fund {
	private String fundId;

	public String getFundId() {
		return fundId;
	}

	public void setFundId(String fundId) {
		this.fundId = fundId;
	}

	public Fund(String fundId) {
		super();
		this.fundId = fundId;
	}
	

}
