package com.example.bandproject.community;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.BandMember;
import com.example.bandproject.model.WriteCounter;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@WebServlet("/community")
public class CommunityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("logonUser") != null)
            req.setAttribute("auth", true);
        else
            req.setAttribute("auth", false);




        String bandNoStr = req.getParameter("bandNo");
        if (bandNoStr != null) {
            int bandNo = Integer.parseInt(bandNoStr);

            try(SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
                req.setAttribute("band", sqlSession.selectOne("mappers.BandMapper.selectByNo", bandNo));
                // 승인 대기자 목록 조회
                List<BandMember> pendingMembers
                        = sqlSession.selectList("mappers.BandMemberMapper.selectPendingMembers", bandNo);

                req.setAttribute("pendingMembers", pendingMembers);
                req.setAttribute("band", sqlSession.selectOne("mappers.BandMapper.selectByNo", bandNo));
                int page = req.getParameter("page") != null ? Integer.parseInt(req.getParameter("page")) : 1;
                String keyword = req.getParameter("keyword") != null ? req.getParameter("keyword") : "";



                // 전체 글 목록
                List<Article> articleList = sqlSession.selectList("mappers.ArticleMapper.selectAll",bandNo );
                req.setAttribute("articleList", articleList);

                req.setAttribute("keyword", keyword);
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        req.getRequestDispatcher("/community/community.jsp").forward(req, resp);
    }

}

