package dao;

import dao.SQLConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.util.*;


public class MemberInformationServlet extends HttpServlet{
	 public MemberInformationServlet() {
	        super(); // HttpServlet 클래스의 기본 생성자를 호출
	        
	    }
	 // 회원 목록을 HTML 형식으로 출력하는 메서드
	 private void printMemberList(HttpServletResponse response) throws SQLException, IOException {
		// StringBuilder를 사용하여 HTML 코드를 효율적으로 생성 java 에서 문자열을 효율적으로 처리하기 위한 클래스 가변성을 가지고 있어 문자열을 동적으로 수정할수 있음
		    StringBuilder responseHTML = new StringBuilder();
		 // HTML 테이블의 헤더 부분 추가
		    responseHTML.append("<div><table><tr><th>ID</th><th>이름</th><th>성별</th><th>전화번호</th><th>주소</th></tr>");
		    SQLConnect sqlConnect = new SQLConnect(); // SQL로 전체 목록 가져오기
		    
		    // 데이터베이스에서 전체 회원 목록을 가져오기 위한 SQL 쿼리 준비
	        // PreparedStatement는 SQL 쿼리를 미리 컴파일하고 실행할 때 사용
		    PreparedStatement pstmt = sqlConnect.getConnection().prepareStatement("SELECT * FROM user");
		    // SQL 쿼리 실행 및 결과(ResultSet) 가져오기
		    ResultSet rs = pstmt.executeQuery(); //데이터베이스에서 반환된 결과 집합을 Java 에서 다룰 수 있는 형식으로 저장

		    while (rs.next()) {
		    	 // 각 행의 데이터를 HTML 테이블의 새로운 행(<tr>)로 추가
		        responseHTML.append("<tr>");
		        responseHTML.append("<td>" + rs.getString("user_id") + "</td>");
		        responseHTML.append("<td>" + rs.getString("name") + "</td>");
		        responseHTML.append("<td>" + rs.getString("sex") + "</td>");
		        responseHTML.append("<td>" + rs.getString("tel") + "</td>");
		        responseHTML.append("<td>" + rs.getString("address") + "</td>");	        
		        responseHTML.append("</tr>");
		    }
		 // HTML 테이블 종료 태그 추가
		    responseHTML.append("</table></div>");
		 // HttpServletResponse 객체를 사용하여 클라이언트에 HTML 데이터 전송
		    response.getWriter().write(responseHTML.toString());
		}
	 
	 
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	// 요청(Request)과 응답(Response)을 처리하는 서블릿 메서드
		    // 클라이언트의 POST 요청을 받아 처리합니다.
	        response.setContentType("text/html;charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        
	        
	        // 클라이언트로부터 전달된 "action" 파라미터 값을 가져옵니다.
	        // 이 값은 사용자가 수행하려는 동작(예: 검색, 추가 등)을 결정합니다.
	        String action = request.getParameter("action");
	        

	        SQLConnect sqlConnect = new SQLConnect(); 
	        if (sqlConnect.getConnection() == null) {
	            out.println("<p>데이터베이스 연결 오류</p>");
	        }

	        try {
	        	
	        	Connection conn = sqlConnect.getConnection();
	        	
	            if (action.equals("search")) {
	            	 // 클라이언트로부터 "user_id" 값을 가져옵니다.
	                String user_id = request.getParameter("user_id");
	                System.out.println("서버에서 받은 user_id: " + user_id);
	                
	                if (user_id == null || user_id.isEmpty()) { //유효성검사 null 이 입력되면 여기서 걸러주고 return 으로 돌려보냄
	                    response.getWriter().write("<p>ID를 입력해 주세요.</p>");
	                    return;
	                }
	                System.out.println("데이터베이스에서 검색 중...");

	                // SQL 쿼리를 준비합니다. user_id에 해당하는 사용자를 검색하는 쿼리입니다.
	                PreparedStatement pstmt = sqlConnect.getConnection().prepareStatement("SELECT * FROM user WHERE user_id = ?");
	                // 쿼리의 첫 번째 파라미터에 클라이언트로부터 전달받은 user_id를 설정합니다.
	                pstmt.setString(1, user_id);
	                // 쿼리를 실행하고 결과(ResultSet)를 가져옵니다.
	                ResultSet rs = pstmt.executeQuery();
	                
	                if (rs.next()) {
	                	System.out.println("검색된 사용자: " + rs.getString("user_id"));
	                	// HTML 응답을 동적으로 생성하기 위해 StringBuilder 객체를 생성합니다.
	                	StringBuilder responseHTML = new StringBuilder();
	                	// html 서블렛으로 응답받은 정보를 출력하기 위해서  
	                    responseHTML.append("<div><table><tr><th>ID</th><th>이름</th><th>성별</th><th>전화번호</th><th>주소</th></tr>");
	                    responseHTML.append("<tr>");
	                    responseHTML.append("<td>" + rs.getString("user_id") + "</td>");
	                    responseHTML.append("<td>" + rs.getString("name") + "</td>");
	                    responseHTML.append("<td>" + rs.getString("sex") + "</td>");
	                    responseHTML.append("<td>" + rs.getString("tel") + "</td>");
	                    responseHTML.append("<td>" + rs.getString("address") + "</td>"); 
	                    responseHTML.append("</tr></table></div>");
	                    
	                    // 응답 데이터의 MIME 타입을 다시 한 번 명시적으로 설정합니다.
	                    response.setContentType("text/html; charset=UTF-8");
	                    // 생성된 HTML 테이블을 클라이언트에게 전송합니다 (실직적으로 위에 코드는 html 내용을 메모리에 작성만 해놓은 상태이고 해당코드로
	                    // 해당 정보를 전송하고 출력하는 코드
	                    response.getWriter().write(responseHTML.toString());
	                } else {
	                	 response.getWriter().write("<p>해당 ID는 존재하지 않습니다.</p>");
	                }

	            } else if (action.equals("add")) {
	            	// 폼 데이터 받기
	                String user_id = request.getParameter("user_id");// 클라이언트가 입력한 사용자 ID를 받음
	                String name = request.getParameter("name");
	                String sex = request.getParameter("sex");
	                String tel = request.getParameter("tel");
	                String address = request.getParameter("address");
	                
	                if (user_id == null || user_id.trim().isEmpty() || name == null || name.trim().isEmpty() || 
	                	    sex == null || sex.trim().isEmpty() || tel == null || tel.trim().isEmpty()) {
	                	    response.getWriter().write("<p>ID, 이름, 성별, 전화번호는 모두 필수 항목입니다.</p>");
	                	    return;  
	                	} //유효성 검사 
	                
	                

	                // SQL 쿼리 준비 - id 중복 검사
	                String checkIdSql = "SELECT COUNT(*) FROM user WHERE user_id = ?";
	                try (PreparedStatement checkStmt = sqlConnect.getConnection().prepareStatement(checkIdSql)) {
	                    checkStmt.setString(1, user_id);  // SQL에 user_id를 바인딩
	                    ResultSet rs = checkStmt.executeQuery(); // 쿼리를 실행하고 결과(ResultSet)를 가져옴
	                    
	                    if (rs.next() && rs.getInt(1) > 0) {
	                        response.getWriter().write("<p>해당 ID는 이미 존재합니다. 다른 ID를 사용해 주세요.</p>");
	                        return;  // 중복 ID일 경우 추가 작업을 진행하지 않음
	                    }
	                } catch (SQLException e) {
	                    response.getWriter().write("<p>오류가 발생했습니다: " + e.getMessage() + "</p>");
	                    return;
	                }

	                // SQL 쿼리 준비 - 데이터 삽입
	                String sql = "INSERT INTO user (user_id, name, sex, tel, address) VALUES (?, ?, ?, ?, ?)";
	                
	                try (PreparedStatement pstmt = sqlConnect.getConnection().prepareStatement(sql)) {
	                    pstmt.setString(1, user_id);
	                    pstmt.setString(2, name);
	                    pstmt.setString(3, sex);
	                    pstmt.setString(4, tel);
	                    pstmt.setString(5, address);
	                    
	                    

	                    // 쿼리 실행
	                    int result = pstmt.executeUpdate();   // INSERT 쿼리 실행, 영향받은 행(row) 수를 반환
	                    
	                    if (result > 0) {
	                        response.getWriter().write("<p>회원이 성공적으로 추가되었습니다.</p>");
	                        printMemberList(response);  // 회원 목록을 다시 출력하여 화면 갱신
	                    } else {
	                        response.getWriter().write("<p>회원 추가 실패</p>");
	                    }
	                } catch (SQLException e) {
	                    response.getWriter().write("<p>회원가입 정보를 입력해주세요</p>");
	               }
	            
	            

	            }else if (action.equals("checkId")) {
	                String userId = request.getParameter("user_id");
	                
	                if (userId != null && !userId.isEmpty()) {
	                    try {
	                        // ID 중복 확인을 위한 SQL 쿼리
	                        String checkIdSql = "SELECT COUNT(*) FROM user WHERE user_id = ?";
	                        // SQL 쿼리를 준비하고, 파라미터로 받은 user_id 값을 넣어서 실행합니다.
	                        try (PreparedStatement checkStmt = sqlConnect.getConnection().prepareStatement(checkIdSql)) {
	                            checkStmt.setString(1, userId); // 첫 번째 ? 자리에 userId 값 설정
	                            ResultSet rs = checkStmt.executeQuery(); // 쿼리 실행하여 결과를 받아옵니다.
	                            
	                            // 만약 rs.next()가 true라면, 해당 ID가 존재함.
	                            // rs.getInt(1) > 0이면, 중복된 ID가 이미 존재하는 경우.
	                            if (rs.next() && rs.getInt(1) > 0) {
	                                response.getWriter().write("<span style='color: red;'>이미 존재하는 ID입니다.</span>");
	                            } else {
	                                response.getWriter().write("<span style='color: green;'>사용 가능한 ID입니다.</span>");
	                            }
	                        }
	                    } catch (SQLException e) {
	                        response.getWriter().write("<span style='color: red;'>오류가 발생했습니다: " + e.getMessage() + "</span>");
	                    }
	                } else {
	                    response.getWriter().write("<span style='color: red;'>ID를 입력해 주세요.</span>");
	                }
	            }
	            
	            else if (action.equals("update")) {
	            	String user_id = request.getParameter("user_id");
	                String name = request.getParameter("name");
	                String sex = request.getParameter("sex");
	                String tel = request.getParameter("tel");
	                String address = request.getParameter("address");
	                
	                if (user_id == null || user_id.trim().isEmpty() || name == null || name.trim().isEmpty() || 
	                	    sex == null || sex.trim().isEmpty() || tel == null || tel.trim().isEmpty()) {
	                	    response.getWriter().write("<p>ID, 이름, 성별, 전화번호는 모두 필수 항목입니다.</p>");
	                	    return;  
	                	} //유효성 검사 
	                if (user_id != null && !user_id.isEmpty()) {
	                    try {
	                        // 사용자 정보 업데이트를 위한 SQL 쿼리
	                        PreparedStatement pstmt = conn.prepareStatement("UPDATE user SET name = ?, sex = ?, tel = ?, address = ? WHERE user_id = ?");
	                        pstmt.setString(1, name);
	                        pstmt.setString(2, sex);
	                        pstmt.setString(3, tel);
	                        pstmt.setString(4, address);
	                        pstmt.setString(5, user_id);

	                        int result = pstmt.executeUpdate();

	                        // 업데이트 성공 여부에 따라 처리
	                        if (result > 0) {
	                            response.getWriter().write("<p>회원 정보가 수정되었습니다.</p>");
	                            printMemberList(response); // 업데이트 후 회원 목록 갱신
	                        } else {
	                            response.getWriter().write("<p>해당 아이디의 정보를 찾을 수 없습니다.</p>");
	                        }
	                    } catch (SQLException e) {
	                        // SQL 오류 발생 시 처리
	                        response.getWriter().write("<p>오류가 발생했습니다: " + e.getMessage() + "</p>");
	                        e.printStackTrace(); // 콘솔에 오류 로그 출력
	                    }
	                } else {
	                    response.getWriter().write("<p>ID를 입력해 주세요.</p>");
	                }
	            } else if (action.equals("delete")) {
	                String user_id = request.getParameter("user_id");
	                
	                
	                if (user_id != null && !user_id.isEmpty()) {
	                    try {
	                        // 삭제 쿼리
	                    	PreparedStatement pstmt = sqlConnect.getConnection().prepareStatement("DELETE FROM user WHERE user_id = ?");
	                        pstmt.setString(1, user_id);  // 아이디 값 설정

	                        int result = pstmt.executeUpdate();  // executeUpdate로 쿼리 실행

	                        // 결과에 따라 처리
	                        if (result > 0) {
	                            response.getWriter().write("<p>회원이 삭제되었습니다.</p>");
	                            
	                            // 삭제 후, 갱신된 목록을 다시 출력
	                            printMemberList(response);
	                            

	                        } else {
	                            response.getWriter().write("<p>해당 아이디가 존재하지 않습니다.</p>");
	                        }
	                    } catch (SQLException e) {
	                        response.getWriter().write("<p>오류가 발생했습니다: " + e.getMessage() + "</p>");
	                        e.printStackTrace();
	                    }
	                } else {
	                    response.getWriter().write("<p>ID를 입력해 주세요.</p>");
	                }
	            } else if (action.equals("all")) {
	                Statement stmt = sqlConnect.getConnection().createStatement(); //statement 를 사용한 이유는 전체다 프린트하려고 정적이게 사용하기 위해서
	                ResultSet rs = stmt.executeQuery("SELECT * FROM user");

	                out.println("<div><table><tr><th>ID</th><th>이름</th><th>성별</th><th>전화번호</th><th>주소</th></tr>");
	                while (rs.next()) {
	                    out.println("<tr>");
	                    out.println("<td>" + rs.getString("user_id") + "</td>");
	                    out.println("<td>" + rs.getString("name") + "</td>");
	                    out.println("<td>" + rs.getString("sex") + "</td>");
	                    out.println("<td>" + rs.getString("tel") + "</td>");
	                    out.println("<td>" + rs.getString("address") + "</td>");	                    
	                    
	                    
	                    out.println("</tr>");
	                }
	                out.println("</table></div>");
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	            out.println("<p>SQL 오류: " + e.getMessage() + "</p>");  // 더 구체적인 오류 메시지 출력
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        } catch (Exception e) {
	            e.printStackTrace();
	            out.println("<p>알 수 없는 오류: " + e.getMessage() + "</p>");  // 예기치 않은 오류 처리
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        } finally {
	            sqlConnect.close();
	        }
	    }
	}