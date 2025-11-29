package org.example.jspcrud22.dao;

import org.example.jspcrud22.bean.BoardVO;
import org.example.jspcrud22.common.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    private final String BOARD_INSERT = "insert into BOARD (title, writer, content, filename) values(?,?,?,?)";
    private final String BOARD_UPDATE = "update BOARD set title = ?, writer = ?, content = ?, filename = ? where id = ?";
    private final String BOARD_DELETE = "delete from BOARD where id = ?";
    private final String BOARD_GET = "select * from BOARD where id = ?";

    public int insertBoard(BoardVO vo) {
        System.out.println("===> JDBC로 insertBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_INSERT);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setString(4, vo.getFilename());
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updateBoard(BoardVO vo) {
        System.out.println("===> JDBC로 updateBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_UPDATE);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setString(4, vo.getFilename());
            stmt.setInt(5, vo.getId());

            System.out.println(vo.getTitle() + "-" + vo.getWriter() + "-" + vo.getContent() + "-" + vo.getFilename() + "-" + vo.getId());
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void deleteBoard(BoardVO vo) {
        System.out.println("===> JDBC로 deleteBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_DELETE);
            stmt.setInt(1, vo.getId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void viewCount(String viewId) throws SQLException, ClassNotFoundException {
        int id = Integer.parseInt(viewId);

        String sql = "update BOARD set cnt = cnt + 1 where id = ?";
        conn = JDBCUtil.getConnection();
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public BoardVO getBoard(int seq) {
        BoardVO one = new BoardVO();
        System.out.println("===> JDBC로 getBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_GET);
            stmt.setInt(1, seq);
            rs = stmt.executeQuery();
            if(rs.next()) {
                one.setId(rs.getInt("id"));
                one.setTitle(rs.getString("title"));
                one.setWriter(rs.getString("writer"));
                one.setContent(rs.getString("content"));
                one.setFilename(rs.getString("filename"));
                one.setRegdate(rs.getDate("regdate"));
                one.setCnt(rs.getInt("cnt"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return one;
    }

    public List<BoardVO> getBoardList(String sort, String order, String keyword){
        List<BoardVO> list = new ArrayList<BoardVO>();

        List<String> allow = List.of("id", "title", "writer", "content", "filename", "regdate", "cnt");
        if (!allow.contains(sort)) sort = "id";
        if (!order.equalsIgnoreCase("asc")) order = "desc";

        String sql = "select * from BOARD " +
                "where title like ? or writer like ?" +
                "order by " + sort + " " + order;

        System.out.println("===> JDBC로 getBoardList() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%"+keyword+"%");
            stmt.setString(2, "%"+keyword+"%");
            rs = stmt.executeQuery();

            while(rs.next()) {
                BoardVO one = new BoardVO();
                one.setId(rs.getInt("id"));
                one.setTitle(rs.getString("title"));
                one.setWriter(rs.getString("writer"));
                one.setContent(rs.getString("content"));
                one.setFilename(rs.getString("filename"));
                one.setRegdate(rs.getDate("regdate"));
                one.setCnt(rs.getInt("cnt"));
                list.add(one);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

//    public static void main(String[] args){
//        BoardVO vo = new BoardVO("글 제목", "Sally", "글 내용");
//        BoardDAO boardDAO = new BoardDAO();
//        int result = boardDAO.insertBoard(vo);
//        if(result == 1){
//            System.out.println("데이터 추가 완료");
//        }
//    }
}
