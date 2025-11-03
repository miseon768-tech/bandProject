package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/article/edit")
public class ArticleEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (bandApproved == null || !bandApproved) {
            resp.sendRedirect("/community");
            return;
        }

        int no = Integer.parseInt(req.getParameter("no"));
        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        Article article = sqlSession.selectOne("mappers.ArticleMapper.selectByNo", no);
        sqlSession.close();

        if(logonUser != null && article != null && article.getWriterId().equals(logonUser.getId())) {
            req.setAttribute("article", article);
            req.getRequestDispatcher("/article/edit.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/article?no=" + no);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (bandApproved == null || !bandApproved) {
            resp.sendRedirect("/community");
            return;
        }

        int no = Integer.parseInt(req.getParameter("no"));
        String title = req.getParameter("title");
        String topic = req.getParameter("topic");
        String content = req.getParameter("content");

        Article one= new Article();
        one.setNo(no);
        one.setTopic(topic);
        one.setTitle(title);
        one.setContent(content);

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        int r = sqlSession.update("mappers.ArticleMapper.updateOne", one);
        sqlSession.close();

        resp.sendRedirect("/article?no="+no);
    }
}
