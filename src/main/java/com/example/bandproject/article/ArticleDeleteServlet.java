package com.example.bandproject.article;

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

@WebServlet("/article/delete")
public class ArticleDeleteServlet extends HttpServlet {

    private SqlSessionFactory sqlSessionFactory;

    @Override
    public void init() throws ServletException {
        try (Reader reader = Resources.getResourceAsReader("mappers/mybatis-config.xml")) {
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            throw new ServletException("MyBatis 초기화 실패", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int no = Integer.parseInt(req.getParameter("no"));

        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            session.delete("mappers.ArticleMapper.deleteOne", no);
        }
        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
