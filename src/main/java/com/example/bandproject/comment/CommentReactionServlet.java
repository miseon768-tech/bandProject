
package com.example.bandproject.comment;

import com.example.bandproject.model.ArticleLike;
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

@WebServlet("/comment/reaction")
public class CommentReactionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (logonUser == null || bandApproved == null || !bandApproved) {
            resp.sendRedirect(logonUser == null ? "/login" : "/community");
            return;
        }

        int articleNo = Integer.parseInt(req.getParameter("no"));

        String memberId = logonUser.getId();

        ArticleLike t = new ArticleLike();
        t.setArticleNo(articleNo);
        t.setMemberId(memberId);

        SqlSession sqlSession = MyBatisUtil.build().openSession(false);
        Comment found =
                sqlSession.selectOne("mappers.CommentMapper.selectLikedCommentsByMemberId", t);


        try {
            if (found != null) {
                sqlSession.delete("mappers.CommentMapper.deleteByNo", found.getNo());
                sqlSession.update("mappers.CommentMapper.decreaseLikeCnt", articleNo);
            } else {
                sqlSession.insert("mappers.CommentMapper.insertOne", t);
                sqlSession.update("mappers.CommentMapper.increaseLikeCnt", articleNo);
            }
            sqlSession.commit();
        } catch(Exception e) {
            System.out.println(e);
            sqlSession.rollback();
        }
        sqlSession.close();

        resp.sendRedirect("/band?no="+articleNo);

    }
}

