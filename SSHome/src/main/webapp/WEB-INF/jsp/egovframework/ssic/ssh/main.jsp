<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : main.jsp
  * @Description : SSIC Main 화면
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

<style>
	body {font-family: "Lato", sans-serif}
	.mySlides {display: none}
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javaScript" defer="defer">
/* 전역 변수 영역 */
var ciNum = 0; // 회사소개 아이콘 Num
var myIndex = 0; // slideshow 화면 Index
/*/전역 변수 영역 */

/* 현재일자 */
function getTodayType() {
  var date = new Date();
  return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
}
/*/현재일자 */

window.onload = function() {
	// slideshow 변경 이벤트
	fn_carousel();

	// 카카오지도 깨짐 현상
	$('#ci_zone6').css("display", "none");

	// 화면시작 위치 변경 이벤트
	var sectionIndex = "${sectionIndex}";
	fn_moveSection(1, sectionIndex);
	
	// 게시판 표시
	fn_selectBoardList(1);
}

$(function(){
	$("#boardKeyword").keydown(function(e) {
		if (e.keyCode == "13") {
			fn_selectBoardList(1);
		}
	});
});

/* slideshow 변경 이벤트 */
function fn_carousel() {
	var x = document.getElementsByClassName("mySlides");
	
	for (var i = 0; i < x.length; i++) {
		x[i].style.display = "none";
	};
	
	myIndex++;
	
	if (myIndex > x.length) {myIndex = 1}
	x[myIndex-1].style.display = "block";
	setTimeout(fn_carousel, 4000);
}
/*/slideshow 변경 이벤트 */

/* small 화면시 우측 바 클릭 이벤트 */
function fn_smallRightBar() {
	var x = document.getElementById("navDemo");
	
	if (x.className.indexOf("w3-show") == -1) {
		x.className += " w3-show";
	} else {
		x.className = x.className.replace(" w3-show", "");
	}
}
/*/small 화면시 우측 바 클릭 이벤트 */

/* section 이동 이벤트 */
function fn_moveSection(flag, num) {
	// 첫화면 구분
	if (!flag && num != "0") fn_smallRightBar();
	
	// 화면 위치 이동
	var offset = "";
	if (num != null && num != "") offset = $("#section" + num).offset();
	if (offset != "") $('html, body').animate({scrollTop : offset.top - 45}, 400);
}
/*/section 이동 이벤트 */

/* 회사소개 a Tag 클릭 이벤트 */
function fn_ci_Onclick(num) {
	var offset = $("#ci_icon" + num).offset(); // company_intro 버튼 위치
	
	if (ciNum == 0) {
		// 스크롤 위치 이동
	    $('html, body').animate({scrollTop : offset.top - 45}, 400);
		
	    // div 활성화, css 변경
		$('#ci_zone' + num).css("display", "block");
		$('#ci_icon' + num).addClass("w3-teal");
		
		ciNum = num;
	} else if (ciNum != num) {
		// 스크롤 위치 이동
	    $('html, body').animate({scrollTop : offset.top - 45}, 400);
		
	 	// div 활성화, css 변경
		$('#ci_zone' + ciNum).css("display", "none");
		$('#ci_icon' + ciNum).removeClass("w3-teal");
		$('#ci_zone' + num).css("display", "block");
		$('#ci_icon' + num).addClass("w3-teal");
		
		ciNum = num;
	} else if (ciNum == num) {
		// div 비활성화, css 변경
		$('#ci_zone' + num).css("display", "none");
		$('#ci_icon' + ciNum).removeClass("w3-teal");
		
		ciNum = 0;
	}
}
/*/회사소개 a Tag 클릭 이벤트 */

/* 회사소개 a Tag 마우스 오버 이벤트 */
function fn_ci_Onmouseover(num) {
	$('#ci_icon' + num).addClass("w3-teal");
}
/*/회사소개 a Tag 마우스 오버 이벤트 */

/* 회사소개 a Tag 마우스 아웃 이벤트 */
function fn_ci_Onmouseout(num) {
	if (ciNum != num) {
		$('#ci_icon' + num).removeClass("w3-teal");
	}
}
/*/회사소개 a Tag 마우스 아웃 이벤트 */

/* 사업년도 select Tag change 이벤트 */
function fn_selectBsnsList() {
	var params = [
		$('#bsnsYear').val() // 사업실적 년도
	];
	
	$.ajax({
        url :"<c:url value='/selectBsnsRstList.do'/>",
        type :"POST",
        traditional : true,
        data : { params : params },
        dataType : "json",
        success : function(data) {
            console.log("$.Ajax / selectBsnsRstList.do / success");
            
            var strHtml = "";
            strHtml += '<table class="w3-table" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">';
            strHtml += '	<caption style="visibility:hidden">사업년도, 기관명, 사업명, 사업기간, 구분 표시하는 테이블</caption>';
            strHtml += '	<colgroup><col width="10%"/><col width="20%"/><col width="?"/><col width="20%"/><col width="10%"/></colgroup>';
            strHtml += '	<tr><th class="w3-center">년도</th><th class="w3-center">기관명</th><th class="w3-center">사업명</th><th class="w3-center w3-hide-small">사업기간</th><th class="w3-center">구분</th></tr>';
            $(data.result).each(function() {
	            strHtml += '<tr>';
	            strHtml += '	<td class="w3-center">' + this.bsnsYear + '</td>';
	            strHtml += '	<td>' + this.orgName + '</td>';
	            strHtml += '	<td><a href="#' + this.bsnsId + '" onclick="fn_selectBsnsDetail(' + "'" + this.bsnsId + "'" + ')">' + this.bsnsName + '</a></td>';
	            strHtml += '	<td class="w3-center w3-hide-small">' + this.bsnsTerm + '</td>';
	            strHtml += '	<td class="w3-center">' + this.bsnsPart + '</td>';
	            strHtml += '</tr>';
            })
	        strHtml += '</table>';
	        
	        // Table 다시 작성
	        $('#bsnsRstList').html(strHtml);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert("Error :\n" + textStatus + " / " + errorThrown);
            self.close();
        }
    });
}
/*/사업년도 select Tag change 이벤트 */

/* 사업명 a Tag 클릭 이벤트 */
function fn_selectBsnsDetail(bsnsId) {
	var params = [
		bsnsId // 사업실적 ID
	];
	
	$.ajax({
        url :"<c:url value='/selectBsnsRstDetail.do'/>",
        type :"POST",
        traditional : true,
        data : { params : params },
        dataType : "json",
        success : function(data) {
            console.log("$.Ajax / selectBsnsRstDetail.do / success");
            
        	if (data.result != null) {
            	$('#bsnsModal').css("display", "block");
            	
	        	$('#bsns_year').val(data.result.bsnsYear);
	        	$('#bsns_org').val(data.result.orgName);
	        	$('#bsns_term').val(data.result.bsnsTerm);
	        	$('#bsns_part').val(data.result.bsnsPart);
	        	$('#bsns_name').val(data.result.bsnsName);
	        	$('#bsns_etc').val(data.result.etc);
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
/*/사업명 a Tag 클릭 이벤트 */

/* 사업소개 a Tag 클릭 이벤트 */
function fn_BsnsIntro_Onclick(num) {
	document.MenuForm.sectionIndex.value = num;
	document.MenuForm.action = "<c:url value='/selectBusiness.do'/>";
   	document.MenuForm.submit();
}
/*/사업소개 a Tag 클릭 이벤트 */

function fn_bMenu_Onclick(num) {
	// 첫 게시판 : 자료실
	$("button[name=bMenu]").removeClass("w3-gray");
	$("button[name=bMenu]").removeClass("w3-light-gray");
	$("button[name=bMenu]").addClass("w3-light-gray");

	$("#bMenu" + num).removeClass("w3-light-gray");
	$("#bMenu" + num).addClass("w3-gray");
	
	$('#boardId').val("B0" + num);	// 게시판 구분
	$('#boardCondition').val("0");	// 게시판 Condition
	$('#boardKeyword').val("");		// 게시판 Keyword
	
	fn_selectBoardList(1);
}

/* 게시판 목록 조회 이벤트 */
function fn_selectBoardList(pIndex) {
	var params = [
		pIndex,									// 페이지 인덱스
		$('#boardId').val(),				// 게시판 구분
		$('#boardCondition').val(),	// 게시판 Condition
		$('#boardKeyword').val()		// 게시판 Keyword
	];
	
	$.ajax({
	    url:  "<c:url value='/selectBoardList.do'/>",
	    type: "POST",
	    traditional : true,
	    data:  { params : params },
	    dataType: "html",
	    success: function(data) {
			$("#boardDiv").empty();
			$("#boardDiv").html(data);
	   },
	   error:function(request, status, error){
	      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	     }
	 });
}
/*/게시판 목록 조회 이벤트 */

/* 게시판 목록 조회 이벤트 */
function fn_saveBoardDetail() {
	if (!fn_inputValidation()) return;
	
	if (confirm('저장하시겠습니까?')) {
		var params = [
			$('#boardId').val(),				// 게시판 구분
			$('#boardNo').val(),				// 게시판 No
			$('#board_title').val(),			// 게시판 제목
			$('#board_user').val(),			// 작성자
			$('#board_pw').val(),			// 비밀번호
			$('#board_content').val()		// 내용
		];
		
		$.ajax({
		    url:  "<c:url value='/saveBoardDetail.do'/>",
	        type :"POST",
	        traditional : true,
	        data : { params : params },
	        dataType : "json",
	        success : function(data) {
	            console.log("$.Ajax / saveBoardDetail.do / success");
	            
	        	$('#boardModal').css("display", "none");
	        	fn_selectBoardList(1);
		   },
		   error:function(request, status, error){
		      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		     }
		 });
	}
}
/*/게시판 목록 조회 이벤트 */

/* input 체크 */
function fn_inputValidation () {
	if ($("#board_title").val() == null || $("#board_title").val() == "") {
		alert("제목을/를 입력하시기 바랍니다.");
		return false;
	}
	if ($("#board_user").val() == null || $("#board_user").val() == "") {
		alert("작성자을/를 입력하시기 바랍니다.");
		return false;
	}
	if ($("#board_pw").val() == null || $("#board_pw").val() == "") {
		alert("비밀번호을/를 입력하시기 바랍니다.");
		return false;
	}
	if ($("#board_content").val() == null || $("#board_content").val() == "") {
		alert("내용을/를 입력하시기 바랍니다.");
		return false;
	}
	if ($("#boardNo").val() != null && $("#boardNo").val() != "") {
		if ($('#boardPw').val() != $('#board_pw').val()) {
			alert("비밀번호가 일치하지 않습니다.\n확인 후 입력하시기 바랍니다.");
			return false;
		}
	}
	return true;
}
/*/input 체크 */

</script>
<body>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-blue w3-card">
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_moveSection(0, '0')">HOME</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small" onclick="fn_moveSection(0, '1')">COMPANY</a>
    <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button w3-blue" onclick="fn_moveSection(0, '2')">BUSINESS▼</button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_BsnsIntro_Onclick(1)">SI사업</a>
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_BsnsIntro_Onclick(2)">SM사업</a>
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_BsnsIntro_Onclick(3)">솔루션&amp;SW</a>
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_BsnsIntro_Onclick(4)">IT컨설팅</a>
      </div>
    </div>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small" onclick="fn_moveSection(0, '3')">BOARD</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-right">&nbsp;</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" onclick="fn_smallRightBar()" title="Toggle Navigation Menu">≡</a>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-blue w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_moveSection(0, '1')">COMPANY</a>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_moveSection(0, '2')">BUSINESS</a>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_moveSection(0, '3')">BOARD</a>
</div>
<!-- /Navbar on small screens -->
<!-- /Navbar -->

<!-- Page content -->
<div class="w3-content" style="max-width:3000px;margin-top:46px">

  <!-- Automatic Slideshow Images -->
  <div id="section0">
	  <div class="mySlides w3-display-container w3-center">
	    <img src="/images/ssic/slideshow01.png" style="width:100%">
	    <div class="w3-display-bottommiddle w3-container w3-text-black w3-padding-32 w3-hide-small">
	      <h3>Opportunity</h3>
	      <p><b>현명한 자라면 찾아낸 기회보다<br>더 많은 기회를 만들 것이다.</b></p>
	    </div>
	  </div>
	  <div class="mySlides w3-display-container w3-center">
	    <img src="/images/ssic/slideshow02.png" style="width:100%">
	    <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
	      <h3>Innovation</h3>
	      <p><b>인생 최고의 가치는 도전,<br>그리고 혁신</b></p>
	    </div>
	  </div>
	  <div class="mySlides w3-display-container w3-center">
	    <img src="/images/ssic/slideshow03.png" style="width:100%">
	    <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
	      <h3>Success</h3>
	      <p><b>좌절과 실패는 성공으로 가는<br>가장 확실한 디딤돌이다.</b></p>
	    </div>
	  </div>
  </div>
  <!-- /Automatic Slideshow Images -->

  <!-- The First Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:1000px" id="section1">
    <h1 class="w3-wide">SHINSUNG I&amp;C</h1>
    <p class="w3-opacity">
    	<i>Best Partner, Best Service</i><br>
    	<i>세상을 변화시키는 힘</i>
    </p>
    <img src="/images/ssic/main01.PNG" style="width:100%">
    <div class="w3-container w3-text-blue w3-padding-24">
      <p><b>
      	신성아이앤씨 Solution &amp; Product<br>
      	고객의 기대에 최상의 품질로 보답하는 기업이 되도록 최선을 다하겠습니다.
      </b></p>
    </div>
    <div class="w3-row">
    	<div class="w3-show-inline-block">
	      <div id="ci_icon1" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#ci" onclick="fn_ci_Onclick(1);" onmouseover="fn_ci_Onmouseover(1);" onmouseout="fn_ci_Onmouseout(1);">
			        <img src="/images/ssic/company_icon01.png" class="w3-round w3-margin-bottom" alt="CEO 인사말"><br>
			        CEO 인사말
		        </a>
	        </p>
	      </div>
	      <div id="ci_icon2" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#ch" onclick="fn_ci_Onclick(2);" onmouseover="fn_ci_Onmouseover(2);" onmouseout="fn_ci_Onmouseout(2);">
			      	<img src="/images/ssic/company_icon02.png" class="w3-round w3-margin-bottom" alt="회사연혁"><br>
			      	회사연혁
		      	</a>
	      	</p>
	      </div>
	      <div id="ci_icon3" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#bf" onclick="fn_ci_Onclick(3);" onmouseover="fn_ci_Onmouseover(3);" onmouseout="fn_ci_Onmouseout(3);">
			        <img src="/images/ssic/company_icon03.png" class="w3-round w3-margin-bottom" alt="사업분야"><br>
			        사업분야
			    </a>
		    </p>
	      </div>
	   </div>
    	<div class="w3-show-inline-block">
	      <div id="ci_icon4" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#br" onclick="fn_ci_Onclick(4);" onmouseover="fn_ci_Onmouseover(4);" onmouseout="fn_ci_Onmouseout(4);">
			        <img src="/images/ssic/company_icon04.png" class="w3-round w3-margin-bottom" alt="사업실적"><br>
			        사업실적
		        </a>
	        </p>
	      </div>
	      <div id="ci_icon5" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#og" onclick="fn_ci_Onclick(5);" onmouseover="fn_ci_Onmouseover(5);" onmouseout="fn_ci_Onmouseout(5);">
			        <img src="/images/ssic/company_icon05.png" class="w3-round w3-margin-bottom" alt="조직도"><br>
			        조직도
		        </a>
	        </p>
	      </div>
	      <div id="ci_icon6" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#map" onclick="fn_ci_Onclick(6);" onmouseover="fn_ci_Onmouseover(6);" onmouseout="fn_ci_Onmouseout(6);">
			        <img src="/images/ssic/company_icon06.png" class="w3-round w3-margin-bottom" alt="오시는 길"><br>
			        오시는 길
		        </a>
	        </p>
	      </div>
	    </div>
	  </div>
    
    <!-- CEO 인사말 -->
    <div id="ci_zone1" class="w3-animate-top w3-margin" style="display: none;">
    	<img src="/images/ssic/ceo_intro01.gif" class="w3-round w3-margin"/>
    	<div class="w3-margin">
    		<div class="w3-half">
    			<img src="/images/ssic/ceo_intro02.gif" class="w3-center w3-margin-bottom"/>
    		</div>
    		<div class="w3-half w3-left-align">
    			저희 신성아이앤씨를 방문해 주신 고객 여러분, 진심으로 환영합니다.<br><br>
    			신성아이앤씨는 지난 2001년 설립 이후 날로 치열해지는 무한경쟁의 기업환경과 하루가 다르게 변화되는 IT기술의 흐름속에 끈임없는 변화와 자기혁신을 통하여 지속적으로 성장해 왔습니다.<br><br>
    			그 동안 쌓아온 풍부한 경험과 다양한 노하우를 기반으로 SI사업, SM사업, 솔루션, IT컨설팅 등 다양한 IT기술부분에 대하여 고객의 요구에 맞추어 최적의 업무환경을 제공해 드리고 있습니다.<br><br> 
    			또한 스스로 가치를 창조하는 창의정신과 실천적 도전정신을 바탕으로 고객에게 신뢰받는 든든한 파트너가 되도록 노력하겠습니다.<br><br><br>
    			<b>대표이사  김종호</b>
    			<img src="/images/ssic/ceo_intro03.gif" class="w3-right"/>
    		</div>
    	</div>
    </div>
    <!-- CEO 인사말 -->
    
    <!-- 회사연혁 -->
    <div id="ci_zone2" class="w3-animate-top w3-margin" style="display: none;">
    	<div class="w3-third">
    		<img src="/images/ssic/com_his01.gif" class="w3-margin"/>
    	</div>
   		<div class="w3-half w3-border-left w3-left-align">
			<table class="w3-margin-left" style="border-spacing: 10px;">
				<colgroup>
       				<col width="15%"/>
       				<col width="?"/>
       			</colgroup>
				<tr>
					<td valign=top><b>2018</b></td>
					<td>경영혁신형 중소기업 (Main-Biz) 인증</td>
				</tr>
				<tr>
					<td valign=top><b>2017</b></td>
					<td>한국산업인력공단 일학습 병행제 사업 및 훈련 실시 약정체결</td>
				</tr>
				<tr>
					<td valign=top><b>2016</b></td>
					<td>서울지방고용노동청 근로자 파견 사업 등록</td>
				</tr>
				<tr>
					<td valign=top><b>2015</b></td>
					<td>인천재능대학교 산학협력 협약 한국산업기술진흥협회 기업연구소 설립</td>
				</tr>
				<tr>
					<td valign=top><b>2013</b></td>
					<td>신성아이앤씨 본사 이전(서초구 양재동)</td>
				</tr>
				<tr>
					<td valign=top><b>2011</b></td>
					<td>신용보증기금 우수중소기업 선정</td>
				</tr>
				<tr>
					<td valign=top><b>2009</b></td>
					<td>삼성에스디에스 개발협력사 선정 우리에프아이에스 개발협력사 선정</td>
				</tr>
				<tr>
					<td valign=top><b>2007</b></td>
					<td>KB데이타 개발 협력사 선정</td>
				</tr>
				<tr>
					<td valign=top><b>2005</b></td>
					<td>SK씨엔씨 기술제휴 파트너 선정</td>
				</tr>
				<tr>
					<td valign=top><b>2004</b></td>
					<td>다우기술 핵심사업 개발사 선정</td>
				</tr>
				<tr>
					<td valign=top><b>2003</b></td>
					<td>신세계아이앤씨 개발 파트너 선정</td>
				</tr>
				<tr>
					<td valign=top><b>2002</b></td>
					<td>신성아이앤씨 법인설립(강남구 대치동)</td>
				</tr>
			</table>
   		</div>
    </div>
    <!-- 회사연혁 -->
    
    <!-- 사업분야 -->
    <div id="ci_zone3" class="w3-animate-top w3-margin" style="display: none;">
    	<img src="/images/ssic/bus_field01.png" class="w3-auto w3-margin"/>
    </div>
    <!-- 사업분야 -->
    
    <!-- 사업실적 -->
    <div id="ci_zone4" class="w3-animate-top w3-margin" style="display: none;">
    	<div class="w3-margin">
	      <div class="w3-left-align">
	      		<img src="/images/ssic/business_result01.gif" class="w3-auto w3-margin-top"/>
	      </div>
        	<!-- List -->
        	<div id="bsnsRstList" class="w3-center">
        		<table class="w3-table" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">사업년도, 기관명, 사업명, 사업기간, 구분 표시하는 테이블</caption>
        			<colgroup>
        				<col width="10%"/>
        				<col width="20%"/>
        				<col width="?"/>
        				<col width="20%"/>
        				<col width="10%"/>
        			</colgroup>
        			<tr>
        				<th class="w3-center">년도</th>
        				<th class="w3-center">기관명</th>
        				<th class="w3-center">사업명</th>
        				<th class="w3-center w3-hide-small">사업기간</th>
        				<th class="w3-center">구분</th>
        			</tr>
        			<c:forEach var="item" items="${bsnsRstList}" varStatus="status">
            			<tr>
            				<td class="w3-center"><c:out value="${item.bsnsYear}"/></td>
            				<td><c:out value="${item.orgName}"/></td>
            				<td><a href="#<c:out value="${item.bsnsId}"/>" onclick="fn_selectBsnsDetail('<c:out value="${item.bsnsId}"/>')"><c:out value="${item.bsnsName}"/></a></td>
            				<td class="w3-center w3-hide-small" ><c:out value="${item.bsnsTerm}"/></td>
            				<td class="w3-center"><c:out value="${item.bsnsPart}"/></td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- End List -->
	      	<div class="w3-margin">
		      	<div class="w3-show-inline-block">
		      		<B>사업년도 :&nbsp;</B>
		      	</div>
		      	<div class="w3-show-inline-block"> 
					<select id="bsnsYear" class="w3-select w3-border" onchange="fn_selectBsnsList()">
		       			<c:forEach var="item" items="${bsnsYearList}" varStatus="status">
					    	<option value='<c:out value="${item.bsnsYear}"/>'><c:out value="${item.bsnsYear}"/></option>
		       			</c:forEach>
					</select>
				</div>
	      	</div>
        </div>
    </div>
    <!-- 사업실적 -->
    
    <!-- 조직도 -->
    <div id="ci_zone5" class="w3-animate-top w3-margin" style="display: none;">
    	<img src="/images/ssic/company_group01.gif" class="w3-auto w3-margin"/>
    </div>
    <!-- 조직도 -->
    
    <!-- 오시는 길 -->
    <div id="ci_zone6" class="w3-animate-top w3-margin" style="display: block;">
    	<div class="w3-show-inline-block">
			<h4><b>신성아이앤시 본사</b></h4>
			<!-- 1. 약도 노드 -->
			<div id="daumRoughmapContainer1584084460769" class="root_daum_roughmap root_daum_roughmap_landing"></div>
			
			<!-- 2. 설치 스크립트 -->
			<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
			
			<!-- 3. 실행 스크립트 -->
			<script charset="UTF-8">
				new daum.roughmap.Lander({
					"timestamp" : "1584084460769",
					"key" : "xhn8",
					"mapWidth" : "450",
					"mapHeight" : "300"
				}).render();
			</script>
		</div>
		<!--
    	<div class="w3-half">
			<h4><b>R&amp;D Center</b></h4>
			
			<div id="daumRoughmapContainer1584084346968" class="root_daum_roughmap root_daum_roughmap_landing"></div>
			
			<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
			
			<script charset="UTF-8">
				new daum.roughmap.Lander({
					"timestamp" : "1584084346968",
					"key" : "xhn3",
					"mapWidth" : "450",
					"mapHeight" : "300"
				}).render();
			</script>
		</div>
		-->
    </div>
    <!-- 오시는 길 -->
  </div>
  <!-- /The First Section -->

  <!-- The Second Section -->
  <div class="w3-blue" id="section2">
  	<form id="MenuForm" name="MenuForm">
  		<input type="hidden" name="sectionIndex">
  	</form>
  	
    <div class="w3-container w3-content w3-padding-64" style="max-width:1000px">
      <h2 class="w3-wide w3-center">BUSINESS</h2>
      <p class="w3-opacity w3-center"><i>SI, SM 사업, 솔루션&amp;소프트웨어, IT 컨설팅</i></p><br>

      <ul class="w3-ul w3-border w3-white w3-text-grey">
        <li class="w3-padding">SI 사업<span class="w3-badge w3-right w3-margin-right">3</span></li>
        <li class="w3-padding">SM 사업<span class="w3-badge w3-right w3-margin-right">1</span></li>
        <li class="w3-padding">솔루션&amp;소프트웨어<span class="w3-badge w3-right w3-margin-right">4</span></li>
        <li class="w3-padding">IT 컨설팅<span class="w3-badge w3-right w3-margin-right">1</span></li>
      </ul>

      <div class="w3-row-padding w3-padding-32" style="margin:0 -16px">
        <div class="w3-quarter w3-margin-bottom">
          <a href="#SI_Business" onclick="fn_BsnsIntro_Onclick(1)">
          	<img src="/images/ssic/business01.jpg" alt="SI_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
          </a>
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>SI 사업</b></p>
            <p class="w3-opacity">Fri 27 Nov 2016</p>
            <p>대학교, 기업(공공), 모바일</p>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <a href="#SI_Business" onclick="fn_BsnsIntro_Onclick(2)">
          	<img src="/images/ssic/business02.jpg" alt="SM_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
          </a>
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>SM 사업</b></p>
            <p class="w3-opacity">Sat 28 Nov 2016</p>
            <p>사업개요, 구성도, etc</p>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <a href="#SI_Business" onclick="fn_BsnsIntro_Onclick(3)">
          	<img src="/images/ssic/business03.jpg" alt="Sol&SW" style="width:100%;height:100%;" class="w3-hover-opacity">
          </a>
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>솔루션&amp;소프트웨어</b></p>
            <p class="w3-opacity">Sun 29 Nov 2016</p>
            <p>Appeon, PowerFrame</p>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <a href="#SI_Business" onclick="fn_BsnsIntro_Onclick(4)">
          	<img src="/images/ssic/business04.jpg" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
          </a>
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>IT 컨설팅</b></p>
            <p class="w3-opacity">Sun 29 Nov 2016</p>
            <p>ISP, IT Assessment</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- /The Second Section -->

  <!-- The Third Section -->
  <div class="w3-container w3-content w3-padding-64" style="max-width:1000px" id="section3">
	<h2 class="w3-wide w3-center">BOARD</h2>
	<p class="w3-opacity w3-center"><i>ShinsungI&amp;C RECRUIT</i></p>
        <div class="w3-row">
        
			    <input type="hidden" id="boardId" value="B01"/>
				<div class="w3-row w3-center">
				   <div class="w3-show-inline-block w3-cell-bottom" style="width: 23%; height: 40px;">
				     <button id="bMenu1" name="bMenu" class="w3-button w3-gray" style="width: 100%; height: 100%;" onclick="fn_bMenu_Onclick(1);">자료실</button>
				   </div>
				   <div class="w3-show-inline-block w3-cell-bottom" style="width: 23%; height: 40px;">
				     <button id="bMenu2" name="bMenu" class="w3-button w3-light-gray" style="width: 100%; height: 100%;" onclick="fn_bMenu_Onclick(2);">News</button>
				   </div>
				   <div class="w3-show-inline-block w3-cell-bottom" style="width: 23%; height: 40px;">
				     <button id="bMenu3" name="bMenu" class="w3-button w3-light-gray" style="width: 100%; height: 100%;" onclick="fn_bMenu_Onclick(3);">인재채용</button>
				   </div>
				   <div class="w3-show-inline-block w3-cell-bottom" style="width: 23%; height: 40px;">
				     <button id="bMenu4" name="bMenu" class="w3-button w3-light-gray" style="width: 100%; height: 100%;" onclick="fn_bMenu_Onclick(4);">프로모션</button>
				   </div>
				</div>
				
				<!-- 게시판 Table -->
				<div id="boardDiv"></div>
				<!-- /게시판 Table -->
				
				<div class="w3-row w3-row-padding w3-center" style="margin-bottom: 24px">
				   <div class="w3-show-inline-block" style="margin: 4px 4px 4px 4px">
					<select id="boardCondition" name="boardCondition" class="w3-select">
					    <option value="0">제목</option>
					    <option value="1">작성자</option>
					</select>
				    </div>
				    <div class="w3-show-inline-block"  style="margin: 4px 4px 4px 4px; width: 30%">
				     <input id="boardKeyword" class="w3-input" type="text" placeholder="Search">
				   </div>
				   <div class="w3-show-inline-block"  style="margin: 4px 4px 4px 4px">
				     <button class="w3-button w3-blue-grey" onclick="fn_selectBoardList(1);">SEARCH</button>
				   </div>
				</div>
				
        </div>
  </div>
  <!-- The Third Section -->

</div>

  <!-- Business Modal -->
  <div id="bsnsModal" class="w3-modal">
    <div class="w3-modal-content w3-animate-top w3-card-4">
      <header class="w3-container w3-teal w3-center w3-padding-32">
        <span class="w3-button w3-teal w3-xlarge w3-display-topright" onclick="$('#bsnsModal').css('display', 'none');">×</span>
        <h2 class="w3-wide">BUSINESS</h2>
      </header>
      <div class="w3-container">
      	<div class="w3-show-inline-block" style="width: 48%">
	        <p><label class="w3-opacity"><b>사업년도</b></label></p>
	        <input id="bsns_year" class="w3-input w3-border" type="text" placeholder="year" readonly/>
	        <p><label class="w3-opacity"><b>기관명</b></label></p>
	        <input id="bsns_org" class="w3-input w3-border" type="text" placeholder="agency" readonly/>
      	</div>
      	<div class="w3-show-inline-block" style="width: 50%">
	        <p><label class="w3-opacity"><b>사업기간</b></label></p>
	        <input id="bsns_term" class="w3-input w3-border" type="text" placeholder="term" readonly/>
	        <p><label class="w3-opacity"><b>구분</b></label></p>
	        <input id="bsns_part" class="w3-input w3-border" type="text" placeholder="part" readonly/>
      	</div>
      	<div class="w3-col" style="width: 99%">
	        <p><label class="w3-opacity"><b>사업명</b></label></p>
	        <input id="bsns_name" class="w3-input w3-border" type="text" placeholder="business" readonly/>
	        <p><label class="w3-opacity"><b>비고</b></label></p>
	        <textarea id="bsns_etc" rows="3" class="w3-input w3-border" placeholder="etc" readonly></textarea>
	        <button class="w3-button w3-red w3-section w3-right" onclick="$('#bsnsModal').css('display', 'none');">Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- /Business Modal -->

  <!-- BoardModal Modal -->
  <div id="boardModal" class="w3-modal">
    <div class="w3-modal-content w3-animate-top w3-card-4">
      <header class="w3-container w3-teal w3-center w3-padding-32">
        <span class="w3-button w3-teal w3-xlarge w3-display-topright" onclick="$('#boardModal').css('display', 'none');">×</span>
        <h2 class="w3-wide">BOARD</h2>
      </header>
      <input type="hidden" id="boardNo"/>
      <input type="hidden" id="boardPw"/>
      <div class="w3-container">
      	<div class="w3-show-inline-block" style="width: 48%">
	        <p><label class="w3-opacity"><b>제목</b></label></p>
	        <input id="board_title" name="board_input" class="w3-input w3-border" type="text" placeholder="title"/>
	        <p><label class="w3-opacity"><b>작성자</b></label></p>
	        <input id="board_user" name="board_input" class="w3-input w3-border" type="text" placeholder="user"/>
      	</div>
      	<div class="w3-show-inline-block" style="width: 50%">
	        <p><label class="w3-opacity"><b>작성일</b></label></p>
	        <input id="board_date" class="w3-input w3-border" type="text" placeholder="date" disabled="disabled"/>
	        <p><label class="w3-opacity"><b>비밀번호</b></label></p>
	        <input id="board_pw" name="board_input" class="w3-input w3-border" type="password" placeholder="password"/>
      	</div>
      	<div class="w3-col" style="width: 99%">
	        <p><label class="w3-opacity"><b>내용</b></label></p>
	        <textarea id="board_content" name="board_input" rows="6" class="w3-input w3-border" placeholder="content"></textarea>
	        <button class="w3-button w3-blue-grey w3-section w3-left" onclick="fn_saveBoardDetail()">Write</button>
	        <button class="w3-button w3-red w3-section w3-right" onclick="$('#boardModal').css('display', 'none');">Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- /BoardModal Modal -->

<!-- Footer -->
<footer class="w3-container w3-padding-64 w3-center w3-opacity w3-light-grey w3-xlarge">
  <p class="w3-medium">
  	서울 서초구 강남대로2길 66, 3층 (도남빌딩,양재동) / Tel. 02)564-5977 / Fax.02)553-9113<br>
  	회사명 : (주)신성아이앤씨 / 대표자 : 김종호 / 사업자등록번호 : 120-86-27423 / 이메일 : 
  	<a href="#webmaster" target="_blank">webmaster@shinsungic.com</a>
  </p>
</footer>
<!-- /Footer -->

</body>
</html>
