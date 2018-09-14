<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<meta charset="utf-8">
	<title>센터찾기</title>
	<!-- Bootstrap CSS -->
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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6377ffb61ec73a41b33914a1add294a0&libraries=services,clusterer"></script>
    
</head>
<body>
	<div class="ui page grid">
		<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="ui center aligned container">
			<div>
				<img src="resources/images/squash.jpg" style="width: 100%; height: 70%" />
			</div>
		</div>
		<div style="width: 100%; text-align: center; margin-top: 20px">
			<div style="margin:auto; display: inline-block; min-width: 700px">
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="txt_search" placeholder="검색"/>
					<div class="input-group-append">
						<input type="button" class="btn btn-outline-secondary" id="btn_search" value="검색"/>
					</div>
				</div>
				<div id="map" style="width:100%; height:400px; margin: auto">
				</div>
			</div>
			<jsp:include page="center_location_context.jsp"></jsp:include>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
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
        	level: 14 //지도의 레벨(확대, 축소 정도)
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
       				'<div style="text-align:center; padding:6px 0;">'
       					+'<div>'+position.CENTER_NAME+'</div>'
       					+'<div>'+position.CENTER_ADDR+' / TEL: '+position.CENTER_TEL+'</div>'
       				+'</div>';
       			var infowindow = new daum.maps.InfoWindow({
        			content : iwContent
        		});

       			daum.maps.event.addListener(mark, 'click', function() {
       				map.panTo(coords);
       			});
       			daum.maps.event.addListener(mark, 'mouseover', makeOverListener(map, mark, infowindow));
                daum.maps.event.addListener(mark, 'mouseout', makeOutListener(infowindow));
       			
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

     	 // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
        function makeOverListener(map, marker, infowindow) {
        	infowindow.close();
            return function() {
            	infowindow.open(map, marker);
            };
        };

        // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
        function makeOutListener(infowindow) {
            return function() {
            	infowindow.close();
            };
        };
    });
    </script>

</body>
</html>
