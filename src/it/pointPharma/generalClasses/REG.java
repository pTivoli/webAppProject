package it.pointPharma.generalClasses;

import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;

public class REG extends Pharmacist{

    public void activatePharmacy(Pharmacy pharmacy) throws Exception{
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
        try {
            try {
                Statement st = con.createStatement();
                String queryPharmacy = "INSERT INTO Farmacia VALUES('" + pharmacy.getName() + "','" + pharmacy.getAddress() + "','" + pharmacy.getPhoneNumber() + "','" + pharmacy.getPharmacyManager().getCF() +  "','" + pharmacy.getPharmacyManager().getEmail() + "')";
                st.executeUpdate(queryPharmacy);
            } catch (SQLException ex) {
                throw ex;
            }
            con.close();
        } catch (Exception e) {
            throw e;
        }

    }

    public void activatePM(PharmacistManager pharmacistManager, Pharmacy pharmacy) throws Exception{
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "postgres", "TivoliPatrick");
        try {
            try {
                Statement st = con.createStatement();
                String queryPM = "INSERT INTO Persona VALUES('" + pharmacistManager.getCF() + "','" + pharmacistManager.getfName() + "','" + pharmacistManager.getlName() + "','" + pharmacistManager.getDOB() + "');";
                String queryPM1 = "insert into Personale values('"+pharmacistManager.getEmail()+"', '"+pharmacistManager.getPwd()+"', '"+pharmacistManager.getCF()+"', 'PM', '"+pharmacy.getName()+"', '"+pharmacy.getAddress()+"', '"+pharmacistManager.getCF()+"');";
                st.executeUpdate(queryPM);
                st.executeUpdate(queryPM1);
            } catch (SQLException exe) {
                throw exe;
            }
            con.close();
        } catch (Exception e) {
            throw e;
        }

    }

    /* STATISTICS */

}
