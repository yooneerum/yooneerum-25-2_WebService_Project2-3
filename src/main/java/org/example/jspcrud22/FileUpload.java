package org.example.jspcrud22;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.example.jspcrud22.bean.BoardVO;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUpload {

    public static BoardVO uploadFile(HttpServletRequest request) throws IOException {

        BoardVO vo = new BoardVO();

        int sizeLimit = 15 * 1024 * 1024;
        String realPath = request.getServletContext().getRealPath("upload");

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        MultipartRequest multipartRequest = null;
        multipartRequest = new MultipartRequest(request, realPath, sizeLimit, "utf-8",new DefaultFileRenamePolicy());

        String idStr = multipartRequest.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            vo.setId(Integer.parseInt(idStr));
        }
        vo.setTitle(multipartRequest.getParameter("title"));
        vo.setWriter(multipartRequest.getParameter("writer"));
        vo.setContent(multipartRequest.getParameter("content"));

        String filename = multipartRequest.getFilesystemName("filename1");
        vo.setFilename(filename);

        return vo;
    }
}
