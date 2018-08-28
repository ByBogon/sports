<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
</head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
<style>
	.box600 {
		width	: 600px;
		border	: 1px solid #cccccc;
		padding	: 30px;
		margin	: 0px auto;	
		margin-top : 10%;	
	}
</style>
<body>
	<jsp:include page="nav_main.jsp"></jsp:include>
	<form action="join.do" method="post" name="join_form"
		onsubmit="return subCheck();">
		<div class="box600">
			<hr />
			<div class="form-inline" style="margin-bottom: 5px">
				<div style="width: 100px">
					<label>아이디</label>
				</div>
				<div style="margin-right: 10px">
					<input type="text" name="id" id="id" class="form-control"
						placeholder="아이디" />
				</div>
				<div>
					<input type="button" class="btn btn-primary" id="btn-idcheck"
						value="중복확인" />
				</div>
			</div>

			<div class="form-inline" style="margin-bottom: 5px">

				<div style="width: 100px">
					<label>암호</label>
				</div>
				<div>
					<input type="password" name="pw" class="form-control" id="pw"
						 onkeyup="pwCheck()" />
				</div>
			</div>

			<div class="form-inline" style="margin-bottom: 5px">

				<div style="width: 100px">
					<label>암호확인</label>
				</div>
				<div style="margin-right: 10px">
					<input type="password" class="form-control" id="pw_chk"
						name="pw_chk" onkeyup="pwCheck()" />
				</div>
				<div>
					<label id="check"></label>
				</div>
			</div>

			<div class="form-inline" style="margin-bottom: 5px">
				<div style="width: 100px">
					<label>이름</label>
				</div>
				<div>
					<input type="text" id="name" name="name" class="form-control" />
				</div>
			</div>

			<div class="form-inline" style="margin-bottom: 5px">

				<div style="width: 100px">
					<label>나이</label>
				</div>
				<div>
					<input type="text" id="age" name="age"class="form-control" />
				</div>
			</div>

			<div class="form-inline" style="margin-bottom: 5px">

				<div style="width: 100px">
					<label>이메일</label>
				</div>
				<div style="margin-right: 10px">
					<input type="text" id="email" name="email" class="form-control" />
				</div>
				<div style="width: 35px">
					<label>@</label>
				</div>
				<div>
					<select id="drops" name="selected" onchange="dropdownChange()">
						<option value="gmail.com" selected>gmail.com</option>
						<option value="hanmail.com">hanmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="select">직접 입력</option>
					</select> <input type="text" id="type_in" name="type_in" style="display: none;" />
				</div>
			</div>
			<hr />
			<div align="right">
				<input type="submit" class="btn btn-success" value="회원가입"	/>
			</div>
		</div>
	</form>
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resource/js/bootstrap.min.js"></script>

</body>
<script type="text/javascript">
	$(function(){
		$('#id').keyup(function(){
			var a = $('#id').val();
			console.log(a);
			if (a.length > 0) {
				//doGET을 호출 {"ret":"y"}
				console.log("if문 안");
				$.get('ajaxidcheck.do?id='+a, function(data){
					console.log("get안");
					if (data.ret =='y') {
						$('#btn-idcheck').val('사용가능');
						$('#btn-idcheck').attr('class', 'btn btn-success');
					} else if (data.ret == 'n') {
						$('#btn-idcheck').val('사용불가');
						$('#btn-idcheck').attr('class', 'btn btn-warning');
					}
					console.log(data)
				}, 'json');
			}
			else {
				$('#btn-idcheck').val('중복확인');
				$('#btn-idcheck').attr('class', 'btn btn-primary');
			}
			
			/* $.post('서버주소','전달할값', function(data){
			},'json'); */
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
	}
</script>
</html>

