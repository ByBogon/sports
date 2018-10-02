<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="ui modal" id="writeFeedOnGroup">
	<i class="close icon"></i>
	<div class="header">
		글쓰기
	</div>
		<form id="writeFeedForm" action="writeFeedOnBoard.do" method="post" enctype="multipart/form-data">
			<div class="image scrolling content">
				<div class="ui middle aligned two column padded relaxed grid">
					<div class="six wide column">
						<div class="ui medium rounded fluid image">
							<input id="file" name="file" type="file" accept=".jpg, .jpeg, .png, .gif" style="display: none">
							<img id="modal_img" class="center aligned" src="resources/images/default.png">
							
						</div>
					</div>
					<div class="ten wide column">
						<div class="description" style="width:100%">
							<div class="ui form">
								<input type="hidden" id="modal_grp_no" name="modal_grp_no">
								<div class="ui fluid field">
									<textarea rows="13" style="resize: none" id="textarea_content" name="textarea_content"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	<div class="actions">
		<div class="ui black deny button">
			취소
		</div>
		<div class="ui positive right labeled icon button">
			작성
			<i class="checkmark icon"></i>
		</div>
	</div>
</div>