<%@ page import="org.example.jspcrud22.dao.BoardDAO" %>
<%@ page import="org.example.jspcrud22.bean.BoardVO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Detail</title>
  <script>
    function delete_ok(id){
      var a = confirm("정말로 삭제하겠습니까?");
      if(a) location.href='delete.jsp?id=' + id;
    }
  </script>
</head>
<body>

<%
  BoardDAO boardDAO = new BoardDAO();
  String id =request.getParameter("id");
  BoardVO u = boardDAO.getBoard(Integer.parseInt(id));

  request.setAttribute("u", u);

    try {
        boardDAO.viewCount(id);
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
%>

  <table>
    <tr><td>Title:</td><td>${u.getTitle()}</td></tr>
    <tr><td>Writer:</td><td>${u.getWriter()}</td></tr>
    <tr><td>Content:</td><td>${u.getContent()}</td></tr>
    <tr><td>File:</td><td><a href="download.jsp?filename=${u.getFilename()}">${u.getFilename()}</a></td></tr>
    <td><a href="edit.jsp?id=${u.getId()}">Edit</a></td>
    <td><a href="javascript:delete_ok('${u.getId()}')">Delete</a></td>
    <td><a href="posts.jsp">Back to lists</a></td>
  </table>

</body>
</html>