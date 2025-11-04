package com.example.bandproject.community;

import com.example.bandproject.model.Band;
import com.example.bandproject.model.Member;
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

        int bandNo = Integer.parseInt(req.getParameter("bandNo"));

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        String role = (String) req.getAttribute("bandRole");

        if (!"MASTER".equals(role)) {
            req.getRequestDispatcher("/community/edit-fail.jsp").forward(req, resp);
            return;
        }
        try (SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
            Band band = sqlSession.selectOne("mappers.BandMapper.selectByNo", bandNo);
            req.setAttribute("band", band);
            req.getRequestDispatcher("/community/edit.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        Boolean approved = (Boolean) req.getAttribute("approved");
        String role = (String) req.getAttribute("bandRole");

        if (approved == null || !approved || !"MASTER".equals(role)) {
            req.getRequestDispatcher("/community.jsp").forward(req, resp);
            return;
        }

        // 폼 데이터 받기
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        Band band = new Band();
        band.setNo(bandNo);
        band.setName(name);
        band.setDescription(description);

        // DB 업데이트
        try (SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
            sqlSession.update("mappers.BandMapper.updateOne", band);
        }

        // 수정 성공시 커뮤니티 상세로 이동
        resp.sendRedirect("community?bandNo=" + bandNo);
    }
}
