<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../main/header.jsp" %>
<link rel="stylesheet" href="../css/Main.css" />
<%@include file="../main/styleloader.jsp" %>
<div class="container m-3">
	<h2>
		<i class="far fa-comments fa-lg"></i>게시글 상세조회
	</h2>
	<div class="col-md-11">
		<form>
			<div>
				<div
					class="input-group input-group-sm col-12 offset-sm-8 col-sm-4 mb-2">
					<input type="text" class="text-sm form-control"
						placeholder="검색어를 입력하세요" aria-label=""
						aria-describedby="basic-addon1">
					<div class="input-group-append">
						<button class="btn btn-success" type="button">검색</button>
					</div>
				</div>
				<ul class="nav">
					<!-- <li class="nav-item"><a class="nav-link" href="#">최신순</a></li>
					<li class="nav-item"><a class="nav-link" href="#">조회순</a></li>
					<li class="nav-item"><a class="nav-link" href="#">추천순</a></li>
					<li class="nav-item"><a class="nav-link" href="#">댓글순</a></li> -->
				</ul>
			</div>
		</form>

		<div class="row justify-content-center">
			<table class="col-md-10 table table-hover table-sm table-striped">
					<!-- 제목 -->
					<tr>
						<td colspan="1">제목</td><td colspan="15">${board.boardTitle }</td>
					</tr>
					<tr>
						<td colspan="1">no.</td><td colspan="3">${board.boardNo }</td>
						<td colspan="1">작성자</td><td colspan="2">${board.boardUser }</td>
						<td colspan="1">조회수</td><td colspan="2">${board.boardRead }</td>
						<td colspan="1">작성일</td><td colspan="2">${board.boardCreate }</td>	
						<td colspan="2">${board.boardRecommand }</td><td colspan="1"><i class="far fa-thumbs-up fa-sm"></i></td>
					</tr>
					<tr>
					
					</tr>
					<!-- 본문 -->
					<tr>
						<td colspan="16">${board.boardContent }</td>
					</tr>
					<!-- 수정 시간 -->
					<tr>
						<td colspan="16" align="left">최근 수정 시간 : ${board.boardModify }</td>
					</tr>
			
			</table>
			
		</div>
		
		<div class="row justify-content-center">
			<a href="#" class="btn btn-secondary btn-sm active"
			role="button" aria-pressed="true">작성</a>
				
			<a href="/Freeboard/update.do?boardno=${board.boardNo }" class="btn btn-secondary btn-sm active"
			role="button" aria-pressed="true">수정</a>
			
			<a href="/Freeboard/delete.do?boardno=${board.boardNo }" class="btn btn-secondary btn-sm active"
			role="button" aria-pressed="true">삭제</a>
		</div>
		<!-- 댓글 영역  -->
		<div class="row" id="replyDisplay"> 
<%-- 			<jsp:include page="/reply/reply.do?boardNo=${param.boardno }" /> 이부분 에러남 --%>
			<%-- Ajax 를 통해서 해결하면 될듯... 구현중 --%>
		</div>
	</div>
</div>
<%@include file="../main/scriptloader.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	//Ajax 통해서 reply.do 호출하고자 함 
	var url ="/reply/reply.do";
	var bNo = getUrlParameter("boardno");
	var data = {boardNo : bNo};
	// 쿼리스트링
	$("#replyDisplay").load(url, bNo);
});
</script>
<%@include file="../main/footer.jsp"%>