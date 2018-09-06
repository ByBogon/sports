<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
</head>
<body>
	<script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/sweetalert2.js"></script>
	<script>
	$(function(){
		swal({
			type	: 'info',
			title	: '${msg}',
			showConfirmButton : false,
			timer	: 1000
		}).then((result) => {
			window.location.href='${url}';
		});
	});
	</script>
	
</body>
</html>
