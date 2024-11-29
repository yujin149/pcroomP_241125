<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.pcroom.dao.ReserveDAO"%>
<%@ page import="com.pcroom.dto.ReserveDTO"%>
<%@ page import="java.util.List"%>
<%
    ReserveDAO reserveDAO = new ReserveDAO();
    List<ReserveDTO> reservations = reserveDAO.getAllReservations();
%>

<div class="reserveWrap">
    <!-- 좌석 선택 뷰 -->
    <div class="seatArea">
        <ul class="seatList">
            <% for(int i = 1; i <= 18; i++) { 
                ReserveDTO seatInfo = reserveDAO.getReservationBySeat(i);
                String seatClass = seatInfo != null ? "seatBtn reserveSeat" : "seatBtn";
            %>
            <li>
                <a href="#" class="<%= seatClass %>" data-seat="<%= i %>" 
                   data-userid="<%= seatInfo != null ? seatInfo.getUserId() : "" %>">
                    <span class="seatNum"><%= i %></span>
                    <p class="userId"><b>아이디 : </b><%= seatInfo != null ? seatInfo.getUserId() : "" %></p>
                    <p class="time"><b>이용시간 : </b><%= seatInfo != null ? seatInfo.getHours() + "시간" : "" %></p>
                </a>
            </li>
            <% } %>
        </ul>
    </div>
    
    <!-- 예약현황 -->
    <div class="reserveTable">
        <div class="titleBox">
            <h3>좌석 선택 현황</h3>
            <div class="rightArea">
	            <div class="searchBox">
	                <select name="search" id="search">
	                    <option value="seat">좌석번호</option>
	                    <option value="user_id">아이디</option>
	                </select>
	                <input type="text" placeholder="검색어를 입력해주세요.">
	                <span class="searchBtn"><img src="./resources/images/search.png" alt="검색"></span>
	            </div>
	            <a href="#" class="allBtn">전체 출력</a>
            </div>
        </div>
        
        <div class="tableWrap">
            <table>
                <colgroup>
                    <col style="width:8%">
                    <col style="width:16%">
                    <col style="width:16%">
                    <col style="width:20%">
                    <col style="width:*">
                </colgroup>
                <thead>
                    <tr>
                        <th>좌석번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>전화번호</th>
                        <th>이용시간</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(ReserveDTO reserve : reservations) { %>
                    <tr>
                        <td><%= reserve.getSeat() %></td>
                        <td><%= reserve.getUserId() %></td>
                        <td><%= reserve.getUserName() %></td>
                        <td><%= reserve.getUserTel() %></td>
                        <td>
                            <%= reserve.getHours() %>시간
                            <small>(<%= reserve.getTimeRange() %>)</small>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- 예약 팝업 -->
    <div class="popupWrap reservePopup">
        <div class="titleWrap">
            <p class="title">좌석 선택</p>
        </div>
        <form action="reserve_process.jsp" method="post">
            <div class="textWrap">
                <ul class="inputTxt">
                    <li>
                        <p class="tit">좌석번호</p>
                        <input type="text" name="seat" readonly>
                    </li>
                    <li>
                        <p class="tit">아이디</p>
                        <input type="text" name="id" required>
                    </li>
                    <li>
                        <p class="tit">이용시간</p>
                        <select name="time" id="time">
                            <option value="1">1시간</option>
                            <option value="2">2시간</option>
                            <option value="3">3시간</option>
                            <option value="6">6시간</option>
                            <option value="12">12시간</option>
                            <option value="24">24시간</option>
                        </select>
                    </li>
                </ul>
            </div>
            <div class="btnWrap">
                <button type="submit" class="btn reserveBtn">좌석 예약</button>
                <a href="#" class="btn close">닫기</a>
            </div>
        </form>
    </div>

    <!-- 취소 팝업 -->
    <div class="popupWrap deletePopup">
        <div class="titleWrap">
            <p class="title">이용 종료</p>
        </div>
        <form action="cancel_process.jsp" method="post">
            <div class="textWrap">
                <ul class="inputTxt">
                    <li>
                        <p class="tit">좌석번호</p>
                        <input type="text" name="seat" readonly>
                    </li>
                    <li>
                        <p class="tit">아이디</p>
                        <input type="text" name="id" readonly>
                    </li>
                </ul>
            </div>
            <div class="btnWrap">
                <button type="submit" class="btn reserveBtn">이용 종료</button>
                <a href="./main.jsp#tab2" class="btn close">닫기</a>
            </div>
        </form>
    </div>
    <div class="bgBlack"></div>
</div>

<script>
$(document).ready(function() {
	// 팝업 닫기
    $(".close").click(function(){
        $(".popupWrap").css("display","none");
        $(".bgBlack").css("display","none");
    });
    
 // 좌석 클릭 이벤트 - 이벤트 위임 방식으로 변경
    $(document).on('click', '.seatList li a', function(){
        let seatNum = $(this).data('seat');
        let userId = $(this).data('userid');
        
        if($(this).hasClass("reserveSeat")){
            $(".deletePopup input[name='seat']").val(seatNum);
            $(".deletePopup input[name='id']").val(userId);
            $(".deletePopup").css("display","block");
            $(".bgBlack").css("display","block");
        } else {
            $(".reservePopup input[name='seat']").val(seatNum);
            $(".reservePopup").css("display","block");
            $(".bgBlack").css("display","block");
        }
    });

    // 검색 기능
    $(".searchBtn").click(function(){
        searchReservations();
    });
    
    // 엔터키 검색 지원
    $(".searchBox input").keypress(function(e){
        if(e.which == 13) {
            searchReservations();
        }
    });
    
    // 전체 출력 버튼
    $(".allBtn").click(function(e){
        e.preventDefault();
        loadAllReservations();
    });
    
    function searchReservations() {
        let searchType = $("#search").val();
        let keyword = $(".searchBox input").val().trim();
        
        if(keyword === "") {
            alert("검색어를 입력해주세요.");
            return;
        }
        
        $.ajax({
            url: 'search_reservations.jsp',
            type: 'POST',
            data: {
                searchType: searchType,
                keyword: keyword
            },
            success: function(response) {
                $(".tableWrap tbody").html(response);
            },
            error: function(xhr, status, error) {
                alert('검색 중 오류가 발생했습니다.');
            }
        });
    }
    
    function loadAllReservations() {
        $.ajax({
            url: 'search_reservations.jsp',
            type: 'POST',
            data: {
                searchType: 'all',
                keyword: ''
            },
            success: function(response) {
                $(".tableWrap tbody").html(response);
                // 검색창 초기화
                $(".searchBox input").val('');
            },
            error: function(xhr, status, error) {
                alert('데이터를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    
 // 예약 폼 제출
    $(".reservePopup form").submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: 'reserve_process.jsp',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if(response.trim() === 'success') {
                    $(".reservePopup").css("display","none");
                    $(".bgBlack").css("display","none");
                    refreshSeatInfo();
                } else {
                    alert('예약 실패');
                }
            },
            error: function() {
                alert('예약 중 오류가 발생했습니다.');
            }
        });
    });

    // 취소 폼 제출
    $(".deletePopup form").submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: 'cancel_process.jsp',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if(response.trim() === 'success') {
                    $(".deletePopup").css("display","none");
                    $(".bgBlack").css("display","none");
                    refreshSeatInfo();
                } else {
                    alert('취소 실패');
                }
            },
            error: function() {
                alert('취소 중 오류가 발생했습니다.');
            }
        });
    });

    // 좌석 정보 새로고침 함수 수정
    function refreshSeatInfo() {
        $.ajax({
            url: 'get_seat_info.jsp',
            type: 'GET',
            success: function(response) {
                $(".seatArea").html(response);
                // 좌석 클릭 이벤트 재바인딩은 이제 필요 없음 (이벤트 위임 사용)
                loadAllReservations();
            },
            error: function() {
                alert('좌석 정보를 불러오는데 실패했습니다.');
            }
        });
    }
});
</script>