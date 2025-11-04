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

@WebServlet("/band/member")
public class BandMemberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        String action = req.getParameter("action"); // 프론트에서 승인신청 버튼 동작을 보냄

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        try {
            if ("apply".equals(action)) {
                String bandNoStr = req.getParameter("bandNo");
                String nickname = req.getParameter("nickname");

                BandMember bandMember = new BandMember();
                bandMember.setMemberNo(logonUser.getNo());
                bandMember.setBandNo(Integer.parseInt(bandNoStr));
                bandMember.setId(logonUser.getId());
                bandMember.setName(logonUser.getName());
                bandMember.setNickname(nickname);
                bandMember.setRole("MEMBER");
                bandMember.setApproved(false); // 신청 단계에서는 false
                bandMember.setJoinedAt(LocalDateTime.now());

                sqlSession.insert("mappers.BandMemberMapper.insertOne", bandMember);
                resp.sendRedirect("/community?bandNo=" + bandNoStr);

            } else if ("approve".equals(action)) {
                // [마스터 승인/거절] : bandMemberNo, approved 값 폼에서 받음
                int bandNo = Integer.parseInt(req.getParameter("bandNo"));
                int bandMemberNo = Integer.parseInt(req.getParameter("bandMemberNo"));
                boolean approved = Boolean.parseBoolean(req.getParameter("approved"));

                BandMember bandMember = new BandMember();
                bandMember.setNo(bandMemberNo);
                bandMember.setApproved(approved);

                sqlSession.update("mappers.BandMemberMapper.updateApprovalStatus", bandMember);
                resp.sendRedirect("community?bandNo=" + bandNo + "&result=" + (approved ? "approved" : "denied"));
            } else {
                resp.sendRedirect("/band/index");
            }
        } finally {
            sqlSession.close();
        }
    }
}