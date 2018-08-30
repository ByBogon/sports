<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade" id="insertGrpMemModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">멤버목록</h5>
				<div class="form-inline">			
					<input type="text" class="form-control" id="modal_txt_search_mem" placeholder="멤버검색"/>
					<input type="button" class="btn btn-primary" id="modal_btn_search_mem" value="검색"/>
				</div>
			</div>

			<div class="modal-body">
				<div class="container" style="margin-bottom: 5px">
					<table class="table table-hover" id="mem_table" style="text-align:center">
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" id="mem_chck_all" /></th>
								<th>멤버 아이디</th>
								<th>멤버 이름</th>
							</tr>
						</thead>
						<tbody class="tbody">
						</tbody>
					</table>
					<div class="container txt_msg">
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<input type="submit" class="btn btn-success" id="modal_add_grp_mem" value="추가" />
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
