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
			스포츠
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="sports.do">스쿼시</a>
				<a class="item" href="sports.do?sports=basketball">농구</a>
				<a class="item" href="sports.do?sports=tennis">테니스</a>
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
				<a class="item" href="myGroupsEdit.do">내모임 관리하기</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<div class="ui dropdown item">
			채팅
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="chatting.do">채팅</a>
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
 <div class="mobile only narrow row">
	<div class="ui inverted menu navbar">
		<a class="item" href="sports.do">Squash</a>
		<div class="right menu open">
			<a href="" class="menu item">
				<i class="dropdown icon"></i>
			</a>
		</div>
	</div>
	<div class="ui vertical navbar menu">
		<a class="item" href="#">Home </a>
		<a class="item" href="#">관리자모드</a>
		<c:if test="${sessionScope.SID eq null}">
			<a class="item" href="join.do">회원가입</a>
			<a class="item" href="login.do">로그인</a>
		</c:if>
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
			스포츠
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="sports.do">스쿼시</a>
				<a class="item" href="sports.do?sports=basketball">농구</a>
				<a class="item" href="sports.do?sports=tennis">테니스</a>
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
				<a class="item" href="#">전체 모임보기</a>
				<a class="item" href="myGroupsEdit.do">내모임 관리하기</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<div class="ui dropdown item">
			채팅
			<i class="dropdown icon"></i>
			<div class="menu">
				<a class="item" href="chatting.do">채팅</a>
				<div class="ui inverted divider"></div>
				<a class="item" href="#">Something else here</a>
			</div>
		</div>
		<c:if test="${sessionScope.SID ne null}">
			<a class="item" href="logout.do">${sessionScope.SNAME}님 로그아웃</a>
		</c:if>
	</div>
 </div>