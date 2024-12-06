<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 성공</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String mid = request.getParameter("mid");
		
		String sql = "DELETE FROM membertbl WHERE memberid = ?";
		
		String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jbedu"; //MySQL이 설치된 주소와 연결할 DB(스키마) 이름
		String username = "root"; //계정 이름 -> 관리자 계정 이름
		String password = "12345"; //계정 비밀번호 -> 관리자 계정 비밀번호
		
		Connection conn = null;  //DB와의 커넥션을 초기값 null로 해서 생성
		PreparedStatement pstmt = null; //sql문을 편하게 작성할 수 있음
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			
			pstmt = conn.prepareStatement(sql);  // sql문이 들어가는 위치가 틀림
			pstmt.setString(1, mid); 
			
			int resultNum = pstmt.executeUpdate();  // 성공 1이 반환, 1아니면 실패
			
			
			if (resultNum == 1) {
				out.println("회원 탈퇴 성공!");
			} else {
				System.out.println(resultNum); //delete 실패했을때 반환되는 값
				out.println("회원 탈퇴 실패!");
			}
			
		} catch (Exception e) {
			out.println("DB 에러발생!! 회원 탈퇴 실패!");
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
	
	
	%>
</body>
</html>