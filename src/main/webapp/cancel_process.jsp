<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.pcroom.dao.ReserveDAO"%>

<%
    request.setCharacterEncoding("UTF-8");
    
    int seat = Integer.parseInt(request.getParameter("seat"));
    
    ReserveDAO dao = new ReserveDAO();
    boolean success = dao.cancelReservation(seat);
    
    out.print(success ? "success" : "fail");
%>