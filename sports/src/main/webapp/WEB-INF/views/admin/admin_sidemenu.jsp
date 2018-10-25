<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<nav class="col-md-2 d-none d-md-block bg-light sidebar">
	<ul class="nav flex-column">
		<li class="nav-item">
			<a 
			${param.menu == 0 || param.menu eq null ? 'class="nav-link active"' : 'class="nav-link"'}
			href="admin.do?menu=0">
			<span data-feather="home"></span> 홈 <span class="sr-only">(current)</span>
			</a>
		</li>
		<li class="nav-item">
			<a ${param.menu == 2 ? 'class="nav-link active"' : 'class="nav-link"'}
			href="admin.do?menu=2"><span data-feather="layers"></span> 센터관리
			</a>
		</li>
	</ul>
</nav>