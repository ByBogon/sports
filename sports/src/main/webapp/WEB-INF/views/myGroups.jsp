<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>내 모임</title>
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css">
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
		
</head>
<body>
	<div class="ui page grid">
	<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="ui center aligned container" style="margin-top: 30px">
			<div class="ui container">
				<div>
					<h2 class="ui center aligned icon header">
						<i class="circular users icon"></i>
						Groups
					</h2>
				</div>
			</div>
			<div class="ui container">
				<c:if test="${list != null}">
				<div class="ui three stackable cards">
					<c:forEach var="vo" items="${list}">
						<div class="ui link card">
							<input type="hidden" class="grp_no" value="${vo.grp_no}"/>
							<div class="image">
	                    		<img src="${vo.grp_mainimg}" onerror="this.src='resources/images/molly.png'"/>
	                    	</div>
							<div class="content">
								<div class="header">${vo.grp_name}</div>
								<div class="meta right floated">모임장: ${vo.grp_leader}</div>
							</div>
							<div class="description">${vo.grp_detail}</div>
							<div class="extra content">
								<span class="right floated">${vo.grp_date}</span>
								<span class="left floated"><i class="users icon"></i>${vo.cnt} Members</span>	
							</div>
							
							<div class="content">
								<c:set var="cname" value="${vo.center_name}"/>
                       			${fn:substring(cname, 0, 20)}
                       			<c:if test="${fn:length(cname) gt 20}">
                       			...
                       			</c:if>
							</div>
						</div>
					</c:forEach>
					
				</div>
				</c:if>
					<c:if test="${list == null}">
						<label>활동중인 모임이 없습니다</label>
						<a href="open_group.do" class="ui blue button">모임 만들기</a>
					</c:if>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			
			$('.cards').on('click', '.card', function() {
				var idx = $(this).index();
				console.log(idx);
				var grp_no = $('.grp_no').eq(idx).val();
				window.location = "group_content.do?grp_no="+grp_no;
				/* 
				var dropdown = $('.right.meta > .ui.dropdown').eq(idx);
				console.log(dropdown);
				$(dropdown).dropdown('show');
				 */
			});
			 
		})
	</script>
</body>
</html>
