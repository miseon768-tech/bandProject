
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

@WebServlet("/article/new")
public class ArticleNewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("logonUser") == null) {
            resp.sendRedirect("/login");
            return;
        }

        Member logonUser =(Member)req.getSession().getAttribute("logonUser");
        req.setAttribute("auth", true);
        req.setAttribute("logonUser", req.getSession().getAttribute("logonUser"));
        req.setAttribute("logonUserNickname", logonUser.getNickname());

        req.getRequestDispatcher("/article/new.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member)req.getSession().getAttribute("logonUser");

        String topic = req.getParameter("topic");
        String title = req.getParameter("title");
        String content = req.getParameter("content");


        Article article = new Article();
        article.setTopic(topic);
        article.setTitle(title);
        article.setContent(content);
        article.setWriterId(logonUser.getId());

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        int r = sqlSession.insert("mappers.ArticleMapper.insertOne", article);


        sqlSession.close();

        if(r == 1) {
            resp.sendRedirect("/community");
        }else {
            req.getRequestDispatcher("/article/new-fail.jsp").forward(req, resp);

        }




    }
}
