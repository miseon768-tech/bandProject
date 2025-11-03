
package com.example.bandproject.community;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.BandMember;
import com.example.bandproject.model.Member;
import com.example.bandproject.model.Band;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@WebServlet("/community/delete")
public class CommunityDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Boolean approved = (Boolean) req.getAttribute("bandApproved");
        String role = (String) req.getAttribute("bandRole");

        if (approved == null || !approved || !"MASTER".equals(role)) {
            req.getRequestDispatcher("/community/edit-fail.jsp").forward(req, resp);
            return;
        }

        int articleNo = Integer.parseInt(req.getParameter("no"));
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));

        Member member = (Member) req.getSession().getAttribute("logonUser");
        if (member == null) {
            resp.sendRedirect("/login");
            return;
        }

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        Article article = sqlSession.selectOne("mappers.ArticleMapper.selectByNo");
        Band band = sqlSession.selectOne("mappers.BandMapper.selectByNo");

        // 밴드 내에서 마스터인지 확인: memberNo와 bandNo로 BandMember 조회
        Map<String, Object> cond = new HashMap<>();
        cond.put("memberNo", member.getNo());
        cond.put("bandNo", bandNo);

        BandMember bandMember = sqlSession.selectOne("mappers.BandMemberMapper.selectByMemberAndBand");

        sqlSession.close();

        boolean master = member != null && "MASTER".equals(bandMember.getRole());

        if (master && article != null && article.getWriterId().equals(member.getId())) {
            req.setAttribute("band", band);
            req.setAttribute("article", article);
            req.getRequestDispatcher("/community/delete.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/community/delete-fail.jsp").forward(req, resp);
        }
    }
}

