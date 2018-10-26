<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<div class="row">
	<div class="col-xl-8">
		<div class="col-xl-12">
		<!-- Example Bar Chart Card-->
			<div class="card mb-3">
				<div class="card-header">
					<i class="fa fa-bar-chart"></i> 회원/게시글/모임 차트
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-sm-10 my-auto">
							<canvas id="myLineChart" width="100" height="70"></canvas>
						</div>
						<div class="col-sm-2 text-center my-auto">
							<div class="h4 mb-0 text-primary allMems"></div>
							<div class="small text-muted">총 회원</div>
							<hr>
							<div class="h4 mb-0 text-danger allBoards"></div>
							<div class="small text-muted">총 게시글</div>
							<hr>
							<div class="h4 mb-0 text-success allGroups"></div>
							<div class="small text-muted">총 모임</div>
						</div>
						
					</div>
				</div>
				<div class="card-footer small text-muted">Updated yesterday at 11:59 PM
				</div>
			</div>
		</div>
		<div class="col-xl-12">
	<!-- Example Bar Chart Card-->
		<div class="card mb-3">
			<div class="card-header">
				<i class="fa fa-bar-chart"></i> 센터 차트
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-lg-10 my-auto">
						<canvas id="barCenterChart" width="100" height="70"></canvas>
					</div>
					<div class="col-sm-2 text-center my-auto">
						<div class="h4 mb-0 text-primary allCenters"></div>
						<div class="small text-muted">행정구역당 센터 통계</div>
						<hr>
						<div class="small text-muted">최다 센터 갯수</div>
						<div class="h4 mb-0 text-primary mostCenters"></div>
						<div class="small text-muted mostCenterArea"></div>
						<hr>
						<div class="small text-muted">차다 센터 갯수</div>
						<div class="h4 mb-0 text-warning secondMostCenters"></div>
						<div class="small text-muted secondMostCenterArea"></div>
						<hr>
						<div class="small text-muted">최소 센터 갯수</div>
						<div class="h4 mb-0 text-danger leastCenters"></div>
						<div class="small text-muted leastCenterArea"></div>
					</div>
				</div>
			</div>
			<div class="card-footer small text-muted">Updated yesterday at 11:59 PM
			</div>
		</div>
	</div>
</div>
<!-- 
	<div class="col-xl-4">	
		<div class="col-lg-12">
	          Example Notifications Card
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bell-o"></i> Feed Example</div>
	            <div class="list-group list-group-flush small">
	              <a class="list-group-item list-group-item-action" href="#">
	                <div class="media">
	                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
	                  <div class="media-body">
	                    <strong>David Miller</strong> posted a new article to
	                    <strong>David Miller Website</strong>.
	                    <div class="text-muted smaller">Today at 5:43 PM - 5m ago</div>
	                  </div>
	                </div>
	              </a>
	              <a class="list-group-item list-group-item-action" href="#">
	                <div class="media">
	                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
	                  <div class="media-body">
	                    <strong>Samantha King</strong>sent you a new message!
	                    <div class="text-muted smaller">Today at 4:37 PM - 1hr ago</div>
	                  </div>
	                </div>
	              </a>
	              <a class="list-group-item list-group-item-action" href="#">
	                <div class="media">
	                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
	                  <div class="media-body">
	                    <strong>Jeffery Wellings</strong>added a new photo to the album
	                    <strong>Beach</strong>.
	                    <div class="text-muted smaller">Today at 4:31 PM - 1hr ago</div>
	                  </div>
	                </div>
	              </a>
	              <a class="list-group-item list-group-item-action" href="#">
	                <div class="media">
	                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
	                  <div class="media-body">
	                    <i class="fa fa-code-fork"></i>
	                    <strong>Monica Dennis</strong>forked the
	                    <strong>startbootstrap-sb-admin</strong>repository on
	                    <strong>GitHub</strong>.
	                    <div class="text-muted smaller">Today at 3:54 PM - 2hrs ago</div>
	                  </div>
	                </div>
	              </a>
	              <a class="list-group-item list-group-item-action" href="#">View all activity...</a>
	            </div>
				<div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
			</div>
		</div>
	</div>
 -->
</div>
	
	
          