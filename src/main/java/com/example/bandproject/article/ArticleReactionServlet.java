
package com.example.bandproject.article;

import com.example.bandproject.model.ArticleLike;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/article/reaction")
public class ArticleReactionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if (bandApproved == null || !bandApproved) {
            resp.sendRedirect("/community");
            return;
        }
        int articleNo = Integer.parseInt(req.getParameter("no"));

        String memberId = logonUser.getId();

        ArticleLike t = new ArticleLike();
        t.setArticleNo(articleNo);
        t.setMemberId(memberId);

        SqlSession sqlSession = MyBatisUtil.build().openSession(false);
        ArticleLike found =
                sqlSession.selectOne("mappers.ArticleLikeMapper.selectByMemberIdAndArticleNo", t);


        try {
            if (found != null) {
                // sqlSession.delete("mappers.ArticleLikeMapper.deleteByMemberIdAndArticleNo", t);
                sqlSession.delete("mappers.ArticleLikeMapper.deleteByIdx", found.getIdx());
                sqlSession.update("mappers.ArticleMapper.decreaseLikeCnt", articleNo);
            } else {
                sqlSession.insert("mappers.ArticleLikeMapper.insertOne", t);
                sqlSession.update("mappers.ArticleMapper.increaseLikeCnt", articleNo);
            }
            sqlSession.commit();
        } catch(Exception e) {
            System.out.println(e);
            sqlSession.rollback();
        }
        sqlSession.close();

        resp.sendRedirect("/community?no="+articleNo);

    }
}

