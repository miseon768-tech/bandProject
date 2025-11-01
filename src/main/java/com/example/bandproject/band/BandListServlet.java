package com.example.bandproject.band;

import com.example.bandproject.model.Article;
import com.example.bandproject.model.Band;
import com.example.bandproject.model.WriteCounter;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/band/list")
public class BandListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SqlSession sqlSession = MyBatisUtil.build().openSession(true);

        // 전체 밴드 리스트
        List<Band> bandList = sqlSession.selectList("mappers.BandMapper.selectAll");

        // 조회수 TOP 5
        List<Band> topViews = sqlSession.selectList("mappers.BandMapper.selectTop5Views");
        sqlSession.update("mappers.BandMapper.increaseViewCnt");

        // 좋아요 TOP 5
        List<Band> topLikes = sqlSession.selectList("mappers.BandMapper.selectTop5Likes");
        sqlSession.update("mappers.BandMapper.increaseLikeCnt");

        req.setAttribute("bandlist", bandList);
        req.setAttribute("topViews", topViews);
        req.setAttribute("topLikes", topLikes);

        sqlSession.close();

        req.getRequestDispatcher("/band/list.jsp").forward(req, resp);
    }
}
