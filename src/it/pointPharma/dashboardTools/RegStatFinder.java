package it.pointPharma.dashboardTools;

import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.*;

public class RegStatFinder extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        String regFName = (String) request.getParameter("regFName");
        String regLName = (String) request.getParameter("regLName");
        String regCF = (String) request.getParameter("regCF");
        String regEmail = (String) request.getParameter("regEmail");
        String regDoB = (String) request.getParameter("regDoB");
        String stat = (String) request.getParameter("stat");

        if (stat.equals("getTotalSalesPerPharmacy")) {
            String result = this.getTotalSalesPerPharmacy();
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getPharmacyInfo")){
            String result = this.getPharmacyInfo();
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getMostSoldMeds")){
            String result = this.getMostSoldMeds();
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }

        return null;
    }

    private String getTotalSalesPerPharmacy() throws Exception{
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            String result = "";
            try {
                Statement st = con.createStatement();
                String query = "select nomefarmacia, sum(totale) as sum, count(*) as totalsales\n" +
                        "from acquisto\n" +
                        "join personale\n" +
                        "on acquisto.cfpersonale = personale.personale_cfpersona\n" +
                        "group by nomefarmacia\n" +
                        "order by sum desc";
                ResultSet ris = st.executeQuery(query);

                while(ris.next()){
                    result = result.concat(ris.getString("nomefarmacia") + ";" + ris.getString("sum") + ";" + ris.getString("totalsales") + ";");
                }
            } catch (SQLException e){
                throw new Exception("Error DB");
            }
            con.close();
            return result;
        } catch (SQLException e){
            throw new Exception("Error DB");
        }

    }

    private String getPharmacyInfo() throws Exception{
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            String result = "";
            try {
                Statement st = con.createStatement();
                String query = "select farmacia.nome as phname, cognome as surname, persona.nome as name, mailtitolare as email \n" +
                        "from farmacia join persona\n" +
                        "on farmacia.cftitolare = persona.codicefiscale";
                ResultSet ris = st.executeQuery(query);

                while(ris.next()){
                    result = result.concat(ris.getString("phname") + ";" + ris.getString("surname") + ";" + ris.getString("name") + ";" + ris.getString("email") + ";");
                }
            } catch (SQLException e){
                throw new Exception("Error DB");
            }
            con.close();
            return result;
        } catch (SQLException e){
            throw new Exception("Error DB");
        }
    }

    private String getMostSoldMeds() throws Exception{
        try {
            String str = "";
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String query = "select sum(acquisto_farmaco.quantita) as sum , farmaco.nome\n" +
                        "from acquisto_farmaco\n" +
                        "join farmaco on acquisto_farmaco.codicefarmacoacquisto = farmaco.codice\n" +
                        "join persona on persona.codicefiscale = acquisto_farmaco.cfpersonaleacquisto\n" +
                        "join personale on persona.codicefiscale = personale.personale_cfpersona\n" +
                        "group by farmaco.codice";
                ResultSet ris = st.executeQuery(query);
                while(ris.next()){
                    str = str.concat(ris.getString("sum") + ";" + ris.getString("nome") + ";");
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
            return str;
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
}}
