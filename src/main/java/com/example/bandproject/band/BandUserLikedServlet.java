package com.example.bandproject.band;



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

@WebServlet("/band/user-liked")
public class BandUserLikedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser =(Member)req.getSession().getAttribute("logonUser");
        if(logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }
        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        List<LikedArticle> likedArticleList =
                sqlSession.selectList("mappers.BandLikeMapper.selectLikedBandsByMemberId", logonUser.getId());


        req.setAttribute("likedBandList", likedArticleList);
        req.getRequestDispatcher("/band/user-liked.jsp").forward(req, resp);
    }
}
