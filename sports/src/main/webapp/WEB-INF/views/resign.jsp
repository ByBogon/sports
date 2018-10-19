<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="resources/css/semantic.min.css?ver=1">
<link rel="stylesheet" href="resources/css/nav_bar.css?ver=2">
<!-- jQuery and Bootstrap -->
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/semantic.min.js?ver=1"></script>
<script src="resources/js/nav_bar.js?ver=1"></script>

</head>
<body>
	<div class="ui page grid">
	<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="ui grid" style="width:100%; margin-top: 20px">
			<jsp:include page="myPageMenuOnLeft.jsp"></jsp:include>
			<div class="right floated column" style="width:70%">
				<div class="ui container context" id="context">
					<form class="ui action input form" style="margin-top: 10px">
						<div class="inline field">
							<div class="ui right pointing label">
								현재 비밀번호를 입력해주세요.
							</div>
							<input type="password" id="pw"/>
							<input type="submit" class="ui primary button" id="pwchk" value="확인"/>
						</div>
						<div id="message">
						
						</div>
					</form>
				</div>
				<div class="ui right aligned container btn-container" style="margin-top: 10px">
				</div>
			</div>
		</div>
	</div>
<!-- Modal -->
<div class="ui basic modal" id="modal_resign_account">
	<div class="ui icon header">
		<i class="exclamation icon"></i><br />
		계정 탈퇴
	</div>
	<div class="ui center aligned content container">
		<p>정말 계정을 탈퇴하시겠습니까?</p>
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
	$(function() {
		
		$('#pw').keypress(function(e) {
			var key = e.which;
			if (key == 13) { //엔터키
				$('#pwchk').trigger("click");
				return false;
			}
		})
		
		$('#pwchk').on('click', function(e) {
			e.preventDefault();
			var id = '${sessionScope.SID}';
			var pw = $('#pw').val();
			var html = '';
			var form_tag = ' ';
			var form = $('.ui.form');
			console.log(form);
			console.log(id);
			console.log(pw);
			if((pw.trim() === "") || (pw.trim() === null)) {
				form.attr('class', 'ui form warning');	
				html += '<div class="ui warning message">';
					html += '<div class="header">비밀번호 미입력</div>';
					html += '<ul class="list">';
						html += '<li>비밀번호 입력란이 비었습니다</li>';
					html += '</ul>';
				html += '</div>';
				$('#message').html(html);
				return false;
			} else {
				$.ajax({
					url		: 'ajaxPwCheck.do',
					method	: 'POST',
					data	: {	
								id : id,
								pw : pw.trim()
							  },
					success : function(data) {
						console.log(data);
						if((data === null) || (data === "")) {
							form.attr('class', 'ui form error');	
							html += '<div class="ui error message">';
								html += '<div class="header">비밀번호 오류</div>';
								html += '<ul class="list">';
									html += '<li>잘못된 비밀번호 입니다</li>';
								html += '</ul>';
							html += '</div>';
							$('#message').html(html);
							return false;
						} else {
							$('#modal_resign_account').modal({
								onHidden	: function() {
									console.log('modal fade out');
									$('#pw').val('');
								}
							})
							.modal('show');
							$('#modal_resign_account').modal('refresh');
						}
					}
				})
			}
		})
		
		$('.ok').on('click', function() {
			var id = '${sessionScope.SID}';
			var pw = $('#pw').val();
			$.ajax({
				url		: 'ajax_block_account.do',
				method	: 'POST',
				data	: {	
							id : id,
							pw : pw.trim()
						  },
				success : function(data) {
					if(data === 1) {
						window.location.href = "squash.do";
					} else {
						console.log('삭제 실패');
					}
				}
			})
		})
	})
</script>
</body>
</html>