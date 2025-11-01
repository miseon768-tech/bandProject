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
//        // 단순히 밴드 생성 폼을 보여주는 역할 (지금은 폼 없이 즉시 POST로 테스트 가능)
//        resp.setContentType("text/plain; charset=UTF-8");
//        resp.getWriter().println("🎸 [GET] BandCreateServlet 동작 중...");
//        resp.getWriter().println("POST /band/create 로 요청을 보내면 밴드가 생성됩니다.");
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
        band.setMemberNo(logonUser.getNo());
        band.setId(logonUser.getId());
        band.setName(name);
        band.setNickname(nickname);
        band.setDescription(description);
        band.setCreatedAt(LocalDateTime.now());


        sqlSession.insert("mappers.BandMapper.insertOne", band);


        BandMember bandMember = new BandMember();

        bandMember.setMemberNo(logonUser.getNo());      // ★ 로그인한 회원의 PK
        bandMember.setBandNo(band.getNo());             // ★ 방금 생성된 밴드의 PK
        bandMember.setId(logonUser.getId());            // ★ 회원 아이디 정보
        bandMember.setName(logonUser.getName());        // ★ 회원 이름 정보

        bandMember.setNickname(nickname);               // 밴드 닉네임
        bandMember.setRole("MASTER");                   // 마스터 역할
        bandMember.setApproved(true);
        bandMember.setJoinedAt(LocalDateTime.now());

        sqlSession.insert("mappers.BandMemberMapper.insertOne", bandMember);


        sqlSession.close();
        resp.sendRedirect("/band");


    }

}