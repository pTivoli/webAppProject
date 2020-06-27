package it.pointPharma.beans;

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
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "pharma", "pass");
            try {
                Statement st = con.createStatement();
                String hint = (String)request.getParameter("hint");
                HttpSession session = request.getSession(true);
                Pharmacy phy = (Pharmacy)session.getAttribute("pharmacy");
                Pharmacist ph = (Pharmacist)session.getAttribute("pharmacist");
                String query = "";
               if(ph instanceof REG)
               {
                   query = "SELECT mail FROM personale WHERE ruolopersonale='PM' AND mail LIKE '" + hint + "%';";
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
                   ris = ris.concat(rs.getString("mail") + ";");
               }
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
