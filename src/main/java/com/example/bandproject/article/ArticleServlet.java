package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/article/list")
public class ArticleServlet extends HttpServlet {
    private final ArticleService service = new ArticleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String no = req.getParameter("no");
        if (no != null) {
            // 상세보기
            int articleNo = Integer.parseInt(no);
            Article article = service.getArticle(articleNo);
            req.setAttribute("article", article);
            req.getRequestDispatcher("/webapp/article/articleDetail.jsp").forward(req, resp);
        } else {
            // 목록
            List<Article> list = service.getAllArticles();
            req.setAttribute("articles", list);
            req.getRequestDispatcher("/webapp/article/article.jsp").forward(req, resp);
        }
    }

    static class ArticleService {
        public Article getArticle(int articleNo) {
            Article o = null;
            Article o1 = o;
            return o1;
        }

        public List<Article> getAllArticles() {
            return List.of();
        }

        public void insertArticle(Article article) {
        }

        public void updateArticle(Article article) {

        }

        public void deleteArticle(int no) {
        }
    }
}
