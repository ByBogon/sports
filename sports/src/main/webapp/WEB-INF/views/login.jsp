<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<html>
<head>
	<title>로그인</title>
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="resources/css/semantic.min.css">
</head>
<style>
	.contents {
		position:relative;
  		width:100%;
  		height:100%;
	}
	.login {
		position:absolute;
		top:50%;
		left:50%;
	}
</style>
<body>
	<div class="contents">
		
		<div class="ui container login">
			<div class="ui centerd card">
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
						<a href="sports.do" class="ui button">홈으로</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	    
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/sweetalert2.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script>
	$('.login').each(function(){
		// determine the real dimensions of the element: http://api.jquery.com/outerWidth/
		var x = $(this).outerWidth();
		var y = $(this).outerHeight();
		// adjust parent dimensions to fit child
		if($(this).parent().height() < y) {
		  $(this).parent().css({height: y + 'px'});
		}
		// offset the child element using negative margins to "center" in both axes
		$(this).css({marginTop: 0-(y/2)+'px', marginLeft: 0-(x/2)+'px'});
	});
	//jquery 사용
	$(function() {
		//id가 btn-login인 개체를 찾고 클릭이 되는 경우에 반응
		$('#btn_login').on("click", function() {
			//input 태그중에서 name 값이 id인 것의 입력값을 가져와서 a에 보관
			var a = $('#id').val();
			//input 태그중에서 name 값이 pw인 것의 입력값을 가져와서 b에 보관
			var b = $('pw').val();

			console.log(a);
			console.log(b);

			if (a == '' || a == undefined) {
				swal('입력오류', '아이디를 입력하세요.', 'warning');
				$('#id').focus();
				return false;
			}

			if (b == '' || b == undefiend) {
				swal('입력오류', '패스워드를 입력하세요.', 'warning');
				$('#pw').focus();
				return false;
			}

		});
	});
	</script>
</body>
</html>
