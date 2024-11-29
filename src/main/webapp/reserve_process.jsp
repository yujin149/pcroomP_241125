<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.pcroom.dao.ReserveDAO"%>
<%@ page import="com.pcroom.dto.ReserveDTO"%>
<%@ page import="java.time.LocalDateTime"%>

<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("id");
    int seat = Integer.parseInt(request.getParameter("seat"));
    int hours = Integer.parseInt(request.getParameter("time"));
    
    ReserveDTO reserve = new ReserveDTO();
    reserve.setSeat(seat);
    reserve.setUserId(userId);
    reserve.setTime(LocalDateTime.now());
    reserve.setHours(hours);
    
    ReserveDAO dao = new ReserveDAO();
    boolean success = dao.reserveSeat(reserve);
    
    out.print(success ? "success" : "fail");
%>