<%@ page import="org.example.jspcrud22.dao.BoardDAO" %>
<%@ page import="org.example.jspcrud22.bean.BoardVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>자유게시판</title>
    <style>
        #list {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        #list td, #list th {
            border: 1px solid #ddd;
            padding: 8px;
            text-align:center;
        }
        #list tr:nth-child(even){background-color: #f2f2f2;}
        #list tr:hover {background-color: #ddd;}
        #list th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: #006bb3;
            color: white;
        }
    </style>
    <script>
        function delete_ok(id){
            var a = confirm("정말로 삭제하겠습니까?");
            if(a) location.href='delete.jsp?id=' + id;
        }
    </script>
</head>
<body>
<h1>자유게시판</h1>
<form action="posts.jsp" method="get">
    <label>검색 : </label>
    <input type="text" name="keyword" placeholder="Content...">
    <input type="submit" value="검색">
</form>

<%
    String sort = request.getParameter("sort");
    String order = request.getParameter("order");
    String keyword = request.getParameter("keyword");

    if(sort == null) sort = "id";
    if(order == null) order = "asc";
    if(keyword == null) keyword = "";

    BoardDAO boardDAO = new BoardDAO();
    List<BoardVO> list = boardDAO.getBoardList(sort, order, keyword);
    request.setAttribute("list",list);
%>
<table id="list" width="90%">
    <tr>
        <th>Id</th>
        <th><button onclick="location.href='posts.jsp?sort=writer&order=asc'">▲</button>
            <button onclick="location.href='posts.jsp?sort=writer&order=desc'">▼</button>
            Writer
        </th>
        <th>
            <button onclick="location.href='posts.jsp?sort=title&order=asc'">▲</button>
            <button onclick="location.href='posts.jsp?sort=title&order=desc'">▼</button>
            Title
        </th>
        <th>
            <button onclick="location.href='posts.jsp?sort=filename&order=asc'">▲</button>
            <button onclick="location.href='posts.jsp?sort=filename&order=desc'">▼</button>
            File
        </th>
        <th>
            <button onclick="location.href='posts.jsp?sort=regdate&order=asc'">▲</button>
            <button onclick="location.href='posts.jsp?sort=regdate&order=desc'">▼</button>
            Regdate
        </th>
        <th>
            <button onclick="location.href='posts.jsp?sort=cnt&order=asc'">▲</button>
            <button onclick="location.href='posts.jsp?sort=cnt&order=desc'">▼</button>
            Views
        </th>
        <th>Delete</th>
    </tr>
    <c:forEach items="${list}" var="u" varStatus="st">
        <tr>
            <td>${st.index + 1}</td>
            <td>${u.getWriter()}</td>
            <td><a href="view.jsp?id=${u.getId()}">${u.getTitle()}</a></td>
            <td><a href="download.jsp?filename=${u.getFilename()}">${u.getFilename()}</a></td>
            <td>${u.getRegdate()}</td>
            <td>${u.getCnt()}</td>
            <td><a href="javascript:delete_ok('${u.getId()}')">Delete</a></td>
        </tr>
    </c:forEach>
</table>
<br/><a href="write.jsp">Add New Post</a>
</body>
</html>