package com.example.bandproject.comment;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.BandMember;
import com.example.bandproject.model.Comment;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/comment/delete")
public class CommentDeleteServlet  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int no = Integer.parseInt(req.getParameter("no"));

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        BandMember user = (BandMember) req.getSession().getAttribute("logonUser");

        Comment comment = sqlSession.selectOne("mappers.CommentMapper.selectByArticleNo", no);

        if(user != null && comment != null && comment.getWriterId().equals(user.getId())) {
            sqlSession.delete("mappers.CommentMapper.deleteByNo", no);
        }
        resp.sendRedirect("/article/list");
    }
}
