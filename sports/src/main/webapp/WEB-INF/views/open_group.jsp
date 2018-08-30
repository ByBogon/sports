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
    <link rel="stylesheet" href="resources/css/semantic.min.css">
	<!-- jQuery and Bootstrap -->
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
</head>
<style>
	.highlight {
		background-color:gray;
	}
</style>
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
		<div class="ui link special cards members" style="margin-top: 20px">
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="modal_del_grp_mem" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">멤버 삭제</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				...
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-secondary" data-dismiss="modal" value="취소"/>
					<input type="submit" class="btn btn-danger" value="삭제"/>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="modal_add_group_mem.jsp"></jsp:include>
	
	<script>
	var id_list = [];
	var cardIdList = [];
	var rmIdList = [];
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
	$(function() {
		$('.btn-rmv').on('click', function() {
			rmIdList.length = 0;
			$('.members').find('.card').each(function() {
				var idx = $(this).index('.card');
				var chk = $('.grp_mem_chck').eq(idx);
				var rmId = chk.val();
				if(chk.is(":checked")) {
					rmIdList.push(rmId);
				}
			})
			console.log(rmIdList.length);
			if(rmIdList.length == 0) {
			} else {
				$('#modal_del_grp_mem').modal('show');	
			}
		})
		$('.members').on('click', '.card', function() {
			var idx = $(this).index('.card');
			console.log(idx);
			var check = $('.grp_mem_chck').eq(idx);
			if(check.is(":checked")) {
   				check.prop('checked', false);
   			} else {
   				check.prop('checked', true);
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
		    		if(id == mem_id) {
		    			mem_id_eq.parent().addClass("highlight");
		    			check.prop('checked', true);
		    		}
				})
			})
		})
		$('#modal_add_grp_mem').on('click', function(e) {
			console.log(id_list.length);
			$.each(id_list, function(index, val) {
				console.log(val);
			})
			e.preventDefault();
			$.ajax({
				traditional : true,
				type	: "POST",
				url		: "ajax_add_grp_mem.do",
				data	: {id_list:id_list},
				success: function(data) {
					console.log(data);
					var len = data.length;
					console.log(len);
					for(var i=0; i<len; i++) {
						$('.members').append(
							'<div class="card">'
								+'<div class="image">'
									+'<img src="resources/images/elyse.png">'
								+'</div>'
								+'<div class="content">'
									+'<div class="header">'+data[i].mem_name+'</div>'
									+'<div class="meta">'+data[i].mem_id+'</div>'
								+'</div>'
								+'<div class="extra content">'
									+'<span class="left floated">'
									+'<input type="checkbox" class="grp_mem_chck" name="grp_chk[]" '
										+'value="'+data[i].mem_id+'"/>'
									+'</span>'
									+'<span class="right floated">'+data[i].level_name+'</span>'
								+'</div>'
							+'</div>'
						);
					}
					id_list.length = 0;
				},
				error: function (error) {
					console.log(error);
				}
			})
			$('#insertGrpMemModal').modal('hide');
			return false;
		})
		
		// 모달이 hide 이벤트를 시작할때는 .on('hide.bs.modal')
		// 모달이 없어진뒤 함수
		$('#insertGrpMemModal').on('hidden.bs.modal', function() {
			id_list.length = 0;
			console.log('hide: '+id_list.length);
		});
		$('#mem_table').on('click', '.mem', function(){
			var idx = $(this).index('.mem');
			var check = $('.mem_chck').eq(idx);
			console.log("clicked!");
			var mem_id_eq = $('.mem_id').eq(idx);
    		var mem_id = mem_id_eq.text();
    		console.log(idx);
    		console.log(mem_id);
   			if(check.is(":checked")) {
   				check.prop('checked', false);
   				mem_id_eq.parent().removeClass("highlight");
   				id_list.splice($.inArray(mem_id, id_list), 1);
   				console.log('size:'+id_list.length);
   			} else {
   				check.prop('checked', true);
   				mem_id_eq.parent().addClass("highlight");
   	    		id_list.push(mem_id);
   	    		console.log('size:'+id_list.length);
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
				console.log('cardIds: '+val);
			})
			$('.tbody').empty();
			var no = $('#sports_genre').val();
			var id = '${sessionScope.SID}';
			console.log(no);
			console.log(id);
			
			$.ajax({
				url		: 'ajax_grp_mem_list.do',
				data	: {no:no, mem_id:id, idList:cardIdList},
				dataType: 'json',
				traditional: true,
				success: function(data) {
					console.log(data);
					var len = data.length;
					console.log(len);
					for(var i=0; i<len; i++) {
						$('.tbody').append(
							'<tr class="mem" id="mem">'
							+'<td><input type="checkbox" class="mem_chck" name="chk[]" '
							+'value="'+data[i].mem_id+'"/></td>'
							+'<td class="mem_id">'+data[i].mem_id+'</td>'
							+'<td>'+data[i].mem_name+'</td>'
							+'</tr>'
						);
					}
					$('#insertGrpMemModal').modal('show');
					return false;
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
			$.get('ajax_search_member.do?mem='+mem+'&myid='+myid+'&myname='+myname,
					function(data) {
				$('.tbody').empty();
				$('.txt_msg').empty();
				console.log(data);
				var len = data.length;
				console.log(len);
				if(data != null && len != 0) {
					for(var i=0; i<len; i++) {
						$('.tbody').append(
							'<tr class="mem">'
							+'<td><input type="checkbox" class="mem_chck" name="chk[]" '
							+'value="'+data[i].mem_id+'"/></td>'
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
		
		$('#modal_txt_search_mem').keypress(function (e) {
    		var key = e.which;
    		if(key == 13) { //엔터키
    			$('#modal_btn_search_mem').trigger("click");
    			return false;
    		}
	    })
		
	})	
	</script>
</body>
</html>
