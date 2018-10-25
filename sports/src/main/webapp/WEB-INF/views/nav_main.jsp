<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6377ffb61ec73a41b33914a1add294a0&libraries=services"></script>
 <!-- Nav Menu -->
 <div class="computer tablet only row">
	<div class="ui inverted menu navbar" style="width:100%">
		<a class="brand item" href="squash.do">Squash</a>
		<a class="brand item" href="http://211.110.165.201:8080/kampipa/main">Soccer</a>
		
		<!-- 
		<a class="item" href="#">Home </a>
		 -->
		<div class="ui dropdown item">
			마이페이지
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="myPage.do">내정보</a>
				<a class="item" href="myGroups.do">내모임</a>
			</div>
		</div>
		<div class="ui dropdown item">
			센터
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="center_location.do">센터검색</a>
			</div>
		</div>
		<div class="ui dropdown item">
			모임
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="open_group.do">모임 만들기</a>
				<a class="item" href="allGroups.do">전체 모임보기</a>
			</div>
		</div>
		<!-- 
		<div class="ui dropdown item">
			채팅
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="chatting.do">채팅</a>
				<a class="item" href="http://13.209.150.69:8005/">오픈 채팅방 목록</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		 -->
		<div class="right menu">
			<c:if test="${sessionScope.SLEVEL == 2}">
				<a class="item" href="admin.do">관리자모드</a>
			</c:if>
			
			<a class="item informingCenter_nav">센터 제보</a>
			<c:if test="${sessionScope.SID eq null}">
				<a class="item" href="join.do">회원가입</a>
				<a class="item" href="login.do">로그인</a>
			</c:if>
			<c:if test="${sessionScope.SID ne null}">
				<a class="item" href="logout.do">${sessionScope.SNAME}님 로그아웃</a>
			</c:if>
		</div>
	</div>
 </div>
 <div class="mobile only narrow row" style="margin-left:5px">
	<div class="ui inverted menu navbar" style="width: 100%">
		<a class="item" href="squash.do">Squash</a>
		<div class="right menu open">
			<a href="" class="menu item">
				<i class="bars icon"></i>
			</a>
		</div>
	</div>
	<div class="ui vertical navbar menu" style="display:none">
		<c:if test="${sessionScope.SLEVEL == 2}">
			<a class="item" href="admin.do">관리자모드</a>
		</c:if>
		<c:if test="${sessionScope.SID eq null}">
			<a class="item" href="join.do">회원가입</a>
			<a class="item" href="login.do">로그인</a>
		</c:if>
		
		<div class="item">
			<div class="header">마이페이지</div>
			<div class="menu">
				<a class="item" href="myPage.do">내정보</a>
				<a class="item" href="myGroups.do">내모임</a>
			</div>
		</div>
		<div class="item">
			<div class="header">센터</div>
			<div class="menu">
				<a class="item" href="center_location.do">센터검색</a>
			</div>
		</div>
		<div class="item">
			<div class="header">모임</div>
			<div class="menu">
				<a class="item" href="open_group.do">모임 만들기</a>
				<a class="item" href="allGroups.do">전체 모임보기</a>
			</div>
		</div>
		<a class="item informingCenter_nav">센터 제보</a>
		<!-- 
		<div class="item">
			<div class="header">채팅</div>
			<div class="menu">
				<a class="item" href="chatting.do">채팅</a>
				<a class="item" href="http://13.209.150.69:8005/">오픈 채팅방 목록</a>
				<div class="ui inverted divider"></div>
			</div>
		</div>
		 -->
		<c:if test="${sessionScope.SID ne null}">
			<a class="item" href="logout.do">${sessionScope.SNAME}님 로그아웃</a>
		</c:if>
	</div>
 </div>
 <div class="ui longer modal" id="insertInformingCenterModal">
	<i class="close icon"></i>
	<div class="header">
		센터 제보
	</div>
		<div class="scrolling content">
			<div class="ui container" style="margin-top: 20px">
				<div class="ui center aligned container map_container">
					<div id="infrm_map" style="width:400px; height: 400px; margin:auto; display: none"></div>
				</div>
				<div class="ui form">
					<div class="ui container" style="margin-top: 20px">
						<label>주소 검색</label>
						<div class="ui fluid action input infrm_addr_container" style="margin-top: 20px">
							<input type="text" id="infrm_txt_addr" name="infrm_txt_addr" autocomplete="off" readonly/>
							<div class="ui button secondary infrm_btn-search-addr" onclick="daumPostcodeNav()">주소검색</div>
						</div>
						<div class="ui fluid labeled action input infrm_addr_center_container">
							<div class="ui label">센터 명</div>
							<input type="text" id="infrm_txt_name_center" name="infrm_txt_name_center" autocomplete="off" />
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<label>센터 정보</label>
						<div class="ui fluid field" style="margin-top: 20px">
							<textarea rows="6" style="resize: none" id="textarea_infrm" name="textarea_infrm" placeholder="코트갯수, 정식규격여부, 이용료, 자유 이용 가능 여부, 주차가능 여부 등등"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
	<div class="actions">
		<div class="ui black deny button">
			취소
		</div>
		<div class="ui positive right labeled icon button">
			작성
			<i class="checkmark icon"></i>
		</div>
	</div>
</div>

<script type="text/javascript">
	var informMapLevel = 3;
	var informCoords, informCoordsCenter, informCoordsAddr, informCenterLat, informCenterLng;
	var informMapContainer, // 지도를 표시할 div
		informMapOption;
	
	//지도를 미리 생성
	var informMap;
	//주소-좌표 변환 객체를 생성
	var informGeocoder = new daum.maps.services.Geocoder();
	//마커를 미리 생성
	var informMarker = new daum.maps.Marker({});
	
	
	$(function() {
		$('#infrm_txt_addr').on('click', function() {
			$('.infrm_btn-search-addr').trigger('click');
		})
		
		$('.informingCenter_nav').on('click', function() {
			if ('${sessionScope.SID}' === '') {
				window.location = 'login.do';
				return false;
			}
			$('#insertInformingCenterModal')
				.modal({
					onShow	: function() {
					},
					onVisible : function() {
						informMapContainer = document.getElementById('infrm_map');
						informMapOption = {
						        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
						        level: 16 // 지도의 확대 레벨
						};
						informMap = new daum.maps.Map(informMapContainer, informMapOption);
					},
					onApprove : function() {
						var id = '${sessionScope.SID}';
						var addr = $('#infrm_txt_addr').val();
						var name = $('#infrm_txt_name_center').val();
						var detail = $('#textarea_infrm').val();
						var lat = informCenterLat, lng = informCenterLng;
						if (addr === '') {
							$('.infrm_addr_container').addClass('error');
							return false;
						} else if (name === '') {
							$('.infrm_addr_container').removeClass('error');
							$('.infrm_addr_center_container').addClass('error');
							return false;
						} else if (detail === '') {
							$('.infrm_addr_container').removeClass('error');
							$('.infrm_addr_center_container').removeClass('error');
							$('.textarea_infrm').focus();
							return false;
						}
						
						$.ajax({
							url		: "insertInformingCenter.do",
							method	: "POST",
							data	: {
										memId		: id,
										centerAddr	: addr,
										centerName	: name,
										centerDetail: detail,
										centerLat	: lat,
										centerLng	: lng
							}
						})
						.done(function() {
							window.location = "alert.do?msg=센터를 제보해주셔서 감사합니다.<b> 추후에 업데이트가 될 예정입니다.&url=" + window.location.href;
						})
						
					}
				
				})
				.modal('show');
		})
	})
	function daumPostcodeNav() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = data.address; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수
	
	            // 기본 주소가 도로명 타입일때 조합한다.
	            if(data.addressType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }
	
	            // 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("infrm_txt_addr").value = fullAddr;
	            console.log('1');
	            // 주소로 상세 정보를 검색
	            informGeocoder.addressSearch(data.address, function(results, status) {
	            	console.log('2');
	                // 정상적으로 검색이 완료됐으면
	                if (status === daum.maps.services.Status.OK) {
	                	console.log('3');
	                	informMarker.setMap(informMap);
	                    var result1 = results[0]; //첫번째 결과의 값을 활용
	                    informCoords = '';
	                    // 해당 주소에 대한 좌표를 받아서
	                    informCoords = new daum.maps.LatLng(result1.y, result1.x);
	                    informCenterLat = result1.y;
	                    informCenterLng = result1.x;
	                    informCoordsAddr = informCoords;
	                    // 지도를 보여준다.
	                    informMapContainer.style.display = "inline-block";
	                    
			   			informMap.setLevel(informMapLevel, {anchor: informCoords}, {animate:true});
	
			   			informMap.relayout();
	                    // 지도 중심을 변경한다.
			   		 	informMap.setCenter(informCoords);
	                    
	                    // 마커를 결과값으로 받은 위치로 옮긴다.
	                    informMarker.setPosition(informCoords);
	                    console.log('4');
	                }
	            });
	        }
	    }).open({
	    	autoClose: true
	    });
	}
</script>
 