package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;

public class PharmacyDoctor extends DeskOperator{

    public void sellItemsWithReceipt(LinkedList<Medicine> medicineLinkedList, User user, String codRegDoc, Pharmacy pharmacy, String recipeCode) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                /*String checkUser = "select count (codicefiscale)\n" +
                        "from persona\n" +
                        "where codicefiscale = '" + user.getCF() + "'";
                ResultSet ris = st.executeQuery(checkUser);
                int checkDB = 0;
                while(ris.next()){
                    checkDB = Integer.parseInt(ris.getString("count"));
                }

                if(checkDB == 0){
                    registerUser(user);
                }*/
                if(!exists("persona", "codicefiscale", user.getCF())){
                    con.close();
                    throw new IllegalArgumentException("This user does not exists in the DB, please, insert it");
                }
                if(exists("ricetta", "codicericetta", recipeCode)){
                    con.close();
                    throw new IllegalArgumentException("This receipt still exists in the DB");
                }
                if(!exists("medico", "codiceregionale", codRegDoc)){
                    con.close();
                    throw new IllegalArgumentException("This doctor does not exists in the DB");
                }
                if(recipeCode != null) {
                    String queryRecipe ="INSERT INTO ricetta VALUES('" + recipeCode + "', CURRENT_TIMESTAMP , '" + user.getCF() + "', '" + codRegDoc + "', \n" +
                            "(select medico_cfpersona from medico where codiceregionale= '" + codRegDoc + "'));";
                    System.out.print(queryRecipe);
                    st.executeUpdate(queryRecipe);
                }
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

    private boolean exists(String table, String field, String value) throws Exception{
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            int count = 0;
            try{
                Statement st = con.createStatement();
                String query = "SELECT count(*) as count from "+table+" where "+field+" = '"+value+"';";
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
