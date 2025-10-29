package com.example.bandproject.member;



import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/editProfile")
public class editProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Member logonUser =(Member)req.getSession().getAttribute("logonUser");
        if(logonUser == null) {
            resp.sendRedirect("/login");
            return;
        }


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        Member found = sqlSession.selectOne("mappers.MemberMapper.selectById", logonUser.getId());
        req.setAttribute("member", found);
        sqlSession.close();
        req.getRequestDispatcher("/member/editprofile.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member logonUser =(Member)req.getSession().getAttribute("logonUser");
        String name =req.getParameter("name");
        String nickname = req.getParameter("nickname");
        String email = req.getParameter("email");
        String interest = req.getParameter("interest");

        Member p = new Member();
        p.setNickname(nickname);
        p.setName(name);
        p.setEmail(email);
        p.setInterest(interest);
        p.setId(logonUser.getId());

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        int r = sqlSession.update("mappers.MemberMapper.updateOne", p);

        resp.sendRedirect("/editProfile");

    }
}
