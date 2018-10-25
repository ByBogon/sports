<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
	<title>관리자 페이지</title>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
	<link rel="stylesheet" href="resources/css/dashboard.css" />
	
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/jquery.form.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/sweetalert2.js"></script>
	<script src="resources/js/Chart.min.js"></script>
	<script src="resources/js/utils.js"></script>
	<script src="https://unpkg.com/feather-icons@4.7.3/dist/feather.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
		<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">관리자</a> 
		<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="squash.do" style="align: right">메인</a>
	</nav>
	<div class="container-fluid">
		<div class="row">
			<jsp:include page="admin/admin_sidemenu.jsp"></jsp:include>
			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
				<c:if test="${param.menu == 0 || param.menu eq null}">
					<jsp:include page="admin/admin_menu0.jsp"></jsp:include>
				</c:if>
			
				<c:if test="${param.menu == 2}">
					<jsp:include page="admin/admin_menu2.jsp"></jsp:include>
				</c:if>
				
			</main>
		</div>
	</div>

	<script type="text/javascript">
		var ctx, myLineChart;
		window.onload = function() {
			ctx = document.getElementById('myLineChart').getContext('2d');
			$.get('ajaxAdminMemCntByDay.do', function(data) {
				console.log(data);
				myLineChart = new Chart(ctx, {
				    type: 'line',
				    data: {
						labels : data.day,
						datasets : [{
							label : '신규 회원',
							backgroundColor : window.chartColors.blue,
							borderColor : window.chartColors.blue,
							data : data.memCnt,
							fill : false,
						}, {
							label : '신규 게시글',
							backgroundColor : window.chartColors.red,
							borderColor : window.chartColors.red,
							data : data.brdCnt,
							fill : false,
						}]	
					},
				    options: {
						responsive : true,
						title : {
							display : true,
							text : '일별 신규 회원/게시글 수'
						},
						elements : {
							line : {
								tension : 0.000001
							}
						}
				    }
				});
			})
		}
			
		$(function() {
			feather.replace();
			
			
			
			$('.btn-update-center').on('click', function() {
				let idx = $(this).index('.btn-update-center');
				let center_no = $('.center_no').eq(idx).val();
				let center_name = $('.center_name').eq(idx).val();
				let center_addr = $('.center_addr').eq(idx).val();
				let center_tel = $('.center_tel').eq(idx).val();
				let center_detail = $('.center_detail').eq(idx).val();
				let center_updated_check = $('.center_updated_check').eq(idx).val();
				console.log(idx);
				$.ajax({
					url		: 'ajaxAdminCenterUpdate.do',
					method	: 'POST',
					data	: {
						center_no : center_no,
						center_name : center_name,
						center_addr : center_addr,
						center_tel : center_tel,
						center_detail : center_detail,
						center_updated_check : center_updated_check
					},
					success	: function(data) {
						$('.center_name').eq(idx).val(data.infrm_center_name);
						$('.center_addr').eq(idx).val(data.infrm_center_addr);
						$('.center_tel').eq(idx).val(data.infrm_center_tel);
						$('.center_detail').eq(idx).val(data.infrm_center_detail);
						$('.center_updated_check').eq(idx).val(data.infrm_center_updated_check);
						$('.btn-update-center').eq(idx).removeClass('btn-success').addClass('btn-primary');
						$('.btn-update-center').eq(idx).text('수정');
					}
					
				})
			});
			
			
		});
	</script>
</body>
</html>
