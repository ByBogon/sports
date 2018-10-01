<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>그룹 만들기</title>
	<!-- Bootstrap CSS -->
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css">
	<!-- jQuery and Bootstrap -->
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6377ffb61ec73a41b33914a1add294a0&libraries=services"></script>
</head>
<style>
.highlight {
	background-color: gray;
}
</style>
<body>
<div class="ui page grid">
<jsp:include page="nav_main.jsp"></jsp:include>
	<div class="ui container">
		<div class="ui two column padded grid">
			<div class="column">
				<form id="myForm">
				<div class="ui container" style="margin: auto; margin-top: 20px;">
					<div class="ui container" style="margin-top: 20px">
						<label>모임명</label>
						<div class="ui fluid input grp_name_input">
							<input type="text" id="grp_name" name="grp_name" placeholder="모임명" maxlength="20" />
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<div class="ui info hidden message" id="grp_name_info">
							<div class="header">
								그룹명을 필히 입력해주세요.
							</div>
							그룹명은 20자 이하로 작성해주세요.
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<label>주최자</label>
						<div class="ui fluid input">
							<input type="text" id="grp_leader" name="grp_leader" readonly value="${sessionScope.SNAME}" />
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<label>운동종목</label>
						<div class="ui fluid selection dropdown sports_genre">
							<i class="dropdown icon"></i>
							<div class="default text">운동종목</div>
							<div class="menu">
								<input type="hidden" id="sports_genre" name="sports_genre">
								<c:forEach var="genre" items="${list}" varStatus="i">
									<div class="item genre" data-value="${i.index}">${genre}</div>
								</c:forEach>
							</div>
							<%-- <select class="form-control" id="sports_genre" name="grp_leader">
								<c:forEach var="genre" items="${list}" varStatus="i">
									<option value="${i.index}">${genre}</option>
								</c:forEach>
							</select> --%>
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<div class="ui info hidden message" id="sports_genre_info">
							<div class="header">
								운동종목 미지원
							</div>
							<ul class="list">
								<li>
									<p>현재는 <b>스쿼시</b>만 지원합니다.</p>
								</li>
								<li>빠른 시일 내에 타 종목들을 지원하겠습니다.</li>
							</ul>
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<div class="ui negative hidden message mem_add_warn" id="mem_add_warn">
							<i class="close icon"></i>
							<div class="header">
								운동종목 미선택
							</div>
							운동종목을 필히 선택하셔야 합니다.
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<label>센터 찾기</label>
						<div class="ui fluid action input" id="div_center">
							<input type="text" id="txt_center" name="txt_center" placeholder="센터명/주소" autocomplete="off"/>
							<div class="ui button secondary btn-search-center">찾기</div>
						</div>
						<div class="ui fluid labeled action input center_container">
							<div class="ui label">
								주소
							</div>
							<input type="text" id="txt_set_center" name="txt_set_center" autocomplete="off" disabled/>
							<div class="ui button primary" id="btn_set_center">확인</div>
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<div class="ui info hidden message" id="first_info">
							<div class="header">
								센터 지정
							</div>
							<ul class="list">
								<li>
									<p>센터는 <b>센터찾기</b>나 <b>직접입력</b> 중 하나만 입력 가능합니다.</p>
								</li>
								<li>원하는 센터명/주소를 입력하고 찾기를 클릭해주세요.</li>
								<li><b>확인</b>을 눌러 해당 모임의 센터를 정해주세요.</li>
							</ul>
						</div>
					</div>
					
					<div class="ui container" style="margin-top: 20px">
						<label>직접 입력</label>
						<div class="ui fluid action input addr_container">
							<input type="text" id="txt_addr" name="txt_addr" autocomplete="off" readonly/>
							<div class="ui button secondary btn-search-addr" onclick="daumPostcode()">주소검색</div>
						</div>
						
						<div class="ui fluid labeled action input addr_center_container">
							<div class="ui label">
								센터 명
							</div>
							<input type="text" id="txt_addr_center" name="txt_addr_center" autocomplete="off"/>
							<div class="ui button primary" id="btn_set_addr_center">확인</div>
						</div>
					</div>
					<div class="ui container" style="margin-top: 20px">
						<div class="ui info hidden message" id="second_info">
							<div class="header">
								센터 지정
							</div>
							<ul class="list">
								<li>
									<p>센터는 <b>센터찾기</b>나 <b>직접입력</b> 중 하나만 입력 가능합니다.</p>
								</li>
								<li>원하는 센터를 위에서 찾지 못했다면 주소를 검색하고 센터 명을 입력해주세요.</li>
								<li>센터의 주소를 몰라도 괜찮습니다. 해당 센터 명을 입력해주세요.</li>
								<li><b>확인</b>을 눌러 해당 모임의 센터를 정해주세요.</li>
							</ul>
						</div>
					</div>
				</div>
				</form>
			</div>
			<div class="column" style="margin: auto; margin-top: 30px">
				<div id="map" style="width:400px; height:500px; margin:auto;"></div>
			</div>
		</div>
		<div class="ui two column padded grid">
			<div class="column" style="margin: auto; margin-top: 20px">
				<input type="button" class="ui button primary btn-add" value="멤버추가" />
				<input type="button" class="ui button negative btn-rmv" id="btn-rmv" value="멤버삭제" />
				
			</div>
			<div class="column" style="margin: auto; margin-top: 20px">
				<div class="ui right aligned container">
					<input type="button" class="ui button grey" id="btn-empty" value="센터 초기화" />
					<input type="button" class="ui button positive btn-create" value="모임생성" />
					<a href="#" class="ui button black btn-dark">홈으로</a>
				</div>
			</div>
		</div>
		<div class="ui container">
			<div class="ui link special cards members" style="margin-top: 20px">
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal" id="modal_del_grp_mem" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">멤버 삭제</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">선택하신 멤버를 제외하시겠습니까?</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-secondary" data-dismiss="modal"
						value="취소" /> <input type="button" class="btn btn-danger"
						id="modal_btn_rmv" value="삭제" />
				</div>
			</div>
		</div>
	</div>
</div>	

<jsp:include page="modal_add_group_mem.jsp"></jsp:include>
<jsp:include page="modal_search_group_center.jsp"></jsp:include>

<script type="text/javascript">
	var id_list = [];
	var cardIdList = [];
	var rmIdList = [];
	var defaultPage = 1;
	
	var mapLevel = 3;
	var coords, coordsCenter, coordsAddr;
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 16 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({});
    
	function havingCardIds() {
		var cardIds = [];
		$('.members').find('.card').each(function() {
			var idx = $(this).index('.card');
			console.log(idx);
			var id = $('.meta').eq(idx).text();
			console.log(id);
			cardIds.push(id);
		})
		return cardIds;
	}
	
	function havingCheckedCards() {
		var checkedCards = [];
		$('.members').find('.card').each(function() {
			var idx = $(this).index('.card');
			var chkbox = $('.grp_mem_chck').eq(idx);
			if (chkbox.is(":checked")) {
				checkedCards.push(chkbox.val());
			}
		})
		return checkedCards;
	}
	
	function clickableDelBtn() {
		cardIdList = havingCheckedCards();
		var rmvBtn = $('.btn-rmv');
		if (cardIdList.length == 0) {
			rmvBtn.prop("disabled", true);
		} else {
			rmvBtn.prop("disabled", false);
		}
	}
	
	function centerOneWithMarker(centerAddr) {
		$.get('ajax_center_one.do?addr='+centerAddr, function(data) {
			marker.setMap(map);
			coords = '';
			coords = new daum.maps.LatLng(data.CENTER_LAT, data.CENTER_LNG);
			coordsCenter = coords;

			map.setLevel(mapLevel, {anchor: coords}, {animate:true});

            map.relayout();
            // 지도 중심을 변경한다.
            map.setCenter(coords);
            
            // 마커를 결과값으로 받은 위치로 옮긴다.
            marker.setPosition(coords);
            daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker, coords) );
		})
	}
	
	function centerSearch(txt, page) {
		$.get('ajax_center_search.do?addr='+txt+'&page='+page, function(data) {
			var len = data.length;
			var html = '';
			for (var i = 0; i < len; i++) {
				html += '<tr class="center_tr">';
					html += '<td>'+data[i].CENTER_AREA_NAME+'</td>';
					html += '<td class="center_name">'+data[i].CENTER_NAME+'</td>';
					html += '<td class="center_addr">'+data[i].CENTER_ADDR+'</td>';
					html += '<td>'+data[i].CENTER_TEL+'</td>';
				html += '</tr>';
			}
			$('#modal_tbody_group_center').html(html);
		})
	}

    function daumPostcode() {
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
                document.getElementById("txt_addr").value = fullAddr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {
                    	marker.setMap(map);
                        var result = results[0]; //첫번째 결과의 값을 활용
                        coords = '';
                        // 해당 주소에 대한 좌표를 받아서
                        coords = new daum.maps.LatLng(result.y, result.x);
                        coordsAddr = coords;
                        // 지도를 보여준다.
                        //mapContainer.style.display = "block";
                        
    		   			map.setLevel(mapLevel, {anchor: coords}, {animate:true});

    		   			map.relayout();
                        // 지도 중심을 변경한다.
    		   		 	map.setCenter(coords);
                        
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        
                        marker.setPosition(coords);

						daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker, coords) );
                    }
                });
            }
        }).open();
    }
    function makeClickListener(map, marker, coords) {
		console.log('0');
    	return function() {
    		if(map.getLevel !== mapLevel) {
    			map.setLevel(mapLevel);
    		}
    		console.log('1');
    		console.log(coords);
    		map.setCenter(coords);
			map.panTo(coords);
    	}
    }
	window.onload = clickableDelBtn;
	
	$(function() {
		
		$('#btn-empty').on('click', function() {
			$('#txt_center').val('');
			$('#txt_set_center').val('');
			$('#txt_addr').val('');
			$('#txt_addr_center').val('');
		})
		
		$('.mem_add_warn .close').on('click', function() {
		    $(this).closest('.message').transition('fade');
		});
		
		$('.dropdown.sports_genre').dropdown({
			action: 'activate',
			onChange: function(value, text, $selectedItem) {

				$('#mem_add_warn').removeClass('visible').addClass('hidden');
				console.log(value);
				console.log(text);
				console.log($selectedItem);
				if(value > 0) {
					console.log('value가 0보다 작음');
					console.log($(this));
					$(this).dropdown('set selected', '0');
					$('#sports_genre_info').removeClass('hidden').addClass('visible');
				} else {
					$('#sports_genre_info').removeClass('visible').addClass('hidden');
				}
			}
		});
		$('#btn_set_center').on('click', function() {
			var btn = $('#btn_set_center');
			var btnTxt = btn.text();
			if (btnTxt === '확인') {
				var addr = $('#txt_set_center').val();
				if ((addr.trim() === '') || (addr === 'undefined')) {
					return false;
				}
				map.setLevel(mapLevel, {anchor: coordsCenter}, {animate:true});

                map.relayout();
                // 지도 중심을 변경한다.
                map.setCenter(coordsCenter);
                
                // 마커를 결과값으로 받은 위치로 옮긴다.
                marker.setPosition(coordsCenter);
                daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker, coordsCenter) );
                
				$('#txt_center').val('');
				$('#txt_addr').val('');
				$('#txt_addr_center').val('');
				
				$('#div_center').addClass('disabled');
				$('.addr_container').addClass('disabled');
				$('.addr_center_container').addClass('disabled');
				
				$('.btn-search-addr').addClass('disabled');
				$('#btn_set_addr_center').addClass('disabled');
				
				$('.btn-search-addr').removeAttr('onclick');
				
				$('#btn-empty').addClass('disabled');
				
				if ( $('#first_info').hasClass('visible') ) {
					$('#first_info').transition('fade down');
				} else {
					$('#first_info').transition('tada');
				}
				
				btn.text('취소');
				return false;
			} else if (btnTxt === '취소') {
				$('#div_center').removeClass('disabled');
				$('.addr_container').removeClass('disabled');
				$('.addr_center_container').removeClass('disabled');
				$('.btn-search-addr').removeClass('disabled');
				$('#btn_set_addr_center').removeClass('disabled');
				$('.btn-search-addr').attr("onclick", 'daumPostcode();');

				$('#btn-empty').removeClass('disabled');
				
				if ( $('#first_info').hasClass('hidden') ) {
					$('#first_info').transition('fade down');
				}
				
				btn.text('확인');
				return false;
			}
		})
		
		$('#btn_set_addr_center').on('click', function() {
			var btn = $('#btn_set_addr_center');
			var btnTxt = btn.text();
			if (btnTxt === '확인') {
				var addr = $('#txt_addr').val();
				var center = $('#txt_addr_center').val();
				if ( $('#second_info').hasClass('visible') ) {
					$('#second_info').transition('fade down');	
				} else {
					$('#second_info').transition('tada');	
				}
				if ( ( ( (addr.trim() === '') || (addr === 'undefined') ) &&
						( (center.trim() === '') || (center === 'undefined') ) ) ) {
					return false;
				}
				   
				$('#txt_set_center').val('');
				$('#txt_center').val('');
				
				$('#div_center').addClass('disabled');
				$('.center_container').addClass('disabled');
				$('.addr_container').addClass('disabled');
				
				$('.btn-search-center').addClass('disabled');
				$('#btn_set_center').addClass('disabled');
				$('.btn-search-addr').addClass('disabled');

				$('.btn-search-addr').removeAttr('onclick');

				$('#btn-empty').addClass('disabled');
				
				btn.text('취소');
				
				if ((addr.trim() === '') && (center.trim() !== '')) {
					return false;	
				}
				map.setLevel(mapLevel, {anchor: coordsAddr}, {animate:true});

                map.relayout();
                // 지도 중심을 변경한다.
                map.setCenter(coordsAddr);
                
                // 마커를 결과값으로 받은 위치로 옮긴다.
                marker.setPosition(coordsAddr);
                daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker, coordsAddr) );
             
				return false;
			} else if (btnTxt === '취소') {
				$('#div_center').removeClass('disabled');
				$('.center_container').removeClass('disabled');
				$('.addr_container').removeClass('disabled');
				
				$('.btn-search-center').removeClass('disabled');
				$('#btn_set_center').removeClass('disabled');

				$('.btn-search-addr').removeClass('disabled');
				$('.btn-search-addr').attr("onclick", 'daumPostcode();');

				$('#btn-empty').removeClass('disabled');
				
				if ( $('#second_info').hasClass('hidden') ) {
					$('#second_info').transition('fade down');	
				}
				btn.text('확인');
				return false;
			}
		})
		
		$('#txt_addr').on('click', function() {
			$('.btn-search-addr').trigger("click");
			
		})
		
		$('.btn-search-addr').on('click', function() {
			if ( $('#first_info').hasClass('visible') ) {
				$('#first_info').transition('fade down');
			}
			if ( $('#second_info').hasClass('hidden') ) {
				$('#second_info').transition('fade down');
			} else {
				$('#second_info').transition('tada');
			}
		})
		
		$('.btn-create').on('click', function(e) {
			console.log('clicked!');
			e.preventDefault();
			var txt_addr = $('#txt_addr').val();
			var txt_addr_center = $('#txt_addr_center').val();
			var txt_set_center = $('#txt_set_center').val();
			var btn_addr = $('#btn_set_addr_center').text();
			var btn_center = $('#btn_set_center').text();
			if ( ( (btn_center === '확인') && !( $('#btn_set_center').hasClass('disabled') ) ) && ( (txt_set_center.trim() !== '') && 
					( (txt_addr_center.trim() === '') || (txt_addr.trim() === '') ) ) ) {
				if( $('#first_info').hasClass('visible') ) {
					$('#first_info').transition('tada');	
				} else if ( $('#first_info').hasClass('hidden') ) {
					$('#first_info').transition('fade down');
				}
				if( $('#second_info').hasClass('visible') ) {
					$('#second_info').transition('fade down');	
				}
			}
			if ( ( ( (txt_addr_center.trim() === '') && (txt_addr.trim() !== '') ) ||
					( (txt_addr_center.trim() !== '') && (txt_addr.trim() === '') ) ) && 
					 (txt_set_center.trim() === '') ) {
				if( $('#second_info').hasClass('visible') ) {
					$('#second_info').transition('tada');	
				} else if ( $('#second_info').hasClass('hidden') ) {
					$('#second_info').transition('fade down');
				}	
				if( $('#first_info').hasClass('visible') ) {
					$('#first_info').transition('fade down');	
				}
			}
			if ( (txt_set_center.trim() !== '') && 
					( (txt_addr_center.trim() !== '') || (txt_addr.trim() !== '') ) ) {
				if( $('#first_info').hasClass('visible') ) {
					$('#first_info').transition('tada');	
				} else if ( $('#first_info').hasClass('hidden') ) {
					$('#first_info').transition('fade down');
				}
				if( $('#second_info').hasClass('visible') ) {
					$('#second_info').transition('tada');	
				} else if ( $('#second_info').hasClass('hidden') ) {
					$('#second_info').transition('fade down');
				}
			}
			var grp = $('#grp_name').val();
			var leader = '${sessionScope.SID}';
			if( (leader === null) || (leader.length === 0) ) {
				//로그인 하라고 하기(로그인페이지로 리다이렉트)
				console.log('로그인 안되어있음');
				return false;
			}
			if( (grp.trim() === null) || (grp.trim().length === 0) ) {
				//그룹명 정하게 Alert나 여러가지 띄울것
				$('#grp_name').focus();
				console.log('그룹명 정하세요');

				$('.grp_name_input').addClass('error');
				if( $('#grp_name_info').hasClass('hidden') ) {
					$('#grp_name_info').transition('fade down');
				} else {
					$('#grp_name_info').transition('tada');
				}
				return false;
			}
			var checkedIds = havingCardIds();
			$.each(checkedIds, function(index, val) {
				console.log(val);
			})
				
			var genre = $('.dropdown.sports_genre').dropdown('get text');
			console.log(genre);
			
			var center = $('#txt_set_center').val();
			var addr = $('#txt_addr').val();
			var final_addr = center + addr;
			console.log(center);
			console.log(addr);
			console.log(final_addr);
			var form = document.getElementById("myForm");
			var formData = new FormData(form);
			formData.append("memList", checkedIds);
			console.log(form);
			console.log(formData);
			
			var request = new XMLHttpRequest();
			request.open("POST", "makeOneGroup.do");
			request.send(formData);
			
			
			/* document.location = '/sports/makeOneGroup.do?grp_name='+grp
					+'&grp_leader='+leader+'&memList='+checkedIds; */
		})

		$('#center_table').on('click', '.center_tr', function() {
			var idx = $(this).index('.center_tr');
			var centerName = $('.center_name').eq(idx).text();
			var centerAddr = $('.center_addr').eq(idx).text();
			$('#txt_set_center').prop('disabled', false);
			$('#txt_set_center').prop('readonly', true);
			
			$('#txt_set_center').val(centerAddr);
			$('#searchGrpCenterModal').modal({
				onHide	: function() {
					centerOneWithMarker(centerAddr);
				}
			})
			.modal('hide');
		})
		
		$('#searchGrpCenterModal').on('hide.bs.modal', function() {
			$('#modal_input_search_center').text('');
		}) 
		
		
		$('.btn-search-center').on('click', function() {
			var center = $('#txt_center').val();
			console.log(center);
			if( (typeof center === 'undefined') || (center.trim() === '')) {
				return false;
			}
			var btn = '';
			var loader = '';
			loader += '<div class="ui segment">';
			loader += '<div class="ui active dimmer">';
			loader += '<div class="ui text loader">Loading</div></div></div>';
			$('#searchGrpCenterModal')
				.modal({
					onShow	: function() {
						console.log('onShow');
						$('#modal_container_loader').html(loader);
					}
				})
				.modal('show');
			$.get('ajax_center_searchCNT.do?addr='+center, function(data) {
				var cntlength = data+1;
				console.log(data);
				console.log(cntlength);
				btn += '<div class="ui buttons">';
				for(var n=1; n < cntlength; n++) {
					btn += '<a href="#" onclick="centerSearch(\''+center+'\','+n+')" class="ui button">'+n+'</a>';
				}
				btn += '</div>';
				$('#modal_container_pagination').html(btn);
				$('#modal_container_loader').empty();
				centerSearch(center, defaultPage);
			})
		})

		$('#modal_btn_rmv').on('click', function() {
			console.log(rmIdList.length);
			$('.members').find('.card').each(function() {
				var idx = $(this).index('.card');
				var rmvCard = $('.card').eq(idx);
				var rmvId = $('.grp_mem_chck').eq(idx).val();
				$.each(rmIdList, function(index, val) {
					console.log('rmIdList: ' + val);
					if (rmvId === val) {
						rmvCard.remove();
					}
				})
			})
			$('#modal_del_grp_mem').modal('hide');
		})

		$('#btn-rmv').on('click', function() {
			rmIdList.length = 0;
			$('.members').find('.card').each(function() {
				var idx = $(this).index('.card');
				var chk = $('.grp_mem_chck').eq(idx);
				var rmId = chk.val();
				if (chk.is(":checked")) {
					rmIdList.push(rmId);
				}
			})
			console.log(rmIdList.length);
			$('#modal_del_grp_mem').modal('show');
		})
		$('.members').on('click', '.card', function() {
			var idx = $(this).index('.card');
			console.log(idx);
			var check = $('.grp_mem_chck').eq(idx);
			if (check.is(":checked")) {
				check.prop('checked', false);
				clickableDelBtn();
			} else {
				check.prop('checked', true);
				clickableDelBtn();
			}
		})

		$('#insertGrpMemModal').on('shown.bs.modal', function() {
			$('.members').find('.card').each(function() {
				var idx = $(this).index('.card');
				console.log(idx);
				var id = $('.meta').eq(idx).text();
				console.log(id);
				$('#mem_table').find('.mem').each(function() {
					var i = $(this).index('.mem');
					var check = $('.mem_chck').eq(i);
					var mem_id_eq = $('.mem_id').eq(i);
					var mem_id = mem_id_eq.text();
					console.log(mem_id);
					if (id == mem_id) {
						mem_id_eq.parent().addClass("highlight");
						check.prop('checked', true);
					}
				})
			})
		})
		
		$('#modal_btn_add_grp_mem').on('click',function(e) {
			console.log(id_list.length);
			$.each(id_list, function(index, val) {
				console.log(val);
			})
			e.preventDefault();
			$.ajax({
				traditional : true,
				type : "POST",
				url : "ajax_add_grp_mem.do",
				data : {
					id_list : id_list
				},
				success : function(data) {
					console.log(data);
					var len = data.length;
					console.log(len);
					for (var i = 0; i < len; i++) {
			// 멤버를 open_group의 .members에 추가 하는 것이므로 html로 하면 매번 선택한 사람들만 추가됨(추가할때마다 리스트에서 추가한 사람 제거하므로)
						$('.members').append(
							'<div class="card">'
								+ '<div class="image">'
									+ '<img src="resources/images/elyse.png">'
								+ '</div>'
								+ '<div class="content">'
									+ '<div class="header">'+data[i].mem_name+'</div>'
									+ '<div class="meta" name="card_mem_id">'+data[i].mem_id+'</div>'
								+ '</div>'
								+ '<div class="extra content">'
									+ '<span class="left floated">'
										+ '<input type="checkbox" class="grp_mem_chck" name="grp_chk[]" '
										+'value="'+data[i].mem_id+'"/>'
									+ '</span>'
									+ '<span class="right floated">'+data[i].level_name+'</span>'
								+ '</div>'
							+ '</div>');
					}
					id_list.length = 0;
				},
				error : function(error) {
					console.log(error);
				}
			})
			$('#insertGrpMemModal').modal('hide');
			return false;
		})

		// 모달이 hide 이벤트를 시작할때는 .on('hide.bs.modal')
		// 모달이 없어진뒤 함수
		$('#insertGrpMemModal').on('hidden.bs.modal', function() {
			$('.members').remove();
			id_list.length = 0;
			console.log('id_list: ' + id_list.length);
		});
		
		$('#mem_table').on('click', '.mem', function() {
			var idx = $(this).index('.mem');
			var check = $('.mem_chck').eq(idx);
			console.log("clicked!");
			var mem_id_eq = $('.mem_id').eq(idx);
			var mem_id = mem_id_eq.text();
			console.log(idx);
			console.log(mem_id);
			if (check.is(":checked")) {
				check.prop('checked', false);
				mem_id_eq.parent().removeClass("highlight");
				id_list.splice($.inArray(mem_id, id_list), 1);
				console.log('size:' + id_list.length);
			} else {
				check.prop('checked', true);
				mem_id_eq.parent().addClass("highlight");
				id_list.push(mem_id);
				console.log('size:' + id_list.length);
			}

		});
		
		$('#mem_chck_all').click(function() {
			$('#mem_table').find('.mem_chck').each(function() {
				var row = $(this);
				console.log(row);
				var value;
				/* if (row.find('.mem_chck').is(':checked') {
					value = $('.mem_chck').val();
				} */
			})
			if ($('#mem_chck_all').is(':checked')) {
				$('.mem_chck').prop('checked', true);
			} else {
				$('.mem_chck').prop('checked', false);
			}
		});
			
		$('.btn-add').on('click', function() {
			var no = $('.dropdown.sports_genre').dropdown('get value');
			if (no === '') {
				$('#mem_add_warn').removeClass('hidden').addClass('visible');
				return false;
			}
			cardIdList = havingCardIds();
			console.log(cardIdList.length);
			$.each(cardIdList, function(index, val) {
				console.log('cardIds: ' + val);
			})
			$('.tbody').empty();
			
			var id = '${sessionScope.SID}';
			console.log(no);
			console.log(id);
			if( (id === 'undefined') || (id === '') ) {
				window.location.href = "login.do";
			}
			var loader = '';
			loader += '<div class="ui segment">';
			loader += '<div class="ui active dimmer">';
			loader += '<div class="ui text loader">Loading</div></div></div>';
			$('#insertGrpMemModal')
				.modal({
					onShow	: function() {
						console.log('onShow');
						$('#modal_addGrpMem_loader').html(loader);
					}
				})
				.modal('show');
			$.ajax({
				url : 'ajax_grp_mem_list.do',
				data : {
					no : no,
					mem_id : id,
					idList : cardIdList
				},
				dataType : 'json',
				traditional : true,
				success : function(data) {
					console.log(data);
					var len = data.length;
					console.log(len);
					var html = '';
					if(len > 0) {
						for (var i = 0; i < len; i++) {
							html += '<tr class="mem" id="mem">';
							html += '<td><input type="checkbox" class="mem_chck" name="chk[]" ';
							html += 'value="'+data[i].mem_id+'"/></td>';
							html += '<td class="mem_id">'+data[i].mem_id+'</td>';
							html += '<td>'+data[i].mem_name+'</td>';
							html += '</tr>';
						}
						$('#tbody_group_mem').html(html);
						$('#modal_addGrpMem_loader').empty();
						return false;	
					} else {
						$('.txt_msg').html('<label>더이상 추가 가능한 멤버가 없습니다</label>');
					}
				}
			});
		})
		
		$('#modal_btn_search_mem').on('click', function() {
			var mem = $('#modal_txt_search_mem').val();
			var myid = '${sessionScope.SID}';
			var myname = '${sessionScope.SNAME}';
			console.log(mem);
			console.log(myid);
			console.log(myname);
			$.get('ajax_search_member.do?mem='+mem+'&myid='+myid+'&myname='+myname, function(data) {
				$('#tbody_group_mem').empty();
				$('.txt_msg').empty();
				console.log(data);
				var len = data.length;
				console.log(len);
				var html= '';
				if (data != null && len != 0) {
					for (var i = 0; i < len; i++) {
						//$('#tbody_group_mem').append(
						html += '<tr class="mem">';
						html += '<td><input type="checkbox" class="mem_chck" name="chk[]" ';
						html += 'value="'+data[i].mem_id+'"/></td>';
						html += '<td class="mem_id">'+data[i].mem_id+'</td>';
						html += '<td>'+data[i].mem_name+'</td>';
						html += '</tr>';
					}
					$('#tbody_group_mem').html(html)
				} else {
					$('.txt_msg').html('<label>원하는 멤버를 찾지 못하였습니다</label>');
				}
			})
		})

		$('#modal_txt_search_mem').keypress(function(e) {
			var key = e.which;
			if (key == 13) { //엔터키
				$('#modal_btn_search_mem').trigger("click");
				return false;
			}
		})
		
		$('#grp_name').keyup(function() {
			var grp = $('#grp_name').val();
			console.log(grp);
			if( grp.trim().length > 20 ) {
				$('.grp_name_input').addClass('error');
				if( $('#grp_name_info').hasClass('hidden') ) {
					$('#grp_name_info').transition('fade down');
				} else if ( $('#grp_name_info').hasClass('visible') ) {
					$('#grp_name_info').transition('tada');
				}
			} else {
				$('.grp_name_input').removeClass('error');
				if( $('#grp_name_info').hasClass('visible') ) {
					$('#grp_name_info').transition('fade down');
				}
			}
		})
		
		$('#txt_center').focus(function() {
			if ( $('#second_info').hasClass('visible') ) {
				$('#second_info').transition('fade down');
			}
			if ( $('#first_info').hasClass('hidden') ) {
				$('#first_info').transition('fade down');
			} else {
				$('#first_info').transition('tada');
			}
		})
		
		$('#txt_addr_center').focus(function() {
			if ( $('#first_info').hasClass('visible') ) {
				$('#first_info').transition('fade down');
			}
			if ( $('#second_info').hasClass('hidden') ) {
				$('#second_info').transition('fade down');
			} else {
				$('#second_info').transition('tada');
			}
		})
		
		$('#txt_center').keypress(function(e) {
			var key = e.which;
			if (key == 13) { //엔터키
				$('.btn-search-center').trigger("click");
				return false;
			}
		})
		
		
	})
	
	

</script>
</body>
</html>
