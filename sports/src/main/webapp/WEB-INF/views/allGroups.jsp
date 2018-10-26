<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>모임들</title>
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	
    <link rel="shortcut icon" href="resources/images/favicon.ico">
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css">
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
		
</head>
<body>
	<div class="ui page grid">
	<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="ui center aligned container" style="margin-top: 30px">
			<div class="ui container">
				<div>
					<h2 class="ui center aligned icon header">
						<i class="circular users icon"></i>
						모임 찾기
					</h2>
				</div>
			</div>
			
			<div class="ui fluid search" style="margin: 20px">
				<div class="ui icon fluid input">
					<input class="prompt" type="text" id="searchGrpName" 
						placeholder="모임명을 입력하세요" onkeyup="searchGrpByName()">
					<i class="search icon"></i>
				</div>
			</div>
			
			<div class="ui container">
				<c:if test="${list != null}">
				<div class="ui three stackable special cards groupsCard">
					<c:forEach var="vo" items="${list}">
						<div class="ui link card">
							<div class="blurring dimmable image">
								<div class="ui dimmer">
									<div class="ui inverted button joinGrpDirectly">참가하기</div>
								</div>
	                    		<img src="${vo.grp_mainimg}" onerror="this.src='resources/images/molly.png'"/>
							</div>
							<div class="content main_content">
								<input type="hidden" class="grp_no" value="${vo.grp_no}">
								<div class="header">${vo.grp_name}</div>
								<div class="meta">${vo.grp_leader}</div>
							</div>
							<div class="description">${vo.grp_detail}</div>
							<div class="extra content">
								<span class="right floated">${vo.grp_date}</span>
								<span class="left floated"><i class="users icon"></i>${vo.cnt} Members</span>	
							</div>
							<div class="content">
								<c:set var="cname" value="${vo.center_name}"/>
                       			${fn:substring(cname, 0, 25)}
                       			<c:if test="${fn:length(cname) gt 25}">
                       			...
                       			</c:if>
							</div>
						</div>
					</c:forEach>
					
				</div>
				</c:if>
				<c:if test="${list == null}">
					<label>활동중인 모임이 없습니다</label>
					<a href="open_group.do" class="ui blue button">모임 만들기</a>
				</c:if>
			</div>
		</div>
	</div>
	<div class="ui mini modal grpMemAdd_modal">
		<div class="header">
		</div>
		<div class="content">
		</div>
		<div class="actions">
			<div class="ui black deny button">
				취소
			</div>
			<div class="ui green ok right labeled icon button approveBtn">
				확인
				<i class="checkmark icon approveIcon"></i>
			</div>
		</div>
	</div>
	<script>
		var list = new Array();
		<c:forEach items="${list}" var="vo">
			var vo = new Object();
			vo.grp_no = ${vo.grp_no};
			list.push(JSON.stringify(vo));
			console.log(vo);
		</c:forEach>

		console.log(list);
		
		function searchGrpByName() {
			var grpName = document.getElementById("searchGrpName").value;
			console.log(grpName);
			$('.groupsCard').empty();
			$.ajax({
				url		: 'ajaxSearchGrpByName.do',
				data	: {grp_name : grpName},
				success	: function(data) {
					if (data.length > 0) {
						console.log(data);
						var html = '';
						for (let i=0; i <data.length; i++) {
							let center_name = data[i].center_name;
							html += '<div class="ui link card">';
							html += '<div class="blurring dimmable image">';
							html += '<div class="ui dimmer">';
							html += '<div class="ui inverted button joinGrpDirectly">참가하기</div>';
							html += '</div>';
							html += '<img src="'+data[i].grp_mainimg+'" onerror="this.src=\'resources/images/molly.png\'"/>';
							html += '</div>';
							html += '<div class="content main_content">';
							html += '<input type="hidden" class="grp_no" value="'+data[i].grp_no+'">';
							html += '<div class="header">'+data[i].grp_name+'</div>';
							html += '<div class="meta">'+data[i].grp_leader+'</div>';
							html += '</div>';
							html += '<div class="description">'+data[i].grp_detail+'</div>';
							html += '<div class="extra content">';
							html += '<span class="right floated">'+data[i].grp_date+'</span>'
							html += '<span class="left floated"><i class="users icon"></i>'+data[i].cnt+' Members</span>';	
							html += '</div>';
							html += '<div class="content">';
							html += center_name.substring(0, 25);
							if (center_name.length > 25) {
								html += '...';
							}
                   			html += '</div>';
                   			html += '</div>';
						}
						$('.groupsCard').append(html);
						$('.groupsCard')
							.transition('slide down', '200ms')
							.transition('slide down', '200ms');	
						$('.special.cards .image').dimmer({
							  on: 'hover'
						});
					}
				}
			})
		}
		
		$(function() {
			$(document).on('click', '.groupsCard > .card > .dimmable.image > .dimmer > .joinGrpDirectly', function() {
				var curId = '${sessionScope.SID}';
				if (curId === '') {
					window.location = 'login.do';
					return false;
				}
				
				var idx = $(this).index('.joinGrpDirectly');
				var grp_no = $('.grp_no').eq(idx).val();
				console.log(idx);
				console.log(grp_no);
				
				$('.grpMemAdd_modal')
				.modal({
					onShow	: function() {
						$('.grpMemAdd_modal > .header').text('모임 참가');
						$('.grpMemAdd_modal > .content').text('해당 모임에 참가 하시겠습니까?');
					},
					onApprove : function() {
						
						$.ajax({
							url		: "ajaxAddExtraGrpMem.do",
							data	: {
								grp_no : grp_no,
								extra_id : curId
							},
							success : function(data) {
								console.log(data);
								if (data === 0) {
									window.location = 'alert.do?msg=이미 가입한 모임 입니다.<br>해당 모임화면으로 이동합니다. &url=group_content.do?grp_no='+grp_no;
								} else {
									$('#searchGrpName').val('');
									window.location = 'alert.do?msg=가입하였습니다.<br>해당 모임화면으로 이동합니다. &url=group_content.do?grp_no='+grp_no;
									
								}
							}
						})
					}
				})
				.modal('show');
			})
			
			$(document).on('click', '.groupsCard > .card > .main_content', function() {
				var idx = $(this).index('.main_content');
				var grp_no = $('.grp_no').eq(idx).val();
				$('#searchGrpName').val('');
				window.location.href = "group_content.do?grp_no="+grp_no+"";
			})
			
			$('.ui.dropdown').dropdown();
			$('.tag.example .ui.dropdown').dropdown({
				allowAdditions: true
			});
			$('.special.cards .image').dimmer({
				  on: 'hover'
			});
		})
	
	</script>
</body>
</html>
