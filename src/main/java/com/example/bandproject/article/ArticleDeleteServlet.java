package com.example.bandproject.article;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/article/delete")
public class ArticleDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int no = Integer.parseInt(req.getParameter("no"));
        ArticleServlet.removeArticle(no);
        resp.sendRedirect(req.getContextPath() + "/article/list");
    }
}
