package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;

public class PharmacyDoctor extends DeskOperator{

    public void sellItemsWithReceipt(LinkedList<Medicine> medicineLinkedList, User user, Integer codRegDoc, Pharmacy pharmacy, String recipeCode) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String checkUser = "select count (codicefiscale)\n" +
                        "from persona\n" +
                        "where codicefiscale = '" + user.getCF() + "'";
                ResultSet ris = st.executeQuery(checkUser);
                int checkDB = 0;
                while(ris.next()){
                    checkDB = Integer.parseInt(ris.getString("count"));
                }

                if(checkDB == 0){
                    registerUser(user);
                }

                String queryRecipe = ("INSERT INTO ricetta VALUES('" + recipeCode + "', CURRENT_TIMESTAMP , '" + user.getCF() + "', '" + codRegDoc + "', '" + this.getCF() + "'");
                st.executeUpdate(queryRecipe);

                sellItems(medicineLinkedList, pharmacy);

            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    public void registerUser(User user) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try{
                Statement st = con.createStatement();
                String queryUtente = "INSERT INTO Persona VALUES ('"+user.getCF()+"','"+user.getfName()+"','"+user.getlName()+"','"+user.getDOB()+"');";
                st.executeUpdate(queryUtente);
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(Exception e){
            throw new Exception("Error DB");
        }
    }
}
