<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<meta charset="utf-8">
	<title>스쿼시</title>
    <meta name=viewport content="width=device-width, initial-scale=1">
    <meta name="mobile-web-app-capable" content="yes">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css?ver=1">
	<!-- jQuery and Bootstrap -->
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
					<img src="resources/images/squash.jpg" style="margin:auto; width: 100%; height: 70%" />
				</div>
			</div>
		</div>
		<div class="row">
			<!-- 후원사 로고 -->
			<div class="column padding-reset">	
		        <div class="container text-center">
		            <img src="resources/images/client-logos.png" alt="client logos" class="img-fluid">
		        </div>
			</div>
		</div>
		<div class="row">
		    <div class="column padding-reset">
		        <div class="container">
		            <div class="section-title">
		                <h3>이번주 우수 모임</h3>
		            </div>
		            <div class="ui three stackable link cards">
	                    <div class="card">
	                    	<div class="image">
	                    		<img src="resources/images/1.jpg" alt="resources/images/default.png"/>
	                    	</div>
	                    	<div class="content">
	                        	<div class="header">
	                        		모임명
	                        		<span class="right floated">장소</span>
	                        	</div>
	                            <div class="meta">주최자</div>
	                            <div class="description">모임 설명</div>
							</div>
						</div>
		                <div class="card">
	                    	<div class="image">
	                    		<img src="resources/images/1.jpg" alt="resources/images/default.png"/>
	                    	</div>
	                    	<div class="content">
	                        	<div class="header">
	                        		모임명
	                        		<span class="right floated">장소</span>
	                        	</div>
	                            <div class="meta">주최자</div>
	                            <div class="description">모임 설명</div>
							</div>
						</div>
		                <div class="card">
	                    	<div class="image">
	                    		<img src="resources/images/1.jpg" alt="resources/images/default.png"/>
	                    	</div>
	                    	<div class="content">
	                        	<div class="header">
	                        		모임명
	                        		<span class="right floated">장소</span>
	                        	</div>
	                            <div class="meta">주최자</div>
	                            <div class="description">모임 설명</div>
							</div>
						</div>
		            </div>
		        </div>
		    </div>
		</div>
		    <!-- // end .section -->
		 <div class="row">
		    <div class="column padding-reset">
		        <div class="container">
		            <div class="section-title">
		                <h3>신규 모임</h3>
		            </div>
		            <div class="ui three stackable link cards">
	                    <div class="card">
	                    	<div class="image">
	                    		<img src="resources/images/1.jpg" alt="resources/images/default.png"/>
	                    	</div>
	                    	<div class="content">
	                        	<div class="header">
	                        		모임명
	                        		<span class="right floated">장소</span>
	                        	</div>
	                            <div class="meta">주최자</div>
	                            <div class="description">모임 설명</div>
							</div>
						</div>
		                <div class="card">
	                    	<div class="image">
	                    		<img src="resources/images/1.jpg" alt="resources/images/default.png"/>
	                    	</div>
	                    	<div class="content">
	                        	<div class="header">
	                        		모임명
	                        		<span class="right floated">장소</span>
	                        	</div>
	                            <div class="meta">주최자</div>
	                            <div class="description">모임 설명</div>
							</div>
						</div>
		                <div class="card">
	                    	<div class="image">
	                    		<img src="resources/images/1.jpg" alt="resources/images/default.png"/>
	                    	</div>
	                    	<div class="content">
	                        	<div class="header">
	                        		모임명
	                        		<span class="right floated">장소</span>
	                        	</div>
	                            <div class="meta">주최자</div>
	                            <div class="description">모임 설명</div>
							</div>
						</div>
		            </div>
		        </div>
		    </div>
		</div>
		    <!-- // end .section -->
	
	</div>
		
    <script>
		$(function() {
			$('.ui.dropdown').dropdown();
			
		})
	
	</script>

</body>
</html>
