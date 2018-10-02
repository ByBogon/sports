<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
	<meta charset="utf-8">
	<title>${vo.grp_name}</title>
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	
	<link rel="stylesheet" href="resources/css/semantic.min.css">
	<link rel="stylesheet" href="resources/css/nav_bar.css">
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/semantic.min.js"></script>
	<script src="resources/js/nav_bar.js"></script>
		
</head>
<body>
	<div class="ui page grid">
	<jsp:include page="nav_main.jsp"></jsp:include>
		<div class="ui container" style="margin-top: 30px">
			<div class="ui centered card">
				<div class="ui slide masked reveal image">
					
					<c:if test="${vo.grp_mainimg == null}">
						<img class="visible content" src="resources/images/jenny.jpg">
					</c:if>
					<c:if test="${vo.grp_mainimg != null}">
						<img class="visible content" src="${vo.grp_mainimg}">
					</c:if>
					<div id="map2" class="hidden content" style="width: 200px; height:310px; 
						max-height: 100%; min-width: 100%; margin:auto;"></div>
				</div>
				<div class="content">
					<div class="header">
						${vo.grp_name}
						
					</div>
					<div class="meta right floated">모임장: ${vo.grp_leader}</div>
				</div>
				<div class="extra content">
					<c:if test="${vo.grp_leader == sessionScope.SID}">
						<div class="ui teal fluid button profile_update">프로필 업데이트</div>
					</c:if>
				</div>
			
			</div>
			<div class="ui segment" style="margin-top: 20px">
				<div class="ui top left attached label">모임 구성원</div>
				<div class="ui centered three stackable cards">
					<c:forEach items="${list}" var="vo">
						<div class="card">
							<div class="content">
								<c:if test="${vo.MEM_IMG == null }">
									<img class="right floated mini ui image" src="resources/images/matthew.png">
								</c:if>
								<c:if test="${vo.MEM_IMG != null }">
									<img class="right floated mini ui image" src="${vo.MEM_IMG}">
								</c:if>
								
								<div class="header">
									${vo.MEM_NAME}
								</div>
								<div class="meta">
									${vo.CENTER_NAME}
								</div>
								<div class="description">
									${vo.MEM_DETAIL}
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="container">
				<div class="ui two column padded grid">
					<div class="column">
						<div class="ui large label">피드 목록</div>
					</div>
					<div class="column">
						<div class="ui right floated primary disabled button write_feed" id="write_feed">글쓰기</div>
					</div>
				</div>
				<div>
					
				</div>
			</div>			
		</div>
	</div>
	
<jsp:include page="modal_write_feed_group.jsp"></jsp:include>
<script type="text/javascript">
	var memIdList = new Array();
	var myFile;
	<c:forEach items="${list}" var="mem">
		var vo = new Object();
		vo.grp_mem = '${mem.GRP_MEM}';
		if ( document.getElementById("write_feed")
				.className.match("disabled") ) {
			if ( ('${mem.GRP_MEM}' === '${sessionScope.SID}') || 
					('${sessionScope.SID}' === '${vo.grp_leader}') ) {
				console.log('Current: disabled');
				document.getElementById("write_feed").className =
					document.getElementById("write_feed").className.replace
						("disabled", "active");
			}
		}
		memIdList.push(JSON.stringify(vo));
		console.log(vo);
	</c:forEach>
	
	console.log(memIdList);
	$(function() {
		$(document).on('change', '#file', function() {
			console.log('change');
			var input = this;
			var url = $(this).val();
			var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
			if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#modal_img').attr('src', e.target.result);
					$('#file').attr('src', e.target.result);
					console.log($('#file').val());
					console.log($('#file').attr('src'));
					console.log($('#modal_img').val());
					console.log($('#modal_img').attr('src'));
				 };
				 reader.readAsDataURL(input.files[0]);
				 myFile = input.files[0];
			} else {
				$('#file').attr('src', null);
			}
			console.log($('#file').val());
			console.log($('#modal_img').attr('src'));
			
		});
		$('#modal_img').on('click', function() {
			console.log('imgClicked');
			$('#file').click();
		})
		
		$('.write_feed').on('click', function() {
			$('#writeFeedOnGroup')
				.modal({
					onShow: function() {
						$('#modal_grp_no').val( ${vo.grp_no} );
						console.log($('#modal_grp_no').val());
					},
					onApprove : function() {
						console.log('aaa');
						if( $('#textarea_content').val() !== '' ) {
							console.log('bbb');
							$('#writeFeedForm').submit();
						} else {
							console.log('false');
							return false;
						}
					}
				})
				.modal('show');
		})
	})
</script>
</body>
</html>
