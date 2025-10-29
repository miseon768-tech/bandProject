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

@WebServlet("/article/edit")
public class ArticleEditServlet extends HttpServlet {

    private SqlSessionFactory sqlSessionFactory;

    @Override
    public void init() throws ServletException {
        try (Reader reader = Resources.getResourceAsReader("mappers/mybatis-config.xml")) {
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            throw new ServletException("MyBatis 초기화 실패", e);
        }
    }

    // 수정 폼
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int no = Integer.parseInt(req.getParameter("no"));
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            Article article = session.selectOne("mappers.ArticleMapper.selectByNo", no);
            req.setAttribute("article", article);
        }
        // ✅ /webapp 쓰지 않음(컨텍스트 기준)
        req.getRequestDispatcher("/article/articleEdit.jsp").forward(req, resp);
    }

    // 수정 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        int no = Integer.parseInt(req.getParameter("no"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String topic = req.getParameter("topic"); // 선택값(없으면 null)

        Article article = new Article();
        article.setNo(no);
        article.setTitle(title);
        article.setContent(content);
        article.setTopic(topic);

        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            session.update("mappers.ArticleMapper.updateOne", article);
        }
        resp.sendRedirect(req.getContextPath() + "/article/list?no=" + no);
    }
}
