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
<script src="resources/js/jquery.form.min.js"></script>
<script src="resources/js/semantic.min.js"></script>
<script src="resources/js/nav_bar.js?ver=1"></script>
</head>
<style>
	.floating.ui.teal.label {
		cursor: pointer;
	}
</style>
<body>
<div class="ui page grid">
<jsp:include page="nav_main.jsp"></jsp:include>
	<div class="ui grid" style="width:100%">
		<div class="left floated column">
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
		<div class="right floated column" style="width:100%">
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
			<div class="ui right aligned container btn-container" style="margin-top: 10px">
				<input type="submit" class="ui primary button" id="pwchk" value="확인">
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		var imgSrc = '';
		var myFile = '';
		var myFilePath = '';
		
		$('.ui.dropdown').dropdown();
		$(document).on('click', '.ui.dropdown.label', function() {
			console.log("ccccccccccc");
			$(this).dropdown('show');
			
			$('#mem_email2').val($(this).dropdown('get text'));
			console.log($('#mem_email2').val());
		})
		
		$(document).on('click', '.ui.button.update', function(e) {
			e.preventDefault();
			var id = '${sessionScope.SID}';
			var defaultImgsrc = $('#img').attr('src');
			console.log(defaultImgsrc);
			if(defaultImgsrc.includes('resources/images/')) {
				$('#update_form').submit();
			} else {
				var formData = new FormData();
				formData.append('file', myFile);
				console.log(myFile);
				console.log(formData.get('file'));
				var xhr = new XMLHttpRequest();
				xhr.open("POST", "ajaxFileIntoS3.do", true);
				xhr.send(formData);
				xhr.onload = function(e) {
					if(xhr.readyState === 4) { // 4가 DONE
						console.log(xhr.responseText);
						$('#mem_email2').val($('.email_last.text').text());
						var upform = $('#update_form').serializeArray();
						console.log(upform);
						upform.push({name: "mem_img", value: xhr.responseText});
						$.post('ajaxUpdateMemOne.do', upform, function(data) {
							console.log(data);
							if(data === 'success') {
								window.location.href="myPage.do";
							}
						})
					}
				}
			}
			
			/* 
			var name = $('#mem_name').val();
			var age = $('#mem_age').val();
			var detail = $('#mem_detail').val();
			var email = $('#mem_email').val();
			var src = $('#img').attr('src');
			var drops = $('.ui.dropdown.label');
			var txt = drops.dropdown('get text');
			email += txt;
			if(src === 'resources/images/matthew.png') {
				src = null;
			}  */
			
			
			//$('#update_form').submit();
		}); 
		
		$(document).on('click', '.floating.label', function() {
			var img = $('#img');
			var defaultImg = 'resources/images/matthew.png';
			console.log('click');
			if( img.attr('src') === defaultImg ) {
				return false;
			} else {
				console.log(imgSrc);
				img.attr('src', defaultImg);
				return false;
			}
		})
		
		$(document).on('click', '.ui.inverted.button', function() {
			console.log('clicked');
			console.log(file);
			$('#file').click();
			
		});
		$(document).on('change', '#file', function() {
			console.log('change');
			var input = this;
			var url = $(this).val();
			var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
			if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#img').attr('src', e.target.result);
					$('#file').attr('src', e.target.result);
					console.log($('#file').val());
					console.log($('#file').attr('src'));
					console.log($('#img').val());
					console.log($('#img').attr('src'));
				 };
				 reader.readAsDataURL(input.files[0]);
				 myFile = input.files[0];
			} else {
				$('#img').attr('src', 'resources/images/matthew.png');
				$('#file').attr('src', null);
			}
			console.log($('#file').val());
			console.log($('#img').attr('src'));
			
		});
		$(document).on('keyup', '#mem_detail', function() {
			var html = ' ';
			console.log('keyup');
			var txt = $(this).val();
			console.log(txt);
			if(txt.length >= 40) {
				
				html += '<div class="ui warning message"><i class="close icon"></i><div class="header">';
				html += '글자수 제한</div>';
				html += '자기소개는 40자 이상 작성할 수 없습니다</div>';
				$('.details_msg').html(html);
			} else {
				$('.details_msg').html(html);
			}
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
							$.post('ajaxSelectMemOne.do', {mem_id : data.MEM_ID}, function(data) {
								var img;
								console.log(data.MEM_IMG);
								if( typeof data.MEM_IMG == "undefined" ) {
									img = 'resources/images/matthew.png';
								} else {
									img = data.MEM_IMG;
								}
								$('.ui.container.context').empty();
								html += '<form id="update_form" action="myPage.do" method="post" enctype="multipart/form-data">';
								html += '<div class="ui two column vertically padded grid">';
									html += '<div class="row" style="margin:0px">';
										html += '<div class="column">';
											html += '<div class="ui special card">';
												html += '<div class="blurring dimmable image"> <div class="ui dimmer">';
												html += '<div class="content"> <div class="center">';
												html += '<div class="ui inverted button" id="profile">이미지 변경</div>';
											    html += '</div></div></div>';
									    		html += '<img name="img" id="img" src="'+img+'"></div>';
									    		html += '<input type="file" name="profile_img" id="file" style="display: none"/>';
												html += '<div class="floating ui teal label">Default</div>';
											   	html += '<div class="content">';
											   	html += '<div class="header">';
											    html += '<div>'+data.MEM_NAME+'</div>';
											    html += '<div class="meta right aligned">'+data.MEM_AGE+'</div>';
											    html += '</div></div>';
											    html += '<div class="extra content">';
											    html += '<div class="left aligned email">'+data.MEM_EMAIL+'</div>';
											    html += '<div class="right aligned extra content">'+data.MCNT+' Groups</div>';
											    html += '</div></div>';
									  		html += '</div>';
									  		html += '<div class="right aligned column">';
										  	html += '<div class="ui container">';
										  	html += '<div class="ui divided list">';
										  	html += '<div class="item">';
											  	html += '<div class="ui labeled fluid input">';
											  	html += '<div class="ui center aligned label">이름</div>';
											  	html += '<input type="text" class="ui large input" id="mem_name" name="mem_name" value="'+data.MEM_NAME+'"/></div></div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui right labeled fluid input">';
											  	html += '<input type="text" class="ui large input" id="mem_age" name="mem_age" value="'+data.MEM_AGE+'"/>';
											  	html += '<div class="ui center aligned label">세</div></div></div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui right labeled fluid input">';
												  	html += '<input type="text" class="ui large input" id="mem_email" name="mem_email1" value="'+data.MEM_EMAIL.substring(0, data.MEM_EMAIL.indexOf("@", 0))+'"/>';
												  	html += '<div class="ui dropdown center aligned label">';
													  	html += '<div class="email_last text" >'+data.MEM_EMAIL.substring(data.MEM_EMAIL.indexOf("@"), data.MEM_EMAIL.length)+'</div>';
													  	html += '<input type="hidden" id="mem_email2" name="mem_email2"/>'
													  	html += '<i class="dropdown icon"></i>';
														  	html += '<div class="menu">';
															  	html += '<div class="item">@gmail.com</div>';
															  	html += '<div class="item">@naver.com</div>';
															  	html += '<div class="item">@daum.net</div>';
															  	html += '<div class="item">@hanmail.net</div>';
															  	html += '<div class="item">@yahoo.com</div>';
														  	html += '</div>';
												  	html += '</div>';
											  	html += '</div>';
										  	html += '</div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui labeled fluid input details">';
											  		html += '<div class="ui top attached label">40자 내 자기소개</div>';
											  		html += '<input type="text" class="ui large input" name="mem_detail" id="mem_detail" placeholder="자기소개" maxlength="40" value="'+data.MEM_DETAIL+'"/></div>';
											  		html += '<div class="details_msg"></div></div>';
									  	html += '</div>';
									html += '</div>';
								html += '</div>';
								html += '</form>';
									  	

								var btn = '';
								btn += '<input type="submit" class="ui green button update" id="update_btn"value="수정하기"/>';
								
								$('.ui.right.aligned.container.btn-container').empty();
								$('.ui.right.aligned.container.btn-container').html(btn);
								$('.ui.container.context').html(html);
								$('.special.card .image').dimmer({
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