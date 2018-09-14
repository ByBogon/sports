<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/semantic.min.css">
<link rel="stylesheet" href="resources/css/nav_bar.css?ver=2">
<!-- jQuery and Bootstrap -->
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
			<div class="ui right aligned container btn-container" style="margin-top: 10px">
				<c:if test="${CENTER_NO == null}">
				<div class="ui action input">
					<input type="text" id="search_txt" placeholder="센터명/주소"/>
					<button class="ui icon button search" id="search_btn">
						<i class="search icon"></i>
					</button>
				</div>
				<!-- <input type="button" class="ui button primary" value="검색"/> -->
				</c:if>
			</div>
			<div class="ui container context" id="context">
				<c:if test="${CENTER_NO == null}">
					<div class="ui info message">
						<div class="header">
							등록된 센터가 없습니다.
						</div>
						센터를 추가하시려면 검색창을 이용해 주세요.
					</div>
				</c:if>
			</div>
			<div id="table_center_popup" style="display:none">
				<jsp:include page="center_location_context.jsp"></jsp:include>
			</div>
			
		</div>
	</div>
</div>

<script>
$(function() {
	$('#search_btn').on('click', function() {
		var txt = $('#search_txt').val();
		console.log(txt);
		if(txt.trim() === '') {
			console.log('공백임');
			return false;
		}
		$.get('ajax_center_search.do?addr='+txt, function(data) {
			$('#context').empty();
			$('.tbody').empty();
			document.getElementById("table_center_popup").style.display="block";
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
		
	})
	$('#search_txt').keypress(function(e) {
		var key = e.which;
		if (key == 13) { //엔터키
			$('#search_btn').trigger("click");
			return false;
		}
	})
})
	
</script>
</body>
</html>