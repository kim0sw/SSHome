<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!-- <html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko"> -->
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>[JUI Library] - JavaScript/Button</title>

<link rel="stylesheet" href="/css/egovframework/jui-ui.classic.css" />
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/juijs@2.2.1-es6/dist/jui-core.js"></script>
<script src="/js/egovframework/jui-ui.js"></script>

<script>
jui.ready([ "ui.button" ], function(button) {
	var btn_radio_options = {
		type: "radio",
		event: {
			change: function(data) {
				alert("index(" + data.index + "), value(" + data.value + ")");
			}
		}
	};
	
	var btn_check_options = {
		type: "check",
		event: {
			change: function(data) {
				var result = "";
				
				for(var i = 0; i < data.length; i++) {
					if(data[i] != null) {
						result += "index(" + data[i].index + "), value(" + data[i].value + ")" + "\n";
					}
				}
				
				alert(result);
			}
		}
	};
	
	// 버튼-라디오 
	btn_radio_1 = button("#btn_radio_1", btn_radio_options);
	btn_radio_2 = button("#btn_radio_2", btn_radio_options);
	btn_radio_3 = button("#btn_radio_3", btn_radio_options);
	
	// 버튼-체크 
	btn_check = button("#btn_check", btn_check_options);
	btn_check_2 = button("#btn_check_2", btn_check_options);
});

</script>

</head>
<body class="jui">

<div class="page-header">
	<h1>Button</h1>
</div>

<section>
	<h2>Radio</h2>
	<p>
		버튼 컴포넌트는 하나만 선택할 수 있는 라디오 타입을 제공합니다.
		
		<table class="table_s" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="200px">View</td>
				<td width="75px">Result</td>
				<td>Test Code</td>
				<td>Description</td>
			</tr>
			<tr>
				<td>
					<div id="btn_radio_1" class="group">
						<a class="btn small" value="true">On</a>
						<a class="btn small" value="false">Off</a>
					</div>
				</td>
				<td>
					<button class="btn btn-gray" onclick="alert(btn_radio_1.getValue())"><i class="icon-play"></i> Run</button>
				</td>
				<td>
					alert(btn_radio_1.getValue());
				</td>
				<td>
					현재 선택된 버튼의 값을 출력
				</td>
			</tr>
			<tr>
				<td>
					<div id="btn_radio_2" class="group">
						<a class="btn mini" value="a">A</a>
						<a class="btn mini" value="b">B</a>
						<a class="btn mini" value="c">C</a>
						<a class="btn mini" value="home"><i class="icon-associate"></i> Home</a>
						<a class="btn mini" value="gear"><i class="icon-jennifer-front"></i></a>
						<a class="btn mini" value="help"><i class="icon-line-each"></i></a>
					</div>
				</td>
				<td>
					<button class="btn btn-gray" onclick="btn_radio_2.setIndex(3);"><i class="icon-play"></i> Run</button>
				</td>
				<td>
					btn_radio_2.setIndex(3);
				</td>
				<td>
					해당 인덱스의 버튼을 선택 상태로 변경
				</td>
			</tr>
			<tr>
				<td>
					<div id="btn_radio_3" class="group">
						<a class="btn mini" value="a">A</a>
						<a class="btn mini" value="b">B</a>
						<a class="btn mini" value="c">C</a>
						<a class="btn mini" value="home"><i class="icon-home icon-white"></i></a>
						<a class="btn mini" value="gear"><i class="icon-gear icon-white"></i></a>
						<a class="btn mini" value="help"><i class="icon-help icon-white"></i></a>
					</div>
				</td>
				<td>
					<button class="btn btn-gray" onclick="btn_radio_3.setValue('gear');"><i class="icon-play"></i> Run</button>
				</td>
				<td>
					btn_radio_3.setValue("gear");
				</td>
				<td>
					해당 값의 버튼을 선택 상태로 변경
				</td>
			</tr>
		</table>
	</p>
	
	<p class="br">
		아래는 라디오 버튼을 생성하는 코드입니다.
		
<pre><code class="language-markup">&lt;div id="btn_radio_1" class="group"&gt;
	&lt;a class="btn small" value="true"&gt;On&lt;/a&gt;
	&lt;a class="btn small" value="false"&gt;Off&lt;/a&gt;
&lt;/div&gt;

...</code></pre>
<pre><code class="language-javascript">jui.ready(function(ui, uix, _) {
	var btn_radio_options = {
		type: "radio",
		event: {
			change: function(data) {
				alert("index(" + data.index + "), value(" + data.value + ")");
			}
		}
	};
	
	btn_radio_1 = ui.button("#btn_radio_1", btn_radio_options);
	btn_radio_2 = ui.button("#btn_radio_2", btn_radio_options);
	btn_radio_3 = ui.button("#btn_radio_3", btn_radio_options);
});</code></pre>
	</p>
</section>
<section>
	<h2>Check</h2>
	<p>
		버튼 컴포넌트는 다수를 선택할 수 있는 체크 타입을 제공합니다.
	
		<table class="table_s" cellpadding="0" cellspacing="0">
			<tr>
				<td width="170px">View</td>
				<td width="75px">Result</td>
				<td>Test Code</td>
				<td>Description</td>
			</tr>
			<tr>
				<td>
					<div id="btn_check" class="group">
						<a class="btn mini" value="check"><i class="icon-check"></i></a>
						<a class="btn mini" value="plus"><i class="icon-plus"></i></a>
						<a class="btn mini" value="edit"><i class="icon-edit"></i></a>
						<a class="btn mini" value="home"><i class="icon-home"></i></a>
						<a class="btn mini" value="gear"><i class="icon-gear"></i></a>
					</div>
				</td>
				<td>
					<button class="btn btn-gray" onclick="btn_check.setIndex([ 3, 4 ]);"><i class="icon-play"></i> Run</button>
				</td>
				<td>
					btn_check.setIndex([ 3, 4 ]);
				</td>
				<td>
					해당 인덱스를 가지는 버튼들을 선택 상태로 변경
				</td>
			</tr>
			<tr>
				<td>
					<div id="btn_check_2" class="group">
						<a class="btn mini" value="check"><i class="icon-check icon-white"></i></a>
						<a class="btn mini" value="plus"><i class="icon-plus icon-white"></i></a>
						<a class="btn mini" value="edit"><i class="icon-edit icon-white"></i></a>
						<a class="btn mini" value="home"><i class="icon-home icon-white"></i></a>
						<a class="btn mini" value="gear"><i class="icon-gear icon-white"></i></a>
					</div>
				</td>
				<td>
					<button class="btn btn-gray" onclick="btn_check_2.setValue([ 'check', 'edit' ]);"><i class="icon-play"></i> Run</button>
				</td>
				<td>
					btn_check_2.setValue([ 'check', 'edit' ]);
				</td>
				<td>
					해당 값을 가지는 버튼들을 선택 상태로 변경
				</td>
			</tr>
		</table>
	</p>
	
	<p class="br">
		아래는 체크 버튼을 생성하는 코드입니다.
		
<pre><code class="language-markup">&lt;div id="btn_check" class="group"&gt;
	&lt;a class="btn mini" value="check"&gt;&lt;i class="icon-check"&gt;&lt;/i&gt;&lt;/a&gt;
	&lt;a class="btn mini" value="plus"&gt;&lt;i class="icon-plus"&gt;&lt;/i&gt;&lt;/a&gt;
	&lt;a class="btn mini" value="edit"&gt;&lt;i class="icon-edit"&gt;&lt;/i&gt;&lt;/a&gt;
	&lt;a class="btn mini" value="home"&gt;&lt;i class="icon-home"&gt;&lt;/i&gt;&lt;/a&gt;
	&lt;a class="btn mini" value="gear"&gt;&lt;i class="icon-gear"&gt;&lt;/i&gt;&lt;/a&gt;
&lt;/div&gt;

...</code></pre>

<pre><code class="language-javascript">var btn_check_options = {
	type: "check",
	event: {
		change: function(data) {
			var result = "";
			
			for(var i = 0; i < data.length; i++) {
				if(data[i] != null) {
					result += "index(" + data[i].index + "), value(" + data[i].value + ")" + "\n";
				}
			}
			
			alert(result);
		}
	}
};

btn_check = ui.button("#btn_check", btn_check_options);
btn_check_2 = ui.button("#btn_check_2", btn_check_options);</code></pre>

	</p>
</section>
</body>
</html>
