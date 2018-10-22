<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
	<meta charset="utf-8">
	<title>가입하기</title>
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	<!-- 
	<link rel="stylesheet" href="resources/css/bootstrap.min.css">
	 -->
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
											<div class="ui icon button" id="btn-idcheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">암호</div>
											<input type="password" name="pw" id="pw" placeholder="암호" onkeyup="pwCheck()" />
											<div class="ui icon button" id="btn-pw">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">암호 확인</div>
											<input type="password" placeholder="암호확인" id="pw_chk"	name="pw_chk" onkeyup="pwCheck()" />
											<div class="ui icon button" id="btn-pwcheck">
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
											<input type="text" id="name" name="name" placeholder="이름" />
											<div class="ui icon button" id="btn-namecheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">나이</div>
											<input type="text" id="age" name="age" placeholder="나이"/>
											<div class="ui icon button" id="btn-agecheck">
												<i class="question icon"></i>
											</div>
										</div>
									</div>
									
									<div class="ui fluid container" style="margin-bottom: 5px">
										<div class="ui fluid labeled input action">
											<div class="ui center aligned label">이메일</div>
											<input type="text" id="email" name="email" placeholder="example@example.com"/>
											<div class="ui icon button" id="btn-emailcheck">
												<i class="question icon"></i>
											</div>
										</div>
										<input type="hidden" id="emails" name="emails" />
									</div>
									
									<div class="ui right aligned container">
										<div class="ui input">
											<input type="text" id="type_in" name="type_in" style="display: none;" />
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
	function pwCheck() {
		var pw = document.getElementById("pw").value;
		var pw_chk = document.getElementById("pw_chk").value;
		console.log(pw);
		console.log(pw_chk);
		if ( (pw === '') || (pw_chk === '') ) {
			return false;
		}
		if (pw === pw_chk) {
			document.getElementById("check").innerHTML = "암호 일치"
		} else {
			document.getElementById("check").innerHTML = "암호 불일치"
		}
	}

	function dropdownChange() {
		var dropDown = document.getElementById('drops');
		var textBox = document.getElementById('type_in');
		var elements = dropDown.options;
		if (elements[dropDown.selectedIndex].value === "select") {
			textBox.style.display = 'block';
			dropDown.style.display = 'none';
			dropDown.value = "";
			textBox.value = "";
		} else {
			textBox.style.display = 'block';
			dropDown.style.display = 'none';
			
			textBox.value = elements[dropDown.selectedIndex].value;
		}
	}

	function subCheck() {
		if (document.getElementById("id").value == "") {
			alert('ID를 입력하세요');
			return false;
		}
		if (document.getElementById("pw").value == "") {
			alert('PW를 입력하세요');
			return false;
		}
		if (document.getElementById("pw_chk").value == "") {
			alert('암호 확인을 입력하세요');
			return false;
		}
		if (document.getElementById("name").value == "") {
			alert('이름을 입력하세요');
			return false;
		}
		if (document.getElementById("age").value == "") {
			alert('나이를 입력하세요');
			return false;
		}
		if (document.getElementById("email").value == "") {
			alert('이메일을 입력하세요');
			return false;
		}
		if (document.getElementById("type_in").style.display != "none") {
			if (document.getElementById("type_in").value == "") {
				alert('이메일 형식을 확인하세요');
				return false
			}
		} else if (document.getElementById("type_in").style.display == "none") {
			if (document.getElementById("drops").value == "") {
				alert('이메일 형식을 확인하세요');
				return false;
			}
		}
		var sep = '@';
		console.log('submit');
		console.log($('#email').val());
		if(($('#type_in').val()).trim() !== '') {
			console.log('trim');
			$('#emails').val( ($('#email').val()) + sep + ($('#type_in').val()).trim());
		} else {
			console.log('type_in');
			$('#emails').val( ($('#email').val()) + sep + $('#drops').val() );
		}
	}
</script>
</html>

