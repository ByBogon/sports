<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script src="resources/js/semantic.min.js"></script>
<script src="resources/js/nav_bar.js?ver=1"></script>
</head>
<body>
<div class="ui page grid">
<jsp:include page="nav_main.jsp"></jsp:include>
	<div class="ui two column vertically padded grid" style="width:100%">
	<div class="row">
		<div class="column">
			<div class="ui vertical menu">
				<div class="ui left pointing dropdown link item">
					<i class="dropdown icon"></i>
					내정보 관리
					<div class="menu">
						<a href="myPage.do" class="item">내 정보 수정하기</a>
						<a href="#" class="item">내 비밀번호 변경하기</a>
						<a href="#" class="item">탈퇴하기</a>
					</div>
				</div>
				<a href="#" class="item">운동 센터 등록</a>
			</div>
		</div>
		<div class="column">
			<div class="ui container context" id="context">
				<form class="ui form">
					<div class="field">
						<div class="ui pointing below label">
							현재 비밀번호를 입력해주세요.
						</div>
						<input type="password" id="pw"/>
					</div>
					<div id="message">
					
					</div>
				</form>
			</div>
			<div class="ui right aligned container" style="margin-top: 10px">
				<input type="submit" class="ui primary button" id="pwchk" value="확인">
			</div>
		</div>
		</div>
	</div>
</div>

<script>

	$(function() {
		$('.ui.dropdown').dropdown();
		$(document).on('click', '.ui.inverted.button', function() {
			console.log('clicked');
		})
		
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
							$.post('ajaxSelectMemOne.do', {mem_id : data.MEM_ID}, function(data) {
								
								$('.ui.container.context').empty();
								html += '<div class="ui special cards"><div class="card">';
								html += '<div class="blurring dimmable image"> <div class="ui dimmer">';
								html += '<div class="content"> <div class="center">';
								html += '<div class="ui inverted button" id="profile">이미지 변경</div>';
							    html += '</div></div></div>';
							    html += '<img src="resources/images/matthew.png"></div>';
								html += '<div class="floating ui teal label">Default</div>';
							   	html += '<div class="content">';
							    html += '<a class="header">'+data.MEM_NAME+'</a>';
							    html += '<div class="meta">';
							    html += '<span class="age">'+data.MEM_AGE+'</span>';
							    html += '<span class="email">'+data.MEM_EMAIL+'</span>';
							    html += '</div></div>';
							    html += '<div class="right aligned extra content">Within '+data.MCNT+' Groups</div>';
							  	html += '</div>';
								html += '</div>';
								
								$('.ui.container.context').html(html);
								$('.special.cards .image').dimmer({
									on: 'hover'
								});

								
							})
						}
					}
				})
			}
		})
		
	})
</script>
</body>
</html>