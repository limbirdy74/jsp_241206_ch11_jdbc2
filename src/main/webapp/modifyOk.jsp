<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jbedu.member.dto.MemberDto"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 성공</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	String mid = request.getParameter("mid");
	String mpw = request.getParameter("mpw");
	String mname = request.getParameter("mname");
	String memail = request.getParameter("memail");
	String mage = request.getParameter("mage");  // getParameter 은 string 으로만 반환

	String sql = "UPDATE membertbl SET memberpw = ?, membername = ?, memberemail = ?, memberage = ? WHERE memberid = ?";
	
	String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
	String url = "jdbc:mysql://localhost:3306/jbedu"; //MySQL이 설치된 주소와 연결할 DB(스키마) 이름
	String username = "root"; //계정 이름 -> 관리자 계정 이름
	String password = "12345"; //계정 비밀번호 -> 관리자 계정 비밀번호
	
	Connection conn = null;  //DB와의 커넥션을 초기값 null로 해서 생성
	PreparedStatement pstmt = null; //stmt 대신 사용. sql문을 편하게 작성할 수 있음
	
	try {
		Class.forName(driverName);
		conn = DriverManager.getConnection(url, username, password);
		
		pstmt = conn.prepareStatement(sql);  // sql문이 들어가는 위치가 틀림
		 //(int 1, x) 앞은 ? 의 순서. 1부터 시작
		pstmt.setString(1, mpw);
		pstmt.setString(2, mname);
		pstmt.setString(3, memail);
		pstmt.setString(4, mage);
		
		pstmt.setString(5, mid);
		
		int resultNum = pstmt.executeUpdate();  // 성공 1이 반환, 1아니면 실패
		
		
		if (resultNum == 1) {
			out.println("회원 수정 성공!");
		} else {
			out.println("회원 수정 실패!");
		}
		
	} catch (Exception e) {
		out.println("DB 에러발생!! 회원 수정 실패!");
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
	
	<h2>회원 정보 수정 결과</h2>
	<hr>
	<%
		request.setCharacterEncoding("utf-8");
		
		String sql1 = "SELECT * FROM membertbl WHERE memberid=?"; 

		Connection conn1 = null;  
		PreparedStatement pstmt1 = null;  
		ResultSet rs = null;  //select문 실행 시 db에서 반환해주는 결과 레코드를 받아주는 자료 타입
		
		MemberDto memberDto = new MemberDto(); // 빈 memberDto 객체 생성
		
		try {
			Class.forName(driverName);
			conn1 = DriverManager.getConnection(url, username, password);
			pstmt1 = conn1.prepareStatement(sql1);
			
			pstmt1.setString(1, mid);  // SELECT ? 값으로 mid 설정 
			
			rs = pstmt1.executeQuery(); 
			
			//List<MemberDto> memberDtos = new ArrayList<MemberDto>();
			
			while(rs.next()) {
				String mid1 = rs.getString("memberid");
				String mpw1 = rs.getString("memberpw"); 
				String mname1 = rs.getString("membername");
				String memail1 = rs.getString("memberemail"); 
				int mage1 = rs.getInt("memberage");
				
				memberDto.setMemberid(mid1);
				memberDto.setMemberpw(mpw1);
				memberDto.setMembername(mname1);
				memberDto.setMemberemail(memail1);
				memberDto.setMemberage(mage1);
			}
			

		} catch (Exception e) {
			out.println("DB 에러발생!! 회원 조회 실패!");
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt1 != null) {
					pstmt1.close();
				}
				if (conn1 != null) {
					conn1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
	%>
	
	아이디 : <%= memberDto.getMemberid() %><br><br>
	비밀번호 : <%= memberDto.getMemberpw() %><br><br>
	이름 : <%= memberDto.getMembername() %><br><br>
	이메일 : <%= memberDto.getMemberemail() %><br><br>
	나이 : <%= memberDto.getMemberage() %><br><br>
</body>
</html>