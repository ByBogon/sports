<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true" %>
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
						console.log(upform);
						$.post('ajaxUpdateMemOne.do', upform, function(data) {
							console.log(data);
							if(typeof data !== 'undefined') {
								window.location.href="myPage.do";
							}
						})
					}
				}
			}
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
							$.post('ajaxSelectMemOne.do', {mem_id : data.MEM_ID}, function(datas) {
								var img;
								var detail;
								var mcnt;
								var email = datas.MEM_EMAIL;
								console.log(datas.MEM_IMG);
								console.log(email);
								if( typeof datas.MEM_IMG == "undefined" ) {
									img = 'resources/images/matthew.png';
								} else {
									img = datas.MEM_IMG;
								}
								if( typeof datas.MCNT == "undefined" ) {
									mcnt = 0;
								} else {
									mcnt = datas.MCNT;
								}
								if( typeof datas.MEM_DETAIL == "undefined" ) {
									detail = ' ';
								} else {
									detail = datas.MEM_DETAIL;
								}
								if ( !(email.includes('@')) ) {
									email = email+'@gmail.com';
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
											    html += '<div>'+datas.MEM_NAME+'</div>';
											    html += '<div class="meta right aligned">'+datas.MEM_AGE+'</div>';
											    html += '</div></div>';
											    html += '<div class="extra content">';
											    html += '<div class="left aligned email">'+datas.MEM_EMAIL+'</div>';
											    html += '<div class="right aligned extra content">'+datas.MCNT+' Groups</div>';
											    html += '</div></div>';
									  		html += '</div>';
									  		html += '<div class="right aligned column">';
										  	html += '<div class="ui container">';
										  	html += '<div class="ui divided list">';
										  	html += '<div class="item">';
											  	html += '<div class="ui labeled fluid input">';
											  	html += '<div class="ui center aligned label">아이디</div>';
											  	html += '<input type="text" class="ui large input" id="mem_id" name="mem_id" value="'+id+'" disabled/></div></div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui labeled fluid input">';
											  	html += '<div class="ui center aligned label">새 암호</div>';
											  	html += '<input type="password" class="ui large input" id="mem_pw" name="mem_pw"/></div></div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui labeled fluid input">';
											  	html += '<div class="ui center aligned label">이름</div>';
											  	html += '<input type="text" class="ui large input" id="mem_name" name="mem_name" value="'+datas.MEM_NAME+'"/></div></div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui right labeled fluid input">';
											  	html += '<input type="text" class="ui large input" id="mem_age" name="mem_age" value="'+datas.MEM_AGE+'"/>';
											  	html += '<div class="ui center aligned label">세</div></div></div>';
										  	html += '<div class="item">';
											  	html += '<div class="ui right labeled fluid input">';
												  	html += '<input type="text" class="ui large input" id="mem_email" name="mem_email1" value="'+email.substring(0, email.indexOf("@", 0))+'"/>';
												  	html += '<div class="ui dropdown center aligned label">';
													  	html += '<div class="email_last text" >'+email.substring(email.indexOf("@"), email.length)+'</div>';
													  	html += '<input type="hidden" id="mem_email2" name="mem_email2" value="'+email.substring(email.indexOf("@"), email.length)+'"/>'
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
											  		html += '<input type="text" class="ui large input" name="mem_detail" id="mem_detail" placeholder="자기소개" maxlength="40" value="'+detail+'"/></div>';
											  		html += '<div class="details_msg"></div></div>';
									  	html += '</div>';
									html += '</div>';
								html += '</div>';
								html += '</form>';
									  	

								var btn = '';
								btn += '<input type="submit" class="ui green button update" id="update_btn"value="수정하기"/>';
								
								$('.btn-container').html(btn);
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