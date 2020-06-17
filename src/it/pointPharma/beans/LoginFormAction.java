package it.pointPharma.beans;

import it.pointPharma.DAOFormLogin.FormLoginDBAccess;
import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.User;
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
        formLoginDBAccess.getUserData();
        Pharmacist pharmacist = formLoginDBAccess.getPharmacist();
        String role = formLoginDBAccess.getRole();
        ActionForward af = null;
        if(password.equals(pharmacist.getPwd())) {
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
