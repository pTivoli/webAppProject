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
        try{
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "TivoliPatrick");
            try{
                Statement st = con.createStatement();
                String query = "SELECT mail, pwd, ruoloPersonale from Personale where mail='"+ userDataIn.getEmail() +"'"; //MAIL IS VALIDATED FROM HTML 5, SQL-INJECTION AVOIDED
                ResultSet ris = st.executeQuery(query);
                Pharmacist pharmacistRetrieved = new Pharmacist();
                pharmacistRetrieved.setEmail(userDataIn.getEmail());
                pharmacistRetrieved.setPwd(ris.getString("pwd"));
                setParameters(pharmacistRetrieved, role);
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(Exception e){
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
