package com.example.bandproject.article;

import com.example.bandproject.article.ArticleServlet;
import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/article/edit")
public class ArticleEdit extends HttpServlet {
    private final ArticleServlet.ArticleService service = new ArticleServlet.ArticleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int no = Integer.parseInt(req.getParameter("no"));
        Article article = service.getArticle(no);
        req.setAttribute("article", article);
        req.getRequestDispatcher("/webapp/article/articleEdit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int no = Integer.parseInt(req.getParameter("no"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Article article = new Article();
        article.setNo(no);
        article.setTitle(title);
        article.setContent(content);

        service.updateArticle(article);
        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
