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
var siNum = 1;		// SI소개 아이콘 Num
var soNum = 1;	// 솔루션&SW 아이콘 Num
/*/전역 변수 영역 */

window.onload = function() {
	// 화면시작 위치 변경 이벤트
	var sectionIndex = "${sectionIndex}";
	fn_moveSection(1, sectionIndex)
}

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

/* screens 상단 클릭 이벤트 */
function fn_selectSection(num) {
	document.MenuForm.sectionIndex.value = num;
	document.MenuForm.action = "<c:url value='/selectMain.do'/>";
   	document.MenuForm.submit();
}
/*/small screens 우측 상단 클릭 이벤트 */

/* SI사업 a Tag 클릭 이벤트 */
function fn_si_Onclick(num) {
	var offset = $("#si_offset").offset(); // company_intro 버튼 위치
	// 스크롤 위치 이동
    $('html, body').animate({scrollTop : offset.top - 45}, 400);
	
	if (siNum == 0) {
	    // div 활성화, css 변경
		$('#si_zone' + num).css("display", "block");
		
		siNum = num;
	} else if (siNum != num) {
	 	// div 활성화, css 변경
		$('#si_zone' + siNum).css("display", "none");
		$('#si_zone' + num).css("display", "block");
		
		siNum = num;
	}
}
/*/SI사업 a Tag 클릭 이벤트 */

/* 솔루션&소프트웨어 a Tag 클릭 이벤트 */
function fn_so_Onclick(num) {
	var offset = $("#so_offset").offset(); // company_intro 버튼 위치
	// 스크롤 위치 이동
    $('html, body').animate({scrollTop : offset.top - 45}, 400);
	
	if (soNum == 0) {
	    // div 활성화, css 변경
		$('#so_zone' + num).css("display", "block");
		
		soNum = num;
	} else if (soNum != num) {
	 	// div 활성화, css 변경
		$('#so_zone' + soNum).css("display", "none");
		$('#so_zone' + num).css("display", "block");
		
		soNum = num;
	}
}
/*/솔루션&소프트웨어 a Tag 클릭 이벤트 */

</script>
<body>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-blue w3-card">
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_selectSection(0)">HOME</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small" onclick="fn_selectSection(1)">COMPANY</a>
	<div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button w3-blue" onclick="fn_selectSection(2)">BUSINESS▼</button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_moveSection(0, '1')">SI사업</a>
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_moveSection(0, '2')">SM사업</a>
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_moveSection(0, '3')">솔루션&amp;SW</a>
        <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="fn_moveSection(0, '4')">IT컨설팅</a>
      </div>
    </div>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small" onclick="fn_selectSection(3)">BOARD</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-right">&nbsp;</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" onclick="fn_smallRightBar()" title="Toggle Navigation Menu">≡</a>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-blue w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_selectSection(1)">COMPANY</a>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_selectSection(2)">BUSINESS</a>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large" onclick="fn_selectSection(3)">BOARD</a>
</div>

<!-- Page content -->
<div class="w3-content" style="max-width:3000px;margin-top:46px">
	<form id="MenuForm" name="MenuForm">
		<input type="hidden" name="sectionIndex">
	</form>
	
  <!-- The First Section -->
  <div class="w3-container w3-content w3-padding-48" style="max-width:1000px" id="section1">
		<h2 class="w3-wide w3-center w3-margin-bottom">SI 사업</h2>
      
		<div id="si_offset" class="w3-left-align">
			<table class="w3-margin-left w3-show-inline-block" style="border-spacing: 10px;">
				<colgroup>
				<col width="100px"/>
				<col width="?"/>
				</colgroup>
				<tr>
					<td class="w3-border-right" valign=top><b>▶ 대학교</b></td>
					<td class="w3-text-grey">
				       	<a href="#si01" onclick="fn_si_Onclick(1);">학사행정시스템</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#si02" onclick="fn_si_Onclick(2);">일반행정시스템</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#si03" onclick="fn_si_Onclick(3);">연구행정시스템</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#si04" onclick="fn_si_Onclick(4);">교육통계지원시스템</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#si05" onclick="fn_si_Onclick(5);">부속기관시스템</a>
				      	</td>
				</tr>
				<tr>
					<td class="w3-border-right" valign=top><b>▶ 기업(공공)</b></td>
					<td class="w3-text-grey">
				       	<a href="#si06" onclick="fn_si_Onclick(6);">전사적자원관리시스템</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#si07" onclick="fn_si_Onclick(7);">단위업무시스템</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#si08" onclick="fn_si_Onclick(8);">시스템리뉴얼</a>
				    </td>
				</tr>
				<tr>
					<td class="w3-border-right" valign=top><b>▶ 모바일</b></td>
					<td class="w3-text-grey">
						<a href="#si09" onclick="fn_si_Onclick(9);">모바일</a>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 대학교>학사행정시스템 -->
		<div id="si_zone1" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: block;">
			<img src="/images/ssic/bsns_si_text01.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				학사행정시스템은 통합정보시스템 중 가장 핵심적인 시스템으로서, 대학과 대학원의 주요 구성원인 학생의 학사일정에 대한 제반 업무를 관리합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img01.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 효율적인 연계 - 학사시스템 내부 및 행정/연구시스템과의 완벽한 연계로 시스템 효율성 극대화<br>
				2. 정확한 자료관리- 권한관리를 통한 접근통제및 자료변조에 대한 추적기능 강화<br>
				3. 사용자중심 - 학생의 학적 변경 시 관련된 모든 업무로의 즉각적인 반영<br>
				4. 유연한 자동화 - 정확한 교과과정 관리로 수강 신청시 이수구분,재수강 등 자동처리로 졸업사정,교직사정등을 자동화하여 업무생산성을 획기적으로 향상
			</div>
		</div>
		<!-- /대학교>학사행정시스템 -->
		
		<!-- 대학교>일반행정시스템 -->
		<div id="si_zone2" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text02.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				대학운영과 관련하여 조직간의 의사소통을 원활히 하고 조직 상호간의 정보공유 일원화로 조직원의 의사결정을 지원하는 일반 사무행정업무의 생산성 향상을 지원하는 시스템으로서 업무절차에 따라 통합 시스템화함으로써 행정업무의 능률화를 유도합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img02.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 업무의 효율화 - 업무확인 절차 간소화<br>
				2. 자료의 무결성 - 시스템간 유기적 연계로 무결성 확보<br>
				3. 사용자중심 - 개인정보 본인관리 및 예산신청, 지출결의서,구매신청 등 각 부서에서 입력, 관리부서의 승인처리<br>
				4. 단위시스템 연계 - 업무간 프로세스 연계성 지원 및 전자결재와의 연동으로 종이문서작업 최소화 및 결재업무 간소화<br>
				5. 중복업무 및 자료의 이중관리 배제시킴으로써 업무효율성 향상, 자료 무결성 확보, 접근권한 부여를 통한 Data 안정성 확보
			</div>
		</div>
		<!-- /대학교>일반행정시스템 -->
		
		<!-- 대학교>연구행정시스템 -->
		<div id="si_zone3" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text03.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				연구행정시스템은 대학 내 교수 및 연구원의 연구활동을 지원하는 시스템입니다 대학 연구에서 발생하는 여러 종류의 산재 된 연구정보를 통합하고 관리 및 평가를 지원하는 시스템입니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img03.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 일반,학사시스템과 통합구축<br>
				2. 자료의 무결성을 보장한 정보공유<br>
				3. 연구과제,연구비관리,업적 및 학술활동 관리 프롯세스의 제공및 관리체계화<br>
				4. 청구및 정산자료를 시스템에서 일괄적으로 관리하여 연구업무의 효율성을 향상<br>
				5. 합리적이고 투명한 업적평가를 실시하여 향후 교수 및 연구원의 재임용과 관련한 객관적인 자료를 제공하여 대학 연구의 투명성 및 신뢰성을 확보
			</div>
		</div>
		<!-- /대학교>연구행정시스템 -->
		
		<!-- 대학교>교육통계지원시스템 -->
		<div id="si_zone4" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text04.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				교육통계지원 시스템은 다양한 대학 내외의 통계정보 요구에 실시간으로 대응할 수 있도록 합니다. 대학 전반에 걸친 데이터를 통합 관리하여, 주요 통계현황을 신속하게 확인할 수 있으며, 급변하는 대학 경영환경에서 경영진의 신속한 의사결정이 가능하도록 신속하고, 정확한 정보를 제공합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img04.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 다양한 통계정보를 실시간으로 신속, 정확하게 제공<br>
				2. 대학 경영의 신속한 의사결정을 위한 정보를 제공<br>
				3. 다양한 형태의 리포트를 지원<br>
				4. 리포트를 전자 파일로 저장하여 재사용성을 고려한 시스템<br>
				5. 사용자의 권한에 따른 참조 정보의 제한<br>
				6. 주요 통계현황 정보를 실시간으로 제공하여, 대학운영 전반에 대한 신속한 의사결정이 가능<br>
				7. 자료에 대한 신뢰성 향상
			</div>
		</div>
		<!-- /대학교>교육통계지원시스템 -->
		
		<!-- 대학교>부속기관시스템 -->
		<div id="si_zone5" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text05.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				부속기관시스템은 산학협력단 자체의 연구, 산학단회계, 행정 등을 제공하여 방대한 산학협력단의 업무를 체계적으로 지원할 수 있도록 합니다. 또한 평생교육원의 학사행정 전반에 관한 관리를 제공하여 평생교육원의 고유한 학사업무에 맞춰 설계되고, 구축됩니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img05.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 업무 프로세스 재 설계를 통한 부속기관 업무의 생산성 향상<br>
				2. 일반행정, 학사행정시스템과 통합구축<br>
				3. 자료의 무결성을 보장한 정보공유<br>
				4. 사용자정의 검색 지원 및 실시간 통계자료제공<br>
				5. 체계적인 정책수립과 의사결정을 지원하는 양질의 정보제공<br>
				6. 유기적 연계를 통한 중복업무 및 자료의 이중관리 배제시킴으로써 업무효율성 향상, 자료 무결성 확보
			</div>
		</div>
		<!-- /대학교>부속기관시스템 -->
		
		<!-- 기업(공공)>전사적자원관리시스템 -->
		<div id="si_zone6" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text06.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				전사적자원관리시스템(ERP : Enterprise Resource Planning)은 구매, 생산, 판매, 회계, 인사 등의 기업(공공)의 모든 인적, 물적 자원을 효율적으로 관리하여 기업의 경쟁력을 강화시켜주는 통합정보 시스템입니다. 이익 극대화와 고객만족을 위해 변혁을 꾀하는 기업(공공)에게 반드시 필요한 시스템입니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img06.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 정보시스템 개발 기간 단축과 비용 절감의 효과<br>
				2. 선진 업무 프로세스 도입<br>
				3. 통합성과 안정성을 확보<br>
				4. 최신 정보기술 도입이 가능하고 편리한 유지보수
			</div>
		</div>
		<!-- /기업(공공)>전사적자원관리시스템 -->
		
		<!-- 기업(공공)>단위업무시스템 -->
		<div id="si_zone7" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text07.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				단위업무시스템 개발이란 기업(공공)의 인사 구매 생산 영업 회계 외주 등 각 부서의 업무 생산성을 증대시킨 시스템을 개발하여 기업(공공)의 경쟁력을 강화하고 선진 업무 프로세스를 도입하여 기존의 단순, 반복되었던 작업을 지양하여 효율성을 높일 뿐 아니라 종이를 쓰지 않는 작업환경(Paperless-office)을 지원합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img07.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 사무문서의 간소화 및 자동화로 업무 생산성을 증대<br>
				2. 실시간 상황 관리 및 현장관리의 최적화<br>
				3. 지식경영 인프라 시스템으로 활용
			</div>
		</div>
		<!-- /기업(공공)>단위업무시스템 -->
		
		<!-- 기업(공공)>시스템리뉴얼 -->
		<div id="si_zone8" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text08.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				기업(공공)의 기존 사용되던 업무시스템을 체계적이고 정확하게 진단 후 DB 업그레이드로업무환경의 속도를 향상하며 과거 실현되지 못한 기업(공공)의 랜드마크에 맞게 UI를 개선하고 사용자의 요구를 수렴하여 사용자 중심의 시스템을 제공하여 드립니다. 
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img08.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 저비용으로 예산절감 효과, 고효율<br>
				2. 기존 시스템을 업그레이드 하며 신규 업무에 혼란을 방지<br>
				3. 사용자의 요구를 충족하며 명확한 프로세스를 제공<br>
				4. 개발기간의 단축
			</div>
		</div>
		<!-- /기업(공공)>시스템리뉴얼 -->
		
		<!-- 모바일>모바일 -->
		<div id="si_zone9" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_si_text09.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				모바일이란 기업이나 대학에서 PC 또는 노트북으로 사용되는 업무프로그램을 스마트폰에서도 사용할수 있도록 자체개발하여 고객의 휴대성, 업무접근성을 높여 능률적인 일처리가 가능하도록 돕는 차세대 시스템입니다. 
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">적용분야</b><br>
				1. 관공서용 어플리케이션<br>
				2. 기업형 DB연동 어플리케이션<br>
				3. 쇼핑몰 어플리케이션<br>
				4. 동영상,음성 서비스 어플리케이션<br>
				5. 교육용 어플리케이션
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">고객별 맞춤 서비스</b><br>
				<b>1. 개발용역형</b><br>
				개발용역형이란 기본 개발비와 저렴한 유지보수비용으로 이루어진 개발의뢰입니다.<br>
				개발용역형은 충분한 초기비용이 산정된 고객에게 유리한 형태이며 저렴한 유지보수비용을 통하여 지속적인 서비스 운영에 부담이 적습니다.<br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img09_1.gif" class="w3-auto w3-padding-16"/><br>
		 		</div>
				<b>2. 초기비용절감형</b><br>
				초기비용절감형이란 개발비의 비중을 낮추는 대신 유지보수비용의 비중을 높여서 부담없이 서비스개발을 진행할 수 있는 장점이 있습니다.<br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img09_2.gif" class="w3-auto w3-padding-16"/><br>
		 		</div>
				<b>3. 공동사업형</b><br>
				공동사업형이란 의뢰하는 개인이나 기업의 아이디어와 기획의 가능성 여부에 따라 우리(주)신성아이앤씨가 해당 사업에 공동으로 참여하는 개발의뢰입니다. 이러한 개발의뢰는 초기 개발비의 투자가 없습니다.<br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img09_3.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구축사례</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_si_img09_4.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
		</div>
		<!-- /모바일>모바일 -->
		
    </div>
  <!-- /The First Section -->

  <!-- The Second Section -->
  <div class="w3-blue" id="section2">
    <div class="w3-container w3-content w3-padding-64" style="max-width:1000px">
		<h2 class="w3-wide w3-center w3-margin-bottom">SM 사업</h2>
		
		<!-- SM 사업 -->
		<div id="sm_zone1" class="w3-row-padding w3-padding-16">
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				SM(System Management)사업이란 고객의 부족한 IT전문인력을 대신해 풍부한 서버관리 경험과 전문 관리툴을 사용한 통합운영 및 유지보수 노하우를 바탕으로 IT 자원관리에 필요한 제반사항을 실시간 모니터링하고, 대규모 데이터센터의 각종 관리절차 및 방법론 활용을 통하여 체계적이고 효율적인 시스템관리 극대화 서비스 제공함을 말합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_sm_img01.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
		</div>
		<!-- /SM 사업 -->
		
    </div>
  </div>
  <!-- /The Second Section -->

  <!-- The Third Section -->
  <div class="w3-container w3-content w3-padding-64" style="max-width:1000px" id="section3">
		<h2 class="w3-wide w3-center w3-margin-bottom">솔루션&amp;소프트웨어</h2>
      
		<div id="so_offset" class="w3-left-align">
			<table class="w3-margin-left w3-show-inline-block" style="border-spacing: 10px;">
				<colgroup>
				<col width="100px"/>
				<col width="?"/>
				</colgroup>
				<tr>
					<td class="w3-border-right" valign=top><b>▶ 솔루션&amp;<br>&nbsp;소프트웨어</b></td>
					<td class="w3-text-grey">
				       	<a href="#haksa" onclick="fn_so_Onclick(1);">Appeon</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#ilban" onclick="fn_so_Onclick(2);">PowerFrame</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#yungu" onclick="fn_so_Onclick(3);">보안솔루션</a>&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href="#gyuyuk" onclick="fn_so_Onclick(4);">소프트웨어</a>
				      	</td>
				</tr>
			</table>
		</div>
		
		<!-- Appeon -->
		<div id="so_zone1" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: block;">
			<img src="/images/ssic/bsns_so_text01.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				Appeon이란 파워빌더 어플리케이션을 쉽고 빠르게 웹으로 자동 전환해주는 개발도구로 J2EE 기반으로 설계된 N-Tier기반의 웹 구조를 가지고 있으며 대부분의 파워빌더UI를 웹으로 사용 가능하게 합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구성도</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_so_img01.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. 다른 어떤 방법보다 빠르게 JAVA형태의 웹으로 변환<br>
				2. 별도의 JAVA와 웹에 대한 교육 없이도 빠르게 적용가능<br>
				3. 파워빌더를 이용한 유지보수로 고객의 요청 대응 가능<br>
				4. 기존 어플리케이션 재사용에 따른 신규 개발 비용 불필요<br>
				5. 자동 변환에 따른 개발기간 단축으로 전체 비용 및 시간절약<br>
				6. 자동화 작업을 통한 프로젝트 실패율 감소<br>
				7. 배포의 위험성 감소
			</div>
		</div>
		<!-- /Appeon -->
		
		<!-- Powerframe -->
		<div id="so_zone2" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_so_text02.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<b class="w3-text-indigo">개요</b><br>
				Powerframe 시스템은 기업의 웹 환경의 디자인과 개발을 위한 차세대 통합 어플리케이션 UX 프레임워크입니다.<br>
				Powerframe은 개발자들이 가장 쉽고도 유연하게 디자인과 개발툴을 통합해 안정적인 어플리케이션을 구축할 수 있도록 하며, 통합성, 안정성, 개발 편의성, 관리 효율을 극대화한 차세대 Web UX를 구축할 수 있도록 지원합니다.
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">구축사례</b><br>
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_so_img02.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b class="w3-text-indigo">기대효과</b><br>
				1. PowerBuilder의 웹 Application 개발 환경의 디자인과 개발을 위한 통합 어플리케이션 프레임워크<br>
				2. Design Studio, Template Architect, Library Space, Performance Expert 등의 기능을 제공해 표준화된 개발과 문서를 제공<br>
				3. 공통 module, menu, 다양한 Base 템플릿 기능 제공, 다양한 프레임윈도우 제공, 기본 MDI 제공<br>
				4. file up/download, user interface Style guide, naming rule, 데이터 멀티 소트, 권한 관리 등의 기본 개발 framework를 제공<br>
				5. 실시간 성능 모니터링, 성능장애 원인분석 및 병목구간 분석자료 산출, SQL과 PB Object의 연관 정보, 실시간 SQL 성능 모니터링을 통한 안정성에 영향을 미치는 factor 감지<br> 
				6. 다양한 데이터윈도우 디자인 프러퍼티로 쉬운 디자인 변경 : 그리드 라인 색상, Row 색상 선택 등<br>
				7. Used Tab Folder 디자인 : 폰트 컬러, 사이즈, 탭 폴더 이미지들
			</div>
		</div>
		<!-- /Powerframe -->
		
		<!-- 보안솔루션 -->
		<div id="so_zone3" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_so_text03.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-row-padding w3-padding-32">
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_1.gif" alt="SI_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">XecureDB</p>
		            <p>
			            - 제조사 : 소프트포럼<br>
						- 구분 : DB암호화<br>
						- 특징 :<br>
						· API와 Plug-in방식을 혼용한 DB암호화<br>
						· 다양한 암호화 알고리즘 제공<br>
						· 다양한 환경/대용량 DB암호화 구축 경험 보유<br>
						· DB특화기술을 통한 마이그레이션 시간 단축<br>
						· GS인증, CMVP, 국가용 암호제품 등록<br>
						· 정보통신망법, PCI/DSS 가이드라인 완벽 준수
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_2.gif" alt="SM_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">D`Amo</p>
		            <p>
			            - 제조사 : 펜타시큐리티<br>
						- 구분 : DB암호화<br>
						- 특징 :<br>
						· 체계적인 보안관리<br>
						· 정보보호 규제 준수<br>
						· 기업 이미지 제고<br>
						· 안정적인 유지보수
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_3.gif" alt="Sol&SW" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">Chakra MAX</p>
		            <p>
			            - 제조사 : 웨어밸리<br>
						- 구분 : DB접근제어<br>
						- 특징 :<br>
						· 데이터베이스 접근 통제 및 정보 유출 방어 ·데이터베이스 부하 없이 모든 작업 이력 로깅 ·데이터베이스 작업 결재 기능 제공<br>
						· 데이터베이스 취약점 공격 방어 
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_4.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">DB-i</p>
		            <p>
			            - 제조사 소만사<br>
						- 구분 : DB접근제어<br>
						- 특징 :<br>
						· 개인정보화면저장을 통한 유출자 추적<br>
						· DB VPN기능으로 개인정보해킹차단<br>
						· 직무분리를 통한 개인정보취급자 최소화기능<br>
						· 전용스토리지, 실시간로딩의 로그위변조방기지<br>
						· DB접속 후 개인정보 PC저장, 출력방지 기능
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_5.gif" alt="SI_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">Wapple</p>
		            <p>
			            - 제조사 : 펜타시큐리티<br>
						- 구분 : 웹방화벽<br>
						- 특징 :<br>
						· HTTP 기반의 웹 공격 방지<br>
						· 웹 보안 요소 방어<br>
						· 웹 컨텐츠 필터링
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_6.gif" alt="SM_Business" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">CubeOne</p>
		            <p>
			            - 제조사 : 이글로벌시스템<br>
						- 구분 : 웹방화벽<br>
						- 특징 :<br>
						· 대용량 DB 전문 컬럼 암호화 솔루션<br>
						· 데이터와 키가 함께 유출되지 않는 완벽한 키 기밀성<br>
						· 분산처리가 가능한 Hybrid 형태의 S/W<br>
						· BMT마다 경이적인 성능 기록
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_7.gif" alt="Sol&SW" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">Webkeeper</p>
		            <p>
			            - 제조사 : 소만사<br>
						- 구분 : 유해사이트 차단<br>
						- 특징 :<br>
						· 대량 트래픽에 특화된 네트워크 패킷 엔진 탑재 어플라이언스 일체형 장비<br>
						· 동일한 컴퓨팅환경에서 3배 이상의 패킷처리성능<br>
						· 동일한 컴퓨팅환경에서 CPU사용량 5~7배 절감<br>
						· 대용량 트래픽에서 로그유실 최소화<br>
						· 과부하로 인한 장애 최소화<br>
						· IP/PORT별 패킷 사전 필터링, DPI기반 패킷 필터링 제공<br>
						· 과부하로 인한 장애 최소화<br>
						· IP/PORT별 패킷 사전 필터링, DPI기반 패킷 필터링 제공
					</p>
		          </div>
		        </div>
		        <div class="w3-quarter">
		          <img src="/images/ssic/bsns_so_img03_8.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          <div class="w3-container w3-white" style="height:410px;">
		            <p class="w3-text-indigo">NetClient</p>
		            <p>
			            - 제조사 : 닥터소프트<br>
						- 구분 : 자산관리 및 통합보안<br>
						- 특징 :<br>
						· DMS-자산관리<br>
						· PMS-패치관리<br>
						· HSM-보안관리<br>
						· IPM-IP관리
					</p>
		          </div>
		        </div>
			</div>
		</div>
		<!-- /보안솔루션 -->
		
		<!-- 소프트웨어 -->
		<div id="so_zone4" class="w3-row-padding w3-padding-16 w3-animate-top" style="display: none;">
			<img src="/images/ssic/bsns_so_text04.gif" class="w3-margin-left" style="height: 18px"/>
			<div class="w3-margin">
				<div class="">
					<h6><b class="w3-text-indigo">사무용</b></h6>
			        <div class="w3-quarter">
			        	<a href="http://www.microsoft.com/ko-kr/default.aspx" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_1.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.adobe.com/kr/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_2.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.autodesk.co.kr/adsk/servlet/home?siteID=1169528&id=18070651" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_3.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.hancom.com/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_4.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
					<h6><b class="w3-text-indigo">바이러스</b></h6>
			        <div class="w3-quarter">
			        	<a href="http://www.ahnlab.com/kr/site/main/main.do" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_5.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.hauri.co.kr/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_6.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://kr.trendmicro.com/kr/home/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_7.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.symantec.co.kr/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_8.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
					<h6><b class="w3-text-indigo">개발용</b></h6>
			        <div class="w3-quarter">
			        	<a href="http://www.sybase.co.kr/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_9.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.borland.com/" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_10.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
			        <div class="w3-quarter">
			        	<a href="http://www.warevalley.com/koMain.asp" target=_blank>
		          			<img src="/images/ssic/bsns_so_img04_11.gif" alt="ITConsult" style="width:100%;height:100%;" class="w3-hover-opacity">
		          		</a>
			        </div>
		        </div>
			</div>
		</div>
		<!-- /소프트웨어 -->
		
    </div>
  <!-- /The Third Section -->

  <!-- The fourth Section -->
  <div class="w3-blue" id="section4">
    <div class="w3-container w3-content w3-padding-64" style="max-width:1000px">
		<h2 class="w3-wide w3-center w3-margin-bottom">IT컨설팅</h2>
		고객사 IT의 획기적 고도화 및 선진화를 위해 IT계획 수립(IT Planning)에서 구축 (Implementation),운영(Operation),모니터링(Monitoring)의 IT 라이프사이클 활동을 수행할수 있는 제반 활동 체계를 수립하고, 수립된 체계에 따른 효과적 업무 수행을 지원하여 드립니다. 
		
		<!-- IT컨설팅 -->
		<div id="it_zone1" class="w3-row-padding w3-padding-16">
			<div class="w3-margin">
				<b>ISP(Information Strategy Planning)</b><br>
				고객의 경영환경 변화에 대응하고 경영전략에 부합하는 중장기 IT계획을 수립하고, IT관련 주요 이슈 해결 및 성과평가를 지원하는 서비스
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_it_img01.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b>IT Assessment</b><br>
				고객사가 IT경쟁력을 확보 / 유지할 수 있도록 IT 수준을 진단하여 고객사의 현재 IT 수준과 업계 최고 수준과의 차이를 분석하고 이를 극복하기 위한 개선방안을 제시하는 서비스
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_it_img02.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
			<div class="w3-margin">
				<b>IT Governance 체계 수립</b><br>
				비즈니스와 IT의 Alignment 극대화를 통한 IT 민첩성(Agility)향상 및 IT 투자와 운영 위험 최소화를 위해 IT라이프사이크 단계별로 관리/통제가 필요한 영역(Domain)을 정의하고, 영역별로 관리/통제 규정, 프로세스, 조직 및 역할과 책임, 관리/통제 정보로 구성된 체계를 정립하는 서비스로 IT투자에 대한 성과측정(IT ROI), 서비스 수준에 대한 전략적 관리 방안 및 계약체계 수립(SLA / SLM), 효과적인 IT서비스 관리체계(ITSM)구축 등을 포함 합니다.
				<div class="w3-center">
		 			<img src="/images/ssic/bsns_it_img03.gif" class="w3-auto w3-padding-16"/>
		 		</div>
			</div>
		</div>
		<!-- /IT컨설팅 -->
		
    </div>
  </div>
  <!-- /The fourth Section -->
  
</div>

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
