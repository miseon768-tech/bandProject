package com.example.bandproject.comment;

import com.example.bandproject.model.Article;
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

@WebServlet("/comment/edit")
public class CommentEditServlet  extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (logonUser == null || bandApproved == null || !bandApproved) {
            resp.sendRedirect(logonUser == null ? "/login" : "/community");
            return;
        }


        int no = Integer.parseInt(req.getParameter("no"));
        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        Member user = (Member) req.getSession().getAttribute("logonUser");
        Comment comment = sqlSession.selectOne("mappers.CommentMapper.selectByNo", no);
        sqlSession.close();

        if (user != null && comment != null && comment.getWriterId().equals(user.getId())) {
            req.setAttribute("comment", comment);
            req.getRequestDispatcher("/comment/edit.jsp").forward(req, resp);
        }
    }

}