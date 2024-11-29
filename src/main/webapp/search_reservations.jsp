<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.pcroom.dao.ReserveDAO"%>
<%@ page import="com.pcroom.dto.ReserveDTO"%>
<%@ page import="java.util.List"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    String searchType = request.getParameter("searchType");
    String keyword = request.getParameter("keyword");
    
    ReserveDAO reserveDAO = new ReserveDAO();
    List<ReserveDTO> reservations;
    
    if("all".equals(searchType) || keyword == null || keyword.trim().isEmpty()) {
        reservations = reserveDAO.getAllReservations();
    } else {
        reservations = reserveDAO.searchReservations(searchType, keyword);
    }
    
    if(reservations != null && !reservations.isEmpty()) {
        for(ReserveDTO reserve : reservations) {
%>
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
<%
        }
    } else {
%>
    <tr>
        <td colspan="5">검색 결과가 없습니다.</td>
    </tr>
<%
    }
%>