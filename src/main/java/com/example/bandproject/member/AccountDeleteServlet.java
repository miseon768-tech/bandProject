package com.example.bandproject.member;

import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/account/delete")
public class AccountDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 탈퇴 확인 페이지로 이동
        req.getRequestDispatcher("/member/accountdelete.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("logonUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Member logonUser = (Member) session.getAttribute("logonUser");
        String id = logonUser.getId();
        String inputPassword = req.getParameter("password");

        try (SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {

            // db에 저장된 비밀번호 조회(MemberMapper에 등록했습니다)
            String dbPassword = sqlSession.selectOne("mappers.MemberMapper.selectPasswordById", id);

            if (dbPassword == null || !dbPassword.equals(inputPassword)) {

                resp.sendRedirect("/member/accountdelete-fail.jsp");
                return;
            }


            int pw = sqlSession.delete("mappers.MemberMapper.deleteById", id);

            if (pw > 0) {

                resp.sendRedirect("/member/accountdelete-success.jsp");
            } else {

                resp.sendRedirect("/member/accountdelete-fail.jsp");
            }

        } catch (Exception e) {

            resp.sendRedirect("/member/accountdelete-fail.jsp");
        }
    }
}
