package it.pointPharma.beans;

import it.pointPharma.DAOFormLogin.FormLoginDBAccess;
import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.*;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.NoSuchElementException;

public class LoginFormAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        UserData loginData = (UserData) form;
        String password = loginData.getPassword();
        FormLoginDBAccess formLoginDBAccess = new FormLoginDBAccess(loginData);
        String realPwd = formLoginDBAccess.getPharmacist().getPwd();
        String role = formLoginDBAccess.getRole();
        ActionForward af = null;
        if(password.equals(realPwd)) {
            switch (role) {
                case "REG":
                    REG reg = new REG();
                    reg.setEmail(loginData.getEmail());
                    reg.setCF(formLoginDBAccess.getCF());
                    // other parameters are missed
                    request.setAttribute("pharmacist", reg);
                    af = mapping.findForward("REG");
                    break;
                case "PM":
                    PharmacistManager pm = new PharmacistManager();
                    pm.setEmail(loginData.getEmail());
                    pm.setCF(formLoginDBAccess.getCF());
                    // other parameters are missed
                    request.setAttribute("pharmacist", pm);
                    af = mapping.findForward("PM");
                    break;
                case "PD":
                    PharmacyDoctor pd = new PharmacyDoctor();
                    pd.setEmail(loginData.getEmail());
                    pd.setCF(formLoginDBAccess.getCF());
                    // other parameters are missed
                    request.setAttribute("pharmacist", pd);
                    af = mapping.findForward("PD");
                    break;
                case "DO":
                    DeskOperator dop = new DeskOperator();
                    dop.setEmail(loginData.getEmail());
                    dop.setCF(formLoginDBAccess.getCF());
                    // other parameters are missed
                    request.setAttribute("pharmacist", dop);
                    af = mapping.findForward("DO");
                    break;
            }
            return af;
        }else{
            return mapping.findForward("Error");
        }
    }

}
