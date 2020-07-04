package it.pointPharma.beans.chat;

import com.sun.org.apache.regexp.internal.RE;
import com.sun.org.apache.xerces.internal.util.HTTPInputSource;
import it.pointPharma.generalClasses.*;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.*;

public class receiverCheck extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String hint = (String)request.getParameter("hint");
                HttpSession session = request.getSession(true);
                Pharmacy phy = (Pharmacy)session.getAttribute("pharmacy");
                Pharmacist ph = (Pharmacist)session.getAttribute("pharmacist");
                String query = "";
                if(request.getParameter("hint").contains("%")) return null;
               if(ph instanceof REG)
               {
                   query = "SELECT nomefarmacia FROM personale WHERE ruolopersonale='PM' AND lower(nomefarmacia) LIKE '" + hint.toLowerCase() + "%';";
               }
               else if(ph instanceof PharmacistManager)
               {
                   query = "SELECT mail FROM personale WHERE cf_titolare_farmacia='" + ph.getCF() + "' AND mail NOT LIKE '" + ph.getEmail() + "' AND mail LIKE '" + hint + "%';";
               }
               else
               {
                   query = "SELECT mail FROM personale WHERE nomefarmacia LIKE '" + phy.getName() + "' AND mail LIKE '" + hint + "%' AND mail NOT LIKE '" + ph.getEmail() +"';";
               }
                ResultSet rs = st.executeQuery(query);
               String ris = "";
               while (rs.next())
               {
                   if(ph instanceof REG)
                    ris = ris.concat(rs.getString("nomefarmacia") + ";");
                   else
                       ris = ris.concat(rs.getString("mail") + ";");
               }
                if(ph instanceof REG) {
                    if ("PM".contains(hint.toUpperCase())) {
                        ris = ris.concat("PM;");
                    }
                }
                else if(ph instanceof PharmacistManager) {
                    if("REG".contains(hint.toUpperCase()))
                        ris = ris.concat("REG;");
                }
                else if (ph instanceof PharmacyDoctor) {
                    if("PD".contains(hint.toUpperCase()))
                        ris = ris.concat("PD;");
                }
                else {
                    if("DO".contains(hint.toUpperCase()))
                        ris = ris.concat("DO;");
                }
                if(ph instanceof REG);
                else
                    if (phy.getName().toLowerCase().contains(hint.toLowerCase()))
                        ris = ris.concat(phy.getName() + ";");
                PrintWriter out = response.getWriter();
                out.println(ris);
                out.flush();
                out.close();
            }catch (SQLException e){
                throw new Exception("Errore DB");
            }
        }catch (SQLException e)
        {
            throw new Exception("Errore DB");
        }
        return null;
    }
}
