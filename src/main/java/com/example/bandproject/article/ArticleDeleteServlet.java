
package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;


@WebServlet("/article/delete")
public class ArticleDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int no = Integer.parseInt(req.getParameter("no"));


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        Member user = (Member)req.getSession().getAttribute("logonUser");

        Article article = sqlSession.selectOne("mappers.ArticleMapper.selectByNo", no);

        if(user != null && article != null && article.getWriterId().equals(user.getId())) {
            sqlSession.delete("mappers.ArticleLikeMapper.deleteByArticleNo", no);
            sqlSession.delete("mappers.ArticleMapper.deleteByNo", no);
        }
        resp.sendRedirect("/community");
    }
}
