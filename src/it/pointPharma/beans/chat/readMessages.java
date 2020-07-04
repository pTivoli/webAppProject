package it.pointPharma.beans.chat;

import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.Pharmacy;
import it.pointPharma.generalClasses.REG;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.*;

public class readMessages extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                HttpSession session = request.getSession(true);
                Pharmacist ph = (Pharmacist)session.getAttribute("pharmacist");
                String mail = ph.getEmail();
                String receiver = "";
                if(ph instanceof REG) {
                    String query = "SELECT mail FROM personale WHERE nomefarmacia LIKE '" + request.getParameter("receiver") + "' AND ruolopersonale = 'PM';";
                    Statement s2 = con.createStatement();
                    ResultSet rs = s2.executeQuery(query);
                    while (rs.next())
                        receiver = rs.getString("mail");
                }
                else receiver = request.getParameter("receiver");
                if(receiver.equals("REG"))
                {
                    String query = "SELECT mail from personale where ruolopersonale = 'REG' ;";

                    Statement s2 = con.createStatement();
                    ResultSet st2 = s2.executeQuery(query);
                    while (st2.next())
                        receiver = st2.getString("mail");
                }
                String query = "SELECT mailpersonalemitt, timestmessaggio, testo FROM (" +
                        "SELECT mailpersonalemitt, timestmessaggio, testo " +
                        "FROM destinatario_messaggio " +
                        "JOIN messaggio on timestmessaggio = timest " +
                        "WHERE mailpersonaledest LIKE '" + receiver + "%'" +
                        "AND mailpersonalemitt LIKE '" + mail + "%'" +
                        " AND groupchat='false'" +
                        "UNION " +
                        "SELECT mailpersonalemitt, timestmessaggio, testo " +
                        "FROM destinatario_messaggio " +
                        "JOIN messaggio on timestmessaggio = timest " +
                        "WHERE mailpersonaledest LIKE '" + mail + "%'" +
                        "AND mailpersonalemitt LIKE '" + receiver + "%'" +
                        " AND groupchat='false'" +
                        ") res" +
                        " ORDER BY res.timestmessaggio";
                ResultSet rs = st.executeQuery(query);
                String ris = "";
                while(rs.next())
                {
                    ris = ris.concat(rs.getString("mailpersonalemitt"));
                    ris = ris.concat(";");
                    ris = ris.concat(rs.getString("testo"));
                    ris = ris.concat(";");
                }
                PrintWriter out = response.getWriter();
                out.println(ris);
                out.flush();
                out.close();
            } catch (SQLException e) {
                throw new Exception("Errore DB");
            }
        } catch (SQLException e){
            throw new Exception("Errore DB");
        }
        return null;

    }
}
