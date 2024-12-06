<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 성공</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String memail = request.getParameter("memail");
		String mage = request.getParameter("mage");  // getParameter 은 string 으로만 반환
		
		String sql = "INSERT INTO membertbl(memberid, memberpw, membername, memberemail, memberage) VALUES('"+mid+"','"+mpw+"','"+mname+"','"+memail+"','"+mage+"')";
		
		String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jbedu"; //MySQL이 설치된 주소와 연결할 DB(스키마) 이름
		String username = "root"; //계정 이름 -> 관리자 계정 이름
		String password = "12345"; //계정 비밀번호 -> 관리자 계정 비밀번호
		
		Connection conn = null;  //DB와의 커넥션을 초기값 null로 해서 생성
		Statement stmt = null;  //SQL문을 실행시켜주는 객체
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			stmt = conn.createStatement();
			
			int resultNum = stmt.executeUpdate(sql); //sql문 db에서 실행 -> 성공 1이 반환, 1아니면 실패
			
			if (resultNum == 1) {
				out.println("회원 가입 성공!");
			} else {
				out.println("회원 가입 실패!");
			}
			
		} catch (Exception e) {
			out.println("DB 에러발생!! 회원 가입 실패!");
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
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