<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>${vo.grp_name}</title>
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
		<div class="ui container" style="margin-top: 30px">
			<div class="ui centered card">
				<div class="ui slide masked reveal image">
					
					<c:if test="${vo.grp_mainimg == null}">
						<img class="visible content" src="resources/images/jenny.jpg">
					</c:if>
					<c:if test="${vo.grp_mainimg != null}">
						<img class="visible content" src="${vo.grp_mainimg}">
					</c:if>
					<div id="map2" class="hidden content" style="width: 200px; height:310px; 
						max-height: 100%; min-width: 100%; margin:auto;"></div>
				</div>
				<div class="content">
					<div class="header">${vo.grp_name}</div>
					<div class="meta right floated">${vo.grp_leader}</div>
				</div>
			
			</div>
		
		</div>
		
	</div>
</body>
</html>
