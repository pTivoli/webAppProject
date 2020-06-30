package it.pointPharma.beans;

import it.pointPharma.generalClasses.DeskOperator;
import it.pointPharma.generalClasses.PharmacistManager;
import it.pointPharma.generalClasses.Pharmacy;
import it.pointPharma.generalClasses.PharmacyDoctor;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegisterPharmacist extends Action{

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        PharmacistManager pm = (PharmacistManager) session.getAttribute("pharmacist");
        Pharmacy ph = (Pharmacy) session.getAttribute("pharmacy");
        String role     =   (String)request.getParameter("role");
        System.out.println(role);
        String cf       =   (String)request.getParameter("cf");
        String fname    =   (String)request.getParameter("fname");
        String lname    =   (String)request.getParameter("lname");
        String dob      =   (String)request.getParameter("dob");
        String usr      =   (String)request.getParameter("usr");
        String pwd      =   (String)request.getParameter("pwd");
        if(role.equals("DO")){
            DeskOperator deskOperator = new DeskOperator();
            deskOperator.setCF(cf);
            deskOperator.setfName(fname);
            deskOperator.setlName(lname);
            deskOperator.setDOB(dob);
            deskOperator.setEmail(usr);
            deskOperator.setPwd(pwd);
            pm.employeeDO(deskOperator, ph);
        }else{
            PharmacyDoctor pharmacyDoctor = new PharmacyDoctor();
            pharmacyDoctor.setCF(cf);
            pharmacyDoctor.setfName(fname);
            pharmacyDoctor.setlName(lname);
            pharmacyDoctor.setDOB(dob);
            pharmacyDoctor.setEmail(usr);
            pharmacyDoctor.setPwd(pwd);
            pm.employeePD(pharmacyDoctor, ph);
        }
        return null;
    }

}
