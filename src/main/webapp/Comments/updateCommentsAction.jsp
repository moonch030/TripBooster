<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Comment</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");

        String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
        String user = "root";
        String password = "abcd1234";
        String update = "(수정됨)";

        String commentNum = request.getParameter("commentNum");
        String newComments = request.getParameter("comments");

        try {
            Class.forName("com.mysql.jdbc.Driver");

            Connection con = DriverManager.getConnection(url, user, password);
            con.setAutoCommit(false);

            String sql = "UPDATE commentsTbl SET comments = ? WHERE commentNum = ?";

            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setString(1, newComments + update);
            pstmt.setString(2, commentNum);

            pstmt.executeUpdate();
            con.commit();

            pstmt.close();
            con.close();

    %>
            <script>
                alert("수정 완료✈");
                location.href = document.referrer;
            </script>
    <%
        } catch(Exception e) {
            e.printStackTrace();
    %>
            <script>
                alert("수정 실패: <%= e.getMessage() %>");
                location.href = document.referrer;
            </script>
    <%
        }
    %>
</body>
</html>
