<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="ui modal" id="insertGrpMemModal">
	<div class="header">
		<div class="container">
			멤버목록
			<div class="ui right aligned container">
				<div class="ui action mini input">
					<input type="text" id="modal_txt_search_mem" placeholder="멤버검색"/>
					<div class="ui blue button" id="modal_btn_search_mem">검색</div>
				</div>			
			</div>
		</div>
	</div>

	<div class="scrolling content">
		<div class="container" style="margin-bottom: 5px">
			<div class="ui dimmer" id="insertGrpMemModal_loader">
				<div class="ui text loader">Loading</div>
			</div>
			<table class="ui selectable celled table table_modal" id="mem_table" style="text-align:center">
				<thead>
					<tr>
						<th scope="col"></th>
						<th>멤버 아이디</th>
						<th>멤버 이름</th>
					</tr>
				</thead>
				<tbody class="tbody addGrpMemTbody" id="tbody_group_mem">
				</tbody>
			</table>
		</div>
		<div class="container txt_msg"></div>
		
	</div>

	<div class="actions">
		<div class="ui teal button" id="modal_btn_add_grp_mem">추가</div>
		<div class="ui black deny button">취소</div>
	</div>
</div>
