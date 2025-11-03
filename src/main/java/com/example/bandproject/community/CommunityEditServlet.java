package com.example.bandproject.community;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.Member;
import com.example.bandproject.model.BandMember;
import com.example.bandproject.model.Band;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import java.io.IOException;

@WebServlet("/community/edit")
public class CommunityEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int articleNo = Integer.parseInt(req.getParameter("no"));
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        Member member = (Member) req.getSession().getAttribute("logonUser");

        Article article = sqlSession.selectOne("mappers.ArticleMapper.selectByNo");
        Band band = sqlSession.selectOne("mappers.BandMapper.selectByNo");
        BandMember bandMember = sqlSession.selectOne("mappers.BandMemberMapper.selectByBandNo");

        sqlSession.close();

        boolean master = member != null && "MASTER".equals(bandMember.getRole());

        if (master && article != null && article.getWriterId().equals(member.getId())) {
            req.setAttribute("band", band);
            req.setAttribute("article", article);
            req.getRequestDispatcher("/community/edit.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/community/edit-fail.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member user = (Member)req.getSession().getAttribute("logonUser");
        BandMember bandMember = (BandMember) req.getSession().getAttribute("logonUser");
        boolean master = user != null && "MASTER".equals(bandMember.getRole());

        int no = Integer.parseInt(req.getParameter("no"));
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        String title = req.getParameter("title");
        String topic = req.getParameter("topic");
        String content = req.getParameter("content");

        if(!master) {
            req.getRequestDispatcher("/community/edit-fail.jsp").forward(req, resp);
            return;
        }
        Article one = new Article();
        one.setNo(no);
        one.setBandNo(bandNo);
        one.setTopic(topic);
        one.setTitle(title);
        one.setContent(content);

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        int r = sqlSession.update("mappers.BandMapper.updateOne", one);
        sqlSession.close();

        resp.sendRedirect("/community?bandNo=" + bandNo);
    }
}
