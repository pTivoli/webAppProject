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
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "Slashrocker1");
            try {
                Statement st = con.createStatement();
                String query = "SELECT * FROM Personale JOIN Persona ON Persona.codicefiscale = Personale.personale_cfpersona WHERE mail='" + userDataIn.getEmail() + "'";
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
                }
                setParameters(pharmacistRetrieved, role, cf, dob, fname, lname);

                /* creation of pharmacy query */
                query = "SELECT * FROM FARMACIA JOIN PERSONALE ON Farmacia.nome = Personale.nomeFarmacia WHERE personale_CFPersona = '" + pharmacistRetrieved.getCF() + "'";
                ris = st.executeQuery(query);
                String name = null;
                String address = null;
                String phoneNumber = null;
                String cfTit = null;

                Pharmacy pharmacyRetrieved = new Pharmacy();
                while(ris.next()){
                    name = ris.getString("nomeFarmacia");
                    address = ris.getString("indirizzo");
                    phoneNumber = ris.getString("telefono");
                    cfTit = ris.getString("cfTitolare");
                }

                pharmacyRetrieved.setName(name);
                pharmacyRetrieved.setAddress(address);
                pharmacyRetrieved.setPhoneNumber(phoneNumber);
                //Pharmacist Manager needed in pharmacy, not sure whether to create a new one
                //or create a function that, given a CF, returns the Pharmacy manager class
                //the only obstacle is to get it from the database and manage to return
                //either a new PharmMan or return the existing one


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
}