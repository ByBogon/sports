<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    
	<!-- jQuery and Bootstrap -->
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	
</head>
<body>
	<jsp:include page="nav_main.jsp"></jsp:include>

	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<a href="squash.do"><img class="d-block w-100" src="resources/images/squash.jpg"
					alt="First slide" style="width: 100%; height: 70%"></a>
				<div class="carousel-caption d-none d-md-block">
					<h3>스쿼시</h3>
					<p>스쿼시 설명</p>
				</div>

			</div>
			<div class="carousel-item">
				<a href="basketball.do"><img class="d-block w-100" src="resources/images/basketball.jpg"
					alt="Second slide" style="width: 100%; height: 70%"></a>
				<div class="carousel-caption d-none d-md-block">
					<h3>농구</h3>
					<p>농구 설명</p>
				</div>
			</div>
			<div class="carousel-item">
				<a href="tennis.do"><img class="d-block w-100" src="resources/images/tennis.jpg"
					alt="Third slide" style="width: 100%; height: 70%"></a>
				<div class="carousel-caption d-none d-md-block">
					<h3>테니스</h3>
					<p>테니스 설명</p>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
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


    <div class="section light-bg">
        <div class="container">
            <div class="section-title">
                <small>FEATURES</small>
                <h3>Do more with our app</h3>
            </div>

            <ul class="nav nav-tabs nav-justified" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#communication">Communication</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#schedule">Scheduling</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#messages">Messages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#livechat">Live Chat</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="communication">
                    <div class="d-flex flex-column flex-lg-row">
                        <img src="resources/images/graphic.png" alt="graphic" class="img-fluid rounded align-self-start mr-lg-5 mb-5 mb-lg-0">
                        <div>

                            <h2>Communicate with ease</h2>
                            <p class="lead">Uniquely underwhelm premium outsourcing with proactive leadership skills. </p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium, nisi nisi fermentum enim, et sagittis dolor nulla vel sapien. Vestibulum sit amet mattis ante. Ut placerat dui eu nulla
                                congue tincidunt ac a nibh. Mauris accumsan pulvinar lorem placerat volutpat. Praesent quis facilisis elit. Sed condimentum neque quis ex porttitor,
                            </p>
                            <p> malesuada faucibus augue aliquet. Sed elit est, eleifend sed dapibus a, semper a eros. Vestibulum blandit vulputate pharetra. Phasellus lobortis leo a nisl euismod, eu faucibus justo sollicitudin. Mauris consectetur, tortor
                                sed tempor malesuada, sem nunc porta augue, in dictum arcu tortor id turpis. Proin aliquet vulputate aliquam.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="schedule">
                    <div class="d-flex flex-column flex-lg-row">
                        <div>
                            <h2>Scheduling when you want</h2>
                            <p class="lead">Uniquely underwhelm premium outsourcing with proactive leadership skills. </p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium, nisi nisi fermentum enim, et sagittis dolor nulla vel sapien. Vestibulum sit amet mattis ante. Ut placerat dui eu nulla
                                congue tincidunt ac a nibh. Mauris accumsan pulvinar lorem placerat volutpat. Praesent quis facilisis elit. Sed condimentum neque quis ex porttitor,
                            </p>
                        </div>
                        <img src="resources/images/graphic.png" alt="graphic" class="img-fluid rounded align-self-start mr-lg-5 mb-5 mb-lg-0">
                    </div>
                </div>
                <div class="tab-pane fade" id="messages">
                    <div class="d-flex flex-column flex-lg-row">
                        <img src="resources/images/graphic.png" alt="graphic" class="img-fluid rounded align-self-start mr-lg-5 mb-5 mb-lg-0">
                        <div>
                            <h2>Realtime Messaging service</h2>
                            <p class="lead">Uniquely underwhelm premium outsourcing with proactive leadership skills. </p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium, nisi nisi fermentum enim, et sagittis dolor nulla vel sapien. Vestibulum sit amet mattis ante. Ut placerat dui eu nulla
                                congue tincidunt ac a nibh. Mauris accumsan pulvinar lorem placerat volutpat. Praesent quis facilisis elit. Sed condimentum neque quis ex porttitor,
                            </p>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="livechat">
                    <div class="d-flex flex-column flex-lg-row">
                        <div>
                            <h2>Live chat when you needed</h2>
                            <p class="lead">Uniquely underwhelm premium outsourcing with proactive leadership skills. </p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium, nisi nisi fermentum enim, et sagittis dolor nulla vel sapien. Vestibulum sit amet mattis ante. Ut placerat dui eu nulla
                                congue tincidunt ac a nibh. Mauris accumsan pulvinar lorem placerat volutpat. Praesent quis facilisis elit. Sed condimentum neque quis ex porttitor,
                            </p>
                        </div>
                        <img src="resources/images/graphic.png" alt="graphic" class="img-fluid rounded align-self-start mr-lg-5 mb-5 mb-lg-0">
                    </div>
                </div>
            </div>


        </div>
    </div>
    <!-- // end .section -->

    <div class="section">

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <img src="resources/images/dualphone.png" alt="dual phone" class="img-fluid">
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div>
                        <div class="box-icon"><span class="ti-rocket gradient-fill ti-3x"></span></div>
                        <h2>Launch your App</h2>
                        <p class="mb-4">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Obcaecati vel exercitationem eveniet vero maxime ratione </p>
                        <a href="#" class="btn btn-primary">Read more</a></div>
                </div>
            </div>

        </div>

    </div>
    <!-- // end .section -->


    <div class="section light-bg">

        <div class="container">
            <div class="row">
                <div class="col-md-8 d-flex align-items-center">
                    <ul class="list-unstyled ui-steps">
                        <li class="media">
                            <div class="circle-icon mr-4">1</div>
                            <div class="media-body">
                                <h5>Create an Account</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium obcaecati vel exercitationem </p>
                            </div>
                        </li>
                        <li class="media my-4">
                            <div class="circle-icon mr-4">2</div>
                            <div class="media-body">
                                <h5>Share with friends</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium obcaecati vel exercitationem eveniet</p>
                            </div>
                        </li>
                        <li class="media">
                            <div class="circle-icon mr-4">3</div>
                            <div class="media-body">
                                <h5>Enjoy your life</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer rutrum, urna eu pellentesque pretium obcaecati vel exercitationem </p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <img src="resources/images/iphonex.png" alt="iphone" class="img-fluid">
                </div>

            </div>

        </div>

    </div>
    <!-- // end .section -->





    <div class="section bg-gradient">
        <div class="container">
            <div class="call-to-action">

                <div class="box-icon"><span class="ti-mobile gradient-fill ti-3x"></span></div>
                <h2>Download Anywhere</h2>
                <p class="tagline">Available for all major mobile and desktop platforms. Rapidiously visualize optimal ROI rather than enterprise-wide methods of empowerment. </p>
                <div class="my-4">

                    <a href="#" class="btn btn-light"><img src="resources/images/appleicon.png" alt="icon"> App Store</a>
                    <a href="#" class="btn btn-light"><img src="resources/images/playicon.png" alt="icon"> Google play</a>
                </div>
                <p class="text-primary"><small><i>*Works on iOS 10.0.5+, Android Kitkat and above. </i></small></p>
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
    	$('.carousel').carousel({
    		interval: 5000
    	});
		/* // Activate Carousel
	    $("#myCarousel").carousel();
	
	    // Enable Carousel Indicators
	    $(".item").click(function(){
	        $("#myCarousel").carousel(1);
	    });
	
	    // Enable Carousel Controls
	    $(".carousel-control-prev").click(function(){
	        $("#myCarousel").carousel("prev");
	    }); */
    
    </script>

</body>
</html>
