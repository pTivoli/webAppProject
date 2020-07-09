package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;

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
                if(pharmacist instanceof PharmacyDoctor) {
                    queryPersonale = "INSERT INTO Personale VALUES ('" + pharmacist.getEmail() + "','" + pharmacist.getPwd() + "','" + pharmacist.getCF() + "','PD', '" + pharmacy.getName() + "', '" + pharmacy.getAddress() + "', '" + pharmacy.getPharmacyManager().getCF() + "');";
                }else {
                    queryPersonale = "INSERT INTO Personale VALUES ('" + pharmacist.getEmail() + "','" + pharmacist.getPwd() + "','" + pharmacist.getCF() + "','DO', '" + pharmacy.getName() + "', '" + pharmacy.getAddress() + "', '" + pharmacy.getPharmacyManager().getCF() + "');";
                }
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

    public void restockMedicine(LinkedList<Medicine> medList, Pharmacy pharmacy) throws Exception{
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            int count;
            try{
                Statement st = con.createStatement();
                String query = "select count(*) as count from magazzino where nomefarmacia = '" + pharmacy.getName() + "' and indirizzofarmacia = '" + pharmacy.getAddress() + "' and cftitolarefarmacia = '" + this.getCF() + "'";

                ResultSet r = st.executeQuery(query);
                r.next();
                count = r.getInt("count");

                if (count == 0) { //medicine is not in table at all
                    query = "insert into magazzino values('" + pharmacy.getName() + "','" + pharmacy.getAddress() + "','" + this.getCF() + "')";
                    st.executeUpdate(query);
                }

                for(Medicine m : medList) {
                    query = "select count(*) as count from magazzino_farmaco where nomefarmaciamagazzino = '" + pharmacy.getName() + "' and codicefarmaco = '" + m.getCode() +"'";
                    r = st.executeQuery(query);
                    r.next();
                    count = r.getInt("count");

                    if (count == 0) { //medicine is not in table at all
                        query = "insert into magazzino_farmaco VALUES('1', '" + pharmacy.getName() + "', '" + pharmacy.getAddress() + "', '" + this.getCF() + "', '" + m.getCode() + "')";
                    } else { //medicine is found in table and needs to be incremented
                        query = "update magazzino_farmaco as mf set quantita = mf.quantita + 1 where mf.codicefarmaco = '" + m.getCode() + "' and mf.nomefarmaciamagazzino = '" + pharmacy.getName() + "'";
                    }
                    st.executeUpdate(query);
                }
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(SQLException e){
            throw new Exception("Error DB");
        }
    }


}
