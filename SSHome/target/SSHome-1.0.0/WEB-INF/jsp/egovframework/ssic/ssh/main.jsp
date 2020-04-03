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
//전역 변수 영역
var areaFlag = true; // 회사소개 접힌 상태
var ciNum = 0;

window.onload = function() {
	// slideshow 변경 이벤트 - Start
	var myIndex = 0;
	
	carousel();

	function carousel() {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";
	  };
	  
	  myIndex++;
	  
	  if (myIndex > x.length) {myIndex = 1}
	  x[myIndex-1].style.display = "block";
	  setTimeout(carousel, 4000);
	}
	// 이벤트 - End
	
	// 카카오지도 깨짐 현상 방안
	$('#ci_zone6').css("display", "none");
}

// small screens 우측 상단 클릭 이벤트 - Start
function myFunction() {
  var x = document.getElementById("navDemo");
  
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
// 이벤트 - End

// 회사소개 a Tag 클릭 이벤트 - Start
function fn_ci_onclick(num) {
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
// 이벤트 - End

// 회사소개 a Tag 마우스 오버 이벤트 - Start
function fn_ci_onmouseover(num) {
	$('#ci_icon' + num).addClass("w3-teal");
}
// 이벤트 - End

// 회사소개 a Tag 마우스 아웃 이벤트 - Start
function fn_ci_onmouseout(num) {
	if (ciNum != num) {
		$('#ci_icon' + num).removeClass("w3-teal");
	}
}
// 이벤트 - End

// 사업년도 select Tag change 이벤트 - Start
function fn_select_bsns_list() {
	// alert($('#bsnsYear').val());
	
	var params = {
		year : $('#bsnsYear').val()
	};
	
	$.ajax({
        url :"selectBsnsRtsList.do",
        type :"POST",
        data : params,
        dataType : "json",
        success : function(data) {
            alert("success!");
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert("Error :\n" + textStatus + " / " + errorThrown);
            self.close();
        }
    });
}
//이벤트 - End



// When the user clicks anywhere outside of the modal, close it
var modal = document.getElementById('ticketModal');
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
//이벤트 - End

// small screens 우측 상단 클릭 이벤트 - Start
$(function() {
	/* 
	$("#test").mouseover(function(){
		$(this).css("color", "red");
	}
	$("#test").mouseleave(function(){
		$(this).css("color", "black");
	}
	for (var i=1; i<7; i++) {
		$('#company_intor0' + i).click(function() {
			if (areaFlag) {
				$('#ci_zone' + i).css("display", "block");
				areaFlag = false;
			} else {
				$('#ci_zone' + i).css("display", "none");
				areaFlag = true;
			}
			
			//alert("높이 : " + $(window).width());
	    });
	}
	 */
});
// 이벤트 - End

/* 글 수정 화면 function */
function fn_egov_select(id) {
	document.listForm.selectedId.value = id;
   	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
   	document.listForm.submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.listForm.action = "<c:url value='/addSample.do'/>";
   	document.listForm.submit();
}

/* 글 목록 화면 function */
function fn_egov_selectList() {
	var jqxhr = $.ajax("<c:url value='/egovSampleList.do'/>")
		.done(function() {
			console.log("성공");
		})
		.fail(function() {
			console.log("실패");
		})
		.always(function() {
		    $('html, body').animate({scrollTop : 1000}, 400);
			console.log("완료");
		});
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
   	document.listForm.submit();
}
</script>
<body>
<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-blue w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="#" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="#company" class="w3-bar-item w3-button w3-padding-large w3-hide-small">COMPANY</a>
    <a href="#business" class="w3-bar-item w3-button w3-padding-large w3-hide-small">BUSINESS</a>
    <a href="#support" class="w3-bar-item w3-button w3-padding-large w3-hide-small">SUPPORT</a>
    <a href="#notice" class="w3-bar-item w3-button w3-padding-large w3-hide-small">NOTICE</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-right">≡</a>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-blue w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#company" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">COMPANY</a>
  <a href="#business" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BUSINESS</a>
  <a href="#support" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">SUPPORT</a>
  <a href="#notice" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">NOTICE</a>
</div>

<!-- Page content -->
<div class="w3-content" style="max-width:3000px;margin-top:46px">

  <!-- Automatic Slideshow Images -->
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

  <!-- The First Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:1000px" id="company">
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
		      	<a href="#ci" onclick="javascript:fn_ci_onclick(1);" onmouseover="javascript:fn_ci_onmouseover(1);" onmouseout="javascript:fn_ci_onmouseout(1);">
			        <img src="/images/ssic/company_icon01.png" class="w3-round w3-margin-bottom" alt="CEO 인사말"><br>
			        CEO 인사말
		        </a>
	        </p>
	      </div>
	      <div id="ci_icon2" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#ch" onclick="javascript:fn_ci_onclick(2);" onmouseover="javascript:fn_ci_onmouseover(2);" onmouseout="javascript:fn_ci_onmouseout(2);">
			      	<img src="/images/ssic/company_icon02.png" class="w3-round w3-margin-bottom" alt="회사연혁"><br>
			      	회사연혁
		      	</a>
	      	</p>
	      </div>
	      <div id="ci_icon3" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#bf" onclick="javascript:fn_ci_onclick(3);" onmouseover="javascript:fn_ci_onmouseover(3);" onmouseout="javascript:fn_ci_onmouseout(3);">
			        <img src="/images/ssic/company_icon03.png" class="w3-round w3-margin-bottom" alt="사업분야"><br>
			        사업분야
			    </a>
		    </p>
	      </div>
	   </div>
    	<div class="w3-show-inline-block">
	      <div id="ci_icon4" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#br" onclick="javascript:fn_ci_onclick(4);" onmouseover="javascript:fn_ci_onmouseover(4);" onmouseout="javascript:fn_ci_onmouseout(4);">
			        <img src="/images/ssic/company_icon04.png" class="w3-round w3-margin-bottom" alt="사업실적"><br>
			        사업실적
		        </a>
	        </p>
	      </div>
	      <div id="ci_icon5" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#og" onclick="javascript:fn_ci_onclick(5);" onmouseover="javascript:fn_ci_onmouseover(5);" onmouseout="javascript:fn_ci_onmouseout(5);">
			        <img src="/images/ssic/company_icon05.png" class="w3-round w3-margin-bottom" alt="조직도"><br>
			        조직도
		        </a>
	        </p>
	      </div>
	      <div id="ci_icon6" class="w3-show-inline-block" style="width: 100px">
	        <p>
		      	<a href="#map" onclick="javascript:fn_ci_onclick(6);" onmouseover="javascript:fn_ci_onmouseover(6);" onmouseout="javascript:fn_ci_onmouseout(6);">
			        <img src="/images/ssic/company_icon06.png" class="w3-round w3-margin-bottom" alt="오시는 길"><br>
			        오시는 길
		        </a>
	        </p>
	      </div>
	    </div>
	  </div>
    
    <!-- CEO 인사말 -->
    <div id="ci_zone1" class="w3-animate-top w3-margin" style="display: none;">
    	<img src="/images/ssic/ceo_intro01.gif" class="w3-round w3-margin-bottom"/>
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
	      <div class=w3-left-align>
	      	<div class="w3-show-inline-block">
	      		<B>사업년도 :&nbsp;</B>
	      	</div>
	      	<div class="w3-show-inline-block"> 
				<select id="bsnsYear" class="w3-select w3-border" onchange="javascript:fn_select_bsns_list()">
	       			<c:forEach var="year" items="${BsnsYearList}" varStatus="status">
				    	<option value='<c:out value="${year.bsnsYear}"/>'><c:out value="${year.bsnsYear}"/></option>
	       			</c:forEach>
				</select>
			</div>
	      </div>
        	<!-- List -->
        	<div id="BsnsRstList" class="w3-center">
        		<table class="w3-table" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">사업년도, 기관명, 사업명, 사업기간, 구분 표시하는 테이블</caption>
        			<colgroup>
        				<col width="10%"/>
        				<col width="20%"/>
        				<col width="?"/>
        				<col width="25%"/>
        				<col width="10%"/>
        			</colgroup>
        			<tr>
        				<th align="center">사업년도</th>
        				<th align="center">기관명</th>
        				<th align="center">사업명</th>
        				<th align="center">사업기간</th>
        				<th align="center">구분</th>
        			</tr>
        			<c:forEach var="list" items="${BsnsRstList}" varStatus="status">
            			<tr>
            				<td align="center" class="listtd"><c:out value="${list.bsnsYear}"/></td>
            				<td align="center" class="listtd"><c:out value="${list.orgName}"/></td>
            				<td align="left" class="listtd"><a href="javascript:fn_select_bsns('<c:out value="${list.bsnsId}"/>')"><c:out value="${list.bsnsName}"/></a></td>
            				<td align="center" class="listtd"><c:out value="${list.bsnsTerm}"/></td>
            				<td align="center" class="listtd"><c:out value="${list.bsnsPart}"/></td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- End List -->
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

  <!-- The Second Section -->
  <div class="w3-blue" id="business">
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
          <img src="/images/ssic/business01.jpg" alt="SI_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>SI 사업</b></p>
            <p class="w3-opacity">Fri 27 Nov 2016</p>
            <p>대학교, 기업(공공), 모바일</p>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <img src="/images/ssic/business02.jpg" alt="SM_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>SM 사업</b></p>
            <p class="w3-opacity">Sat 28 Nov 2016</p>
            <p>사업개요, 구성도, etc</p>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <img src="/images/ssic/business03.jpg" alt="Sol&SW" style="width:100%;height:100%;" class="w3-hover-opacity">
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>솔루션&amp;소프트웨어</b></p>
            <p class="w3-opacity">Sun 29 Nov 2016</p>
            <p>Appeon, PowerFrame</p>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <img src="/images/ssic/business04.jpg" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
          <div class="w3-container w3-white" style="height:180px;">
            <p><b>IT 컨설팅</b></p>
            <p class="w3-opacity">Sun 29 Nov 2016</p>
            <p>ISP, IT Assessment</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- The Third Section -->
  <div class="w3-container w3-content w3-padding-64" style="max-width:1000px" id="support">
    <h2 class="w3-wide w3-center">SUPPORT</h2>
    <p class="w3-opacity w3-center"><i>Fan? Drop a note!</i></p>
    <div class="w3-row w3-padding-32">
      <div class="w3-col m6 w3-large w3-margin-bottom">
        <i class="fa fa-map-marker" style="width:30px"></i> Chicago, US<br>
        <i class="fa fa-phone" style="width:30px"></i> Phone: +00 151515<br>
        <i class="fa fa-envelope" style="width:30px"> </i> Email: mail@mail.com<br>
      </div>
      <div class="w3-col m6">
        <form action="/action_page.php" target="_blank">
          <div class="w3-row-padding" style="margin:0 -16px 8px -16px">
            <div class="w3-half">
              <input class="w3-input w3-border" type="text" placeholder="Name" required name="Name">
            </div>
            <div class="w3-half">
              <input class="w3-input w3-border" type="text" placeholder="Email" required name="Email">
            </div>
          </div>
          <input class="w3-input w3-border" type="text" placeholder="Message" required name="Message">
          <button class="w3-button w3-blue w3-section w3-right" onclick="document.getElementById('ticketModal').style.display='block'">SEND</button>
        </form>
      </div>
    </div>
  </div>
  
  <!-- The fourth Section -->
  <div class="w3-blue" id="notice">
    <div class="w3-container w3-content w3-padding-64" style="max-width:1000px">
	<h2 class="w3-wide w3-center">NOTICE</h2>
	<p class="w3-opacity w3-center"><i>ShinsungI&amp;C RECRUIT</i></p>
  	  <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
        <input type="hidden" name="selectedId" />
        <div id="content_pop">
        	<!-- List -->
        	<div id="table" style="margin-bottom: 24px">
        		<table summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">No, 카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="10%"/>
        				<col width="?"/>
        				<col width="15%"/>
        				<col width="15%"/>
        			</colgroup>
        			<tr>
        				<th align="center">No</th>
        				<th align="center">제목</th>
        				<th align="center">작성자</th>
        				<th align="center">작성일</th>
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
            				<td align="left" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.id}"/>')"><c:out value="${result.name}"/></a></td>
            				<td align="center" class="listtd"><c:out value="${result.regUser}"/></td>
            				<td align="center" class="listtd"><c:out value="${result.description}"/></td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- End List -->
        	
        	<!-- paging part -->
		    <div class="w3-row w3-row-padding" style="margin-bottom: 16px">
			      	<div class="w3-center">
		        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
		        		<form:hidden path="pageIndex" />
	        		</div>
			        <button class="w3-button w3-white w3-right">ADD1</button>
			        <!-- <button class="w3-button w3-white w3-right" onclick="document.getElementById('ticketModal').style.display='block'">ADD</button> -->
			</div>
        	<!-- End paging part -->
		    
		    <div class="w3-row w3-row-padding w3-center" style="margin-bottom: 24px">
			      <div class="w3-show-inline-block" style="margin: 4px 4px 4px 4px">
					<select name="job" class="w3-select">
					    <option value="1">Name</option>
					    <option value="0">ID</option>
					</select>
			      </div>
			      <div class="w3-show-inline-block"  style="margin: 4px 4px 4px 4px; width: 30%">
			        <input class="w3-input" type="text" placeholder="Search">
			      </div>
			      <div class="w3-show-inline-block"  style="margin: 4px 4px 4px 4px">
			        <button class="w3-button w3-white" onclick="javascript:fn_egov_selectList();">SEARCH</button>
			      </div>
		    </div>
        </div>
    </form:form>
  </div>
 </div>
<!-- End Page Content -->
</div>

  <!-- Ticket Modal -->
  <div id="ticketModal" class="w3-modal">
    <div class="w3-modal-content w3-animate-top w3-card-4">
      <header class="w3-container w3-teal w3-center w3-padding-32">
        <span onclick="document.getElementById('ticketModal').style.display='none'" 
       class="w3-button w3-teal w3-xlarge w3-display-topright">×</span>
        <h2 class="w3-wide"><i class="fa fa-suitcase w3-margin-right"></i>Write</h2>
      </header>
      <div class="w3-container">
        <p><label><i class="fa fa-shopping-cart"></i>제목</label></p>
        <input class="w3-input w3-border" type="text" placeholder="title">
        <p><label><i class="fa fa-user"></i>내용</label></p>
        <input class="w3-input w3-border" type="text" placeholder="contents">
        <p><label><i class="fa fa-user"></i>작성자</label></p>
        <input class="w3-input w3-border" type="text" placeholder="writer">
        <button class="w3-button w3-teal w3-section w3-left" onclick="document.getElementById('ticketModal').style.display='none'">Add</button>
        <button class="w3-button w3-red w3-section w3-right" onclick="document.getElementById('ticketModal').style.display='none'">Close</button>
      </div>
    </div>
  </div>

<!-- Footer -->
<footer class="w3-container w3-padding-64 w3-center w3-opacity w3-light-grey w3-xlarge">
  <p class="w3-medium">
  	서울 서초구 강남대로2길 66, 3층 (도남빌딩,양재동) / Tel. 02)564-5977 / Fax.02)553-9113<br>
  	회사명 : (주)신성아이앤씨 / 대표자 : 김종호 / 사업자등록번호 : 120-86-27423 / 이메일 : 
  	<a href="https://www.w3schools.com/w3css/default.asp" target="_blank">webmaster@shinsungic.com</a>
  </p>
</footer>
</body>
</html>
