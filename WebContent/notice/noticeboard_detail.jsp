<%@page import="dto.ReplyDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
						<td colspan="2" id="recommend">${board.boardRecommend }</td><td colspan="1"><i class="far fa-thumbs-up fa-sm"></i></td>
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
			<a href="/notice/notice.do" class="btn btn-secondary btn-sm active mr-1"
			role="button" aria-pressed="true">목록으로</a>
				
			<a href="/notice/update.do?boardno=${board.boardNo }" class="btn btn-secondary btn-sm active mr-1"
			role="button" aria-pressed="true">수정</a>
			
			<a href="/notice/delete.do?boardno=${board.boardNo }" class="btn btn-secondary btn-sm active mr-1"
			role="button" aria-pressed="true">삭제</a>
			
			<c:if test="${login }">
			<button id="btnRecommend" type="button" class="btn btn-secondary btn-sm active">추천</button>
			</c:if>
		</div>
		<!-- 댓글 입력 영역  -->
		<div class="row mt-3 justify-content-center" id="replyDisplay" > 
			<form action="/reply/reply.do" method="post" class="form-inline">
			  <div class="form-group mr-3">
			    <label for="userEmail">작성자</label>
			    <input type="email" class="form-control" id="userEmail" name="userEmail" value="${sessionScope.userEmail }" readonly />
			  </div>
			  <div class="form-group ">
			    <input type="text" class="form-control" id="boardNo" name="boardNo" value="${param.boardNo }" readonly hidden="true">
			  </div>
			  <div class="form-group mr-3">
			    <textarea class="form-control" id="replyContent" name="replyContent" placeholder="댓글을 입력해주세요."></textarea>
			  </div>
			  <button type="submit" class="btn btn-primary">Submit</button>
			</form>

		</div>
		<!-- 댓글 목록 영역 -->
		<div class="row mt-3 justify-content-center">
<%-- 			<c:import url="/reply/reply.do?boardNo=${board.boardNo }" />		 --%>
			<ul class="list-group">
				<c:forEach items="${replyList}" var="reply">
					<li class="list-group-item">
						<div class="d-flex w-100 justify-contents-between">
							<small>댓글번호:${reply.replyNo }, 작성자:${reply.userEmail }, 작성일:${reply.replyCreate }</small><button type="button" name="${reply.replyNo }" class="btn btn-sm bg-primary">댓글삭제</button>
						</div>
						<div>
							<p class="mb-1">${reply.replyContent }</p>					
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>

<%@include file="../main/scriptloader.jsp" %>
<script type="text/javascript">

	// 추천한 게시글이면 "추천 취소"로 보이도록 설정
	// 추천하지 않은 게시글이면 "추천"으로 보이도록 설정
	if(${recommend }) { //추천상태
		$("#btnRecommend")
			.addClass("btn-danger")
			.removeClass("btn-primary")
			.text("추천 취소");
	} else {	//추천 안 한상태
		$("#btnRecommend")
			.addClass("btn-primary")
			.removeClass("btn-danger")
			.text("추천");
	}
	
	// 추천 버튼 클릭 이벤트 처리
	$("#btnRecommend").click(function() {
		$.ajax({
			type: "get"
			, url: "/recommend/recommend.do"
			, dataType: "json"
			, data: {
				boardno: '${board.boardNo }'
			}
			, success: function(data) {
					console.log("success");
				console.log(data);
				
				//추천 버튼 색상 변경
				$("#btnRecommend")
					.toggleClass("btn-primary")
					.toggleClass("btn-danger");
	
				//추천수 갱신
				$("#recommend").text(data.recommend);
				
				//추천 버튼 텍스트 변경
				if(data.result) {
					$("#btnRecommend").text("추천 취소");
				} else {
					$("#btnRecommend").text("추천");
				}
			}
			, error: function(e) {
					console.log("fail");
				
				console.log(e.responseText);
			}
		});
	});

</script>

<%@include file="../main/footer.jsp"%>