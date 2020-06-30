package it.pointPharma.beans.chat;

import it.pointPharma.generalClasses.*;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.nimbus.State;
import java.sql.*;
import java.util.Date;

public class messagesGroup extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        Pharmacist ph = (Pharmacist) session.getAttribute("pharmacist");
        Pharmacy phy = (Pharmacy) session.getAttribute("pharmacy");
        Date d = new Date();
        Timestamp ts = new Timestamp(d.getTime());
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String retrieveReceiversInfo = "";
                if(ph instanceof REG)
                    retrieveReceiversInfo = "SELECT personale_cfpersona, mail FROM personale WHERE ruolopersonale='PM'";
                else if(ph instanceof PharmacistManager)
                    retrieveReceiversInfo = "SELECT personale_cfpersona, mail FROM personale WHERE nomefarmacia LIKE '" + phy.getName() + "';";
                else if(ph instanceof PharmacyDoctor)
                    retrieveReceiversInfo = "SELECT personale_cfpersona, mail FROM personale WHERE nomefarmacia LIKE '" + phy.getName() + "'" +
                            "AND ruolopersonale = 'PD';";
                else if(ph instanceof DeskOperator)
                    retrieveReceiversInfo = "SELECT personale_cfpersona, mail FROM personale WHERE nomefarmacia LIKE '" + phy.getName() + "'" + "AND ruolopersonale LIKE 'DO';";
                ResultSet rs = st.executeQuery(retrieveReceiversInfo);
                String messageQuery = "INSERT INTO messaggio VALUES ('" +
                        ts + "', '" +
                        request.getParameter("message") + "', '" +
                        ph.getCF() + "','" +
                        ph.getEmail() + "');";
                Statement st2 = con.createStatement();
                st2.executeUpdate(messageQuery);
                while (rs.next())
                {
                    String cf = rs.getString("personale_cfpersona");
                    String mail = rs.getString("mail");
                    String receiverMessage = "INSERT INTO destinatario_messaggio VALUES ('" +
                            cf + "','" +
                            mail + "','" +
                            ph.getCF() + "','" +
                            ph.getEmail() + "','" +
                            ts + "','" +
                            true + "');";
                    st2.executeUpdate(receiverMessage);
                }
            } catch (SQLException e)
            {
                throw new Exception("Errore DB");
            }
        } catch (SQLException e)
        {
            throw new Exception("Errore DB");
        }
        return null;
    }
}
