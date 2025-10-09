package org.example.demo;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.util.JPAsingleton;

import java.io.IOException;
@WebServlet(name = "testDBServlet", value = "/test")

public class TestDBServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em =  JPAsingleton.getEntityManager();

        response.setContentType("text/html");
        try {
            em.getTransaction().begin();
            response.getWriter().println("<h1>Connection to PostgreSQL successful!</h1>");
            em.getTransaction().commit();
        } catch (Exception e) {
            response.getWriter().println("<h1>Error: " + e.getMessage() + "</h1>");
        } finally {
            em.close();
        }
    }
}
