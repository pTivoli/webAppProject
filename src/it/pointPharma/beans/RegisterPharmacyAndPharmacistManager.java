package it.pointPharma.beans;

import it.pointPharma.generalClasses.PharmacistManager;
import it.pointPharma.generalClasses.Pharmacy;
import it.pointPharma.generalClasses.REG;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegisterPharmacyAndPharmacistManager extends Action{

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        PharmacistManager pm = new PharmacistManager();
        pm.setCF((String)request.getParameter("cf"));
        pm.setfName((String)request.getParameter("fname"));
        pm.setlName((String)request.getParameter("lname"));
        pm.setDOB((String)request.getParameter("dob"));
        pm.setEmail((String)request.getParameter("usr"));
        pm.setPwd((String)request.getParameter("pwd"));
        Pharmacy ph = new Pharmacy();
        ph.setName((String)request.getParameter("phname"));
        ph.setAddress((String)request.getParameter("phaddr"));
        ph.setPhoneNumber((String)request.getParameter("phtel"));
        ph.setPharmacyManager(pm);
        HttpSession session = request.getSession(true);
        REG reg = (REG)session.getAttribute("pharmacist");
        reg.activatePM(pm, ph);
        reg.activatePharmacy(ph);
        return null;
    }

}
