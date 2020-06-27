package it.pointPharma.beans;

import it.pointPharma.generalClasses.DeskOperator;
import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.Pharmacy;
import it.pointPharma.generalClasses.PharmacyDoctor;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.*;
import java.util.LinkedList;

public class MedicineFinder extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String hint = (String)request.getParameter("hint");
                HttpSession session = request.getSession(true);
                Pharmacy ph = (Pharmacy)session.getAttribute("pharmacy");
                Pharmacist pharmacist = (Pharmacist)session.getAttribute("pharmacist");
                String query;
                if(pharmacist instanceof PharmacyDoctor)
                    query = "SELECT distinct farmaco.codice, farmaco.nome, farmaco.obbligoricetta from farmaco join Magazzino_Farmaco on Magazzino_Farmaco.codiceFarmaco = farmaco.codice where farmaco.nome ILIKE '%" + hint + "%' and Magazzino_Farmaco.nomeFarmaciaMagazzino = '"+ ph.getName() +"' and Magazzino_Farmaco.indirizzoFarmaciaMagazzino = '"+ ph.getAddress() +"' and Magazzino_Farmaco.cfTitolareFarmaciaMagazzino = '"+ ph.getPharmacyManager().getCF() +"' and scadenza > CURRENT_DATE;";
                else
                    query = "SELECT distinct farmaco.codice, farmaco.nome, farmaco.obbligoricetta from farmaco join Magazzino_Farmaco on Magazzino_Farmaco.codiceFarmaco = farmaco.codice where farmaco.nome ILIKE '%" + hint + "%' and Magazzino_Farmaco.nomeFarmaciaMagazzino = '"+ ph.getName() +"' and Magazzino_Farmaco.indirizzoFarmaciaMagazzino = '"+ ph.getAddress() +"' and Magazzino_Farmaco.cfTitolareFarmaciaMagazzino = '"+ ph.getPharmacyManager().getCF() +"' and scadenza > CURRENT_DATE and obbligoricetta = false;";
                ResultSet ris = st.executeQuery(query);
                String risString = "";
                while(ris.next()){
                    risString = risString.concat(ris.getString("codice") + ";" + ris.getString("nome") + ";" + ris.getString("obbligoricetta") + ";");
                }
                PrintWriter out = response.getWriter();
                out.println(risString);
                out.flush();
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
        return null;
    }
}
