package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/article/list")
public class ArticleServlet extends HttpServlet {

    // 게시글을 메모리에 저장하는 리스트 (DB 없이 동작)
    private static final List<Article> articleList = new ArrayList<>();
    private static int nextId = 1;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String noParam = req.getParameter("no");

        // 상세보기
        if (noParam != null && !noParam.isBlank()) {
            int no = Integer.parseInt(noParam);
            Article found = getArticleByNo(no);

            if (found == null) {
                resp.getWriter().println("⚠ 게시글을 찾을 수 없습니다.");
                return;
            }

            req.setAttribute("article", found);
            req.getRequestDispatcher("/article/articleDetail.jsp").forward(req, resp);
            return;
        }

        // 목록 보기
        req.setAttribute("articles", articleList);
        req.getRequestDispatcher("/article/list.jsp").forward(req, resp);
    }

    // ✅ 새 글 추가
    public static void addArticle(Article article) {
        article.setNo(nextId++);
        articleList.add(article);
    }

    // ✅ 게시글 삭제
    public static void removeArticle(int no) {
        articleList.removeIf(a -> a.getNo() == no);
    }

    // ✅ 게시글 수정
    public static void updateArticle(Article updated) {
        for (int i = 0; i < articleList.size(); i++) {
            if (articleList.get(i).getNo() == updated.getNo()) {
                articleList.set(i, updated);
                break;
            }
        }
    }

    // ✅ 게시글 번호로 조회 (ArticleEdit, ArticleDelete 등에서 사용)
    public static Article getArticleByNo(int no) {
        return articleList.stream()
                .filter(a -> a.getNo() == no)
                .findFirst()
                .orElse(null);
    }
}
