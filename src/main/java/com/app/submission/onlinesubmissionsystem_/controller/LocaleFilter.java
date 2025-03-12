package com.app.submission.onlinesubmissionsystem_.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Locale;

@WebFilter("/*")
public class LocaleFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        String lang = req.getParameter("lang");
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        if (session.getAttribute("lang") == null) {
            session.setAttribute("lang", "en"); // Default to English
        }

        Locale locale = new Locale((String) session.getAttribute("lang"));
        request.setAttribute("locale", locale);
        chain.doFilter(request, response);
    }
    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
