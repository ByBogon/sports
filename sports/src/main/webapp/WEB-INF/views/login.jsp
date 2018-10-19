<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<html>
<head>
	<title>로그인</title>
    <link rel="stylesheet" href="resources/css/semantic.min.css">
    	    
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/sweetalert2.js"></script>
	<script src="resources/js/semantic.min.js"></script>
</head>
<style>
	.contents {
		position:relative;
		width: 100%;
		height: 100%;
	}
</style>
<body>
	<div class="contents" style="display: table;">
		<div class="ui fluid container" style="display: table-cell; vertical-align: middle">
			<div class="ui cards" style="margin: 0 auto; text-align: center; display: none">
				<div class="ui centered card login">
					<div class="image">
						<img src="resources/images/basketball.jpg"/>
					</div>
					<form action="login.do" method="post">
						<div class="content">
							<div class="ui large fluid input focus">
								<input type="text" id="id" name="username" placeholder="아이디"/>
							</div>
							<div class="ui large fluid input focus">
								<input type="password" id="pw" name="pass" placeholder="비밀번호"/>
							</div>
						</div>
						<div class="content" style="margin-top:10px; text-align:right">
							<input type="submit" class="ui primary button" id="btn_login" value="로그인"/>
							<a href="squash.do" class="ui button">홈으로</a>
						</div>
						<div class="center aligned content" style="margin-top:10px;">
							아이디가 없다면, <a href="join.do">회원가입</a> 먼저 하세요
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
	
	$(function() {
		$('.ui.cards').transition('slide up');
		
		$('#btn_login').on("click", function() {
			var a = $('#id').val();
			var b = $('pw').val();
			if ( (a === '') || (typeof a === undefined) ) {
				swal('입력오류', '아이디를 입력하세요.', 'warning');
				return false;
			}
			if ( (b === '') || (typeof b === undefined) ) {
				swal('입력오류', '패스워드를 입력하세요.', 'warning');
				return false;
			}
		});
	});
	</script>
</body>
</html>
