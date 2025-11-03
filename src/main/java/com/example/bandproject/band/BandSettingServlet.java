package com.example.bandproject.band;

import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;

@WebServlet("/band/setting")
public class BandSettingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 설정 화면 보여주기
        req.getRequestDispatcher("/band/bandSetting.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // action: delete 외에는 다시 설정 화면으로
        final String action = req.getParameter("action");
        if (!"delete".equals(action)) {
            resp.sendRedirect(req.getContextPath() + "/band/setting");
            return;
        }

        // 1) 요청 파라미터(no) → 2) 세션(currentBandNo) → 3) 기본값(1) 순으로 안전하게 획득
        Integer bandNo = null;
        try {
            String noParam = req.getParameter("no");
            if (noParam != null && !noParam.isBlank()) {
                bandNo = Integer.parseInt(noParam);
            }
        } catch (NumberFormatException ignore) { /* 무시하고 다음 경로로 */ }

        if (bandNo == null) {
            Object sessNo = req.getSession().getAttribute("currentBandNo");
            if (sessNo instanceof Integer) bandNo = (Integer) sessNo;
        }
        if (bandNo == null) bandNo = 1; // TODO: 실제 서비스에서는 기본값 지양

        try (SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
            // 매퍼 id는 질문에서 주신 deleteByNo 기준으로 호출
            sqlSession.delete("mappers.BandMapper.deleteByNo", bandNo);
            // 성공 시 목록으로
            resp.sendRedirect(req.getContextPath() + "/band/list");
        } catch (Exception e) {
            e.printStackTrace();
            // 실패 시 설정 페이지로 복귀
            resp.sendRedirect(req.getContextPath() + "/band/setting");
        }
    }
}
