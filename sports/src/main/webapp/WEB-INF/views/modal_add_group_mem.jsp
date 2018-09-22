<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="ui modal" id="insertGrpMemModal">
	<div class="header">
		<div class="container" >
			멤버목록
			<div class="ui right aligned container">
				<div class="ui action input">
					<input type="text" class="form-control" id="modal_txt_search_mem" placeholder="멤버검색"/>
					<input type="button" class="ui blue button" id="modal_btn_search_mem" value="검색"/>
				</div>			
			</div>
		</div>
	</div>

	<div class="content">
		<div class="container" style="margin-bottom: 5px">
			<table class="table table-hover" id="mem_table" style="text-align:center">
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="mem_chck_all" /></th>
						<th>멤버 아이디</th>
						<th>멤버 이름</th>
					</tr>
				</thead>
				<tbody class="tbody" id="tbody_group_mem">
				</tbody>
			</table>
		</div>
		<div class="container txt_msg">
		</div>
	</div>

	<div class="actions">
		<input type="submit" class="ui teal button" id="modal_btn_add_grp_mem" value="추가" />
		<button type="button" class="ui black deny button"
			data-dismiss="modal">취소</button>
	</div>
</div>
