package com.jwt.struts.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.*;

public class UserRegisterForm extends ActionForm{

    private static final long serialVersionUID = 1L;

    private String email;
    private String pwd;

    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request){
        ActionErrors errors = new ActionErrors();

        if(email == null || email.length() < 1){
            errors.add("email", new ActionMessage("error.email.required"));
        }

        if(pwd == null || pwd.length() < 1){
            errors.add("pwd", new ActionMessage("error.password.required"));
        }

        return errors;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
