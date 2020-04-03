<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : board.jsp
  * @Description : SSIC board 화면
  * @Modification Information
  *
  *   수정일					수정자			수정내용
  *  -------------		-------		--------
  *  2020.02.01		swkim		최초 생성
  */
%>
<!DOCTYPE HTML>
<html>
<head>
<title>(주)신성아이앤씨</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="/css/ssic/w3.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javaScript" defer="defer">

$(function(){
	$("button").on('click', function(e){
		e.stopPropagation();	// 기본 이벤트를 제거
		e.preventDefault();	// 이벤트 전달을 막기
	});
});

/* 게시판 상세 조회 이벤트 */
function fn_selectBoardDetail(boardNo) {
	var params = [
		$('#boardId').val(),	// 게시판 구분
		boardNo					// 게시판 No
	];
	
	$.ajax({
        url :"<c:url value='/selectBoardDetail.do'/>",
        type :"POST",
        traditional : true,
        data : { params : params },
        dataType : "json",
        success : function(data) {
            console.log("$.Ajax / selectBoardDetail.do / success");
			
        	if (data.result != null) {
            	$('#boardModal').css("display", "block");
            	
                $("#board_user").attr("readonly", true);
            	
            	$('#boardNo').val(data.result.boardNo);					// 게시판번호 : hidden
            	$('#boardPw').val(data.result.boardPw);					// 비밀번호 : hidden
            	
            	$('#board_title').val(data.result.boardTitle);				// 제목
            	$('#board_user').val(data.result.boardUser);				// 작성자
            	$('#board_date').val(data.result.boardDate);				// 작성일
            	$('#board_pw').val("");											// 비밀번호
            	$('#board_content').val(data.result.boardContent);	// 내용
        	} else {
        		alert("처리 중 오류가 발생하였습니다.\n관리자에게 문의바랍니다.");
        	}
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert("Error :\n" + textStatus + " / " + errorThrown);
            self.close();
        }
    });
}
/*/게시판 상세 조회 이벤트 */

function fn_selectBoardAdd() {
	$('#boardModal').css("display", "block");
	
	$("#board_user").removeAttr("readonly");
	
	$('#boardNo').val("");	// 게시판번호 : hidden
	$('#boardPw').val("");	// 비밀번호 : hidden

	$('#board_title').val("");							// 제목
	$('#board_user').val("");							// 작성자
	$('#board_date').val(getTodayType());		// 작성일
	$('#board_pw').val("");							// 비밀번호
	$('#board_content').val("");						// 내용
}

</script>
<body>

	  	<!-- List -->
	  	<div id="table" style="margin-bottom: 24px">
	  		<table class="w3-table" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
	  			<caption style="visibility:hidden">No, 카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
	  			<colgroup>
	  				<col width="10%"/>
	  				<col width="?"/>
	  				<col width="15%"/>
	  				<col width="25%"/>
	  			</colgroup>
	  			<tr>
	  				<th class="w3-center">No</th>
	  				<th class="w3-center">제목</th>
	  				<th class="w3-center w3-hide-small">작성자</th>
	  				<th class="w3-center">작성일</th>
	  			</tr>
	  			<c:forEach var="item" items="${boardList}" varStatus="status">
	      			<tr>
						<td class="w3-center"><c:out value="${paginationInfo.totalRecordCount+1 - ((paginationInfo.currentPageNo-1) * paginationInfo.pageSize + status.count)}"/></td>
	      				<td><a href="#<c:out value="${item.boardNo}"/>" onclick="fn_selectBoardDetail('<c:out value="${item.boardNo}"/>')"><c:out value="${item.boardTitle}"/></a></td>
	      				<td class="w3-center w3-hide-small"><c:out value="${item.boardUser}"/></td>
	      				<td class="w3-center"><c:out value="${item.boardDate}"/></td>
	      			</tr>
	  			</c:forEach>
	  		</table>
	  	</div>
	  	<!-- End List -->
	  	
	  	<!-- paging part -->
		<div class="w3-row w3-row-padding" style="margin-bottom: 16px">
		   	<div class="w3-center">
		    	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_selectBoardList" />
	      	</div>
	        <button class="w3-button w3-right w3-blue-grey" onclick="fn_selectBoardAdd();">ADD</button>
		</div>
		<!-- End paging part -->
		
</body>
</html>
