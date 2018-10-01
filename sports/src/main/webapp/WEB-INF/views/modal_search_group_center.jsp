<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="ui modal" id="searchGrpCenterModal">
	<div class="header">
		<i class="building outline icon"></i>
		센터 목록
		<div class="ui right aligned container">
			<div class="ui mini action input labeled modal_search_center">
				<div class="ui label">검색  내 재검색</div>
				<input type="text" id="modal_input_search_center" placeholder="센터명/주소">
				<button class="ui primary icon button" id="modal_btn_search_center">
					<i class="search icon"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container" style="margin-bottom: 5px">
			<table class="ui selectable celled table table_modal" id="center_table" style="text-align:center">
				<thead class="thead-light">
					<tr>
						<th class="two wide">지역</th>
						<th>센터명</th>
						<th>주소</th>
						<th class="three wide">연락처</th>
					</tr>
				</thead>
				<tbody class="tbody center modal_tbody_group_center" id="modal_tbody_group_center" style="text-align:center; vertical-align: middle">
				</tbody>
			</table>
		</div>
		<div class="ui center aligned container" id="modal_container_pagination" style="margin-top: 20px"></div>
		<div class="ui center aligned container" id="modal_container_loader" style="margin-top: 20px; width: auto; height: 100%"></div>
	</div>
</div>
