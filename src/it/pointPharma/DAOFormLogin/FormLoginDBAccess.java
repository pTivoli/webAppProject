package it.pointPharma.DAOFormLogin;

import it.pointPharma.formBeans.UserData;
import it.pointPharma.generalClasses.Pharmacist;
import java.sql.*;

public class FormLoginDBAccess {

    private UserData userDataIn;
    private Pharmacist pharmacist;
    private String role;

    public FormLoginDBAccess(UserData userData){
        this.userDataIn = userData;
        this.pharmacist = null;
        this.role = null;
    }

    public void getUserData() throws Exception {
        /*
            BE CAREFUL
            Check out if in your directory there is the postgres driver class.
            BE CAREFUL
            Change the credential in getConnection.
         */
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
            try{
                Statement st = con.createStatement();
                String query = "SELECT mail, pwd, ruoloPersonale from Personale where mail='"+ userDataIn.getEmail() +"'"; //MAIL IS VALIDATED FROM HTML 5, SQL-INJECTION AVOIDED
                ResultSet ris = st.executeQuery(query);
                String role = null;
                Pharmacist pharmacistRetrieved = new Pharmacist();
                pharmacistRetrieved.setEmail(userDataIn.getEmail());
                while(ris.next()) {
                    pharmacistRetrieved.setPwd(ris.getString("pwd"));
                    role = ris.getString("ruoloPersonale");
                }
                setParameters(pharmacistRetrieved, role);
            }catch(SQLException e){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(SQLException e){
            throw new Exception("Error DB");
        }
    }

    private void setParameters(Pharmacist pharmacist, String ruolo){
        this.pharmacist = pharmacist;
        this.role = ruolo;
    }

    public Pharmacist getPharmacist(){
        return this.pharmacist;
    }

    public String getRole(){
        return this.role;
    }

}
