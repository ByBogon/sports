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
	.contents {
		position:relative;
		width: 100%;
		height: 100%;
	}
</style>
<body>
	<div class="ui page grid">
		<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="row">
			<div class="column padding-reset">
				<div class="contents" style="display: table">
			<div class="ui fluid container" style="display: table-cell; vertical-align: middle">
				<div class="ui centered card" style="width:100%">
					<div class="ui form content">
					<form action="join.do" method="post" name="join_form"
					id="join_form" onsubmit="return subCheck();">
						<hr />
						<div class="ui fluid container" style="margin-bottom: 5px">
							<div class="ui fluid labeled input action">
								<div class="ui label">아이디</div>
								<input type="text" name="id" id="id" placeholder="아이디" />
								<div class="ui primary button" id="btn-idcheck">중복확인</div>
							</div>
						</div>
						
						<div class="ui fluid container" style="margin-bottom: 5px">
							<div class="ui fluid labeled input action">
								<div class="ui label">암호</div>
								<input type="password" name="pw" class="form-control" id="pw" onkeyup="pwCheck()" />
							</div>
						</div>
						
						<div class="ui fluid container" style="margin-bottom: 5px">
							<div class="ui fluid labeled input action">
								<div class="ui label">암호확인</div>
								<input type="password" class="form-control" id="pw_chk"	name="pw_chk" onkeyup="pwCheck()" />
							</div>
							<div>
								<label id="check"></label>
							</div>
						</div>
						
						<div class="ui fluid container" style="margin-bottom: 5px">
							<div class="ui fluid labeled input action">
								<div class="ui label">이름</div>
								<input type="text" id="name" name="name" />
							</div>
						</div>
						
						<div class="ui fluid container" style="margin-bottom: 5px">
							<div class="ui fluid labeled input action">
								<div class="ui label">나이</div>
								<input type="text" id="age" name="age"/>
							</div>
						</div>
						
						<div class="ui fluid container" style="margin-bottom: 5px">
							<div class="ui fluid labeled input action">
								<div class="ui label">이메일</div>
								<input type="text" id="email" name="email"/>
								<div class="ui dropdown label" id="drops" name="selected" onchange="dropdownChange()">
									<div class="text">gmail.com</div>
									<i class="dropdown icon"></i>
									<div class="menu">
										<div class="item" data-value="gmail.com">gmail.com</div>
										<div class="item" data-value="hanmail.com">hanmail.com</div>
										<div class="item" data-value="naver.com">naver.com</div>
										<div class="item" data-value="daum.net">daum.net</div>
										<div class="item" data-value="select">직접 입력</div>
									</div>
								</div>
							</div>
							<input type="hidden" id="emails" name="emails" />
						</div>
			
						
						<div class="ui right aligned container">
							<div class="ui input">
								<input type="text" id="type_in" name="type_in" style="display: none;" />
							</div>
							
						</div>
					</form>
				</div>
				<div class="extra content">
					<input type="submit" class="ui positive button submit" id="submit" value="회원가입"	/>
					<a href="squash.do" class="ui black button">홈으로</a>
				</div>
			</div>
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
						$('#btn-idcheck').text('사용가능');
						$('#btn-idcheck').attr('class', 'ui green button');
					} else if (data > 0) {
						$('#btn-idcheck').text('사용불가');
						$('#btn-idcheck').attr('class', 'ui red button');
					}
					console.log(data)
				}, 'json');
			}
			else {
				$('#btn-idcheck').text('중복확인');
				$('#btn-idcheck').attr('class', 'ui blue button');
			}
		});
	});
	function pwCheck() {
		var pw = document.getElementById("pw").value;
		var pw_chk = document.getElementById("pw_chk").value;

		if ((pw === pw_chk)) {
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

