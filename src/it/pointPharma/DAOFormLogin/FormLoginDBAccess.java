package it.pointPharma.DAOFormLogin;

import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.PharmacistManager;
import it.pointPharma.generalClasses.Pharmacy;

import java.sql.*;

public class FormLoginDBAccess {

    private UserData userDataIn;
    private Pharmacist pharmacist;
    private String role;
    private String cf;
    private String dob;
    private String fname;
    private String lname;

    //Pharmacy
    private String phName = null;
    private String phAddress = null;
    private String phPhoneNumber = null;
    private String phCfTit = null;
    private String phMailTit = null;

    public FormLoginDBAccess(UserData userData) throws Exception {
        this.userDataIn = userData;
        this.getUserData();
    }

    private void getUserData() throws Exception {
        /*
            BE CAREFUL
            Check out if in your directory there is the postgres driver class.
            BE CAREFUL
            Change the credential in getConnection.
         */
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String query = "SELECT * FROM Personale JOIN Persona ON Persona.codicefiscale = Personale.personale_cfpersona JOIN Farmacia ON Farmacia.nome = Personale.nomeFarmacia WHERE mail = '" + userDataIn.getEmail() + "'";
                ResultSet ris = st.executeQuery(query);
                String role = null;
                String cf = null;
                String dob = null;
                String fname = null;
                String lname = null;

                Pharmacist pharmacistRetrieved = new Pharmacist();
                pharmacistRetrieved.setEmail(userDataIn.getEmail());
                while (ris.next()) {
                    pharmacistRetrieved.setPwd(ris.getString("pwd"));
                    role = ris.getString("ruoloPersonale");
                    cf = ris.getString("personale_cfpersona");
                    dob = ris.getString("datanascita");
                    fname = ris.getString("nome");
                    lname = ris.getString("cognome");

                    phName = ris.getString("nomeFarmacia");
                    phAddress = ris.getString("indirizzo");
                    phPhoneNumber = ris.getString("telefono");
                    phCfTit = ris.getString("cfTitolare");
                    phMailTit = ris.getString("mailtitolare");
                }
                setParameters(pharmacistRetrieved, role, cf, dob, fname, lname);

                Pharmacy pharmacyRetrieved = new Pharmacy();
                PharmacistManager pM = pharmacyRetrieved.getPharmacyManager();
                pM.setCF(phCfTit);
                pM.setEmail(phMailTit);

                pharmacyRetrieved.setName(phName);
                pharmacyRetrieved.setAddress(phAddress);
                pharmacyRetrieved.setPhoneNumber(phPhoneNumber);
                pharmacyRetrieved.setPharmacyManager(pM);

            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
            con.close();
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    private void setParameters(Pharmacist pharmacist, String ruolo, String cf, String dob, String fname, String lname) {
        this.pharmacist = pharmacist;
        this.role = ruolo;
        this.cf = cf;
        this.dob = dob;
        this.fname = fname;
        this.lname = lname;
    }

    public String getDob() {
        return dob;
    }

    public String getFname() {
        return fname;
    }

    public String getLname() {
        return lname;
    }

    public Pharmacist getPharmacist() {
        return this.pharmacist;
    }

    public String getRole() {
        return this.role;
    }

    public String getCF() {
        return this.cf;
    }

    public String getPhName(){
        return this.phName;
    }

    public String getPhAddress(){
        return this.phAddress;
    }

    public String getPhPhoneNumber(){
        return this.phPhoneNumber;
    }

    public String getPhCfTit(){
        return this.phCfTit;
    }

    public String getPhMailTit(){
        return this.phMailTit;
    }
}