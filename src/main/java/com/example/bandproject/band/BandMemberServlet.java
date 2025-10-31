package com.example.bandproject.band;

import com.example.bandproject.model.Band;
import com.example.bandproject.model.BandMember;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/band/member")
public class BandMemberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/band/member.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("logonUser") == null) {
            resp.sendRedirect("/login");
            return;
        }

        String nickname = req.getParameter("nickname");
        boolean approoved = Boolean.parseBoolean(req.getParameter("approved"));

        String memberId = (String) req.getSession().getAttribute("id");
        String name = (String) req.getSession().getAttribute("name");
        String role = (String) req.getSession().getAttribute("role");


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        BandMember bandMember = new BandMember();
        bandMember.setId(memberId);
        bandMember.setName(name);
        bandMember.setNickname(nickname);
        bandMember.setApproved(approoved);
        bandMember.setRole(role);
        bandMember.setJoined_at(LocalDateTime.now());


        if ("MASTER".equals(role)) {
            bandMember.setRole("MASTER");
            bandMember.setApproved(true); // 마스터는 승인

        } else if ("MEMBER".equals(role)) {
            bandMember.setRole("MEMBER");
            bandMember.setApproved(true); // 멤버도 승인

        } else {
            // 회원이 아님/권한없음
            bandMember.setApproved(false);
            sqlSession.close();
            resp.sendRedirect("/band/index");
            return;
        }

        sqlSession.insert("mappers.BandMemberMapper.insertOne", bandMember);
        resp.sendRedirect("/article/list");

        sqlSession.close();
    }
}

