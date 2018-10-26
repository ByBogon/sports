<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>

<link rel="shortcut icon" href="resources/images/favicon.ico">
<link rel="stylesheet" href="resources/css/semantic.min.css">
<link rel="stylesheet" href="resources/css/nav_bar.css?ver=2">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery.form.min.js"></script>
<script src="resources/js/semantic.min.js"></script>
<script src="resources/js/nav_bar.js?ver=1"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6377ffb61ec73a41b33914a1add294a0&libraries=services,clusterer"></script>
</head>

<body>
<div class="ui page grid">
<jsp:include page="nav_main.jsp"></jsp:include>
	<div class="ui grid" style="width:100%; margin-top: 20px">
		<jsp:include page="myPageMenuOnLeft.jsp"></jsp:include>
		<div class="right floated column" style="width:70%">
			<div class="ui right aligned container" style="margin-top: 10px">
				<c:if test="${map.CENTER_NO == null}">
					<div class="ui action input search_center_class">
						<input type="text" id="search_txt" placeholder="센터명/주소"/>
						<button class="ui icon button search" id="search_btn">
							<i class="search icon"></i>
						</button>
					</div>
				</c:if>
				<c:if test="${map.CENTER_NO != null}">
					<div class="ui right aligned container">
						<a class="ui primary button" id="editMyCenter">내 센터 수정하기</a> 
					</div>
				</c:if>
			</div>
			<div class="ui container context" id="context">
				<c:if test="${map.CENTER_NO == null}">
					<div class="ui info message">
						<div class="header">
							등록된 센터가 없습니다.
						</div>
						센터를 추가하시려면 검색창을 이용해 주세요.
					</div>
				</c:if>
				<c:if test="${map.CENTER_NO != null}">
					<div class="ui container" style="margin-top: 20px">
						<div class="ui centered card">
							<div class="left aligned content">
								<c:if test="${map.MEM_IMG == null}">
									<img class="ui avatar image" src="resources/images/molly.png">
								</c:if>
								<c:if test="${map.MEM_IMG != null}">
									<img class="ui avatar image" src="${map.MEM_IMG}" onerror="this.src='resources/images/matthew.png'">
								</c:if>
								${map.MEM_NAME}
							</div>
							<div class="image">
								<div id="map2" style="width: 200px; height:310px; 
								max-height: 100%; min-width: 100%; 
								margin:auto;"></div>
			
							</div>
							<div class="center aligned content">
								<label>${map.CENTER_NAME}</label>
								<div class="right floated meta" style="margin-top: 10px">${map.CENTER_TEL}</div>
							</div>
							<div class="center aligned content">
								${map.CENTER_ADDR}
							</div>
						</div>
					</div>											
				</c:if>
			</div>
			<div id="table_center_popup" style="display:none">
				<div id="map" style="width:500px; height:300px; margin:auto; margin-top:10px; display:none"></div>
				<jsp:include page="center_location_context.jsp"></jsp:include>
				<div class="ui center aligned container" id="container_pagination" style="margin-top: 20px">
				</div>
				<div class="ui right aligned container">
					<input type="button" class="ui disabled button" id="btn_add_myCenter" value="등록"/>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="modal_search_group_center.jsp"></jsp:include>
<!-- Modal -->
<div class="ui basic modal" id="modal_add_my_center">
	<div class="ui icon header">
		<i class="question icon"></i><br />
		내 센터 등록
	</div>
	<div class="ui center aligned content container">
		<p>해당 센터를 내 센터로 등록하시겠습니까?</p>
	</div>
	<div class="actions">
		<div class="ui red basic cancel inverted button">
			<i class="remove icon"></i>
			No
		</div>
		<div class="ui green ok inverted button">
			<i class="checkmark icon"></i>
			Yes
		</div>
	</div>
</div>

<script>
	var html = '';
	var mapLevel = 5;
	var defaultPage = 1, pageNumberCNT = 10, pageContentCNT = 10;
	var flagForSearch = 0;
	var flagForSearched = 0;
	var myCenterNo = '${map.CENTER_NO}';
	var curPageNum, startPageNum, prevPageNum, nextPageNum;
	var pageNumBtn = '';
	var tbodyId = $('.table_modal > .modal_tbody_group_center').attr('id');
	var tbodyIdCenterLocationContext = $('.center_location_table > .tbody_group_center').attr('id');
	
	
	function prevPagePagination(txt, page, totalPageNumCNT) {
		startPageNum = startPageNum - pageNumberCNT; 
		console.log('in:'+startPageNum);
		console.log('in:'+prevPageNum);
		pageNumPagination(txt, totalPageNumCNT);
		centerSearchWOMine('', myCenterNo, prevPageNum, tbodyId);
	}
	function nextPagePagination(txt, page, totalPageNumCNT) {
		startPageNum = nextPageNum;
		console.log('next_in:'+startPageNum);
		console.log('next_in:'+prevPageNum);
		console.log('next_in page:'+page);
		pageNumPagination(txt, totalPageNumCNT);
		centerSearchWOMine('', myCenterNo, page, tbodyId);
	}
	
	function pageNumPagination(txt, totalPageNumCNT) {
		console.log(tbodyId);
		console.log(txt);
		console.log('1: '+curPageNum);
		console.log('2: '+startPageNum);
		console.log('next: '+nextPageNum);
		console.log('prev: '+prevPageNum);
		pageNumBtn = '';
		pageNumBtn += '<div class="ui buttons">';
		
		if( (startPageNum !== 1) && ((totalPageNumCNT/10) >= 1) && ( (totalPageNumCNT%10) > 0) ) {
			pageNumBtn += '<button class="ui icon button" onclick="prevPagePagination(\''+txt+'\','+prevPageNum+','+totalPageNumCNT+')">';
			pageNumBtn += '<i class="left chevron icon"></i></button>';
		}
		for(var n = startPageNum; n < (startPageNum + pageNumberCNT); n++) {
			if(n > totalPageNumCNT) {
				break;
			}
			if(flagForSearch === 1) {
				if (flagForSearched === 1) {
					pageNumBtn += '<a href="#" onclick="centerSearchWOMine(\''+txt+'\',\''+myCenterNo+'\','+n+',\''+tbodyId+'\')" class="ui button">'+n+'</a>';	
				} else if (flagForSearched === 0) {
					pageNumBtn += '<a href="#" onclick="centerSearchWOMine(\'\',\''+myCenterNo+'\','+n+',\''+tbodyId+'\')" class="ui button">'+n+'</a>';
					
				}	
			} else if(flagForSearch === 0) {
				pageNumBtn += '<a href="#" onclick="centerSearch(\''+txt+'\','+n+',\''+tbodyId+'\')" class="ui button">'+n+'</a>';
			}
			
			nextPageNum = n;
			prevPageNum = n;
			
		};
		console.log('3: '+nextPageNum);
		nextPageNum += 1;
		console.log('4: '+nextPageNum);
		if( ((totalPageNumCNT/10) >= 1) && 
				( (totalPageNumCNT%10) > 0) && 
					( ( (totalPageNumCNT - nextPageNum) + pageNumberCNT ) >= pageNumberCNT ) ) {
			pageNumBtn += '<button class="ui icon button" onclick="nextPagePagination(\''+txt+'\','+nextPageNum+','+totalPageNumCNT+')">';
			pageNumBtn += '<i class="right chevron icon"></i></button>';
		}
		pageNumBtn += '</div>';
		$('#modal_container_pagination').html(pageNumBtn);
	}
	
	function centerSearchWOMine(txt, myCenter_No, page, tbd) {
		console.log(myCenter_No);
		$.get('ajax_center_search_except_mine.do?myCenterNo='+myCenter_No+'&addr='+txt+'&page='+page, 
			function(data) {
				html = ' ';
				var len = data.length;
				for (var i = 0; i < len; i++) {
					html += '<tr class="updateMyCenter_tr">';
						html += '<td>'+data[i].CENTER_AREA_NAME+'</td>';
						html += '<td class="center_name">'+data[i].CENTER_NAME+'</td>';
						html += '<td class="addr">'+data[i].CENTER_ADDR+'</td>';
						html += '<td>'+data[i].CENTER_TEL+'</td>';
					html += '</tr>';
			}
			$("#"+tbd).html(html);
			curPageNum = page;
			console.log(curPageNum);
		})
	}
	
	function centerSearch(txt, page, tbd) {
		$.get('ajax_center_search.do?addr='+txt+'&page='+page, function(data) {
			if (flagForSearch === 0) {
				html = '';
				$('#context').empty();
				html += '<div class="ui info message">';
				html += '<div class="header">원하시는 센터가 없거나 센터 정보가 올바르지 않습니까?</div>';
				html += '센터를 제보 및 수정을 원하시면 상단의 센터제보를 클릭해주세요.';
				html += '</div>';
				$('#context').html(html);
				document.getElementById("table_center_popup").style.display="block";
			}
			console.log(data);
			var tbody = '';
			var len = data.length;
			if(data != null) {
				for (var i = 0; i < len; i++) {
					if (flagForSearch === 0) {
						tbody += '<tr class="addMyCenter_tr">';
					} else if (flagForSearch === 1) {
						tbody += '<tr class="updateMyCenter_tr">';
					}
						tbody += '<td class>'+data[i].CENTER_AREA_NAME+'</td>';
						tbody += '<td class="center_name">'+data[i].CENTER_NAME+'</td>';
						tbody += '<td class="addr">'+data[i].CENTER_ADDR+'</td>';
						tbody += '<td>'+data[i].CENTER_TEL+'</td>';
					tbody += '</tr>';
				}
				$('#'+tbd).html(tbody);
			}
		})	
	}
	
	function centerSearchCNT(myCenter, searchCenter) {
		console.log(searchCenter);
		let myCntNo = 0;
		
		if (flagForSearch === 1) {
			myCntNo = myCenterNo;
		}
		//전체 갯수 읽어오기(txt를 안넘겨도됨)
		$.get('ajax_center_searchCNT.do?myCenterNo='+myCntNo+'&addr='+searchCenter, function(data) {
			//data는 page 갯수
			console.log(data);
			console.log(myCenter);
			if(searchCenter === '') {
				pageNumPagination(myCenter, data);	
			} else {
				pageNumPagination(searchCenter, data);
			}
			
		})
	}
	
	$(function() {
		
		console.log('내센터번호: '+myCenterNo);
		if( myCenterNo === '') {
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		    mapOption = {
		        center: new daum.maps.LatLng(35.13974, 129.09811), // 지도의 중심좌표
		        level: mapLevel // 지도의 확대 레벨
		    };	
			//지도를 미리 생성
			var map = new daum.maps.Map(mapContainer, mapOption);
			//마커를 미리 생성
			var marker;
			
			var coords;
		} else {
			console.log('다시들어옴');
			var coords2 = new daum.maps.LatLng('${map.CENTER_LAT}', '${map.CENTER_LNG}');
			var mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div		
			    mapOption2 = {
			        center: coords2, // 지도의 중심좌표
			        level: mapLevel // 지도의 확대 레벨
		    };	
			//지도를 미리 생성
			var map2 = new daum.maps.Map(mapContainer2, mapOption2);
			map2.setZoomable(false);
			map2.setDraggable(false);
			var marker2 = new daum.maps.Marker({
				map: map2,
				position: coords2
			});
		}
		
		var customOverlay = new daum.maps.CustomOverlay({
			clickable: true,
   			xAnchor : 0.5,
   			yAnchor : 1.6,
	   	});
		
		$(document).on('click', '.updateMyCenter_tr', function() {
			var idx = $(this).index('.updateMyCenter_tr');
			var addr = $('.addr').eq(idx).text();
			console.log(idx);
			console.log(addr);
			$('.updateMyCenter_tr').eq(idx).addClass("active");
			$('#modal_add_my_center').modal('show');
		})
		
		$('#modal_input_search_center').keypress(function(e) {
			var key = e.which;
			if (key == 13) { //엔터키
				$('#modal_btn_search_center').trigger("click");
				return false;
			}
		})

		$('#editMyCenter').on('click', function() {
			startPageNum = defaultPage;
			curPageNum = defaultPage;
			nextPageNum = defaultPage;
			prevPageNum = 0;
			var myCenter = '${map.CENTER_ADDR}';
			console.log(tbodyId);
			
			$('#searchGrpCenterModal').modal({
				onShow		: function() {
					flagForSearch = 1;
					centerSearchCNT(myCenter, '');
					centerSearchWOMine('', myCenterNo, defaultPage, tbodyId);
				},
				onHidden	: function() {
					console.log('modal fade out');
					$('#modal_input_search_center').val('');
					$('.modal_search_center').removeClass('error');
					flagForSearch = 0;
					flagForSearched = 0;
				}
			})
			.modal('show');
		});
		
		$('#modal_btn_search_center').on('click', function() {
			var id = '${sessionScope.SID}';
			var txt = $('#modal_input_search_center').val();
			var btn = '';
			
			console.log(id);
			if ((typeof id === 'undefined') || 
				(id === '')) {
				window.location.href="login.do";
				return false;
			}
			console.log(txt);
			if(txt.trim() === '') {
				console.log('공백임');
				$('.modal_search_center').addClass('error');
				return false;
			} else {
				$('.modal_search_center').removeClass('error');
			}
			flagForSearched = 1;
			flagForSearch = 1;
			$("#"+tbodyId).empty();
			centerSearchCNT('', txt);
			centerSearchWOMine(txt, myCenterNo, defaultPage, tbodyId);
		});
		
		
		$('#btn_add_myCenter').on('click', function() {
			$('#modal_add_my_center').modal('show');
		})
		
		$('.ok').on('click', function() {
			var myCenter = '${map.CENTER_NO}';
			if(myCenter === '') {
				// 센터 신규 등록
				myCenter = $('.tbody > .active > .addr').text();	
			} else {
				// 센터 변경
				myCenter = $('.modal_tbody_group_center > .active > .addr').text();
			}
			console.log(myCenter);
			$.ajax({
				url : "ajax_add_myCenter.do",
				method : "GET",
				data : {
					addr : myCenter,
					id : '${sessionScope.SID}'
					}
			})
			.done(function(data) {
				console.log(data);
				if(data === 0) {
					console.log('error');
				} else {
					console.log('success');
					window.location.href = "myCenter.do";
				}
			})
		})
		
		$('#search_btn').on('click', function() {
			var id = '${sessionScope.SID}';
			var txt = $('#search_txt').val();
			var btn = '';
			
			console.log(id);
			if ((typeof id === 'undefined') || 
				(id === '')) {
				window.location.href="login.do";
				return false;
			}
			console.log(txt);
			if(txt.trim() === '') {
				console.log('공백임');
				$('.search_center_class').addClass('error');
				return false;
			} else {
				$('.search_center_class').removeClass('error');
			}
			
			$.get('ajax_center_searchCNT.do?addr='+txt, function(data) {
				var cntlength = data+1;
				console.log(data);
				console.log(cntlength);
				console.log(txt);
				btn += '<div class="ui buttons">';
				for(var n=1; n < cntlength; n++) {
					btn += '<a href="#" onclick="centerSearch(\''+txt+'\','+n+',\''+tbodyIdCenterLocationContext+'\')" class="ui button">'+n+'</a>';
				}
				btn += '</div>';
				$('#container_pagination').html(btn);
				centerSearch(txt, defaultPage, tbodyIdCenterLocationContext);
			})
		})
		
		$('#search_txt').keypress(function(e) {
			var key = e.which;
			if (key == 13) { //엔터키
				$('#search_btn').trigger("click");
				return false;
			}
		})

		
		$(document).on('click', '.addMyCenter_tr', function() {
			console.log(coords);
			console.log(marker);

			if( typeof coords != 'undefined' ) {
				console.log(marker.getPosition());
				marker.setVisible(false);
			} 
			marker = new daum.maps.Marker({
				map: map
			});
			
			coords = '';
			console.log(coords);
			console.log(marker.getPosition());
			customOverlay.setMap(null);
			
			console.log("clicked!");
			var idx = $(this).index('.addMyCenter_tr');
			var addr = $('.addr').eq(idx).text();
			var tr = $('.addMyCenter_tr').eq(idx);
			$('.addMyCenter_tr').removeClass("active");
			tr.addClass("active");
			if( (tr.hasClass("active")) ) {
				$('#btn_add_myCenter').removeClass("disabled");
				$('#btn_add_myCenter').addClass("teal");
			}
			
			console.log(tr.hasClass("active"));
			
			console.log(idx);
			console.log(addr);
			
			$.ajax({
				url : "ajax_center_one.do",
				method : "GET",
				data : {addr : addr}
			})
			.done(function(data) {
				console.log(data);
				if (typeof data !== 'undefined') {
					marker.setMap(map);
					coords = new daum.maps.LatLng(data.CENTER_LAT, data.CENTER_LNG);
					customOverlay.setMap(map);
		   			map.panTo(coords);
		   			map.setLevel(mapLevel, {anchor: coords}, {animate:true});
		   			var iwContent = 
	       				'<div class="ui raised very padded text container segment" style="width: min-content; text-align:center; padding:6px 0;">'
	       					+'<div>'+data.CENTER_NAME+'</div>'
	       					+'<div>'+data.CENTER_ADDR+'</div><div>'+data.CENTER_TEL+'</div>'
	       				+'</div>';
	       			
                    // 지도를 보여준다.
                    mapContainer.style.display = "block";
                    map.relayout();
                    // 지도 중심을 변경한다.
                    map.setCenter(coords);
                    // 마커를 결과값으로 받은 위치로 옮긴다.
                    marker.setPosition(coords);
	       			daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker, coords, iwContent, customOverlay) );
				}
			});
				

		});
	})
	
	function makeClickListener(map, marker, coords, iwContent, customOverlay) {
		console.log('0');
		customOverlay.setMap(null);
    	return function() {
    		if(map.getLevel !== mapLevel) {
    			map.setLevel(mapLevel);
    		}
    		customOverlay.setPosition(coords);
   			customOverlay.setContent(iwContent);
    		console.log('1');
    		console.log(coords);
			
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
</script>
</body>
</html>