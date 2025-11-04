package com.example.bandproject.band;

import com.example.bandproject.model.*;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/band/list")
public class BandListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        // 전체 밴드 리스트
        List<Band> bandList = sqlSession.selectList("mappers.BandMapper.selectAll");

        HttpSession session = req.getSession(false);
        Member member = null;
        if (session != null) {
            member = (Member) session.getAttribute("logonUser");
        }

        // 멤버가 가입한 밴드 조회
        String bandNoStr = req.getParameter("bandNo");
        List<BandMember> bandMembers = Collections.emptyList();
        if (member != null && bandNoStr != null && !bandNoStr.isEmpty()) {
            try {
                int bandNo = Integer.parseInt(bandNoStr);
                Map<String, Object> cond = new HashMap<>();
                cond.put("memberNo", member.getNo());
                cond.put("bandNo", bandNo);
                bandMembers = sqlSession.selectList("mappers.BandMapper.selectAll", cond);
            } catch (NumberFormatException e) {
                resp.sendRedirect("/band/list");
                return; // 예외 발생 시 이후 코드 진행 방지
            }
        }


        // 조회수 TOP 5
        List<Band> topViews = sqlSession.selectList("mappers.BandMapper.selectTop5Views");
        sqlSession.update("mappers.BandMapper.increaseViewCnt");

        // 좋아요 TOP 5
        List<Band> topLikes = sqlSession.selectList("mappers.BandMapper.selectTop5Likes");
        sqlSession.update("mappers.BandMapper.increaseLikeCnt");

        req.setAttribute("bandlist", bandList);
        req.setAttribute("topViews", topViews);
        req.setAttribute("topLikes", topLikes);

        sqlSession.close();

        req.getRequestDispatcher("/band/list.jsp").forward(req, resp);
    }
}
