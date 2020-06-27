package it.pointPharma.beans;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class ValidateUser extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return null;
    }

    public boolean exist(String codicefiscale) throws Exception {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String queryfindCF;
                queryfindCF = ("SELECT count(codiceFiscale) FROM persona where codicefiscale = '" + codicefiscale + "'");
                ResultSet ris = st.executeQuery(queryfindCF);
                int check = 0;
                while(ris.next()){
                    check = Integer.parseInt(ris.getString("count"));
                }
                return (check == 1);

            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

}