package it.pointPharma.beans.chat;

import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.REG;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.sql.*;

public class messages extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        Pharmacist ph = (Pharmacist) session.getAttribute("pharmacist");
        String cf = ph.getCF();
        String email = ph.getEmail();
        String message = (String) request.getParameter("message");
        Date d = new Date();
        Timestamp tm = new Timestamp(d.getTime());
        String receiver = (String) request.getParameter("receiver");
        String cfReceiver = "";
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                if(receiver.equals("REG"))
                {
                    String retrieveReceiverInfo = "SELECT personale_cfpersona, mail FROM personale WHERE ruolopersonale='REG'";
                    ResultSet rs = st.executeQuery(retrieveReceiverInfo);
                    while (rs.next()) {
                        cfReceiver = rs.getString("personale_cfpersona");
                        receiver = rs.getString("mail");
                    }
                }
                else {
                    String retrieveReceiverInfo;
                    if(ph instanceof REG)
                        retrieveReceiverInfo = "SELECT personale_cfpersona, mail FROM personale WHERE personale.nomefarmacia='" + receiver + "' and ruolopersonale = 'PM' ;";
                    else retrieveReceiverInfo = "SELECT personale_cfpersona, mail FROM personale WHERE personale.mail='" + receiver + "';";
                    ResultSet rs = st.executeQuery(retrieveReceiverInfo);
                    while (rs.next()) {
                        cfReceiver = rs.getString("personale_cfpersona");
                        receiver = rs.getString("mail");
                    }
                }
                String sendMessage = "INSERT INTO messaggio VALUES ('" + tm + "', '" + message + "', '" + cf + "', '" + email + "');";
                st.executeUpdate(sendMessage);
                String receiverUpdate = "INSERT INTO destinatario_messaggio VALUES ('" + cfReceiver + "', '" + receiver + "', '" + cf + "', '" + email + "', '" + tm + "', 'false');";
                st.executeUpdate(receiverUpdate);
            } catch (SQLException e) {
                throw new Exception("Errore DB");
            }
        }catch (SQLException e){
            throw new Exception("Errore DB");
        }
        return null;
    }
}
