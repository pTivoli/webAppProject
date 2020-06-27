package it.pointPharma.beans;

import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.Pharmacy;
import it.pointPharma.generalClasses.REG;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.*;

public class readMessagesGroup extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        Pharmacist ph = (Pharmacist) session.getAttribute("pharmacist");
        Pharmacy phy = (Pharmacy) session.getAttribute("pharmacy");
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String query = "";
                if(ph instanceof REG)
                    query = "SELECT personale_cfpersona FROM personale WHERE ruolopersonale='PM'";
                else
                    query = "SELECT personale_cfpersona FROM personale WHERE nomefarmacia LIKE '" + phy.getName() + "';";
                ResultSet rs = st.executeQuery(query);
                String ris = "";
                while (rs.next())
                {
                    String queryInt = "SELECT mailpersonalemitt, timestmesssaggio, testo FROM (" +
                            "SELECT mailpersonalemitt, timestmesssaggio, testo " +
                            "FROM destinatario_messaggio " +
                            "JOIN messaggio on timestmesssaggio = timest " +
                            "WHERE cfpersonaledest LIKE '" + rs.getString(0) + "%'" +
                            "AND mailpersonalemitt LIKE '" + ph.getEmail() + "%'" +
                            "UNION " +
                            "SELECT mailpersonalemitt, timestmesssaggio, testo " +
                            "FROM destinatario_messaggio " +
                            "JOIN messaggio on timestmesssaggio = timest " +
                            "WHERE mailpersonaledest LIKE '" + ph.getEmail() + "%'" +
                            "AND cfpersonaledest LIKE '" + rs.getString(0) + "%'" +
                            ") res" +
                            " ORDER BY res.timestmesssaggio";
                    ResultSet rs2 = st.executeQuery(queryInt);
                    while(rs2.next())
                    {
                        ris = ris.concat(rs2.getString(0) + ";" + rs2.getString(1) + ";");
                    }
                }
                PrintWriter out = response.getWriter();
                out.println(ris);
                out.flush();
                out.close();
            } catch (SQLException e) {
                throw new Exception("Errore DB");
            }
        } catch (SQLException e) {
            throw new Exception("Errore DB");
        }
        return null;
    }
}