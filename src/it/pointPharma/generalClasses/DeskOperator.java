package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;

import java.util.Date;


public class DeskOperator extends Pharmacist {

    public void sellItems(LinkedList<Medicine> medicineLinkedList, Pharmacist pharmacist) throws Exception {
        try{
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "TivoliPatrick");
            try {
                Statement st = con.createStatement();
                String queryVendita;
                String queryVenditaFarmaco;
                for (Medicine m: medicineLinkedList) {
                    queryVendita = "INSERT INTO Acquisto VALUES ('" + getTime() + "','" + pharmacist.getCF() + "','" + pharmacist.getEmail() + "','" + this.getCF() + "','" + m.getCost() + "')";
                    queryVenditaFarmaco = "INSERT INTO Acquisto VALUES ('" + "SELECT quantita FROM Magazzino_Farmaco" + "','" + getTime() + "','" + pharmacist.getCF() + "','" + m.getCode() + "')";
                    st.executeUpdate(queryVendita);
                    st.executeUpdate(queryVenditaFarmaco);
                }
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    public Timestamp getTime()
    {
        //Date object
        Date date= new Date();
        //getTime() returns current time in milliseconds
        long time = date.getTime();
        //Passed the milliseconds to constructor of Timestamp class
        Timestamp ts = new Timestamp(time);
        return ts;
    }
}
