package com.example.bandproject.listener;

import com.example.bandproject.model.BandMember;
import com.example.bandproject.model.Member;
import com.example.bandproject.util.MyBatisUtil;
import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

@WebListener
public class BandMemberApprovalListener implements ServletRequestListener {

    @Override
    public void requestInitialized(ServletRequestEvent sre) {

        HttpServletRequest req = (HttpServletRequest) sre.getServletRequest();


        HttpSession session = req.getSession(false);

        String bandNoStr = req.getParameter("bandNo");
        boolean approved = false;

        if (session != null && bandNoStr != null) {
            Member member = (Member) session.getAttribute("logonUser");
            if (member != null) {
                try(SqlSession sqlSession = MyBatisUtil.build().openSession(true)) {
                    Map<String, Object> cond = new HashMap<>();
                    cond.put("memberNo", member.getNo());
                    cond.put("bandNo", Integer.parseInt(bandNoStr));

                    BandMember bandMember = sqlSession.selectOne("mappers.BandMemberMapper.selectByMemberAndBand", cond);

                    if(bandMember==null){
                        req.setAttribute("bandRole", "NOT_JOINED");
                    }else if(bandMember.getRole().equals("MASTER")){
                        req.setAttribute("bandRole", "MASTER");
                    }else if(bandMember.getRole().equals("MEMBER") && bandMember.isApproved()){
                        req.setAttribute("bandRole", "MEMBER");
                    }else if(bandMember.getRole().equals("MEMBER")){
                        req.setAttribute("bandRole", "MEMBER_WAITING");
                    }else {
                        req.setAttribute("bandRole", "ERROR");
                    }

                } catch (Exception e) {
                    System.out.println("BandMemberApprovalListener 오류: " + e.getMessage());
                }
            }
        }

        if (!approved) {
            req.setAttribute("bandApproved", false);
            req.setAttribute("errorMsg", "해당 밴드에서 승인된 멤버만 이용 가능합니다.");
        } else {
            req.setAttribute("bandApproved", true);
        }
    }
}