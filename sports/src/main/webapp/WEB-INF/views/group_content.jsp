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
					<div class="meta right floated">모임장: ${vo.mem_name}</div>
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
					<c:forEach items="${list}" var="mem">
						<div class="card">
							<div class="content">
								<c:if test="${vo.grp_leader == mem.GRP_MEM}">
									<div class="ui red ribbon label">
										Leader
									</div>
								</c:if>
								<c:if test="${sessionScope.SID == mem.GRP_MEM}">
									<div class="ui blue right corner label">
										<i class="user outline icon"></i>
									</div>
								</c:if>
								<c:if test="${mem.MEM_IMG == null }">
									<img class="right floated mini ui image" src="resources/images/matthew.png">
								</c:if>
								<c:if test="${mem.MEM_IMG != null }">
									<img class="right floated mini ui image" src="${mem.MEM_IMG}">
								</c:if>
								
								<div class="header">
									${mem.MEM_NAME}
								</div>
								<div class="meta">
									${mem.CENTER_NAME}
								</div>
								<div class="description">
									${mem.MEM_DETAIL}
								</div>     
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="container" style="margin-bottom: 50px">
				<div class="ui two column padded grid">
					<div class="column">
						<div class="ui large label">피드 목록</div>
					</div>
					<div class="column">
						<div class="ui right floated primary disabled button write_feed" id="write_feed">글쓰기</div>
					</div>
				</div>
				<div class="ui cards disabled" id="boardContainer">
					<c:forEach items="${board}" var="bo">
						<div class="ui fluid card">
							<div class="content">
								<div class="header">
									<span class="right floated time">${bo.brd_date}</span>
									<div class="left floated author">
										<c:if test="${bo.mem_img == null}">	
											<img class="ui avatar image" src="resources/images/jenny.jpg">
										</c:if>
										<c:if test="${bo.mem_img != null}">	
											<img class="ui avatar image" src="${bo.mem_img}">
										</c:if>
										${bo.mem_name}
									</div>
								</div>
								<div class="description" style="margin-top: 40px">
									<c:if test="${bo.brd_img != null}">  
										<img class="ui large aligned left floated medium image" src="${bo.brd_img}" >
									</c:if>
									${bo.brd_content}
								</div>
							</div>
							<div class="extra content">
								<div>
									<span class="right floated">
										<i class="heart outline like icon"></i>
										17 likes
									</span>
									<i class="comment icon"></i>
									3 comments
								</div>
								
							<form class="commentForm" action="writeCommentOnBoard.do" method="post">
								<input type="hidden" class="brd_no" value="${bo.brd_no}">
								<div class="ui large fluid inverted left icon action input" id="reply_div" style="margin-top: 20px">
									<button class="ui icon black button">
										<i class="heart outline icon"></i>
									</button>
									<input class="txt_brd_reply" type="text" id="brd_reply" name="rpl_content" placeholder="Add Comment...">
									<button class="ui teal button reply_post">POST</button>
								</div>
							</form>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>			
		</div>
	</div>
	<div class="ui mini modal reply_modal">
		<div class="header">
			댓글 작성
		</div>
		<div class="content">
			댓글을 작성하시겠습니까?
		</div>
		<div class="actions">
			<div class="ui black deny button">
				취소
			</div>
			<div class="ui positive right labeled icon button">
				작성
				<i class="checkmark icon"></i>
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
				document.getElementById("boardContainer").className =
					document.getElementById("boardContainer").className.replace
						("disabled", "active");
			}
		}
		memIdList.push(JSON.stringify(vo));
		console.log(vo);
	</c:forEach>
	
	console.log(memIdList);
	$(function() {
		$('.reply_post').on('click', function() {
			let id = '${sessionScope.SID}';
			if (id === '') {
				window.location = "login.do";
			}
			let index = $(this).index();
			let repl = $('.txt_brd_reply').eq(index).val();
			let brd_no = $('.brd_no').eq(index).val();
			if (repl.trim() === '') {
				$('#reply_div').addClass('error');
				return false;
			}
			let 
			$('.reply_modal').modal({
					onApprove : function() {
					}
				})
				.modal('show');
		})
		$('#brd_reply').keyup(function() {
			var repl = $('#brd_reply').val();
			if ( repl.trim() !== '' ) {
				$('#reply_div').removeClass('error');
			}
		})
		
		
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
							$('#textarea_content').val('');
						} else {
							console.log('false');
							return false;
						}
					}
				})
				.modal('show');
		});
		$('#brd_reply').keypress(function(e) {
			var key = e.which;
			if (key == 13) { //엔터키
				$('.reply_post').trigger("click");
				return false;
			}
		})
	})
</script>
</body>
</html>
