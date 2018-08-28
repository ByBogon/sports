<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
	<div class="container" style="margin:auto; margin-top: 20px">
		<div>
			<form:form action="open_group.do" method="post" modelAttribute="vo">
				<div class="form-inline">
					<label>모임명: </label>
					<form:input type="text" class="form-control" path="grp_name" placeholder="모임명"/>	
				</div>
				<div class="form-inline">
					<label>주최자: </label>
					<input type="text" class="form-control" readonly value="${sessionScope.SNAME}"/>
				</div>
				<div class="form-inline">
					<label>운동종목: </label>
					<form:select class="form-control" id="sports_genre" path="sports_no" items="${vo.map}"/>
				</div>
				<div class="form-inline">
					<input type="text" class="form-control" placeholder="장소"/>
					<input type="button" class="btn btn-secondary" value="찾기"/>
				</div>
				<input type="button" class="btn btn-primary btn-add" value="멤버추가"/>
				<input type="button" class="btn btn-danger btn-rmv" value="멤버삭제"/>
				<div style="float: right">
					<input type="submit" class="btn btn-success" value="모임생성"/>
					<a href="#" class="btn btn-dark">홈으로</a>
				</div>
			</form:form>
		</div>
		
		<div class="members">
			
		</div>
	</div>
	<jsp:include page="modal_add_group_mem.jsp"></jsp:include>
	
	<script>
	$(function() {
		$('.btn-add').on('click', function() {
			$('.tbody').empty();
			var no = $('#sports_genre').val();
			var id = '${sessionScope.SID}';
			console.log(no);
			console.log(id);
			$.get('ajax_grp_mem_list.do?no='+no+'&mem_id='+id, function(data) {
				console.log(data);
				var len = data.length;
				console.log(len);
				for(var i=0; i<len; i++) {
					$('.tbody').append(
						'<tr class="mem">'
						+'<td class="mem_id">'+data[i].mem_id+'</td>'
						+'<td>'+data[i].mem_name+'</td>'
						+'</tr>'
					);
				}				
				$('#insertGrpMemModal').modal('show');
				
			},'json');			
		})
		
		$('#insertGrpMemModal').on('shown.bs.modal', function() {
			$('#mem_table').on('click', '.mem', function() {
	    		console.log("clicked!");
	    		var idx = $(this).index('.mem');
	    		var mem_id = $('.mem_id').eq(idx).text();
	    		console.log(idx);
	    		console.log(mem_id);
	    		/* $.get('ajax_center_one.do?addr='+addr, function(data) {
	    			console.log(data);
	    			coords = new daum.maps.LatLng(data.CENTER_LAT, data.CENTER_LNG);
	       			mark = new daum.maps.Marker({
						position : coords
					});
	       			map.panTo(coords);
	       			map.setLevel(4, {anchor: coords}, {animate:true});
	       			
	       			document.getElementById('txt_search').scrollIntoView(true);
	       			
	    		}) */
	    	});
			
			$('#modal_txt_search_mem').keypress(function (e) {
	    		var key = e.which;
	    		if(key == 13) { //엔터키
	    			$('#modal_btn_search_mem').trigger("click");
	    			return false;
	    		}
	    	})
			$('#modal_btn_search_mem').on('click', function() {
				var mem = $('#modal_txt_search_mem').val();
				console.log(mem);
				$.get('ajax_search_member.do?mem='+mem, function(data) {
					$('.tbody').empty();
					$('.txt_msg').empty();
					console.log(data);
					var len = data.length;
					console.log(len);
					if(data != null && len != 0) {
						for(var i=0; i<len; i++) {
							$('.tbody').append(
								'<tr class="mem">'
								+'<td class="mem_id">'+data[i].mem_id+'</td>'
								+'<td>'+data[i].mem_name+'</td>'
								+'</tr>'
							);
						}	
					} else {
						$('.txt_msg').append(
							'<label>원하는 멤버를 찾지 못하였습니다</label>'		
						);
					}						
				})
			})
		})
	})	
	</script>
</body>
</html>
