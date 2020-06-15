package it.pointPharma.beans;

import it.pointPharma.DAOFormLogin.FormLoginDBAccess;
import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.Pharmacist;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFormAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        UserData loginData = new UserData();
        String password = loginData.getPassword();
        FormLoginDBAccess formLoginDBAccess = new FormLoginDBAccess(loginData);
        Pharmacist pharmacist = formLoginDBAccess.getPharmacist();
        String role = formLoginDBAccess.getRole();
        ActionForward af = null;
        if(password == pharmacist.getPwd()) {
            switch (role) {
                case "REG":
                    af = mapping.findForward("REG");
                    break;
                case "PM":
                    af = mapping.findForward("PM");
                    break;
                case "PD":
                    af = mapping.findForward("PD");
                    break;
                case "DO":
                    af = mapping.findForward("DO");
                    break;
            }
            return af;
        }else{
            return mapping.findForward("Error");
        }
    }

}
