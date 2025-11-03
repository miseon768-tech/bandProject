package com.example.bandproject.article;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.Comment;
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
import java.util.Map;

@WebServlet("/article")
public class ArticleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Boolean bandApproved = (Boolean) req.getAttribute("bandApproved");
        if(bandApproved == null || !bandApproved) {
            resp.sendRedirect("/community");
            return;
        }

        String no = req.getParameter("no");
        if (no == null || !no.matches("\\d+")) {
            resp.sendRedirect("/community");
            return;
        }

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        sqlSession.update("mappers.ArticleMapper.updateViewCnt", Integer.parseInt(no));
        Article found = sqlSession.selectOne("mappers.ArticleMapper.selectByNo", Integer.parseInt(no));
        if (found == null) {
            resp.sendRedirect("/community");
            return;
        }

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");

        if(logonUser == null) {
            req.setAttribute("alreadyLike", false);
        }else {
            Map<String, Object> map = Map.of("bandMemberId", logonUser.getId(), "articleNo", no);
            int cnt = sqlSession.selectOne("mappers.ArticleLikeMapper.countByMemberIdAndArticleNo", map);
            req.setAttribute("alreadyLike", cnt == 1);
        }

        if(logonUser == null || !found.getWriterId().equals(logonUser.getId()) ) {
            req.setAttribute("owner", false);
        }else {
            req.setAttribute("owner", true);
        }

        List<Comment> comments
                =sqlSession.selectList("mappers.CommentMapper.selectByArticleNo", Integer.parseInt(no));
        req.setAttribute("comments", comments);

        sqlSession.close();

        req.setAttribute("auth", req.getSession().getAttribute("logonUser") != null);
        req.setAttribute("article", found);

        req.getRequestDispatcher("/article.jsp").forward(req, resp);
    }
}