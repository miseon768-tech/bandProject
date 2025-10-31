package com.example.bandproject.band;

import com.example.bandproject.model.Band;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/band/list")
public class BandListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String no = req.getParameter("no");


        SqlSession sqlSession = MyBatisUtil.build().openSession(true);
        List<Band> bandList
                =sqlSession.selectList("mappers.BandMapper.selectByArticleNo", Integer.parseInt(no));
        req.setAttribute("bandlist", bandList);

        sqlSession.close();
        req.getRequestDispatcher("/band/list.jsp").forward(req, resp);


    }



}
