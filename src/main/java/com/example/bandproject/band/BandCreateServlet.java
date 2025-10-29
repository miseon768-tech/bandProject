package com.example.bandproject.band;

import com.example.bandproject.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;


@WebServlet("/band/create")
public class BandCreateServlet extends HttpServlet {

    private SqlSessionFactory sqlSessionFactory;

    @Override
    public void init() throws ServletException {
        try (Reader reader = Resources.getResourceAsReader("mappers/mybatis-config.xml")) {
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            throw new ServletException("MyBatis 초기화 실패", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 로그인 체크 (세션에 Member 객체 보관 가정: "logonUser")
        Member loginUser = (Member) req.getSession().getAttribute("logonUser");
        if (loginUser == null) {
            // 로그인 페이지로
            resp.sendRedirect(req.getContextPath() + "/member/login.jsp");
            return;
        }

        // 생성 폼으로 포워드 (프로젝트에 있는 폼 JSP로 바꿔도 됨)
        req.getRequestDispatcher("/band/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        Member loginUser = (Member) req.getSession().getAttribute("logonUser");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login.jsp");
            return;
        }

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String isPublicParam = req.getParameter("is_public"); // 체크박스(on/null)
        boolean isPublic = "on".equalsIgnoreCase(isPublicParam) || "true".equalsIgnoreCase(isPublicParam);

        // 필수값 검증
        if (name == null || name.isBlank()) {
            req.setAttribute("error", "밴드 이름을 입력하세요.");
            req.getRequestDispatcher("/band/index.jsp").forward(req, resp);
            return;
        }

        String masterMemberId = loginUser.getId(); // 로그인한 사용자를 마스터로

        // 트랜잭션 처리: 밴드 생성 + 마스터 등록
        try (SqlSession session = sqlSessionFactory.openSession(false)) { // auto-commit=false
            // 1) band INSERT
            var bandParam = new java.util.HashMap<String, Object>();
            bandParam.put("name", name);
            bandParam.put("description", description);
            bandParam.put("masterMemberId", masterMemberId);
            bandParam.put("isPublic", isPublic);

            int inserted = session.insert("mappers.BandMapper.insertOne", bandParam);
            if (inserted != 1) {
                session.rollback();
                throw new ServletException("밴드 생성에 실패했습니다.");
            }

            // 2) 방금 생성된 band.no 조회 (혹은 useGeneratedKeys 사용)
            Integer bandNo = session.selectOne("mappers.BandMapper.selectLastInsertId");
            if (bandNo == null) {
                session.rollback();
                throw new ServletException("밴드 번호를 가져오지 못했습니다.");
            }

            // 3) band_member에 MASTER로 자동 등록 (approved=true)
            var bmParam = new java.util.HashMap<String, Object>();
            bmParam.put("bandNo", bandNo);
            bmParam.put("memberId", masterMemberId);
            bmParam.put("role", "MASTER");
            bmParam.put("approved", true);

            // UNIQUE 제약(band_no, member_id)이 있다면 중복 방지 필요
            session.insert("mappers.BandMemberMapper.insertOne", bmParam);

            session.commit();

            // 생성 완료 → 상세/메인 페이지로 이동
            resp.sendRedirect(req.getContextPath() + "/band/index?bandNo=" + bandNo);
        } catch (Exception e) {
            // 실패 시 메시지와 함께 폼으로
            req.setAttribute("error", "생성 중 오류가 발생했습니다: " + e.getMessage());
            req.getRequestDispatcher("/band/index.jsp").forward(req, resp);
        }
    }
}
