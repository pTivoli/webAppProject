package it.pointPharma.beans;

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
                String ris = "";
                if(ph instanceof REG)
                    query = "SELECT DISTINCT mailpersonalemitt, timestmesssaggio, testo" +
                            " FROM destinatario_messaggio" +
                            " JOIN messaggio ON timestmesssaggio = timest" +
                            " JOIN personale ON cfpersonaledest = personale_cfpersona" +
                            " WHERE mailpersonalemitt LIKE '=" + ph.getEmail() + "'" +
                            " AND groupchat = 'true'" +
                            " AND ruolopersonale='PM'" +
                            " ORDER BY timestmesssaggio";
                else if(ph instanceof PharmacistManager)
                    query = "SELECT DISTINCT mailpersonalemitt, timestmesssaggio, testo" +
                            " FROM destinatario_messaggio" +
                            " JOIN messaggio ON timestmesssaggio = timest" +
                            " JOIN personale ON cfpersonaledest = personale_cfpersona" +
                            " WHERE mailpersonalemitt LIKE '" + ph.getEmail() + "%'" +
                            " AND groupchat = 'true'" +
                            " AND nomefarmacia='" + phy.getName() + "'" +
                            " ORDER BY timestmesssaggio";
                else
                {
                    String retrieveReceivers = "";
                    if(ph instanceof PharmacyDoctor)
                        retrieveReceivers = "SELECT personale_cfpersona, mail FROM personale WHERE ruolopersonale = 'PD'" +
                                "AND nomefarmacia = '" + phy.getName() + "';";
                    else
                        retrieveReceivers = "SELECT personale_cfpersona, mail FROM personale WHERE ruolopersonale = 'DO'"+
                                "AND nomefarmacia = '" + phy.getName() + "';";
                    Statement st2 = con.createStatement();
                    ResultSet rs2 = st2.executeQuery(retrieveReceivers);
                    while (rs2.next())
                    {
                        query = "SELECT DISTINCT res.mailpersonalemitt, res.timestmesssaggio, res.testo FROM (" +
                                "SELECT mailpersonalemitt, timestmesssaggio, testo " +
                                "FROM destinatario_messaggio " +
                                "JOIN messaggio on timestmesssaggio = timest " +
                                "WHERE mailpersonaledest LIKE '" + rs2.getString("mail") + "%'" +
                                "AND mailpersonalemitt LIKE '" + ph.getEmail() + "%'" +
                                " AND groupchat='true'" +
                                "UNION " +
                                "SELECT mailpersonalemitt, timestmesssaggio, testo " +
                                "FROM destinatario_messaggio " +
                                "JOIN messaggio on timestmesssaggio = timest " +
                                "WHERE mailpersonaledest LIKE '" + ph.getEmail() + "%'" +
                                "AND mailpersonalemitt LIKE '" + rs2.getString("mail") + "%'" +
                                " AND groupchat='true'" +
                                ") res" +
                                " ORDER BY res.timestmesssaggio";
                        ResultSet rs = st.executeQuery(query);
                        while (rs.next())
                        {
                            ris = ris.concat(rs.getString("mailpersonalemitt") + ";" + rs.getString("testo") + ";");
                        }
                    }
                }
                if(ph instanceof REG || ph instanceof PharmacyDoctor) {
                    ResultSet rs = st.executeQuery(query);
                    while (rs.next()) {
                        ris = ris.concat(rs.getString("mailpersonalemitt") + ";" + rs.getString("testo") + ";");
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
