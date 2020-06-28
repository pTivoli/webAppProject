package it.pointPharma.beans;

import it.pointPharma.generalClasses.PharmacyDoctor;
import it.pointPharma.generalClasses.User;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class RegisterUser extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        User usr = new User();
        String cf = (String)request.getParameter("cf");
        String fname = (String)request.getParameter("fname");
        String lname = (String)request.getParameter("lname");
        String dob = (String)request.getParameter("dob");
        usr.setCF(cf);
        usr.setfName(fname);
        usr.setlName(lname);
        usr.setDOB(dob);
        HttpSession session = request.getSession(true);
        PharmacyDoctor pharmacyDoctor = (PharmacyDoctor)session.getAttribute("pharmacist");
        try {
            pharmacyDoctor.registerUser(usr);
        }catch (Exception e){
            PrintWriter out = response.getWriter();
            out.println(e.getMessage());
            out.flush();
        }
        return null;
    }
}
