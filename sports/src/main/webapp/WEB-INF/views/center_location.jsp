<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<meta charset="utf-8">
	<title>센터찾기</title>
    <meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	
    <link rel="shortcut icon" href="resources/images/favicon.ico">
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css?ver=1">
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6377ffb61ec73a41b33914a1add294a0&libraries=services,clusterer"></script>
    
</head>
<body>
	<div class="ui page grid">
		<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="row">
			<div class="column padding-reset">
				<div class="container">
					<img src="resources/images/squash.jpg" style="width: 100%; height: 70%" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column padding-reset">
				<div class="container" style="margin-top: 20px">
					<div class="ui center aligned fluid container" style="margin:auto;">
						<div class="ui input action" style="width:100%">
							<input type="text" id="txt_search" placeholder="센터명, 센터지역, 센터주소 검색"/>
							<input type="button" class="ui secondary button" id="btn_search" value="검색"/>
						</div>
						<div id="map" class="fluid" style="width:100%; height:400px; margin: auto">
						</div>
					</div>
					<jsp:include page="center_location_context.jsp"></jsp:include>
				</div>
			</div>
		</div>
		
	</div>
    <script>
    $(function() {
    	$(document).on('click', '.tr', function() {
    		console.log("clicked!");
    		var idx = $(this).index('.tr');
    		var addr = $('.addr').eq(idx).text();
    		console.log(idx);
    		console.log(addr);
    		$.get('ajax_center_one.do?addr='+addr, function(data) {
    			console.log(data);
    			coords = new daum.maps.LatLng(data.CENTER_LAT, data.CENTER_LNG);
       			mark = new daum.maps.Marker({
					position : coords
				});
       			map.panTo(coords);
       			map.setCenter(coords);
       			map.setLevel(4, {anchor: coords}, {animate:true});
       			
       			document.getElementById('txt_search').scrollIntoView(true);
       			
    		})
    	});
    	$('#txt_search').keypress(function (e) {
    		var key = e.which;
    		if(key == 13) { //엔터키
    			$('#btn_search').trigger("click");
    			return false;
    		}
    	})
    	$('#btn_search').on('click', function() {
    		$('.tbody').empty();
    		var addr = $('#txt_search').val();
			console.log(addr);
    		$.get('ajax_center_search.do?addr='+addr, function(data) {
    			console.log('ajax 성공');
    			console.log(data);
				var len = data.length;
    			if(data != null) {
    				for(var i=0; i<len; i++) {
    					$('.tbody').append(
   							'<tr class="tr">'+
	   							'<td>'+data[i].CENTER_AREA_NAME+'</td>'+
	   							'<td>'+data[i].CENTER_NAME+'</td>'+
	   							'<td class="addr">'+data[i].CENTER_ADDR+'</td>'+
	   							'<td>'+data[i].CENTER_TEL+'</td>'+	   							
   							'</tr>'
    					);
    				}
    			}
    		})
    	});
    	
    	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
        	center: new daum.maps.LatLng(35.139073, 129.100735), //지도의 중심좌표.
        	level: 13 //지도의 레벨(확대, 축소 정도)
        };
        var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
		
    	var clusterer = new daum.maps.MarkerClusterer({
    	    map: map,
    	    averageCenter: true,
    	    minLevel: 4
    	});
    	
        $.get('ajax_center_locations.do', function(data) {
        	console.log(data);
        	// 데이터에서 좌표 값을 가지고 마커를 표시합니다
            // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
       		var markers = $(data).map(function(i, position) {
       			var coords = new daum.maps.LatLng(position.CENTER_LAT, position.CENTER_LNG);
       			var mark = new daum.maps.Marker({
					position : coords
				});
        		
     			var iwContent = 
       				'<div class="ui raised very padded text container segment" style="width: min-content; text-align:center; padding:6px 0;">'
       					+'<div>'+position.CENTER_NAME+'</div>'
       					+'<div>'+position.CENTER_ADDR+'</div><div>'+position.CENTER_TEL+'</div>'
       				+'</div>';
     			var customOverlay = new daum.maps.CustomOverlay({
     				clickable: true,
     		   		xAnchor : 0.5,
     		   		yAnchor : 1.6,
     			});

       			daum.maps.event.addListener(mark, 'click', makeClickListener(map, mark, coords, iwContent, customOverlay) );
                return mark;
       		});       		
            // 클러스터러에 마커들을 추가합니다
            clusterer.addMarkers(markers);            
        });
        
        daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
            // 현재 지도 레벨에서 1레벨 확대한 레벨
            var level = map.getLevel()-1;
            // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
            map.setLevel(level, {anchor: cluster.getCenter()});
        });
        
        function makeClickListener(map, mark, coords, iwContent, customOverlay) {
 			console.log('0');
        	return function() {
        		customOverlay.setPosition(coords);
       			customOverlay.setContent(iwContent);
        		console.log(mark);
        		console.log('1');
				
   				if((customOverlay.getMap() === null)) {
   					customOverlay.setMap(map);
   					map.setCenter(coords);
   	   				map.panTo(coords);
   	   				console.log('2');
   				} else {
   					customOverlay.setMap(null);
   					map.setCenter(coords);
   	   				map.panTo(coords);
   	   				console.log('3');
   				}
        	}
        }
    });
    </script>
</body>
</html>
