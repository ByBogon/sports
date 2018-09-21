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
	<div>
		<div class="ui two column padded grid">
			<div class="column">
				<div class="ui container" style="margin: auto; margin-top: 20px;">
					<div class="form-inline" style="margin-top: 20px">
						<label>모임명: </label>
						<input type="text" class="form-control" id="grp_name" name="grp_name" placeholder="모임명" />
					</div>
					<div class="form-inline" style="margin-top: 20px">
						<label>주최자: </label>
						<input type="text" class="form-control" id="grp_leader" name="grp_leader"  readonly value="${sessionScope.SNAME}" />
					</div>
					<div class="form-inline" style="margin-top: 20px">
						<label>운동종목: </label>
						<select class="form-control" id="sports_genre" name="grp_leader">
							<c:forEach var="genre" items="${list}" varStatus="i">
								<option value="${i.index}">${genre}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-inline" style="margin-top: 20px">
						<label>센터 찾기: </label>
						<input type="text" class="form-control"	id="txt_center"	name="txt_center" placeholder="센터명/주소" autocomplete="off"/>
						<input type="button" class="btn btn-secondary btn-search-center" value="찾기" />
					</div>
					<div class="form-inline" style="margin-top: 20px">
						<label>직접 입력: </label>
						<input type="text" class="form-control" id="txt_addr" name="txt_addr" autocomplete="off"/>
						<input type="button" class="btn btn-secondary btn-search-addr" onclick="daumPostcode()" value="주소 검색" />
					</div>
				</div>
			</div>
			<div class="column">
				<div id="map" style="width:300px; height:300px; margin:auto; margin-top:10px; display:none"></div>
			</div>
		</div>
		<div class="ui two column padded grid">
			<div class="column">
				<div class="ui container">
					<div style="margin-top: 20px">
						<input type="button" class="btn btn-primary btn-add" value="멤버추가" />
						<input type="button" class="btn btn-danger btn-rmv" id="btn-rmv" value="멤버삭제" />
					</div>
				</div>
			</div>
			<div class="column">
				<input type="button" class="btn btn-success btn-create" value="모임생성" />
				<a href="#" class="btn btn-dark">홈으로</a>
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
	function centerSearch(txt, page) {
		$.get('ajax_center_search.do?addr='+txt+'&page='+page, function(data) {
			var len = data.length;
			var html = '';
			for (var i = 0; i < len; i++) {
				html += '<tr class="center_tr">';
					html += '<td class>'+data[i].CENTER_AREA_NAME+'</td>';
					html += '<td class="center_name">'+data[i].CENTER_NAME+'</td>';
					html += '<td>'+data[i].CENTER_ADDR+'</td>';
					html += '<td>'+data[i].CENTER_TEL+'</td>';
				html += '</tr>';
			}
			$('#tbody_group_center').html(html);
		})
	}
	window.onload = clickableDelBtn;
	$(function() {
		$('.btn-create').on('click', function(e) {
			console.log('clicked!');
			e.preventDefault();
			var grp = $('#grp_name').val();
			var leader = $('#grp_leader').val();
			if(grp.trim() === null || grp.trim().length === 0) {
				//그룹명 정하게 Alert나 여러가지 띄울것
				console.log('그룹명 정하세요');
				return false;
			}
			if(leader === null || leader.length === 0) {
				//로그인 하라고 하기(로그인페이지로 리다이렉트)
				console.log('로그인 안되어있음');
				return false;
			}
			var checkedIds = havingCardIds();
			$.each(checkedIds, function(index, val) {
				console.log(val);
			})

			document.location = '/sports/makeOneGroup.do?grp_name='+grp
					+'&grp_leader='+leader+'&memList='+checkedIds;
			
		})

		$('#center_table').on('click', '.center_tr', function() {
			var idx = $(this).index('.center_tr');
			var centerName = $('.center_name').eq(idx).text();
			$('#txt_center').val(centerName);
			$('#searchGrpCenterModal').modal('hide');
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
				centerSearch(center, defaultPage);
			})
			$('#searchGrpCenterModal').modal('show');
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
			cardIdList = havingCardIds();
			console.log(cardIdList.length);
			$.each(cardIdList, function(index, val) {
				console.log('cardIds: ' + val);
			})
			$('.tbody').empty();
			var no = $('#sports_genre').val();
			var id = '${sessionScope.SID}';
			console.log(no);
			console.log(id);
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
						$('#insertGrpMemModal').modal('show');
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
	})
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

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

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
</body>
</html>
