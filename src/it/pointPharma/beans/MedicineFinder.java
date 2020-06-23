package it.pointPharma.beans;

import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
                String hint = (String)request.getParameter("hint"); // TO BE MODIFIED
                String query = "SELECT distinct farmaco.codice, farmaco.nome from farmaco join Magazzino_Farmaco on Magazzino_Farmaco.codiceFarmaco = farmaco.codice where farmaco.nome ILIKE '%"+ hint +"%'";
                        /*
                        "!and Magazzino_Farmaco.nomeFarmaciaMagazzino = ''\n" + //PHARMA MISSED
                        "!and Magazzino_Farmaco.indirizzoFarmaciaMagazzino = ''\n" +
                        "!and Magazzino_Farmaco.cfTitolareFarmaciaMagazzino = ''";*/
                ResultSet ris = st.executeQuery(query);
                //LinkedList<String> lc = new LinkedList<String>();
                String risString = "";
                while(ris.next()){
                    risString = risString.concat(ris.getString("codice") + ";" + ris.getString("nome") + ";");
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
