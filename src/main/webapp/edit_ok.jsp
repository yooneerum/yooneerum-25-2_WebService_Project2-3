
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.jspcrud22.dao.BoardDAO" %>
<%@ page import="org.example.jspcrud22.bean.BoardVO" %>
<%@ page import="org.example.jspcrud22.FileUpload" %>
<%@ page import="java.io.File" %>

<%
    FileUpload fileUpload = new FileUpload();
    BoardVO vo = fileUpload.uploadFile(request);

    int sid = vo.getId();

    Boolean isNewfile = true;

    BoardDAO boardDAO = new BoardDAO();
    BoardVO oldVo = boardDAO.getBoard(sid);
    String oldFilename = oldVo.getFilename();

    if (vo.getFilename() == null || vo.getFilename().trim().isEmpty()) {
        isNewfile = false;
        vo.setFilename(oldFilename);
    }

    int i=boardDAO.updateBoard(vo);

    if (isNewfile && !vo.getFilename().trim().isEmpty()) {
        if (oldFilename != null && !oldFilename.trim().isEmpty()) {
            String savePath = "./upload";
            String realPath = application.getRealPath(savePath);

            File file = new File(realPath + "/" + oldFilename);

            if (file.exists()) {
                file.delete();
            }
        }
    }

    String msg = "데이터 수정 성공";
    if(i==0) msg = "에러_데이터 수정";
%>

<script>
    alert('<%=msg%>');
    location.href = 'posts.jsp';
</script>