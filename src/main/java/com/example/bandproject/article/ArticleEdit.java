package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/article/edit")
public class ArticleEdit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int no = Integer.parseInt(req.getParameter("no"));

        // ✅ ArticleServlet의 게시글 찾기 메서드 사용
        Article article = ArticleServlet.getArticleByNo(no);

        if (article == null) {
            resp.getWriter().println("⚠ 게시글을 찾을 수 없습니다.");
            return;
        }

        req.setAttribute("article", article);
        req.getRequestDispatcher("/article/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int no = Integer.parseInt(req.getParameter("no"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // 수정된 내용으로 새 객체 생성
        Article updated = new Article();
        updated.setNo(no);
        updated.setTitle(title);
        updated.setContent(content);
        updated.setWriterId("guest");

        // ✅ ArticleServlet을 통해 수정 반영
        ArticleServlet.updateArticle(updated);

        resp.sendRedirect(req.getContextPath() + "/article/list?no=" + no);
    }
}
