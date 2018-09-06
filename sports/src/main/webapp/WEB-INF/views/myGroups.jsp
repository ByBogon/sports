<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>내 모임</title>
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css">
	<!-- jQuery and Bootstrap -->
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
							<div class="content">
								<div class="right floated meta">
									<div class="ui left pointing dropdown">
										<input type="hidden" name="">
										<i class="dropdown icon"></i>
										<div class="menu">
											<div class="item" data-value="view">그룹 정보</div>
											<div class="item" data-value="mems">그룹 멤버</div>
											<div class="item" data-value="edit">그룹 수정</div>
											<div class="item" data-value="delete">그룹 삭제</div>
										</div>
									</div>
								</div>
							</div>
							<div class="image">
								<img src="resources/images/molly.png">
							</div>
							<div class="content">
								<div class="header">${vo.grp_name}</div>
								<div class="meta">${vo.grp_leader}</div>
							</div>
							<div class="description"></div>
							<div class="extra content">
								<span class="right floated">Opened in ${vo.grp_date}</span>
								<span class="left floated"><i class="users icon"></i>${vo.cnt} Members</span>	
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
			$('.ui.dropdown').dropdown();
		})
	
	</script>
</body>
</html>
