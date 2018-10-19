<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<html>
<head>
	<meta charset="utf-8">
	<title>스쿼시</title>
    <meta name=viewport content="width=device-width, initial-scale=1">
    <meta name="mobile-web-app-capable" content="yes">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
    
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css?ver=1">
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
</head>

<body>
	<div class="ui page grid">
	<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="row">
			<div class="column padding-reset">
				<div class="container">
					<img src="resources/images/squash.jpg" class="ui fluid image" style="margin:auto; width: 100%; height: 70%" />
				</div>
			</div>
		</div>
		<div class="row">
			<!-- 후원사 로고 -->
			<div class="column padding-reset">	
		        <div class="container">
		            <img src="resources/images/client-logos.png" class="ui fluid image" alt="client logos" style="margin:auto;">
		        </div>
			</div>
		</div>
		<div class="row">
		    <div class="column padding-reset">
		        <div class="container">
		            <div class="section-title" style="margin-bottom: 10px">
		                <label>이번주 우수 모임</label>
		            </div>
		            <div class="ui three stackable link cards bestGrpCards">
		            	<c:forEach items="${bestList}" var="vo">
			            	<div class="ui card">
		                    	<div class="image">
		                    		<img src="${vo.grp_mainimg}" onerror="this.src='resources/images/matthew.png'"/>
		                    	</div>
		                    	<div class="center aligned content">
		                    		<input type="hidden" class="grp_no" value="${vo.grp_no}"/>
		                        	<div class="header">${vo.grp_name}</div>
		                            <div class="meta">${vo.mem_name}</div>
		                            <div class="description">${vo.grp_detail}</div>
								</div>
								<div class="extra content">
									<span class="right floated">${vo.grp_date}</span>
									<span class="left floated"><i class="users icon"></i>${vo.cnt} Members</span>	
								</div>
								<div class="center aligned content">
									<c:set var="cname" value="${vo.center_name}"/>
	                       			${fn:substring(cname, 0, 25)}
	                       			<c:if test="${fn:length(cname) gt 25}">
	                       			...
	                       			</c:if>
								</div>
							</div>
		            	</c:forEach>
		            </div>
		        </div>
		    </div>
		</div>
		    <!-- // end .section -->
		 <div class="row">
		    <div class="column padding-reset">
		        <div class="container">
		            <div class="section-title" style="margin-bottom: 10px">
		                <label>신규 모임</label>
		            </div>
		            <div class="ui three stackable link cards newestGrpCards">
		            	<c:forEach items="${list}" var="vo">
			            	<div class="ui card">
		                    	<div class="image">
		                    		<img class="ui fluid image" src="${vo.grp_mainimg}" onerror="this.src='resources/images/matthew.png'"/>
		                    	</div>
		                    	<div class="center aligned content">
		                    		<input type="hidden" class="grp_no" value="${vo.grp_no}"/>
		                        	<div class="header">${vo.grp_name}</div>
		                            <div class="meta">${vo.mem_name}</div>
		                            <div class="description">${vo.grp_detail}</div>
								</div>
								<div class="extra content">
									<span class="right floated">${vo.grp_date}</span>
									<span class="left floated"><i class="users icon"></i>${vo.cnt} Members</span>	
								</div>
								<div class="center aligned content">
									<c:set var="cname" value="${vo.center_name}"/>
	                       			${fn:substring(cname, 0, 25)}
	                       			<c:if test="${fn:length(cname) gt 25}">
	                       			...
	                       			</c:if>
								</div>
							</div>
		            	</c:forEach>
		            </div>
		        </div>
		    </div>
		</div>
		    <!-- // end .section -->
	
	</div>
		
    <script>
		$(function() {
			$('.ui.dropdown').dropdown();
			
			$('.card').on('click', function() {
				var idx = $(this).index('.card');
				console.log(idx);
				var grp_no = $('.card > .content > .grp_no').eq(idx).val();
				console.log(grp_no);
				window.location = "group_content.do?grp_no="+grp_no;
			})
			
		})
	
	</script>

</body>
</html>
