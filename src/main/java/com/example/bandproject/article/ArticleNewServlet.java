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

@WebServlet("/article/new")
public class ArticleNewServlet extends HttpServlet {

    private SqlSessionFactory sqlSessionFactory;

    @Override
    public void init() throws ServletException {
        try (Reader reader = Resources.getResourceAsReader("mappers/mybatis-config.xml")) {
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            throw new ServletException("MyBatis 초기화 실패", e);
        }
    }

    // 글쓰기 폼
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/article/articlenew.jsp").forward(req, resp);
    }

    // 등록 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String topic = req.getParameter("topic"); // 선택값
        String writerId = (String) req.getSession().getAttribute("loginId");
        if (writerId == null || writerId.isBlank()) writerId = "guest";

        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);
        article.setTopic(topic);
        article.setWriterId(writerId);

        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            session.insert("mappers.ArticleMapper.insertOne", article);
        }
        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
