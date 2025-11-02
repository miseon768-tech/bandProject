package com.example.bandproject.band;

import com.example.bandproject.model.Band;
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


@WebServlet("/band")
public class BandServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        req.getRequestDispatcher("/band/band.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }

        String name = req.getParameter("name");
        String nickname = req.getParameter("nickname");
        String description = req.getParameter("description");


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        Band band = new Band();
        try {
            band.setMemberNo(logonUser.getNo());
            band.setId(logonUser.getId());
            band.setName(name);
            band.setNickname(nickname);
            band.setDescription(description);
            band.setCreatedAt(LocalDateTime.now());


            sqlSession.insert("mappers.BandMapper.insertOne", band);


            BandMember bandMember = new BandMember();
            bandMember.setMemberNo(logonUser.getNo());
            bandMember.setBandNo(band.getNo());
            bandMember.setId(logonUser.getId());
            bandMember.setName(logonUser.getName());

            bandMember.setNickname(nickname);
            bandMember.setRole("MASTER");
            bandMember.setApproved(true);
            bandMember.setJoinedAt(LocalDateTime.now());

            sqlSession.insert("mappers.BandMemberMapper.insertOne", bandMember);

        } finally {
            sqlSession.close();
        }
        resp.sendRedirect("/community?bandNo=" +band.getNo());
    }
}
