package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

/**
 * 목록 & 상세 전용 서블릿 (MyBatis 직접 초기화)
 * JSP: /article/article.jsp, /article/articleDetail.jsp
 * URL:
 *   - GET /article/list
 *   - GET /article/list?no={번호}
 */
@WebServlet("/article/list")
public class ArticleServlet extends HttpServlet {

    private SqlSessionFactory sqlSessionFactory;

    @Override
    public void init() throws ServletException {
        // ✅ MyBatis 초기화 (서블릿 시작 시 1회 실행)
        try {
            Reader reader = Resources.getResourceAsReader("mappers/mybatis-config.xml");
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            throw new ServletException("MyBatis 설정 파일 로드 실패", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String noParam = req.getParameter("no");

        // ── 상세보기 ─────────────────────────────────────────────
        if (noParam != null && !noParam.isBlank()) {
            int articleNo;
            try {
                articleNo = Integer.parseInt(noParam);
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 글 번호입니다.");
                return;
            }

            try (SqlSession session = sqlSessionFactory.openSession(true)) {
                session.update("mappers.ArticleMapper.increaseViewCnt", articleNo);
                Article article = session.selectOne("mappers.ArticleMapper.selectByNo", articleNo);

                if (article == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "게시글을 찾을 수 없습니다.");
                    return;
                }

                req.setAttribute("article", article);
                req.getRequestDispatcher("/article/articleDetail.jsp").forward(req, resp);
            }
            return;
        }

        // ── 목록보기 ─────────────────────────────────────────────
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            List<Article> list = session.selectList("mappers.ArticleMapper.selectAll");
            req.setAttribute("articles", list);
            req.getRequestDispatcher("/article/article.jsp").forward(req, resp);
        }
    }
}
