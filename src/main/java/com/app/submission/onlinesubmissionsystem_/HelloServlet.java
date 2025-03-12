package com.app.submission.onlinesubmissionsystem_;

import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

/**
 * A simple servlet that handles HTTP GET requests and responds with a "Hello World!" message.
 */
@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    /**
     * Initializes the servlet by setting the message to "Hello World!".
     */
    public void init() {
        message = "Hello World!";
    }

    /**
     * Handles HTTP GET requests by responding with an HTML page containing the message.
     *
     * @param request  the HttpServletRequest object that contains the request the client made
     * @param response the HttpServletResponse object that contains the response the servlet returns
     * @throws IOException if an input or output error occurs while the servlet is handling the request
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    /**
     * Called when the servlet is destroyed. Can be used for cleanup operations.
     */
    public void destroy() {
    }
}
