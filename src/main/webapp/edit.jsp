<%@ page import="org.example.jspcrud22.dao.BoardDAO" %>
<%@ page import="org.example.jspcrud22.bean.BoardVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Form</title>
</head>
<body>

<%
  BoardDAO boardDAO = new BoardDAO();
  String id=request.getParameter("id");
  BoardVO u=boardDAO.getBoard(Integer.parseInt(id));
%>

<h1>Edit Form</h1>
<form action="edit_ok.jsp" method="post" enctype="multipart/form-data">
  <input type="hidden" name="id" value="<%=u.getId() %>"/>
  <table>
    <tr><td>Title:</td><td><input type="text" name="title" value="<%= u.getTitle()%>"/></td></tr>
    <tr><td>Writer:</td><td><input type="text" name="writer" value="<%= u.getWriter()%>" /></td></tr>
    <tr><td>Content:</td><td><textarea cols="50" rows="5" name="content"><%= u.getContent()%></textarea></td></tr>
    <tr><td>File:</td><td><input type="file" name="filename1" /></td></tr>
    <tr><td colspan="2"><input type="submit" value="Edit Post"/>
      <input type="button" value="Cancel" onclick="history.back()"/></td></tr>
  </table>
</form>

</body>
</html>