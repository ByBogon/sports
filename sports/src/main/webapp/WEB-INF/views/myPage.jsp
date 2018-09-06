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
<!-- jQuery and Bootstrap -->
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/semantic.min.js"></script>
</head>
<body>
<div class="ui page grid">
<jsp:include page="nav_main.jsp"></jsp:include>
<div class="ui container">
	<div class="ui two column padded grid">
		<div class="column">
			<div class="ui vertical menu">
				<div class="ui left pointing dropdown link item">
					<i class="dropdown icon"></i>
					내정보 관리
					<div class="menu">
						<div class="item">내 정보 수정하기</div>
						<div class="item">내 비밀번호 변경하기</div>
						<div class="item">탈퇴하기</div>
					</div>
				</div>
				<div class="item">
					주로 운동하는 장소 등록
				</div>
			</div>
		</div>
		<div class="column">
			<div class="ui container">
				<form class="ui fluid form">
					<div class="inline filed">
						<div class="ui pointing below label">
							현재 비밀번호를 입력해주세요.
						</div>
						<input type="password"/>
					</div>
				</form>
			</div>
			<div class="ui right aligned container">
				<input type="submit" class="ui primary button" value="확인">
			</div>
		</div>
	</div>
</div>
</div>

<script>
	$(function() {
		$('.ui.dropdown').dropdown();
	})
</script>
</body>
</html>