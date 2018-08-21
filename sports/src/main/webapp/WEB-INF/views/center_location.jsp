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
		<div style="width: 100%; text-align: center; margin-top: 20px">
			<div style="margin:auto; display: inline-block; min-width: 700px">
				<div class="input-group mb-3">
					<input type="text" class="form-control" placeholder="검색"/>
					<div class="input-group-append">
						<input type="button" class="btn btn-outline-secondary" value="검색"/>
					</div>
				</div>
				<div id="map" style="width:100%; height:400px; margin: auto">
				</div>
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
        	level: 14 //지도의 레벨(확대, 축소 정도)
        };
        //35.139073, 129.100735
        var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
        /*
        var coords = new daum.maps.LatLng(35.139073, 129.100735);
        var marker = new daum.maps.Marker({
            map: map,
            position: coords,
            clickable: true
        });
        var iwContent = '<div style="width:150px;text-align:center;padding:6px 0;">경성대 스포츠센터</div>',
        	iwRemoveable = true;
    		 
		// 인포윈도우로 장소에 대한 설명을 표시합니다
		var infowindow = new daum.maps.InfoWindow({
			content: iwContent,
			removable : iwRemoveable
		});
		daum.maps.event.addListener(marker, 'click', function(){
			infowindow.open(map, marker);
		}); */
		
		
        //map.setCenter(coords);
    	var clusterer = new daum.maps.MarkerClusterer({
    	    map: map,
    	    averageCenter: true,
    	    minLevel: 4
    	});
        //var markers = [];
        $.get('ajax_center_locations.do', function(data) {
        	console.log(data);
        	// 데이터에서 좌표 값을 가지고 마커를 표시합니다
            // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
       		var markers = $(data).map(function(i, position) {
       			return new daum.maps.Marker({
					position : new daum.maps.LatLng(position.CENTER_LAT, position.CENTER_LNG),
       				title : position.CENTER_NAME
                   
                   });
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
        /* $.get('ajax_customer_food.do?rtr_crn='+'${param.rtr_crn}', function(data){
			var str_select = "<select class='browser-default ord_cnt'>";
			for (var i=1; i<=100; i++) {
				str_select += "<option value='"+ i +"'>"+ i +"</option>";
			}
			str_select += "</select>";
			
			console.log(data);
			var len = data.length;
			for(var i=0; i<len; i++) {
				$('.collection').append(
					'<li class="collection-item avatar" style="margin: 20px;">'+
						'<input type="hidden" class="fd_num" value="'+data[i].FD_NUM+'"/>'+
						'<div style="cursor:pointer">'+
							'<img src="resources/imgs/2.jpg" class="circle" />'+							
							'<span class="title">'+data[i].FD_NAME+ '</span>'+
							'<p>'+data[i].FD_PRICE+' 원</p>'+
							'<div class="input-field inline">'+
							'<input type="text" class="validate"/>'+
							str_select +
							'</div>'+
							'<a href="#!" class="secondary-content btn_order">주문</a>'+
						'</div>'+
					'</li>'
				);
			}
		},'json'); 

    })
    */
    });
    
    </script>

</body>
</html>
