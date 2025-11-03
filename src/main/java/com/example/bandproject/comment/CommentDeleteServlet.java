package com.example.bandproject.comment;

import com.example.bandproject.model.Comment;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/comment/delete")
public class CommentDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (logonUser == null || bandApproved == null || !bandApproved) {
            resp.sendRedirect(logonUser == null ? "/login" : "/community");
            return;
        }

        int commentNo = Integer.parseInt(req.getParameter("commentNo"));
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        int articleNo = Integer.parseInt(req.getParameter("articleNo"));

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        try {
            // 댓글 정보 조회해서 작성자 확인
            Comment comment = sqlSession.selectOne("mappers.CommentMapper.selectByNo", commentNo);
            if (comment == null) {
                req.getRequestDispatcher("/comment/delete.jsp").forward(req, resp);
                return;
            }
            if (!comment.getWriterId().equals(logonUser.getId())) {
                req.getRequestDispatcher("/comment/delete.jsp").forward(req, resp);
                return;
            }

            // 댓글 삭제
            sqlSession.delete("mappers.CommentMapper.deleteByNo", commentNo);
            /*// 댓글 카운트 감소(밴드, 글)
            sqlSession.update("mappers.BandMapper.decreaseCommentCnt", bandNo);
            sqlSession.update("mappers.ArticleMapper.decreaseCommentCnt", articleNo);*/

        } finally {
            sqlSession.close();
        }

        // 원래 게시글로 이동
        resp.sendRedirect("/band?no=" + bandNo + "&articleNo=" + articleNo);
    }
}