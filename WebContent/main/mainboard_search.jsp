<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../main/header.jsp" %>
<link rel="stylesheet" href="../css/Main.css" />
<%@include file="../main/styleloader.jsp" %>
<c:set var="FreeBoard" value="FreeBoard" />
<c:set var="TechBoard" value="TechBoard" />
<c:set var="QuestionBoard" value="QuestionBoard" />
<c:set var="NoticeBoard" value="NoticeBoard" />
<c:set var="Recruit" value="Recruit" />


<div class="container m-3">
	<h1>
		<span class="fa fa-laptop fa-fw mr-1"></span>전체 게시판 검색결과
	</h1>
	<div class="col mt-1">
		<div class="col-mt-11">
			<form action="/Main/search.do" name="search" method="get">	
				<div>
					<div class="input-group input-group-sm col-12 offset-sm-8 col-sm-4 my-3">
						<input type="text" class="text-sm form-control"
							placeholder="내용을입력하세요" aria-label=""
							aria-describedby="basic-addon1" name="searchString">
						<div class="input-group-append">
							<button class="btn btn-success" type="submit">검색</button>
						</div>
					</div>
				</div>
			</form>

			<div style="overflow: auto;" class="">
				<table class="table table-hover table-sm">
					<thead class="thead-light">
						<tr>
							<th>카테고리</th>	<!-- 카테고리 추가 -->
							<th>글번호</th>
							<th>작성일</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th><i class="far fa-thumbs-up fa-sm"></i></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${boardList }" var="board">
						<tr>
							<td>${board.boardCategory }</td>  <!-- 카테고리 추가 -->
							<td>${board.boardNo }</td>
							<td>${board.boardCreate }</td>
							<td>
								<c:if test="${board.boardCategory eq FreeBoard }" >
									<a href="/Freeboard/detail.do?boardno=${board.boardNo }">${board.boardTitle }</a>
								</c:if>
								<c:if test="${board.boardCategory eq TechBoard }" >
									<a href="/tech/detail.do?boardno=${board.boardNo }">${board.boardTitle }</a>
								</c:if>
								<c:if test="${board.boardCategory eq NoticeBoard }">
									<a href="/notice/detail.do?boardno=${board.boardNo }">${board.boardTitle }</a>
								</c:if>
								<c:if test="${board.boardCategory eq QuestionBoard }">
									<a href="/question/detail.do?boardno=${board.boardNo }">${board.boardTitle }</a>
								</c:if>
								<c:if test="${board.boardCategory eq Recruit }">
									<a href="/recruit/detail.do?boardno=${board.boardNo }">${board.boardTitle }</a>
								</c:if>
							</td>
							<td>${board.boardNick }</td>
							<td>${board.boardRead }</td>
					    	<td>${board.boardRecommend }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="row justify-content-center">
				<div class="col-3 text-center m-1">
					<%-- 게시판으로 돌아가기 버튼 --%>
					<a href="/main/main.do" class="btn btn-secondary btn-sm active" role="button" aria-pressed="true">돌아가기</a>
				</div>
			</div>	
			<div class="row justify-content-center">
				<div class="col m-4">
					<%-- 페이지네이션 --%>
					<jsp:include page="/util/totalsearchPaging.jsp" />
				</div>
			</div>
		</div>

	</div>
</div>
<%@include file="../main/scriptloader.jsp" %>
<%@include file="../main/footer.jsp"%>