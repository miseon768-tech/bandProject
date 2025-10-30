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


@WebServlet("/band")
public class BandServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        req.getRequestDispatcher("/band/band.jsp").forward(req, resp);
//        // 단순히 밴드 생성 폼을 보여주는 역할 (지금은 폼 없이 즉시 POST로 테스트 가능)
//        resp.setContentType("text/plain; charset=UTF-8");
//        resp.getWriter().println("🎸 [GET] BandCreateServlet 동작 중...");
//        resp.getWriter().println("POST /band/create 로 요청을 보내면 밴드가 생성됩니다.");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 밴드 생성 처리
        // 입력값 수신
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String masterMemberId = req.getParameter("masterMemberId");
        boolean isPublic = "on".equalsIgnoreCase(req.getParameter("is_public"));



        // 밴드 객체 구성 (DB에 저장하지 않음)
        Band band = new Band();
        band.setName(name);
        band.setDescription(description);
        band.setMaster_member_id(masterMemberId);
        band.set_public(isPublic);
        band.setCreated_at(java.time.LocalDateTime.now());
        band.setUpdated_at(java.time.LocalDateTime.now());

        // 밴드 멤버 객체 구성 (마스터 자동 등록)
        BandMember master = new BandMember();
        master.setMember_id(masterMemberId);
        master.setRole("MASTER");
        master.setApproved(true);
        master.setJoined_at(java.time.LocalDateTime.now());

        SqlSession sqlsession = MyBatisUtil.build().openSession(true);
        // 밴드 정보 DB에 저장
        sqlsession.insert("mappers.BandMapper.insertOne", band);
        // 밴드 마스터 멤버 DB에 저장
        sqlsession.insert("mappers.BandMemberMapper.insertOne", master);

        sqlsession.close();


        // ✅ ArticleServlet으로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
