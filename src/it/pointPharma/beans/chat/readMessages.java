package it.pointPharma.beans.chat;

import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.Pharmacy;
import javafx.beans.property.ReadOnlySetProperty;
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
                String receiver = request.getParameter("receiver");
                String query = "SELECT mailpersonalemitt, timestmesssaggio, testo FROM (" +
                        "SELECT mailpersonalemitt, timestmesssaggio, testo " +
                        "FROM destinatario_messaggio " +
                        "JOIN messaggio on timestmesssaggio = timest " +
                        "WHERE mailpersonaledest LIKE '" + receiver + "%'" +
                        "AND mailpersonalemitt LIKE '" + mail + "%'" +
                        " AND groupchat='false'" +
                        "UNION " +
                        "SELECT mailpersonalemitt, timestmesssaggio, testo " +
                        "FROM destinatario_messaggio " +
                        "JOIN messaggio on timestmesssaggio = timest " +
                        "WHERE mailpersonaledest LIKE '" + mail + "%'" +
                        "AND mailpersonalemitt LIKE '" + receiver + "%'" +
                        " AND groupchat='false'" +
                        ") res" +
                        " ORDER BY res.timestmesssaggio";
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
