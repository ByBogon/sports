<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>스쿼시</title>
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    
	<!-- jQuery and Bootstrap -->
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	
</head>
<body>
	<jsp:include page="nav_main.jsp"></jsp:include>

	<div>
		<div>
			<div>
				<img src="resources/images/squash.jpg" style="width: 100%; height: 70%" />
			</div>
		</div>
	</div>

    
	<!-- 후원사 로고 -->
    <div class="client-logos my-5">
        <div class="container text-center">
            <img src="resources/images/client-logos.png" alt="client logos" class="img-fluid">
        </div>
    </div>

    <div class="section light-bg" id="features" style="margin-bottom: 20px">
        <div class="container">
            <div class="section-title">
                <h3>이번주 우수 모임</h3>
            </div>
            <div class="row">
                <div class="col-12 col-lg-4">
                    <div class="card features" style="max-height: 385px">
                    	<img class="card-img-top" src="resources/images/1.jpg" alt="resources/images/default.png"/>
                        <div class="card-body">
                        	<div style="margin:20px; text-align:right">
                       			날짜
                        	</div>
                            <div class="media">
                            	<div style="margin-left: 20px; margin-right: 20px">
                            		<div class="media-body">
                            			
                                    	<h4 class="card-title">모임명</h4>
                                    	<p class="card-text">모임설명</p>
                                	</div>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="card features" style="max-height: 385px">
                    	<img class="card-img-top" src="resources/images/고양이.jpg" alt="resources/images/default.png"/>
                        <div class="card-body">
                            <div class="media">
                            	<div style="margin-left: 20px; margin-right: 20px">
                            		<div class="media-body">
                                    	<h4 class="card-title">Simple</h4>
                                    	<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque </p>
                                	</div>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="card features" style="max-height: 385px">
                    	<img class="card-img-top" src="resources/images/2.jpg" alt="resources/images/default.png"/>
                        <div class="card-body">
                            <div class="media">
                            	<div style="margin-left: 20px; margin-right: 20px">
                            		<div class="media-body">
                                    	<h4 class="card-title">Simple</h4>
                                    	<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque </p>
                                	</div>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // end .section -->
    <div class="section dark-bg" id="features">
        <div class="container">
            <div class="section-title">
                <h3>신규 모임</h3>
            </div>
            <div class="row">
                <div class="col-12 col-lg-4">
                    <div class="card features" style="max-height: 385px">
                    	<img class="card-img-top" src="resources/images/1.jpg" alt="resources/images/default.png"/>
                        <div class="card-body">
                        	<div style="margin:20px; text-align:right">
                       			날짜
                        	</div>
                            <div class="media">
                            	<div style="margin-left: 20px; margin-right: 20px">
                            		<div class="media-body">
                            			
                                    	<h4 class="card-title">모임명</h4>
                                    	<p class="card-text">모임설명</p>
                                	</div>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="card features" style="max-height: 385px">
                    	<img class="card-img-top" src="resources/images/고양이.jpg" alt="resources/images/default.png"/>
                        <div class="card-body">
                            <div class="media">
                            	<div style="margin-left: 20px; margin-right: 20px">
                            		<div class="media-body">
                                    	<h4 class="card-title">Simple</h4>
                                    	<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque </p>
                                	</div>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="card features" style="max-height: 385px">
                    	<img class="card-img-top" src="resources/images/2.jpg" alt="resources/images/default.png"/>
                        <div class="card-body">
                            <div class="media">
                            	<div style="margin-left: 20px; margin-right: 20px">
                            		<div class="media-body">
                                    	<h4 class="card-title">Simple</h4>
                                    	<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque </p>
                                	</div>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // end .section -->

    <div class="light-bg py-5" id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 text-center text-lg-left">
                    <p class="mb-2"> <span class="ti-location-pin mr-2"></span> 1485 Pacific St, Brooklyn, NY 11216 USA</p>
                    <div class=" d-block d-sm-inline-block">
                        <p class="mb-2">
                            <span class="ti-email mr-2"></span> <a class="mr-4" href="/cdn-cgi/l/email-protection#cdbeb8bdbda2bfb98da0a2afa4a1a8acbdbde3aea2a0"><span class="__cf_email__" data-cfemail="ccbfb9bcbca3beb88ca1a3aea5a0a9adbcbce2afa3a1">[email&#160;protected]</span></a>
                        </p>
                    </div>
                    <div class="d-block d-sm-inline-block">
                        <p class="mb-0">
                            <span class="ti-headphone-alt mr-2"></span> <a href="tel:51836362800">518-3636-2800</a>
                        </p>
                    </div>

                </div>
                <div class="col-lg-6">
                    <div class="social-icons">
                        <a href="#"><span class="ti-facebook"></span></a>
                        <a href="#"><span class="ti-twitter-alt"></span></a>
                        <a href="#"><span class="ti-instagram"></span></a>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <script type="text/javascript">
 
    
    </script>

</body>
</html>
