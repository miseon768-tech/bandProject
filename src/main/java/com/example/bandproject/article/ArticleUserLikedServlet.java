package com.example.bandproject.article;



import com.example.bandproject.model.LikedArticle;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/article/likeduser")
public class ArticleUserLikedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (logonUser == null || bandApproved == null || !bandApproved) {
            resp.sendRedirect(logonUser == null ? "/login" : "/community");
            return;
        }

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        List<LikedArticle> likedArticleList =
                sqlSession.selectList("mappers.ArticleLikeMapper.selectLikedArticlesByMemberId", logonUser.getId());


        req.setAttribute("likedArticleList", likedArticleList);
        req.getRequestDispatcher("/user/liked.jsp").forward(req, resp);
    }
}
