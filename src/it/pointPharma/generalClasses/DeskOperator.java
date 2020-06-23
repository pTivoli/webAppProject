package it.pointPharma.generalClasses;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.LinkedList;

import java.util.Date;


public class DeskOperator extends Pharmacist {

    public void sellItems(LinkedList<Medicine> medicineLinkedList, Pharmacy pharmacy) throws Exception {
        try{
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "Franci99");
            try {
                Statement st = con.createStatement();
                String queryPurchase;
                String queryMedPurchase;
                String mqty;
                float totalCost = 0;
                for (Medicine m  : medicineLinkedList ){
                    totalCost += m.getCost();
                    //queryMedPurchase = "INSERT INTO Acquisto_Farmaco VALUES()"

                    mqty = ("update magazzino_farmaco as mf " +
                            "set quantita = mf.quantita - 1 " +
                            "where mf.codiceFarmaco = (select distinct farmaco.codice " +
                            "from magazzino_farmaco " +
                            "join farmacia on magazzino_farmaco.nomeFarmaciaMagazzino = farmacia.nome " +
                            "join farmaco on magazzino_farmaco.codiceFarmaco = farmaco.codice " +
                            "where magazzino_farmaco.codiceFarmaco = '" + m.getCode() + "' and farmacia.nome = '" + pharmacy.getName() + "'");
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
