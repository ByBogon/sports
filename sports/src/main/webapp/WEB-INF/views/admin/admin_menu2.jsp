<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="true" %>
<div class="d-flex justify-content-between flex-wrap
			flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h4>센터관리</h4>
</div>

<div>
	<table class="table table-hover table-sm">
		<thead>
			<tr style="text-align: center">
				<th scope="col"><input type="checkbox" />
				<td>센터번호</td>
				<td>센터명</td>
				<td>주소</td>
				<td>전화번호</td>
				<td>센터정보</td>
				<td>제보자</td>
				<td>제보일</td>
				<td>업데이트</td>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty mList}">
				<tr>
					<td colspan="9" style="text-align: center">내용이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty mList}">
				<c:forEach var="vo" items="${mList}">
					<tr>
						<td style="vertical-align: middle"><input type="checkbox" /></td>
						<td class="id"><input type="text" value="${vo.infrm_center_no}" class="form-control center_no" readonly style="text-align: center"/></td>
						<td><input type="text" value="${vo.infrm_center_name}" class="form-control center_name"/></td>
						<td><input type="text" value="${vo.infrm_center_addr}" class="form-control center_addr" /></td>
						<td><input type="text" value="${vo.infrm_center_tel}" class="form-control center_tel" /></td>
						<td><input type="text" value="${vo.infrm_center_detail}" class="form-control center_detail" /></td>
						<td><input type="text" value="${vo.mem_name}" class="form-control mem_name" readonly style="text-align: center"/></td>
						<td><input type="text" value="${vo.infrm_center_reg_date}" class="form-control center_reg_date" readonly style="text-align: center"/></td>
						<td><input type="text" value="${vo.infrm_center_updated_check}" class="form-control center_updated_check" readonly style="text-align: center"/></td>
						<td>
							<c:if test="${vo.infrm_center_updated_check == 0}">
								<button type="button" class="block-id-btn btn btn-sm btn-success btn-update-center">제보</button>
							</c:if>
							<c:if test="${vo.infrm_center_updated_check == 1}">
								<button type="button" class="block-id-btn btn btn-sm btn-primary btn-update-center">수정</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>	
</div>