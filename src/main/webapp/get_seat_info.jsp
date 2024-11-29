<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.pcroom.dao.ReserveDAO"%>
<%@ page import="com.pcroom.dto.ReserveDTO"%>

<ul class="seatList">
    <% 
        ReserveDAO reserveDAO = new ReserveDAO();
        for(int i = 1; i <= 18; i++) { 
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