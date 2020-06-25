package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.Date;


public class DeskOperator extends Pharmacist {

    public void sellItems(LinkedList<Medicine> medicineLinkedList, Pharmacy pharmacy) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "Franci99");
            try {
                Statement st = con.createStatement();
                String queryPurchase;
                String queryMedPurchase;
                String mqty;
                LinkedList<Medicine> examined = new LinkedList<Medicine>();
                float totalCost = 0;


                for (Medicine m  : medicineLinkedList ){
                    if(!examined.contains(m)){
                        examined.add(m);
                        int quantity = countDuplicates(medicineLinkedList, m);
                        queryMedPurchase = ("INSERT INTO Acquisto_Farmaco VALUES('" + quantity + "', '" + getTime() + "', '" + this.getCF() + "', '" + m.getCode() + "'");
                        st.executeUpdate(queryMedPurchase);
                    }


                    totalCost += m.getCost();
                    mqty = ("update magazzino_farmaco as mf " +
                            "set quantita = mf.quantita - 1 " +
                            "where mf.codiceFarmaco = (select distinct farmaco.codice " +
                            "from magazzino_farmaco " +
                            "join farmacia on magazzino_farmaco.nomeFarmaciaMagazzino = farmacia.nome " +
                            "join farmaco on magazzino_farmaco.codiceFarmaco = farmaco.codice " +
                            "where magazzino_farmaco.codiceFarmaco = '" + m.getCode() + "' and farmacia.nome = '" + pharmacy.getName() + "'");

                    st.executeUpdate(mqty);
                }

                queryPurchase = ("INSERT INTO Acquisto VALUES('" + getTime() + "', '" + this.getCF() + "', '" + this.getEmail() + "', null '" + totalCost + "'");
                st.executeUpdate(queryPurchase);
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    public int countDuplicates(LinkedList<Medicine> medicineLinkedList, Medicine m) {
        int count = 0;
        for(Medicine check: medicineLinkedList){
            if(check.getCode() == m.getCode()) { count++; }
        }
        return count;
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
