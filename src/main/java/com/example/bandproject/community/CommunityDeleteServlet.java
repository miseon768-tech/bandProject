
package com.example.bandproject.community;

import com.example.bandproject.model.Member;
import com.example.bandproject.model.Band;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import java.io.IOException;



@WebServlet("/community/delete")
public class CommunityDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int bandNo = Integer.parseInt(req.getParameter("bandNo"));

        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        String role = (String) req.getAttribute("bandRole");

        if (!"MASTER".equals(role)) {
            req.getRequestDispatcher("/community/delete-fail.jsp").forward(req, resp);
            return;
        }
        try(SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
            Band band = sqlSession.selectOne("mappers.BandMapper.deleteByNo", bandNo);
            req.setAttribute("band", band);
            req.getRequestDispatcher("/community/delete.jsp").forward(req, resp);
        }
    }
}