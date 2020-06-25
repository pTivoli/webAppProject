package it.pointPharma.generalClasses;

import sun.reflect.annotation.ExceptionProxy;

import java.sql.*;
import java.util.Date;
import java.util.LinkedList;

public class PharmacyDoctor extends DeskOperator{

    public void sellItemsWithReceipt(LinkedList<Medicine> medicineLinkedList, User user, Date date, Integer codRegDoc, Pharmacy pharmacy, String recipeCode) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "Franci99");
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

                String queryRecipe = ("INSERT INTO ricetta VALUES('" + recipeCode + "', '" + date + "', '" + user.getCF() + "', '" + codRegDoc + "', '" + this.getCF() + "'");
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
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "TivoliPatrick");
            try{
                Statement st = con.createStatement();
                String queryUtente = "INSERT INTO Persona VALUES ('"+ user.getCF() +"',' "+ user.getfName() +"',' "+ user.getlName() +"','"+user.getDOB()+"')";
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
