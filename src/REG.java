import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;

public class REG {

    public boolean activatePharmacy(Pharmacy pharmacy) throws Exception{

        Class.forName("");
        Connection con = DriverManager.getConnection("localhost/PharmaPoint", "postgresql", "Slashrocker1");

        try {
            try {
                Statement st = con.createStatement();
                int value = st.executeUpdate("INSERT INTO USER_DETAILS(NAME,ADDRESS,PHONENUMBER,PHARMACYDOCTOR) "
                        + "VALUES('"
                        + pharmacy.getName()
                        + "','"
                        + pharmacy.getAddress()
                        + "','"
                        + pharmacy.getPhoneNumber()
                        + "','"
                        + pharmacy.getPharmacyDoctor() + "')");
            } catch (SQLException ex) {
                return false;
            }
            con.close();
        } catch (Exception e){
            return false;
        }

        return true;
    }

    public boolean activatePM(PharmacistManager pharmacistManager){
        return  false;
    }

    /* STATISTICS */

}
