<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.example.jspcrud22.bean.BoardVO,org.example.jspcrud22.dao.BoardDAO" %>
<%@ page import="org.example.jspcrud22.FileUpload" %>
<%@ page import="java.io.File" %>
<%
    String sid = request.getParameter("id");
    BoardDAO boardDAO = new BoardDAO();

    BoardVO vo = boardDAO.getBoard(Integer.parseInt(sid));
    String filename = vo.getFilename();

    boardDAO.deleteBoard(vo);

    if (filename!=null && !filename.trim().isEmpty()){
        String savePath = "./upload";
        String realPath = application.getRealPath(savePath);

        File file = new File(realPath + "/" + filename);

        if (file.exists()) {
            file.delete();
        }
    }
%>
<script>
    alert("삭제 완료!");
    location.href = "posts.jsp";
</script>