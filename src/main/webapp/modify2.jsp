<%@page import="com.jbedu.member.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
	<h2>회원 정보 수정</h2>
	<hr>
	<%
		request.setCharacterEncoding("utf-8");
		
		String modifyid = request.getParameter("mid");
		String sql = "SELECT * FROM membertbl WHERE memberid=?"; 
		
		String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jbedu"; //MySQL이 설치된 주소와 연결할 DB(스키마) 이름
		String username = "root"; //계정 이름 -> 관리자 계정 이름
		String password = "12345"; //계정 비밀번호 -> 관리자 계정 비밀번호

		Connection conn = null;  
		PreparedStatement pstmt = null;  
		ResultSet rs = null;  //select문 실행 시 db에서 반환해주는 결과 레코드를 받아주는 자료 타입
		
		MemberDto memberDto = new MemberDto(); // 빈 memberDto 객체 생성
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, modifyid);  // SELECT ? 값으로 mid 설정 
			
			rs = pstmt.executeQuery(); 
			
			//List<MemberDto> memberDtos = new ArrayList<MemberDto>();
			
			while(rs.next()) {
				String mid = rs.getString("memberid");
				String mpw = rs.getString("memberpw"); 
				String mname = rs.getString("membername");
				String memail = rs.getString("memberemail"); 
				int mage = rs.getInt("memberage");
				
				memberDto.setMemberid(mid);
				memberDto.setMemberpw(mpw);
				memberDto.setMembername(mname);
				memberDto.setMemberemail(memail);
				memberDto.setMemberage(mage);
			}
			

		} catch (Exception e) {
			out.println("DB 에러발생!! 회원 조회 실패!");
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
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
	
<%-- 	아이디 : <%= memberDto.getMemberid() %><br><br> --%>
<%-- 	비밀번호 : <%= memberDto.getMemberpw() %><br><br> --%>
<%-- 	이름 : <%= memberDto.getMembername() %><br><br> --%>
<%-- 	이메일 : <%= memberDto.getMemberemail() %><br><br> --%>
<%-- 	나이 : <%= memberDto.getMemberage() %><br><br> --%>
	
	<form action="modifyOk.jsp">
<!-- disabled 하면 값이 가지 않음 -->
		<input type="hidden" name="mid" value="<%= memberDto.getMemberid() %>">
		아이디 : <input type="text" value="<%= memberDto.getMemberid() %>" disabled="disabled"><br><br>
		비밀번호 : <input type="password" name="mpw" value="<%= memberDto.getMemberpw() %>"><br><br>
		이름 : <input type="text" name="mname" value="<%= memberDto.getMembername() %>"><br><br>
		이메일 : <input type="text" name="memail" value="<%= memberDto.getMemberemail() %>"><br><br>
		나이 : <input type="text" name="mage" value="<%= memberDto.getMemberage() %>"><br><br>
		<input type="submit" value="회원수정">
	</form>

</body>
</html>