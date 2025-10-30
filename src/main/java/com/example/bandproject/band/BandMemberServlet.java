package com.example.bandproject.band;

import com.example.bandproject.model.BandMember;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

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

        int band_no = Integer.parseInt(req.getParameter("no"));

        BandMember bandmember = new BandMember();
        bandmember.setBand_no(band_no);


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        sqlSession.insert("mappers.BandMemberMapper.insertOne", bandmember);




        sqlSession.close();


        resp.sendRedirect("/band/member");

    }
}
