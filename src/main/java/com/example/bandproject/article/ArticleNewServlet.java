package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/article/new")
public class ArticleNewServlet extends HttpServlet {

    // 글쓰기 폼
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/article/new.jsp").forward(req, resp);
    }

    // 등록 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String writerId = "guest";

        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);
        article.setWriterId(writerId);

        ArticleServlet.addArticle(article);

        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
