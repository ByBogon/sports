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
		<div>
			<div>
				<input type="text" class="form-inline" placeholder="검색"/>
			</div>
			<div id="map" style="width:50%; height:400px; margin: auto">
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6377ffb61ec73a41b33914a1add294a0&libraries=services,clusterer"></script>
    <script>
    $(function() {

    	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
        	center: new daum.maps.LatLng(35.139073, 129.100735), //지도의 중심좌표.
        	level: 3 //지도의 레벨(확대, 축소 정도)
        };
        //35.139073, 129.100735
        var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
        var coords = new daum.maps.LatLng(35.139073, 129.100735);
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });
        map.setCenter(coords);
    	var clusterer = new daum.maps.MarkerClusterer({
    	    map: map,
    	    markers: markers,
    	    gridSize: 35,
    	    averageCenter: true,
    	    minLevel: 6,
    	    disableClickZoom: true,
    	    styles: [{
    	        width : '53px', height : '52px',
    	        background: 'url(cluster.png) no-repeat',
    	        color: '#fff',
    	        textAlign: 'center',
    	        lineHeight: '54px'
    	    }]
    	});
        $.get
       
        
        //var markers = [];

    })
    
    </script>

</body>
</html>
