package it.pointPharma.DAOFormLogin;

import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.Pharmacist;
import it.pointPharma.generalClasses.PharmacistManager;
import it.pointPharma.generalClasses.Pharmacy;

import java.sql.*;

public class FormLoginDBAccess {

    private UserData userDataIn;
    private Pharmacist pharmacist;
    private Pharmacy pharmacy;
    private String role;
    private String cf;
    private String dob;
    private String fname;
    private String lname;

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

                //Pharmacist attributes
                String role = null;
                String cf = null;
                String dob = null;
                String fname = null;
                String lname = null;

                //Pharmacy attributes
                String phName = null;
                String phAddress = null;
                String phPhoneNumber = null;
                String phCfTit = null;
                String phMailTit = null;

                Pharmacist pharmacistRetrieved = new Pharmacist();
                PharmacistManager pM = pharmacy.getPharmacyManager();

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

                pM.setCF(phCfTit);
                pM.setEmail(phMailTit);

                pharmacy.setName(phName);
                pharmacy.setAddress(phAddress);
                pharmacy.setPhoneNumber(phPhoneNumber);
                pharmacy.setPharmacyManager(pM);

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
        return pharmacy.getName();
    }

    public String getPhAddress(){
        return pharmacy.getAddress();
    }

    public String getPhPhoneNumber(){
        return pharmacy.getPhoneNumber();
    }

    public String getPhCfTit(){
        return pharmacy.getPharmacyManager().getCF();
    }

    public String getPhMailTit(){
        return pharmacy.getPharmacyManager().getEmail();
    }
}