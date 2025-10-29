package com.example.bandproject.band;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.Objects;

/**
 * ✅ MyBatis 없이 순수 JDBC 사용
 * - band 테이블과 band_member 테이블에 직접 insert
 */
@WebServlet("/band/create")
public class bandCreate extends HttpServlet {

    // ✅ DB 접속 정보 (본인 DB 환경에 맞게 변경)
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bandproject?useSSL=false&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "1234";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 밴드 생성 페이지 표시
        req.getRequestDispatcher("/band/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 폼 입력값 받기
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        boolean isPublic = Objects.equals(req.getParameter("is_public"), "on");
        String masterMemberId = "test_user"; // 로그인 미사용 버전: 고정 아이디

        // 필수값 검증
        if (name == null || name.isBlank()) {
            req.setAttribute("error", "밴드 이름을 입력하세요.");
            req.getRequestDispatcher("/band/index.jsp").forward(req, resp);
            return;
        }

        Connection conn = null;
        PreparedStatement psBand = null;
        PreparedStatement psMember = null;
        ResultSet rs = null;

        try {
            // ✅ DB 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 1️⃣ band 테이블 insert
            String insertBandSQL = """
                    INSERT INTO band (name, description, master_member_id, is_public, created_at, updated_at)
                    VALUES (?, ?, ?, ?, NOW(), NOW())
                    """;
            psBand = conn.prepareStatement(insertBandSQL, Statement.RETURN_GENERATED_KEYS);
            psBand.setString(1, name);
            psBand.setString(2, description);
            psBand.setString(3, masterMemberId);
            psBand.setBoolean(4, isPublic);
            int bandInserted = psBand.executeUpdate();

            if (bandInserted != 1) {
                conn.rollback();
                throw new SQLException("밴드 생성 실패");
            }

            // 2️⃣ 생성된 밴드 번호 가져오기
            rs = psBand.getGeneratedKeys();
            int bandNo = 0;
            if (rs.next()) {
                bandNo = rs.getInt(1);
            } else {
                conn.rollback();
                throw new SQLException("밴드 번호를 가져오지 못했습니다.");
            }

            // 3️⃣ band_member 등록 (MASTER로 등록)
            String insertMemberSQL = """
                    INSERT INTO band_member (band_no, member_id, role, approved)
                    VALUES (?, ?, 'MASTER', TRUE)
                    """;
            psMember = conn.prepareStatement(insertMemberSQL);
            psMember.setInt(1, bandNo);
            psMember.setString(2, masterMemberId);
            psMember.executeUpdate();

            // ✅ 트랜잭션 커밋
            conn.commit();

            req.setAttribute("success", "밴드가 성공적으로 생성되었습니다!");
            req.getRequestDispatcher("/band/index.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ignore) {}

            req.setAttribute("error", "밴드 생성 중 오류가 발생했습니다: " + e.getMessage());
            req.getRequestDispatcher("/band/index.jsp").forward(req, resp);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (psBand != null) psBand.close(); } catch (Exception ignored) {}
            try { if (psMember != null) psMember.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
