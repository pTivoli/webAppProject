package it.pointPharma.generalClasses;

import java.util.Date;
import java.util.LinkedList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class PharmacyDoctor extends DeskOperator{

    public boolean sellItemsWithReceipt(LinkedList<Medicine> medicineLinkedList, User user, Date date, Integer codRegDoc){
        return false;
    }

    public void registerUser(User user) throws Exception {
        try{
            Class.forName("org.postgresql.Driver");
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
