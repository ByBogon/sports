<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <!-- Nav Menu -->
 <div class="computer tablet only row">
	<div class="ui inverted menu navbar" style="width:100%">
		<a class="brand item" href="sports.do">Squash</a>
		<a class="item" href="#">Home </a>
		<a class="item" href="#">관리자모드</a>
		<div class="ui dropdown item">
			마이페이지
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="myPage.do">내정보</a>
				<a class="item" href="myGroups.do">내모임</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<div class="ui dropdown item">
			센터
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="center_location.do">센터검색</a>
				<a class="item" href="#">센터소개</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<div class="ui dropdown item">
			모임
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="open_group.do">모임 만들기</a>
				<a class="item" href="allGroups.do">전체 모임보기</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<div class="ui dropdown item">
			채팅
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="chatting.do">채팅</a>
				<a class="item" href="http://13.209.150.69:8005/">오픈 채팅방 목록</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<div class="right menu">
			<c:if test="${sessionScope.SID eq null}">
				<a class="item" href="join.do">회원가입</a>
				<a class="item" href="login.do">로그인</a>
			</c:if>
			<c:if test="${sessionScope.SID ne null}">
				<a class="item" href="logout.do">${sessionScope.SNAME}님 로그아웃</a>
			</c:if>
		</div>
	</div>
 </div>
 <div class="mobile only narrow row" style="margin-left:5px">
	<div class="ui inverted menu navbar" style="width: 100%">
		<a class="item" href="sports.do">Squash</a>
		<div class="right menu open">
			<a href="" class="menu item">
				<i class="bars icon"></i>
			</a>
		</div>
	</div>
	<div class="ui vertical navbar menu" style="display:none">
		<a class="item" href="#">Home </a>
		<a class="item" href="#">관리자모드</a>
		<c:if test="${sessionScope.SID eq null}">
			<a class="item" href="join.do">회원가입</a>
			<a class="item" href="login.do">로그인</a>
		</c:if>
		<div class="item">
			<div class="header">마이페이지</div>
			<div class="menu">
				<a class="item" href="myPage.do">내정보</a>
				<a class="item" href="myGroups.do">내모임</a>
				<div class="ui inverted divider"></div>
			</div>
		</div>
		<div class="item">
			<div class="header">센터</div>
			<div class="menu">
				<a class="item" href="center_location.do">센터검색</a>
				<a class="item" href="#">센터소개</a>
				<div class="ui inverted divider"></div>
			</div>
		</div>
		<div class="item">
			<div class="header">모임</div>
			<div class="menu">
				<a class="item" href="open_group.do">모임 만들기</a>
				<a class="item" href="allGroups.do">전체 모임보기</a>
				<div class="ui inverted divider"></div>
			</div>
		</div>
		<div class="item">
			<div class="header">채팅</div>
			<div class="menu">
				<a class="item" href="chatting.do">채팅</a>
				<a class="item" href="http://13.209.150.69:8005/">오픈 채팅방 목록</a>
				<div class="ui inverted divider"></div>
			</div>
		</div>
		<c:if test="${sessionScope.SID ne null}">
			<a class="item" href="logout.do">${sessionScope.SNAME}님 로그아웃</a>
		</c:if>
	</div>
 </div>