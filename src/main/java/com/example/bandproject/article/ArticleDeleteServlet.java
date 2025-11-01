
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
        /*else{
            글을 삭제할 권한이 없으면 페이지를 바꾸지 않고 알람창을 띄운다.
            req.getRequestDispatcher("/article/access-error.jsp").forward(req, resp);
            "권한이 없습니다"
        }*/
        resp.sendRedirect("/community");
        /*
        "글이 삭제되었습니다" 알람창을 띄우고 community로 이동
         */
    }
}
