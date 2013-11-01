<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>OTAS Demo</title>
<link rel="stylesheet" href="static/css/main.css" type="text/css"></link>
<link rel="stylesheet" href="static/css/colors.css" type="text/css"></link>
<link rel="stylesheet" href="static/css/local.css" type="text/css"></link>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="static/js/jquery.mustache.js"></script>
<script type="text/javascript">
	var running = false;
	var timer;
	var debug = false;
	var lastquote = 0;
	var lasttrades = {};
	var template = "{{#quotes}}<tr>\
		<td>{{timeString}}</td>\
		<td>{{#stock}}{{ticker}}{{/stock}}</td>\
		<td>{{price}}</td>\
	</tr>{{/quotes}}";
	var confirmation = "{{#response}}Trade Confirmation: <ul>\
		<li>Id: {{confirmationNumber}}</li>\
		<li>Quantity: {{quantity}}</li>\
		<li>Ticker: {{ticker}}</li>\
		<li>Price: {{price}}</li>\
	</ul>{{/response}}";
	function load() {
		if (running) {
			$('#status').text("Waiting...")
			$.ajax({
				url : "quotes?timestamp=" + lastquote,
				success : function(message) {
					$('#status').text("Updating")
					if (debug) {
						$('#debug').text(JSON.stringify(message))
					}
					if (message && message.length) {
						lastquote = message[0].timestamp;
						$('#lastquote').prepend($.mustache(template, {
							quotes : message
						}));
					}
					timer = poll();
				},
				error : function() {
					$('#status').text("Failed")
					timer = poll();
				},
				cache : false
			})
		} else {
			$('#status').text("Stopped")
		}
	}
	function start() {
		if (!running) {
			running = true;
			if (timer != null) {
				clearTimeout(timer);
			}
			timer = poll();
		}
	}
	function clear() {
		$('#lastquote').html('')
	}
	function stop() {
		$('#status').text("Stopped")
		if (running && timer != null) {
			clearTimeout(timer);
		}
		running = false;
	}
	function poll() {
		if (timer != null) {
			clearTimeout(timer);
		}
		return setTimeout(load, 1000);
	}
	function confirm(id) {
		if (lasttrades.id) {
			clearTimeout(lasttrades.id);
			delete lasttrades.id;
		}
		$.get("trade?requestId=" + id, function(response) {
			if (response && response.requestId) {
				$('#messages').html($.mustache(confirmation, {
					response : response
				}));
				delete lasttrades.id;
			} else {
				lasttrades.id = setTimeout("confirm('" + id + "')", 2000);
			}
		});
	}
	$(function() {
		$.ajaxSetup({cache:false});
		$('#start').click(start);
		$('#stop').click(stop);
		$('#clear').click(clear);
		start();
		$('#tradeForm')
				.submit(
						function() {
							$
									.post(
											$('#tradeForm').attr("action"),
											$('#tradeForm').serialize(),
											function(request) {
												var message = "Processing...";
												if (request && request.ticker) {
													confirm(request.id);
												} else {
													message = "The trade request was invalid.  Please provide a quantity and a stock ticker.";
												}
												$('#messages').text(message);
											});
							return false;
						});
	});
</script>
</head>
<body>
	<div id="page">
		<div id="header">
			<div id="name-and-company">
				<div id='site-name'>
					<a href="" title="Site Name" rel="home"> 欧塔斯 
						Demo</a>
				</div>
				<div id='company-name'>
					<a href="http://www.springsource.org/spring-amqp"
						title="Spring AMQP"> OTAS Home</a>
				</div>
			</div>
			<!-- /name-and-company -->
		</div>
		<!-- /header -->
		<div id="container">
			<div id="content" class="no-side-nav">
				This application is a the "stocks" sample from <a
					href="http://github.com/SpringSource/spring-amqp">Spring AMQP</a>.
				You can get the source code from the <a
					href="http://github.com/SpringSource/spring-amqp-samples">Spring
					AMQP Samples</a> project on Github.
					<br /><br />
					<div id='openAccount'>
					<a href="account.jsp"
						title="account"> 开户</a>
				     </div>
				
				     <div id='redem'>
					<a href="redem.jsp"
						title="Redem"> 取现</a>
				<h1>Deal</h1>
				<c:choose>
					<c:when test="trade!=null">
						<c:set var="quantity" value="${trade.quantity}" />
						<c:set var="ticker" value="${trade.ticker}" />
					</c:when>
					<c:otherwise>
						<c:set var="quantity" value="0" />
						<c:set var="ticker" value="" />
					</c:otherwise>
				</c:choose>
				<form id="tradeForm" method="post" action="trade">
					<ol>
							
							<li><label for="ticker">基金账号</label><input id="acctId"
							type="text" name="name" value="${name}" /></li>
							
							<li><label for="ticker">基金代码</label><input id="fundId"
							type="text" name="cardType" value="${cardType}" /></li>
							
							<li><label for="ticker">存入金额</label><input id="purchMoney"
							type="text" name="purchMoney" value="${purchMoney}" /></li>
							
							<li><label for="ticker">校验码</label><input id="checkNo"
							type="text" name="checkNo" value="${checkNo}" /></li>
													
						<li><input type="submit" name="tradePurch" value="存入" />
						</li>
					</ol>
				</form>
				<div id="messages">
					<form:errors path="*" cssClass="errors" />
				</div>
				<div id="debug"></div>
			</div>
		</div>
	</div>
</body>
</html>