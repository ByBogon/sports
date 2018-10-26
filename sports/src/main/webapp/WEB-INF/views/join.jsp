<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
	<meta charset="utf-8">
	<title>가입하기</title>
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	
    <link rel="shortcut icon" href="resources/images/favicon.ico">
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css">
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
</head>
<style>
	.center.aligned.label {
		min-width: 15%
	}
	.noHover {
		pointer-events: none;
	}
</style>
<body>
	<div class="ui page grid">
		<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="row" style="margin-top: 150px">
			<div class="column padding-reset">
				<div class="contents" >
					<div class="ui fluid container" >
						<form action="join.do" method="post" name="join_form"
									id="join_form" onsubmit="return subCheck();">
							<div class="ui centered card" style="width:70%">
								<div class="ui form content">
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">아이디</div>
											<input type="text" name="id" id="id" placeholder="아이디" />
											<div class="ui icon button noHover" id="btn-idcheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">암호</div>
											<input type="password" name="pw" id="pw" placeholder="암호" onkeyup="pwCheck()" />
											<div class="ui icon button noHover" id="btn-pw">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">암호 확인</div>
											<input type="password" placeholder="암호확인" id="pw_chk"	name="pw_chk" onkeyup="pwCheck()" />
											<div class="ui icon button noHover" id="btn-pwcheck">
												<i class="question icon"></i>
											</div>
										</div>
										<div>
											<label id="check"></label>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">이름</div>
											<input type="text" id="name" name="name" placeholder="이름" onkeyup="nameCheck()"/>
											<div class="ui icon button noHover" id="btn-namecheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">나이</div>
											<input type="text" id="age" name="age" placeholder="나이" onkeyup="ageCheck()" />
											<div class="ui icon button noHover" id="btn-agecheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">이메일</div>
											<input type="text" id="email" name="email" placeholder="example@example.com" onkeyup="emailCheck()"/>
											<div class="ui icon button noHover" id="btn-emailcheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
								</div>
							<div class="right aligned extra content">
								<input type="submit" class="ui positive button submit" id="submit" value="회원가입"	/>
								<a href="squash.do" class="ui black button">홈으로</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
		
</div>

</body>

<!-- 
<div class="form-inline" style="margin-bottom: 5px">
	<div style="width: 100px">
		<label>이메일</label>
	</div>
	<div style="margin-right: 10px">
		<input type="text" id="email" name="email" class="form-control" />
	</div>
	<div style="width: 20px">
		<label>@</label>
	</div>
	<div>
		<input type="hidden" id="emails" name="emails" />
		<select class="ui dropdown" id="drops" name="selected" onchange="dropdownChange()">
			<option value="gmail.com" selected>gmail.com</option>
			<option value="hanmail.com">hanmail.com</option>
			<option value="naver.com">naver.com</option>
			<option value="daum.net">daum.net</option>
			<option value="select">직접 입력</option>
		</select>
	</div>
</div>
-->
<script type="text/javascript">
	$(function(){
		$('.ui.dropdown').dropdown();
		
		$('#id').keyup(function(){
			var a = $('#id').val();
			console.log(a);
			if (a.length > 0) {
				console.log("if문 안");
				$.get('ajax_id_check.do?id='+a, function(data){
					console.log("get안");
					if (data == 0) {
						$('#btn-idcheck').attr('class', 'ui green icon button');
						$('#btn-idcheck').children().attr('class', 'check icon');
					} else if (data > 0) {
						$('#btn-idcheck').attr('class', 'ui red icon button');
						$('#btn-idcheck').children().attr('class', 'x icon');
					}
					console.log(data)
				}, 'json');
			}
			else {
				$('#btn-idcheck').attr('class', 'ui icon button');
				$('#btn-idcheck').children().attr('class', 'question icon');
			}
		});
	});
	
	function emailCheck() {
		var email = document.getElementById("email").value;
		var at = email.indexOf('@');
		var dot = email.indexOf('.');
		console.log(email);
		if ( (email === '') || (at <= 0) || (at > dot) ) {
			$('#btn-emailcheck').attr('class', 'ui red icon button');
			$('#btn-emailcheck').children().attr('class', 'x icon');
		} else if ( (email !== '') && (at > 0) && (at < dot) ) {
			$('#btn-emailcheck').attr('class', 'ui green icon button');
			$('#btn-emailcheck').children().attr('class', 'check icon');
		}
	}
	
	function ageCheck() {
		var age = document.getElementById("age").value;
		console.log(typeof age);
		if ( (age === '') || (age.match(/^[0-9]+$/) == null ) ) {
			$('#btn-agecheck').attr('class', 'ui red icon button');
			$('#btn-agecheck').children().attr('class', 'x icon');
		} else if ( (age !== '') && (age.match(/^[0-9]+$/) != null) ){
			$('#btn-agecheck').attr('class', 'ui green icon button');
			$('#btn-agecheck').children().attr('class', 'check icon');
		}
	}
	
	function nameCheck() {
		var name = document.getElementById("name").value;
		console.log(name);
		if ( name === '' ) {
			$('#btn-namecheck').attr('class', 'ui red icon button');
			$('#btn-namecheck').children().attr('class', 'x icon');
		} else {
			$('#btn-namecheck').attr('class', 'ui green icon button');
			$('#btn-namecheck').children().attr('class', 'check icon');
		}
	}
	
	function pwCheck() {
		var pw = document.getElementById("pw").value;
		var pw_chk = document.getElementById("pw_chk").value;
		console.log(pw);
		console.log(pw_chk);
		if ( (pw === '') || (pw_chk === '') ) {
			$('#btn-pw').attr('class', 'ui icon button');
			$('#btn-pw').children().attr('class', 'question icon');

			$('#btn-pwcheck').attr('class', 'ui icon button');
			$('#btn-pwcheck').children().attr('class', 'question icon');
		}
		if ( (pw === pw_chk) && pw !== '' ) {
			$('#btn-pw').attr('class', 'ui green icon button');
			$('#btn-pwcheck').attr('class', 'ui green icon button');
			
			$('#btn-pw').children().attr('class', 'check icon');
			$('#btn-pwcheck').children().attr('class', 'check icon');
		} else {
			$('#btn-pw').attr('class', 'ui red icon button');
			$('#btn-pwcheck').attr('class', 'ui red icon button');
			
			$('#btn-pw').children().attr('class', 'x icon');
			$('#btn-pwcheck').children().attr('class', 'x icon');
		}
	}

	function subCheck() {
		if ( !(document.getElementById("btn-idcheck").classList.contains("green")) ) {
			alert('아이디를 다시 확인해주세요');
			return false;
		}
		if ( !(document.getElementById("btn-pw").classList.contains("green")) ) {
			alert('암호를 다시 확인해주세요');
			return false;
		}
		if ( !(document.getElementById("btn-pwcheck").classList.contains("green")) ) {
			alert('암호와 암호 확인이 일치하지 않습니다');
			return false;
		}
		if ( !(document.getElementById("btn-namecheck").classList.contains("green")) ) {
			alert('이름을 다시 확인해주세요');
			return false;
		}
		if ( !(document.getElementById("btn-agecheck").classList.contains("green")) ) {
			alert('나이를 다시 확인해주세요');
			return false;
		}
		if ( !(document.getElementById("btn-emailcheck").classList.contains("green")) ) {
			alert('이메일의 형식 및 입력을 다시 확인해주세요');
			return false;
		}
	}
</script>
</html>

