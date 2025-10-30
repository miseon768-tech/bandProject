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

@WebServlet("/band/join")
public class bandJoin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/band/join.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("logonUser") == null) {
            resp.sendRedirect("/login");
            return;
        }

        String member_id = req.getParameter("member_id");
        boolean approved = Boolean.parseBoolean(req.getParameter("approved"));

        BandMember bandmember = new BandMember();
        bandmember.setMember_id(member_id);
        bandmember.setApproved(approved);

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        sqlSession.insert("mappers.BandMemberMapper.insertOne", bandmember);

        if(member_id != null && approved) {

            sqlSession.update("mappers.BandMapper.bandPublic", 1);

        }else{
            sqlSession.update("mappers.BandMapper.bandPrivate", 0);

        }



        sqlSession.close();


        resp.sendRedirect("/band/join");

    }
}
