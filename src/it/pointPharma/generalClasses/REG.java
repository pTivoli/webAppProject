package it.pointPharma.generalClasses;

import java.sql.*;

public class REG extends Pharmacist{

    public void activatePharmacy(Pharmacy pharmacy) throws Exception{
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
        try {
            try {
                Statement st = con.createStatement();
                int count = 0;
                String query = "select count(*) as COUNT from farmacia where nome ILIKE '"+pharmacy.getName()+"' and indirizzo ILIKE '"+pharmacy.getAddress()+"' and cftitolare ILIKE '"+pharmacy.getPharmacyManager().getCF()+"';";
                ResultSet r = st.executeQuery(query);
                r.next();
                count = r.getInt("count");
                if(count != 0){
                    con.close();
                    throw new IllegalArgumentException("This pharmacy still exists in the DB");
                }
                String queryPharmacy = "INSERT INTO Farmacia VALUES('" + pharmacy.getName() + "','" + pharmacy.getAddress() + "','" + pharmacy.getPhoneNumber() + "','" + pharmacy.getPharmacyManager().getCF() +  "','" + pharmacy.getPharmacyManager().getEmail() + "')";
                st.executeUpdate(queryPharmacy);
            } catch (SQLException ex) {
                throw new Exception("Error DB");
            }
            con.close();
        } catch (Exception e) {
            throw new Exception("Error DB");
        }

    }

    public void activatePM(PharmacistManager pharmacistManager, Pharmacy pharmacy) throws Exception{
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
        try {
            try {
                Statement st = con.createStatement();
                if(!exists("persona", "codicefiscale", pharmacistManager.getCF())){
                    String queryPM = "INSERT INTO Persona VALUES('" + pharmacistManager.getCF() + "','" + pharmacistManager.getfName() + "','" + pharmacistManager.getlName() + "','" + pharmacistManager.getDOB() + "');";
                    st.executeUpdate(queryPM);
                }
                if(exists("Personale", "mail", pharmacistManager.getEmail())){
                    con.close();
                    throw new IllegalArgumentException("This pharmacist still exists in the DB");
                }
                String queryPM1 = "insert into Personale values('"+pharmacistManager.getEmail()+"', '"+pharmacistManager.getPwd()+"', '"+pharmacistManager.getCF()+"', 'PM', '"+pharmacy.getName()+"', '"+pharmacy.getAddress()+"', '"+pharmacistManager.getCF()+"');";
                st.executeUpdate(queryPM1);
            } catch (SQLException exe) {
                throw new Exception("Error DB");
            }
            con.close();
        } catch (SQLException exe) {
            throw new Exception("Error DB");
        }
    }

    private boolean exists(String table, String field, String value) throws Exception{
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            int count = 0;
            try{
                Statement st = con.createStatement();
                String query = "SELECT count(*) as count from "+table+" where "+field+" ILIKE '"+value+"';";
                ResultSet r = st.executeQuery(query);
                r.next();
                count = r.getInt("count");
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
            return count != 0;
        }catch(Exception e){
            throw new Exception("Error DB");
        }
    }

}
