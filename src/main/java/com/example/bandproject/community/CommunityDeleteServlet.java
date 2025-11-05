package com.example.bandproject.community;

import com.example.bandproject.model.Member;
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

    /** ✅ GET: 삭제 안내 페이지로 포워드 */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String bandNoParam = req.getParameter("bandNo");

        // 파라미터 검사
        if (bandNoParam == null || bandNoParam.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "bandNo 파라미터가 없습니다.");
            return;
        }

        int bandNo;
        try {
            bandNo = Integer.parseInt(bandNoParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "bandNo가 숫자가 아닙니다.");
            return;
        }

        // JSP로 전달
        req.setAttribute("bandNo", bandNo);
        req.getRequestDispatcher("/community/delete.jsp").forward(req, resp);
    }

    /** ✅ POST: 실제 삭제 처리 */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        // 로그인 유저 확인
        Member logonUser = (Member) req.getSession().getAttribute("logonUser");
        if (logonUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 파라미터 검사
        String bandNoParam = req.getParameter("bandNo");
        if (bandNoParam == null || bandNoParam.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "bandNo 파라미터가 없습니다.");
            return;
        }

        int bandNo;
        try {
            bandNo = Integer.parseInt(bandNoParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "bandNo가 숫자가 아닙니다.");
            return;
        }

        try (SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {

            /** ✅ 1️⃣ 삭제 권한 확인 (MASTER만 가능) */
            String role = sqlSession.selectOne("mappers.BandMemberMapper.selectRoleByBandAndMember",
                    java.util.Map.of("bandNo", bandNo, "memberId", logonUser.getId()));

            if (role == null || !"MASTER".equalsIgnoreCase(role)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "밴드장만 밴드를 삭제할 수 있습니다.");
                return;
            }

            /** ✅ 2️⃣ 연관 데이터 먼저 삭제 (게시글/멤버 등) */
            sqlSession.delete("mappers.ArticleMapper.deleteByBandNo", bandNo);
            sqlSession.delete("mappers.BandMemberMapper.deleteByBandNo", bandNo);

            /** ✅ 3️⃣ 밴드 본체 삭제 */
            int deleted = sqlSession.delete("mappers.BandMapper.deleteByNo", bandNo);

            if (deleted == 0) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 밴드를 찾을 수 없습니다.");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "삭제 중 오류 발생");
            return;
        }

        /** ✅ 4️⃣ 삭제 후 리다이렉트 */
        resp.sendRedirect(req.getContextPath() + "/community?deleted=success");
    }
}
