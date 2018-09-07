<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../main/header.jsp" %>
<link rel="stylesheet" href="../summernote/summernote-bs4.css" />
<%@include file="../main/styleloader.jsp" %>
<div class="container m-3">

<%if(session.getAttribute("userNick") == null) { %>
	<script type="text/javascript">
		alert("로그인 상태여야 사용 가능합니다.")
		location.href = "/main/signin.do";
	</script>
<%} %>

	<h2><i class="fa fa-project-diagram fa-fw mr-1"></i>프로젝트 등록하기</h2>

<form action="/project/projectWrite.do" method="post">	
	  <div class="form-group row mt-5">
	    <label for="title" class="col-sm-2 col-form-label">프로젝트 명</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="title" name="title" placeholder="프로젝트명을 입력하세요">
	    </div>
	  </div>	  
	  	  
	  <div class="form-group row">
	    <div class="col-sm-2">지역</div>
	    <div class="col-sm-10">
	 	<select class="custom-select" name="location">	 	
			<option selected>지역을 선택하세요</option>	 		
	 		<c:forEach items="${location }" var="location">
 				<option value="${location.locationNo }">${location.locationName }</option>
	 		</c:forEach>	 		
		</select>
	    </div>
	  </div>  

	  <div class="form-group row">
	    <div class="col-sm-2">사용기술</div>
	    <div class="col-sm-10">
	    
	    	<c:forEach items="${tech }" var="tech" varStatus="stat">
	      	  <div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="inlineCheckbox${stat.index+1}" name="checkbox" value="${tech.techNo }">
			  <label class="form-check-label" for="inlineCheckbox${stat.index+1}">${tech.techName }</label>
			</div>
	    	</c:forEach>		
			
	    </div>
	  </div>
		
	  <div class="form-group row">
	    <div class="col-sm-2">기간</div>
		  
			<div class="form-group col-md-5">
			 <label >시작일</label>
			 <input type="date" name="startday" max="3000-12-31" 
			        min="1000-01-01" class="form-control">
			</div>
			
			<div class="form-group col-md-5">
			 <label >종료일</label>
			 <input type="date" name="endday" min="1000-01-01"
			        max="3000-12-31" class="form-control">
			</div>

	  </div>
	  
		<%-- 내용 --%>
		<%-- summernote_start --%>
		<textarea id="summernote" name="summernote"></textarea>
		
		<br>
		<%-- summernote_end --%>	  	

		<%-- 버튼 --%>
		<div class="row justify-content-around">
			<button id="btnReset" type="reset" class="btn btn-secondary">초기화</button>
			<button id="btnBefore" type="button" class="btn btn-secondary">목록으로</button>
			<button id="btnWrite" class="btn btn-primary">등록</button>
		</div>

</form>

</div>

<%@include file="../main/scriptloader.jsp" %>
<%-- 여기에 페이지에 사용할 js를 삽입하세요. --%>
<script type="text/javascript" src="../summernote/summernote-bs4.js" ></script>
<script type="text/javascript">
	// 버튼 이벤트
	$(document).ready(function(){
		$("#btnBefore").click(function(){
			history.back(); // 이전 화면으로 넘어가기
		});
		
		$("#btnReset").click(function(){
			$("#summernote").summernote("reset");
		});

		$("#btnWrite").click(function(){
			$("#summernote").summernote("code");
			$("form").submit();
		});

	});
</script>


<script type="text/javascript">
    	$(document).ready(function() {
      		$('#summernote').summernote({
      			height : 300 // 높이 300 지정
      		});
    	});
</script>

<%@include file="../main/footer.jsp" %>