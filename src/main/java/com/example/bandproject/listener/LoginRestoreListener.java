package com.example.bandproject.listener;

import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;

@WebListener
public class LoginRestoreListener implements ServletRequestListener {

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        HttpServletRequest req = (HttpServletRequest)sre.getServletRequest();
        // 요청자가 보내준 쿠키를 뽑고
        Cookie[] all = req.getCookies() == null ? new Cookie[0] : req.getCookies();
        // 이 쿠키중에 "keepLogin" 이름의 쿠키를 찾아야됨
        Cookie found = null;
        for (Cookie c : all) {
            if (c.getName().equals("keepLogin")) {
                found = c;
            }
        }
        // keepLogin 가지고 왔다면 인증상태로 바로 설정
        if (found != null) {
            String id = found.getValue();
            try(SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
                req.getSession().setAttribute("logonUser", sqlSession.selectOne("mappers.MemberMapper.selectById", id));
            }catch(Exception e) {
                System.out.println(e);
            }
        }

        if (req.getSession().getAttribute("logonUser") == null) {
            req.setAttribute("auth", false); // auth 라는 이름으로 인증여부를 저장, 로그인되지 않은 상태
        } else {
            req.setAttribute("auth", true); // auth 라는 이름으로 인증여부를 저장, 로그인된 상태
        }

    }
}
