package com.dldata.drgs.controller.Login;

import com.dldata.drgs.utils.ServerCache;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by 倪继文 on 2016/8/22.
 */
@Controller
@RequestMapping(value = "/ticket")
public class TicketController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @RequestMapping(value = "/getuserid")
    public void getUserName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String ticket = request.getParameter("ticket");
        String username = ServerCache.TICKET_AND_NAME.get(ticket);
        //ServerCache.TICKET_AND_NAME.remove(ticket);
        PrintWriter writer = response.getWriter();

        writer.write(username);

    }
}
