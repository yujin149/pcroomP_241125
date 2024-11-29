<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>PC방 고객관리 시스템</title>
<link rel="stylesheet" href="./resources/css/main.css" />
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
	<div class="mainWrap">
		
		<div class="menuList">
			<ul class="tabMenu">
				<li><a href="#tab1" class="on">회원정보</a></li>
				<li><a href="#tab2">좌석선택</a></li>
			</ul>
			<ul class="btnWrap">
				<li><a href="./correction.jsp" class="updateBtn btn">관리자 정보 수정</a></li>
				<li><a href="./login.jsp" class="btn">로그아웃</a></li>
			</ul>
			
		</div>

		<div class="tabList">
			<div id="tab1" class="on"><%@ include file="./member.jsp" %></div>
			
			<div id="tab2"><%@ include file="./reserve.jsp" %></div>
		</div>
	</div>

<script>
	$(".tabMenu li a").click(function(){
	
		let tabId = $(this).attr("href");
		
		$(".tabMenu li a").removeClass("on");
		$(this).addClass("on");
		
		$(".tabList div").removeClass("on");
		$(tabId).addClass("on");

		return false;
	});
</script>

</body>
</html>