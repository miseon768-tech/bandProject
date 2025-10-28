package com.example.bandproject.util;

import com.example.app.model.Member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;

public class DataBaseUtil {

    /*
    insert into member(id, password, email, name, nickname, interest, agree)
        values(?, ?, ?, ?, ?, ?, ?);
     */


    public static int insertMember(String id, String password, String email, String name, String nickname, String interest, boolean agree) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn =
                    DriverManager.getConnection(
                            "jdbc:mysql://database-1.cvkqiwea22jn.ap-northeast-2.rds.amazonaws.com:3306/community",
                            "admin", "miseon8976!");


            System.out.println("db 연결됨");

            String sql = "insert into member(id, password, email, name, nickname, interest, agree) values(?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setObject(1, id);
            ps.setObject(2, password);
            ps.setObject(3, email);
            ps.setObject(4, name);
            ps.setObject(5, nickname);
            ps.setObject(6, interest);
            ps.setObject(7, agree);

            int r = ps.executeUpdate();
            System.out.println("executeAdd() : " + r);

            conn.close();
            return r;

        } catch (Exception e) {
            System.out.println("에러가 발생했습니다." + e);
            return -1;
        }
    }


    public static Member selectMemberById(String id) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn =
                    DriverManager.getConnection(
                            "jdbc:mysql://database-1.cvkqiwea22jn.ap-northeast-2.rds.amazonaws.com:3306/community",
                            "admin", "miseon8976!");


            PreparedStatement ps = conn.prepareStatement("select *from Member where id = ? ");
            ps.setObject(1, id);

            ResultSet rs = ps.executeQuery();
            Member member = null;

            if (rs.next()) {
                member= new Member();
                member.setAgree(rs.getObject("agree", boolean.class));
                member.setEmail(rs.getObject("email", String.class));
                member.setId(rs.getObject("id", String.class));
                member.setInterest(rs.getObject("interest", String.class));
                member.setJoinAt(rs.getObject("joinAt", LocalDateTime.class));
                member.setName(rs.getObject("name", String.class));
                member.setPassword(rs.getObject("password", String.class));
                member.setNickname(rs.getObject("nickname", String.class));

                conn.close();
                return member;
            }

            conn.close();
            return null;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }

    public static Member selectMemberByNickname(String nickname) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn =
                    DriverManager.getConnection(
                            "jdbc:mysql://database-1.cvkqiwea22jn.ap-northeast-2.rds.amazonaws.com:3306/community",
                            "admin", "miseon8976!");


            PreparedStatement ps = conn.prepareStatement("select * from member where nickname=?");
            ps.setObject(1, nickname);
            ResultSet rs = ps.executeQuery();
            Member member = null;
            if (rs.next()) {
                member = new Member();
                member.setAgree(rs.getObject("agree", boolean.class));
                member.setEmail(rs.getObject("email", String.class));
                member.setId(rs.getObject("id", String.class));
                member.setInterest(rs.getObject("interest", String.class));
                member.setJoinAt(rs.getObject("joinAt", LocalDateTime.class));
                member.setName(rs.getObject("name", String.class));
                member.setPassword(rs.getObject("password", String.class));
                member.setNickname(rs.getObject("nickname", String.class));
            }
            conn.close();
            return member;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }

}

