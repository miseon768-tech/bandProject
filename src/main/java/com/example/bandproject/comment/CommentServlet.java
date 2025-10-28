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
        Member logonUser = (Member)req.getSession().getAttribute("logonUser");
        int articleNo= Integer.parseInt(req.getParameter("articleNo"));
        String content = req.getParameter("content");
        String writerId = logonUser.getId();

        Comment comment = new Comment();
        comment.setArticleNo(articleNo);
        comment.setContent(content);
        comment.setWriterId(writerId);

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        int r = sqlSession.insert("mappers.CommentMapper.insertOne", comment);

        resp.sendRedirect("/article?no="+articleNo);
    }
}

