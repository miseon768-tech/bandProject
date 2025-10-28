package com.example.bandproject.band;

import com.example.bandproject.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/band/create")
public class bandCreate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



        if (req.getSession().getAttribute("logonUser") == null) {
            resp.sendRedirect("/login");
            return;
        }

        Member master = (Member) req.getSession().getAttribute("master");
        req.setAttribute("auth", true);
        req.setAttribute("master", req.getSession().getAttribute("master"));
        req.setAttribute("masterNickname", master.getNickname());

        req.getRequestDispatcher("/band/create.jsp").forward(req, resp);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



    }
}

