
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcrud22.dao.BoardDAO" %>
<%@ page import="org.example.jspcrud22.FileUpload" %>
<%@ page import="org.example.jspcrud22.bean.BoardVO" %>

<%
    FileUpload fileUpload = new FileUpload();
    BoardVO vo = fileUpload.uploadFile(request);

    BoardDAO boardDAO = new BoardDAO();
    int i = boardDAO.insertBoard(vo);

    String msg = "데이터 추가 성공";
    if(i==0) msg = "에러_데이터 추가";
%>

<script>
    alert('<%=msg%>');
    location.href = 'posts.jsp';
</script>