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

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/member/signup.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String name = req.getParameter("name");
        String nickname = req.getParameter("nickname");
        String interest = req.getParameter("interest");
        boolean agree = Boolean.parseBoolean(req.getParameter("agree"));

        Member member = new Member();
        member.setId(id);
        member.setPassword(password);
        member.setEmail(email);
        member.setName(name);
        member.setNickname(nickname);
        member.setInterest(interest);
        member.setAgree(agree);

        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        int r = 0;

        if (id.matches("[a-z0-9]{4,15}")
                && password.matches("(?=.*[a-z])(?=.*[0-9]).{6,}")) {
            Member found1 =
                    sqlSession.selectOne("mappers.MemberMapper.selectById", id);
            Member found2 =
                    sqlSession.selectOne("mappers.MemberMapper.selectByNickname", nickname);
            if (found1 == null && found2 == null) {
                r = sqlSession.insert("mappers.MemberMapper.insertOne", member);
            }
        }
        if (r == 1) {
            req.setAttribute("nickname", nickname);
            req.getRequestDispatcher("/member/signup-success.jsp").forward(req, resp);
        } else {
            req.setAttribute("id", id);
            req.setAttribute("password", password);
            req.setAttribute("email", email);
            req.setAttribute("name", name);
            req.setAttribute("nickname", nickname);
            req.setAttribute("interest", interest);
            req.setAttribute("agree", agree);

            if (sqlSession.selectOne("mappers.MemberMapper.selectById", id) != null) {
                req.setAttribute("mainError", "이미 사용되고 있는 아이디 입니다.");
            }
            if (sqlSession.selectOne("mappers.MemberMapper.selectByNickname", nickname) != null) {
                req.setAttribute("mainError", "이미 사용되고 있는 닉네임 입니다.");
            }
            req.getRequestDispatcher("/member/signup-fail.jsp").forward(req, resp);
        }
        sqlSession.close();

    }


}

