package com.example.bandproject.band;

import com.example.bandproject.model.BandMember;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/band/member?no={no}")
public class BandMemberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }
        req.getRequestDispatcher("/band/member.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (req.getSession().getAttribute("logonUser") == null) {
            resp.sendRedirect("/login");
            return;
        }

        String no = req.getParameter("no");

        String nickname = req.getParameter("nickname");
        boolean approved = Boolean.parseBoolean(req.getParameter("approved"));

        String id = logonUser.getId();
        String name = (String) req.getSession().getAttribute("name");
        String role = (String) req.getSession().getAttribute("role");


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        BandMember bandMember = new BandMember();

        bandMember.setMemberNo(logonUser.getNo());
        bandMember.setBandNo(Integer.parseInt(no));
        bandMember.setId(logonUser.getId());
        bandMember.setName(logonUser.getName());
        bandMember.setNickname(nickname);
        bandMember.setRole("MASTER");
        bandMember.setApproved(true);
        bandMember.setJoinedAt(LocalDateTime.now());

        if ("MASTER".equals(role)) {
            bandMember.setRole("MASTER");
            bandMember.setApproved(true); // 마스터는 승인
            resp.sendRedirect("/community");


        } else if ("MEMBER".equals(role)) {
            bandMember.setRole("MEMBER");
            bandMember.setApproved(true); // 멤버도 승인
            resp.sendRedirect("/community");

        } else {
            // 회원이 아님/권한없음
            bandMember.setApproved(false);
            sqlSession.close();
            resp.sendRedirect("/band/index");
            return;
        }

        sqlSession.insert("mappers.BandMemberMapper.insertOne", bandMember);

        sqlSession.close();
    }
}

