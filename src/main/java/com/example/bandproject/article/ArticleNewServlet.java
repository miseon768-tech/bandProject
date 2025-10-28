package com.example.bandproject.article;

import com.example.bandproject.article.ArticleServlet;
import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.bandproject.article.ArticleServlet.*;

@WebServlet("/article/new")
public class ArticleNewServlet extends HttpServlet {
    private final ArticleService service = new ArticleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/webapp/article/articlenew.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String writerId = (String) req.getSession().getAttribute("loginId");

        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);
        article.setWriterId(writerId);

        service.insertArticle(article);
        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
