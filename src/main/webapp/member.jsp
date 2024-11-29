<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="userWrap">
	<div class="titleBox">
		<h3>회원 관리 시스템</h3>

		<!-- 메뉴 버튼 -->
		<form id="menuForm" method="post" action="MemberInformationServlet">
			<ul id="menuList">
				<li><button type="button" class="menuBtn" data-action="search">검색</button></li>
				<li><button type="button" class="menuBtn" data-action="add">추가</button></li>
				<li><button type="button" class="menuBtn" data-action="update">수정</button></li>
				<li><button type="button" class="menuBtn" data-action="delete">삭제</button></li>
				<li><button type="button" class="menuBtn" data-action="all">전체
						출력</button></li>
			</ul>
		</form>
	</div>

	<div class="formArea">
		<!-- 검색 폼 -->
		<form id="searchForm" style="display: none;">
			<p class="tit">ID</p>
			<input type="text" name="user_id" required>
			<button type="button" id="searchSubmitBtn">검색</button>
		</form>

		<!-- 삭제 폼 -->
		<form id="deleteForm" style="display: none;">
			<p class="tit">ID</p>
			<input type="text" name="user_id" required>
			<button type="button" id="deleteSubmitBtn">삭제</button>
		</form>

		<!-- 추가 폼 -->
		<form id="addForm" style="display: none;" class="addForm">
			<div class="list">
				<p class="tit">ID</p>
				<input type="text" name="user_id" required>
			</div>
			<div class="list">
				<p class="tit">이름</p>
				<input type="text" name="name" required>
			</div>
			<div class="list">
				<p class="tit">성별</p>
				<input type="text" name="sex" required>
			</div>
			<div class="list">
				<p class="tit">전화번호</p>
				<input type="text" name="tel" required>
			</div>
			<div class="list list02">
				<p class="tit">주소</p>
				<input type="text" name="address" required>
			</div>
			<div class="btnWrap">
				<button type="button" id="addSubmitBtn" style="margin-right: 10px;">추가</button>
				<button type="button" id="checkIdBtn">중복검사</button>
				<br> <span id="idCheckResult"></span><br>
			</div>

		</form>

		<!-- 수정 폼 -->
		<form id="updateForm" style="display: none;" class="addForm">
			<div class="list">
				<p class="tit">ID</p>
				<input type="text" name="user_id" required>
			</div>
			<div class="list">
				<p class="tit">이름</p>
				<input type="text" name="name" required>
			</div>
			<div class="list">
				<p class="tit">성별</p>
				<input type="text" name="sex" required>
			</div>
			<div class="list">
				<p class="tit">전화번호</p>
				<input type="text" name="tel" required>
			</div>
			<div class="list list02">
				<p class="tit">주소</p>
				<input type="text" name="address" required>
			</div>
			<div class="btnWrap">
				<button type="button" id="updateSubmitBtn">수정</button>
			</div>
		</form>
	</div>

</div>
<!-- 결과 테이블 -->
<div class="contWrap">
	<div id="content">
		<!-- 동적으로 내용이 채워질 영역 -->
	</div>
</div>


<script>
	//AJAX로 콘텐츠 로드
	$('.menuBtn').click(function(e) { //$ jquery 객체를 생성하는 함수 .menubtn 클래스menubtn 인 html요소를 jquery 객체로 반환해서 클릭시 해당 function이 실행
		// e는 event objectfh jquery 자체적으로 가지고 있는 객체
		var action = $(this).data('action'); // 버튼에 설정된 action 값을 가져옴 // $(this)는 this를 jQuery 객체로 감싸서, jQuery 메서드들을 사용

		$('#searchForm').hide();
		$('#addForm').hide();
		$('#updateForm').hide();
		$('#deleteForm').hide();

		// '검색' 버튼이 클릭되면 검색 폼을 보여주고, 다른 버튼은 결과만 처리
		if (action === 'search') {
			$('#searchForm').show(); // 검색 폼을 보이도록 설정
		} else if (action === 'add') {
			$('#addForm').show(); // 추가 폼을 보이도록 설정
		} else if (action === 'update') {
			$('#updateForm').show(); // 수정 폼을 보이도록 설정
		} else if (action === 'delete') {
			$('#deleteForm').show(); // 삭제 폼을 보이도록 설정
		} else {
			$('#searchForm').hide();
			$('#addForm').hide();
			$('#updateForm').hide();
			$('#deleteForm').hide();
		}

		// 서버에 AJAX 요청 보내기
		$.ajax({
			url : 'MemberInformationServlet',
			type : 'POST',
			data : {
				action : action
			}, // 버튼에 설정된 action을 서버로 전송
			success : function(response) {
				$('#content').html(response); // 응답을 #content에 삽입
			},
			error : function(xhr, status, error) {
				alert('오류가 발생했습니다.' + status + ', 오류: ' + error);
			}
		});
	});

	// 검색 버튼 클릭 시 AJAX 요청 보내기
	$('#searchSubmitBtn').click(function(e) {
		e.preventDefault();
		var searchId = $('#searchForm input[name="user_id"]').val(); // 입력된 아이디 값

		console.log("검색하려는 user_id:", searchId);

		if (searchId.trim() === "") {
			alert("ID를 입력해 주세요.");
			return;
		}

		$.ajax({
			url : 'MemberInformationServlet',
			type : 'POST',
			data : {
				action : 'search',
				user_id : searchId
			}, // 검색할 아이디와 함께 action 전송
			success : function(response) {
				$('#content').html(response); // 검색 결과를 #content에 삽입
				$('#searchForm input[name="user_id"]').val('');
			},
			error : function(xhr, status, error) {
				alert('오류가 발생했습니다.' + status + ', 오류: ' + error);
			}
		});
	});

	$('#addSubmitBtn').click(function(e) {
		e.preventDefault();
		var formData = $('#addForm').serialize(); // 폼 데이터를 직렬화
		console.log(formData);
		$.ajax({
			url : 'MemberInformationServlet',
			type : 'POST',
			data : formData + '&action=add', // 추가할 데이터와 함께 action 전송
			success : function(response) {
				$('#content').html(response); // 서버에서 반환된 메시지 출력
				$('#addForm input').val('');
			},
			error : function(xhr, status, error) {
				alert('오류가 발생했습니다.' + status + ', 오류: ' + error);
			}
		});
	});
	$('#checkIdBtn').click(
			function(e) {
				e.preventDefault(); // 기본 동작 방지
				var userId = $('#addForm input[name="user_id"]').val(); // 입력된 아이디 값

				if (userId) {
					$.ajax({
						url : 'MemberInformationServlet',
						type : 'POST',
						data : {
							action : 'checkId',
							user_id : userId
						}, // 중복검사를 위한 데이터 전송
						success : function(response) {
							$('#idCheckResult').html(response); // 응답을 #idCheckResult에 표시
						},
						error : function(xhr, status, error) {
							alert('오류가 발생했습니다.' + status + ', 오류: ' + error);
						}
					});
				} else {
					$('#idCheckResult').html(
							'<span style="color: red;">ID를 입력해 주세요.</span>');
				}
			});

	// 수정 버튼 클릭 시 AJAX 요청 보내기
	$('#updateSubmitBtn').click(function(e) {
		e.preventDefault();
		var formData = $('#updateForm').serialize(); // 폼 데이터를 직렬화

		$.ajax({
			url : 'MemberInformationServlet',
			type : 'POST',
			data : formData + '&action=update', // 수정할 데이터와 함께 action 전송
			success : function(response) {
				$('#content').html(response); // 서버에서 반환된 메시지 출력
				$('#updateForm input').val('');
			},
			error : function(xhr, status, error) {
				alert('오류가 발생했습니다.' + status + ', 오류: ' + error);
			}
		});
	});

	// 삭제 버튼 클릭 시 AJAX 요청 보내기
	$('#deleteSubmitBtn').click(function(e) {
		e.preventDefault(); // 기본 동작 방지
		var deleteId = $('#deleteForm input[name="user_id"]').val(); // 입력된 아이디 값           

		if (deleteId) {
			$.ajax({
				url : 'MemberInformationServlet',
				type : 'POST',
				data : {
					action : 'delete',
					user_id : deleteId
				}, // 삭제할 아이디와 함께 action 전송
				success : function(response) {
					// 삭제 후 결과를 #content에 표시 (즉시 갱신된 목록 출력)
					$('#content').html(response); // 서버에서 반환한 응답을 바로 #content에 적용
					$('#deleteForm input[name="user_id"]').val('');
				},
				error : function(xhr, status, error) {
					alert('오류가 발생했습니다.' + status + ', 오류: ' + error);
				}
			});
		} else {
			$('#content').html('<p>ID를 입력해 주세요.</p>'); // 아이디가 비어 있으면 메시지 표시
		}
	});
	function reloadMemberList() {
		$.ajax({
			url : 'MemberInformationServlet',
			type : 'POST',
			data : {
				action : 'list'
			}, // 전체 목록 요청
			success : function(response) {
				$('#content').html(response); // 전체 목록을 #content에 표시
			},
			error : function(xhr, status, error) {
				alert('목록을 불러오는 데 오류가 발생했습니다.' + status + ', 오류: ' + error);
			}
		});
	}
</script>
