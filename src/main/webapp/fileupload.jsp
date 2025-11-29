<%--
  Created by IntelliJ IDEA.
  User: yooneerum
  Date: 25. 11. 24.
  Time: 오전 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
    제목 : <input type="text" name="title" />
    이미지 : <input type="file" name="filename1" />
  <input type="submit" value="upload" />
</form>
</body>
</html>
