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

@WebServlet("/comment/new")
public class CommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String content = req.getParameter("content");
        String writerId = logonUser.getId();

        /*boolean isBandMember = false;
        try (SqlSession sqlSession = MyBatisUtil.build().openSession()) {
            // 승인된 멤버인지 확인
            int count = sqlSession.selectOne("mappers.BandMapper.checkApprovedMember",
                    new BandMemberCheckParam(bandNo, logonUser.getId()));
            isBandMember = count > 0;
        }
        if (!isBandMember) {
            resp.sendRedirect("/error?msg=승인된 밴드 멤버만 코멘트를 작성할 수 있습니다.");
            return;
        }*/


        Comment comment = new Comment();
        comment.setWriterId(writerId);
        comment.setContent(content);
        comment.setBandNo(bandNo);
        comment.setArticleNo(articleNo);

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        int r = sqlSession.insert("mappers.CommentMapper.insertOne", comment);
        sqlSession.update("mappers.BandMapper.increaseCommentCnt", bandNo);
        sqlSession.update("mappers.ArticleMapper.increaseCommentCnt", articleNo);

        sqlSession.close();


        resp.sendRedirect("/band?no=" + bandNo + "&articleNo=" + articleNo);
    }
}

