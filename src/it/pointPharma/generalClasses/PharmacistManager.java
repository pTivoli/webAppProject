package it.pointPharma.generalClasses;

import java.sql.*;

public class PharmacistManager extends PharmacyDoctor{

    private void employee(Pharmacist pharmacist, Pharmacy pharmacy) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try{
                Statement st = con.createStatement();
                if(!exists("persona", "codicefiscale", pharmacist.getCF())){
                    String queryUtente = "INSERT INTO Persona VALUES ('"+ pharmacist.getCF() +"','"+ pharmacist.getfName() +"','"+ pharmacist.getlName() +"','"+pharmacist.getDOB()+"');";
                    st.executeUpdate(queryUtente);
                }
                if(exists("personale", "mail", pharmacist.getEmail())){
                    con.close();
                    throw new IllegalArgumentException("This pharmacist still exists in the DB");
                }
                String queryPersonale;
                if(pharmacist instanceof DeskOperator)
                    queryPersonale = "INSERT INTO Personale VALUES ('"+pharmacist.getEmail()+"','"+pharmacist.getPwd()+"','"+pharmacist.getCF()+"','DO', '"+pharmacy.getName()+"', '"+pharmacy.getAddress()+"', '"+pharmacy.getPharmacyManager().getCF()+"');";
                else
                    queryPersonale = "INSERT INTO Personale VALUES ('"+pharmacist.getEmail()+"','"+pharmacist.getPwd()+"','"+pharmacist.getCF()+"','PD', '"+pharmacy.getName()+"', '"+pharmacy.getAddress()+"', '"+pharmacy.getPharmacyManager().getCF()+"');";
                st.executeUpdate(queryPersonale);
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(SQLException e){
            throw new Exception("Error DB");
        }
    }

    public void employeePD(PharmacyDoctor pharmacyDoctor, Pharmacy pharmacy) throws Exception {
        try {
            this.employee(pharmacyDoctor, pharmacy);
        }catch(Exception e){
            throw e;
        }
    }

    public void employeeDO(DeskOperator deskOperator, Pharmacy pharmacy) throws Exception {
        try {
            this.employee(deskOperator, pharmacy);
        }catch(Exception e){
            throw e;
        }
    }

    private boolean exists(String table, String field, String value) throws SQLException {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            int count = 0;
            try{
                Statement st = con.createStatement();
                String query = "SELECT count(*) as count from "+table+" where "+field+" ILIKE '"+value+"';";
                st.executeQuery(query);
                ResultSet r = st.executeQuery(query);
                r.next();
                count = r.getInt("count");
            }catch (SQLException e){
                throw e;
            }
            return count != 0;
        } catch (SQLException e) {
            throw e;
        }
    }
}
