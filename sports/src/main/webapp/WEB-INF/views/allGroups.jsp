<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>모임들</title>
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
						모임 찾기
					</h2>
				</div>
			</div>
			<div class="ui fluid search" style="margin: 20px">
				<div class="ui icon input">
					<input class="prompt" type="text" placeholder="Common passwords...">
						<i class="search icon"></i>
				</div>
				<div class="results"></div>
			</div>
			<div class="ui container">
				<c:if test="${list != null}">
				<div class="ui three stackable special cards">
					<c:forEach var="vo" items="${list}">
						<div class="ui link card">
							<div class="blurring dimmable image">
								<div class="ui dimmer">
									<div class="content">
										<div class="center">
											<div class="ui inverted button">참가하기</div>
										</div>
									</div>
								</div>
	                    		<img src="${vo.grp_mainimg}" onerror="this.src='resources/images/molly.png'"/>
							</div>
							<div class="content">
								<div class="header">${vo.grp_name}</div>
								<div class="meta">${vo.grp_leader}</div>
							</div>
							<div class="description">${vo.grp_detail}</div>
							<div class="extra content">
								<span class="right floated">${vo.grp_date}</span>
								<span class="left floated"><i class="users icon"></i>${vo.cnt} Members</span>	
							</div>
							<div class="content">
								<c:set var="cname" value="${vo.center_name}"/>
                       			${fn:substring(cname, 0, 25)}
                       			<c:if test="${fn:length(cname) gt 25}">
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
		var list = new Array();
		<c:forEach items="${list}" var="vo">
			var vo = new Object();
			vo.grp_no = ${vo.grp_no};
			list.push(JSON.stringify(vo));
			console.log(vo);
		</c:forEach>

		console.log(list);
		$(function() {
			$('.cards').on('click', '.card', function() {
				var idx = $(this).index();
				var grp_no = JSON.parse(list[idx]).grp_no;
				console.log(idx);
				console.log(grp_no);
				window.location.href = "group_content.do?grp_no="+grp_no+"";
			})
			
			$('.ui.dropdown').dropdown();
			$('.tag.example .ui.dropdown').dropdown({
				allowAdditions: true
			});
			$('.special.cards .image').dimmer({
				  on: 'hover'
			});
		})
	
	</script>
</body>
</html>
