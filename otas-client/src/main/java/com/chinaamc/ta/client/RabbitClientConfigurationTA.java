package com.chinaamc.ta.client;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.rabbit.stocks.config.AbstractStockAppRabbitConfiguration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitClientConfigurationTA extends AbstractStockAppRabbitConfiguration  {

	@Value("${stocks.quote.pattern1}")
	private String marketDataRoutingKey;
	
	@Override
	protected void configureRabbitTemplate(RabbitTemplate template) {
		// TODO Auto-generated method stub
		
		
	}
	
	

}
