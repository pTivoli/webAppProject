package it.pointPharma.beans;

import it.pointPharma.DAOFormLogin.FormLoginDBAccess;
import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.*;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.NoSuchElementException;

public class LoginFormAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        UserData loginData = (UserData) form;
        HttpSession session = request.getSession(true);
        String password = loginData.getPassword();
        FormLoginDBAccess formLoginDBAccess = new FormLoginDBAccess(loginData);
        String realPwd = formLoginDBAccess.getPharmacist().getPwd();
        String role = formLoginDBAccess.getRole();
        ActionForward af = null;
        if(password.equals(realPwd)) {
            Pharmacy pharm = new Pharmacy();
            pharm.setName(formLoginDBAccess.getPhName());
            pharm.setAddress(formLoginDBAccess.getPhAddress());
            pharm.setPhoneNumber(formLoginDBAccess.getPhPhoneNumber());
            pharm.setPharmacyManager(new PharmacistManager());
            pharm.getPharmacyManager().setCF(formLoginDBAccess.getPhCfTit());
            pharm.getPharmacyManager().setEmail(formLoginDBAccess.getPhMailTit());
            session.setAttribute("pharmacy", pharm);
            switch (role) {
                case "REG":
                    REG reg = new REG();
                    reg.setEmail(loginData.getEmail());
                    reg.setCF(formLoginDBAccess.getCF());
                    reg.setDOB(formLoginDBAccess.getDob());
                    reg.setfName(formLoginDBAccess.getFname());
                    reg.setlName(formLoginDBAccess.getLname());
                    session.setAttribute("pharmacist", reg);
                    af = mapping.findForward("REG");
                    break;
                case "PM":
                    PharmacistManager pm = new PharmacistManager();
                    pm.setEmail(loginData.getEmail());
                    pm.setCF(formLoginDBAccess.getCF());
                    pm.setDOB(formLoginDBAccess.getDob());
                    pm.setfName(formLoginDBAccess.getFname());
                    pm.setlName(formLoginDBAccess.getLname());
                    session.setAttribute("pharmacist", pm);
                    af = mapping.findForward("PM");
                    break;
                case "PD":
                    PharmacyDoctor pd = new PharmacyDoctor();
                    pd.setEmail(loginData.getEmail());
                    pd.setCF(formLoginDBAccess.getCF());
                    pd.setDOB(formLoginDBAccess.getDob());
                    pd.setfName(formLoginDBAccess.getFname());
                    pd.setlName(formLoginDBAccess.getLname());
                    session.setAttribute("pharmacist", pd);
                    af = mapping.findForward("PD");
                    break;
                case "DO":
                    DeskOperator dop = new DeskOperator();
                    dop.setEmail(loginData.getEmail());
                    dop.setCF(formLoginDBAccess.getCF());
                    dop.setDOB(formLoginDBAccess.getDob());
                    dop.setfName(formLoginDBAccess.getFname());
                    dop.setlName(formLoginDBAccess.getLname());
                    session.setAttribute("pharmacist", dop);
                    af = mapping.findForward("DO");
                    break;
            }
            return af;
        }else{
            return mapping.findForward("Error");
        }
    }

}
