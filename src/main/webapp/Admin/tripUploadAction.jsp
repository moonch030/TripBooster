<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Upload and Insert</title>
</head>
<body>
<%
	String path = "D:/TripBooster/TripBooster/src/main/webapp/resources/images";

    int size = 1024 * 1024 * 10;
    String file = "";

    try {
        MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
        Enumeration files = multi.getFileNames();
        String str = (String) files.nextElement();
        
        file = multi.getFilesystemName(str);
        
        String tripCode = multi.getParameter("tripCode");
        String tripSort = multi.getParameter("tripSort");
        String tripName = multi.getParameter("tripName");
        String tripLoca = multi.getParameter("tripLoca");
        String tripPerson = multi.getParameter("tripPerson");
        String tripParking = multi.getParameter("tripParking");
        String tripContent = multi.getParameter("tripContent");
        String tripTel = multi.getParameter("tripTel");
        
        if (tripSort == null || tripSort.isEmpty()) {
            tripSort = "0";
        }
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false";
            String user = "root";
            String password = "abcd1234";

            Connection con = DriverManager.getConnection(url, user, password);
            con.setAutoCommit(false);

            String sql = "INSERT INTO triptbl(tripCode, tripSort, tripName, tripLoca, tripImg, tripPerson, tripParking, tripContent, tripTel) VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setString(1, tripCode);
            pstmt.setString(2, tripSort);
            pstmt.setString(3, tripName);
            pstmt.setString(4, tripLoca);
            pstmt.setString(5, file);
            pstmt.setString(6, tripPerson);
            pstmt.setString(7, tripParking);
            pstmt.setString(8, tripContent);
            pstmt.setString(9, tripTel);

            pstmt.executeUpdate();

            con.commit();

            pstmt.close();
            con.close();

            %>
            <script>
                alert("추가 완료✈");
                location.href="../index.jsp";
            </script>
            <%
        } catch (Exception e) {
            e.printStackTrace();
            %>
            <script>
                alert("오류가 발생했습니다.");
                history.back();
            </script>
            <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
