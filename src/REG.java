import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;

public class REG extends Pharmacist{

    public void activatePharmacy(Pharmacy pharmacy) throws Exception{

        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "Slashrocker1");

        try {
            try {
                Statement st = con.createStatement();
                String queryPharmacy = "INSERT INTO Farmacia VALUES('" + pharmacy.getName() + "','" + pharmacy.getAddress() + "','" + pharmacy.getPhoneNumber() + "','" + pharmacy.getPharmacyDoctor().getCF() +  "','" + pharmacy.getPharmacyDoctor().getEmail() + "')";
                st.executeUpdate(queryPharmacy);
            } catch (SQLException ex) {
                throw ex;
            }
            con.close();
        } catch (Exception e) {
            throw e;
        }

    }

    public void activatePM(PharmacistManager pharmacistManager) throws Exception{

        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "Slashrocker1");

        try {
            try {
                Statement st = con.createStatement();
                String queryPM = "INSERT INTO Persona VALUES('" + pharmacistManager.getCF() + "','" + pharmacistManager.getfName() + "','" + pharmacistManager.getlName() + "','" + pharmacistManager.getDOB() + "')";
                st.executeUpdate(queryPM);
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
