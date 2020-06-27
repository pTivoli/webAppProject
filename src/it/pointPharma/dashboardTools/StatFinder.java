package it.pointPharma.dashboardTools;

import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.*;

public class StatFinder extends Action{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        String phname = (String)request.getParameter("phname");
        String phaddr = (String)request.getParameter("phaddr");
        String phpm = (String)request.getParameter("phpm");
        String stat = (String)request.getParameter("stat");
        if(stat.equals("getGeneralNumberItems")) {
            int result = this.getGeneralNumberItems(phname, phaddr, phpm);
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getPiecesSold")){
            int result = this.getPiecesSold(phname, phaddr, phpm);
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getDrugsMoreSold")){
            String result = this.getDrugsMoreSold(phname, phaddr, phpm);
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getChartPharmacists")){
            String result = this.getChartPharmacists(phname, phaddr, phpm);
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getChartPharmacies")){
            String result = this.getChartPharmacies();
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        if(stat.equals("getChartNumberDrugsPharmacies")){
            String result = this.getChartNumberDrugsPharmacies();
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }
        return null;
    }

    private Integer getPiecesSold(String phname, String phaddr, String phpm) throws Exception {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            Integer result = null;
            try {
                Statement st = con.createStatement();
                String query = "select sum(acquisto_farmaco.quantita) as sum\n" +
                        "from acquisto_farmaco\n" +
                        "join persona on persona.codicefiscale = acquisto_farmaco.cfpersonaleacquisto\n" +
                        "join personale on persona.codicefiscale = personale.personale_cfpersona\n" +
                        "where personale.nomefarmacia ='"+phname+"'--da personalizzare\n" +
                        "and personale.indirizzofarmacia = '"+phaddr+"'\n" +
                        "and personale.cf_titolare_farmacia = '"+phpm+"'\n" +
                        "--and timestacquisto > '2016-01-01'--da eliminare per intero db";
                ResultSet ris = st.executeQuery(query);
                while(ris.next()){
                    result = ris.getInt("sum");
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
            return result;
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    private Integer getGeneralNumberItems(String phname, String phaddr, String phpm) throws Exception {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            Integer result = null;
            try {
                Statement st = con.createStatement();
                String query = "select count(*) as counter\n" +
                        "from acquisto_farmaco\n" +
                        "join persona on persona.codicefiscale = acquisto_farmaco.cfpersonaleacquisto\n" +
                        "join personale on persona.codicefiscale = personale.personale_cfpersona\n" +
                        "where personale.nomefarmacia ='"+phname+"' --da personalizzare\n" +
                        "and personale.indirizzofarmacia = '"+phaddr+"'\n" +
                        "and personale.cf_titolare_farmacia = '"+phpm+"'\n" +
                        "--and timestacquisto > '2016-01-01' --da eliminare per intero db";
                ResultSet ris = st.executeQuery(query);
                while(ris.next()){
                    result = ris.getInt("counter");
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
            return result;
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    private String getDrugsMoreSold(String phname, String phaddr, String phpm) throws Exception{
        try {
            String str = "";
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String query = "select sum(acquisto_farmaco.quantita) as sum , farmaco.nome\n" +
                        "from acquisto_farmaco\n" +
                        "join farmaco on acquisto_farmaco.codicefarmacoacquisto = farmaco.codice\n" +
                        "join persona on persona.codicefiscale = acquisto_farmaco.cfpersonaleacquisto\n" +
                        "join personale on persona.codicefiscale = personale.personale_cfpersona\n" +
                        "where personale.nomefarmacia ='"+phname+"' --da personalizzare\n" +
                        "and personale.indirizzofarmacia = '"+phaddr+"'\n" +
                        "and personale.cf_titolare_farmacia = '"+phpm+"'\n" +
                        "--and timestacquisto > '2016-01-01' --da eliminare per intero db\n" +
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
    }

    private String getChartPharmacists(String phname, String phaddr, String phpm) throws Exception{
        try {
            String str = "";
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String query = "select sum(acquisto_farmaco.quantita) sum, persona.nome, persona.cognome\n" +
                        "from acquisto_farmaco\n" +
                        "join farmaco on acquisto_farmaco.codicefarmacoacquisto = farmaco.codice\n" +
                        "join persona on persona.codicefiscale = acquisto_farmaco.cfpersonaleacquisto\n" +
                        "join personale on persona.codicefiscale = personale.personale_cfpersona\n" +
                        "where personale.nomefarmacia ='"+phname+"' --da personalizzare\n" +
                        "and personale.indirizzofarmacia = '"+phaddr+"'\n" +
                        "and personale.cf_titolare_farmacia = '"+phpm+"'\n" +
                        "--and timestacquisto > '2016-01-01' --da eliminare per intero db\n" +
                        "group by personale.mail, persona.nome, persona.cognome\n" +
                        "order by sum";
                ResultSet ris = st.executeQuery(query);
                while(ris.next()){
                    str = str.concat(ris.getString("nome") + ";" + ris.getString("cognome") + ";");
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
            return str;
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    private String getChartPharmacies() throws Exception{
        try {
            String str = "";
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String query = "select sum(totale) sum, personale.nomefarmacia, personale.indirizzofarmacia, personale.cf_titolare_farmacia\n" +
                        "from acquisto\n" +
                        "join personale on personale.mail = acquisto.mailpersonale and acquisto.cfpersonale = personale.personale_CFPersona\n" +
                        "group by personale.nomefarmacia, personale.indirizzofarmacia, personale.cf_titolare_farmacia\n" +
                        "order by sum";
                ResultSet ris = st.executeQuery(query);
                while(ris.next()){
                    str = str.concat(ris.getString("nomefarmacia") + ";" + ris.getString("sum") + ";");
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
            return str;
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    private String getChartNumberDrugsPharmacies() throws Exception{ //df
        try {
            String str = "";
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String query = "select count(*) count, nomefarmaciamagazzino, indirizzofarmaciamagazzino, cftitolarefarmaciamagazzino\n" +
                        "from magazzino_farmaco\n" +
                        "group by nomefarmaciamagazzino, indirizzofarmaciamagazzino, cftitolarefarmaciamagazzino\n" +
                        "order by count";
                ResultSet ris = st.executeQuery(query);
                while(ris.next()){
                    str = str.concat(ris.getString("nomefarmaciamagazzino") + ";" + ris.getString("count") + ";");
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
            return str;
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }
}
